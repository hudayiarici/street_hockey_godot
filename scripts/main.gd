extends Node2D

@onready var puck = $Puck
@onready var player1 = $Taxi1
@onready var player2 = $Taxi2
@onready var score_label = $ScoreLabel
@onready var start_screen = $StartScreen
@onready var game_over_screen = $GameOverScreen
@onready var pause_menu = $PauseMenu
@onready var hud_player1 = $HUD_Player1
@onready var hud_player2 = $HUD_Player2

var score_player1 = 0
var score_player2 = 0
const WINNING_SCORE = 3
var game_over = false
var is_paused = false
var game_started = false

# Fuel system - separate for each player
var fuel_player1: float = 100.0
var fuel_player2: float = 100.0
const MAX_FUEL: float = 100.0
const FUEL_CONSUMPTION_RATE: float = 5.0  # fuel per second while moving

# Distance tracking - separate for each player
var distance_player1: float = 0.0
var distance_player2: float = 0.0
var last_position_p1: Vector2
var last_position_p2: Vector2

# Player starting positions (scaled for 1280x720)
const PLAYER1_START_POS = Vector2(333, 360)
const PLAYER2_START_POS = Vector2(947, 360)

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	print("Game started!")
	print("ScoreLabel found: ", score_label != null)
	print("Puck found: ", puck != null)

	if puck:
		puck.goal_scored.connect(_on_goal_scored)
		puck.puck_hit.connect(_on_puck_hit)
		print("Puck signals connected!")

	# Connect UI signals
	if start_screen:
		start_screen.start_game.connect(_on_start_game)
		start_screen.quit_game.connect(_on_quit_game)

	if game_over_screen:
		game_over_screen.restart_game.connect(_on_restart_from_game_over)
		game_over_screen.quit_game.connect(_on_quit_game)

	if pause_menu:
		print("Pause menu found and connecting signals!")
		pause_menu.resume_game.connect(_on_resume_game)
		pause_menu.restart_game.connect(restart_game)
		pause_menu.quit_game.connect(_on_quit_game)
	else:
		print("ERROR: Pause menu NOT found!")

	# Initialize game state
	_initialize_game_state()
	update_score_display()

func _initialize_game_state():
	# Disable players until game starts
	if player1:
		player1.set_physics_process(false)
		last_position_p1 = player1.global_position
		# Set HUD reference for Player 1
		if player1.has_method("set_hud_reference") and hud_player1:
			player1.set_hud_reference(hud_player1)
	if player2:
		player2.set_physics_process(false)
		last_position_p2 = player2.global_position
		# Set HUD reference for Player 2
		if player2.has_method("set_hud_reference") and hud_player2:
			player2.set_hud_reference(hud_player2)
	if puck:
		puck.set_physics_process(false)

	# Reset fuel and distance for both players
	fuel_player1 = MAX_FUEL
	fuel_player2 = MAX_FUEL
	distance_player1 = 0.0
	distance_player2 = 0.0

	# Update HUDs
	if hud_player1:
		hud_player1.update_fuel_display(100.0)
		hud_player1.update_distance_display(0.0)
	if hud_player2:
		hud_player2.update_fuel_display(100.0)
		hud_player2.update_distance_display(0.0)

func _on_start_game():
	print("Starting game...")
	game_started = true

	# Enable players
	if player1:
		player1.set_physics_process(true)
	if player2:
		player2.set_physics_process(true)
	if puck:
		puck.set_physics_process(true)

func _process(delta):
	# Handle pause (can pause anytime after game starts)
	if Input.is_action_just_pressed("ui_cancel"):
		print("ESC pressed! game_started: ", game_started, " game_over: ", game_over, " is_paused: ", is_paused)

		if game_started:
			print("Pause condition met!")
			if game_over:
				print("Game is over, cannot pause")
				return

			if is_paused:
				print("Resuming game...")
				_on_resume_game()
			else:
				print("Pausing game...")
				pause_game()

	# Don't process game logic if game hasn't started
	if not game_started:
		return

	# Don't update game state if paused or game over
	if is_paused or game_over:
		return

	# Update fuel consumption for both players
	update_fuel(delta)

	# Update distance tracking for both players
	update_distance(delta)

	# Check for out of fuel for each player
	if fuel_player1 <= 0:
		game_over_out_of_fuel(1)
	elif fuel_player2 <= 0:
		game_over_out_of_fuel(2)

func update_fuel(delta: float):
	# Check if each player is moving and consume their fuel separately
	if player1:
		var player1_moving = player1.velocity.length() > 10.0
		if player1_moving:
			fuel_player1 -= FUEL_CONSUMPTION_RATE * delta
			fuel_player1 = max(0, fuel_player1)

			# Update Player 1 HUD
			if hud_player1:
				var fuel_percent = (fuel_player1 / MAX_FUEL) * 100.0
				hud_player1.update_fuel_display(fuel_percent)

	if player2:
		var player2_moving = player2.velocity.length() > 10.0
		if player2_moving:
			fuel_player2 -= FUEL_CONSUMPTION_RATE * delta
			fuel_player2 = max(0, fuel_player2)

			# Update Player 2 HUD
			if hud_player2:
				var fuel_percent = (fuel_player2 / MAX_FUEL) * 100.0
				hud_player2.update_fuel_display(fuel_percent)

func update_distance(delta: float):
	# Update distance for Player 1
	if player1:
		var distance_p1 = player1.global_position.distance_to(last_position_p1)
		distance_player1 += distance_p1
		last_position_p1 = player1.global_position

		# Update Player 1 HUD
		if hud_player1:
			hud_player1.update_distance_display(distance_player1)

	# Update distance for Player 2
	if player2:
		var distance_p2 = player2.global_position.distance_to(last_position_p2)
		distance_player2 += distance_p2
		last_position_p2 = player2.global_position

		# Update Player 2 HUD
		if hud_player2:
			hud_player2.update_distance_display(distance_player2)

func game_over_out_of_fuel(player_id: int):
	game_over = true

	# Stop all physics
	if player1:
		player1.set_physics_process(false)
	if player2:
		player2.set_physics_process(false)
	if puck:
		puck.linear_velocity = Vector2.ZERO
		puck.set_physics_process(false)

	# Show game over screen with the losing player and distances
	if game_over_screen:
		var message = "PLAYER " + str(player_id) + " RAN OUT OF FUEL!"
		game_over_screen.show_game_over_fuel(player_id, distance_player1, distance_player2)

	print("Game Over! Player ", player_id, " ran out of fuel. P1 distance: ", distance_player1, " P2 distance: ", distance_player2)

func pause_game():
	print("Game paused")
	is_paused = true
	get_tree().paused = true

	if pause_menu:
		pause_menu.show_pause()

func _on_resume_game():
	print("Game resumed")
	is_paused = false
	get_tree().paused = false

	if pause_menu:
		pause_menu.hide_pause()

func _on_restart_from_game_over():
	restart_game()

func _on_quit_game():
	get_tree().quit()

func _on_puck_hit(player_id: int):
	print("Puck hit by Player ", player_id, "! Adding fuel...")

	# Add 10% fuel (10 points), max 100
	if player_id == 1:
		fuel_player1 = min(fuel_player1 + 10.0, MAX_FUEL)
		if hud_player1:
			var fuel_percent = (fuel_player1 / MAX_FUEL) * 100.0
			hud_player1.update_fuel_display(fuel_percent)
			hud_player1.show_notification("FUEL +10%", 2.0, Color.YELLOW)
		print("Player 1 fuel increased by 10%, now at: ", fuel_player1)
	elif player_id == 2:
		fuel_player2 = min(fuel_player2 + 10.0, MAX_FUEL)
		if hud_player2:
			var fuel_percent = (fuel_player2 / MAX_FUEL) * 100.0
			hud_player2.update_fuel_display(fuel_percent)
			hud_player2.show_notification("FUEL +10%", 2.0, Color.YELLOW)
		print("Player 2 fuel increased by 10%, now at: ", fuel_player2)

func _on_goal_scored(player_id: int):
	print("GOAL! Player ", player_id, " scored!")

	if game_over:
		return

	if player_id == 1:
		score_player1 += 1
	elif player_id == 2:
		score_player2 += 1

	print("Current scores - P1: ", score_player1, " P2: ", score_player2)

	update_score_display()

	# Reset player positions after goal
	reset_player_positions()

	check_winner()

func reset_player_positions():
	if player1:
		player1.global_position = PLAYER1_START_POS
		player1.velocity = Vector2.ZERO
		last_position_p1 = player1.global_position
	if player2:
		player2.global_position = PLAYER2_START_POS
		player2.velocity = Vector2.ZERO
		last_position_p2 = player2.global_position
	print("Players reset to starting positions")

func update_score_display():
	if score_label:
		score_label.text = str(score_player1) + " : " + str(score_player2)
		print("Score updated to: ", score_label.text)
	else:
		print("ERROR: ScoreLabel not found!")

func check_winner():
	if score_player1 >= WINNING_SCORE:
		end_game(1)
	elif score_player2 >= WINNING_SCORE:
		end_game(2)

func end_game(winner_id: int):
	game_over = true
	get_tree().paused = true

	if player1:
		player1.set_physics_process(false)
	if player2:
		player2.set_physics_process(false)
	if puck:
		puck.linear_velocity = Vector2.ZERO
		puck.set_physics_process(false)

	# Show game over screen for air hockey victory
	if game_over_screen:
		game_over_screen.show_game_over_score(winner_id, distance_player1, distance_player2)

	print("Game Over! Player ", winner_id, " wins by scoring 3 goals!")

func restart_game():
	print("Restarting game...")

	if get_tree().paused:
		get_tree().paused = false

	score_player1 = 0
	score_player2 = 0
	game_over = false
	is_paused = false
	game_started = true

	# Reset fuel and distance for both players
	fuel_player1 = MAX_FUEL
	fuel_player2 = MAX_FUEL
	distance_player1 = 0.0
	distance_player2 = 0.0

	if score_label:
		score_label.add_theme_color_override("font_color", Color.WHITE)

	update_score_display()

	if player1:
		player1.global_position = PLAYER1_START_POS
		player1.velocity = Vector2.ZERO
		player1.set_physics_process(true)
		last_position_p1 = player1.global_position
	if player2:
		player2.global_position = PLAYER2_START_POS
		player2.velocity = Vector2.ZERO
		player2.set_physics_process(true)
		last_position_p2 = player2.global_position

	if puck:
		puck.reset_puck()
		puck.set_physics_process(true)

	# Update both HUDs
	if hud_player1:
		hud_player1.update_fuel_display(100.0)
		hud_player1.update_distance_display(0.0)
	if hud_player2:
		hud_player2.update_fuel_display(100.0)
		hud_player2.update_distance_display(0.0)

	# Hide all menus
	if pause_menu:
		pause_menu.hide_pause()
	if game_over_screen:
		game_over_screen.hide()

	print("Game restarted!")
