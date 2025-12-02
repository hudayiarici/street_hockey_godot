extends Node2D

@onready var puck = $Puck
@onready var player1 = $Taxi1
@onready var player2 = $Taxi2
@onready var score_label = $ScoreLabel

var score_player1 = 0
var score_player2 = 0
const WINNING_SCORE = 3
var game_over = false
var is_paused = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS 
	print("Game started!")
	print("ScoreLabel found: ", score_label != null)
	print("Puck found: ", puck != null)
	
	if puck:
		puck.goal_scored.connect(_on_goal_scored)
		print("Puck signal connected!")
	
	update_score_display()

func _process(delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		if game_over:
			return 
		
		if is_paused:
			resume_game()
		else:
			pause_game()
			
	
	if is_paused:
		if Input.is_action_just_pressed("ui_restart"): 
			restart_game()
		elif Input.is_action_just_pressed("KEY_E"): 
			get_tree().quit()
			
	elif game_over and Input.is_action_just_pressed("ui_restart"):
		restart_game()

func pause_game():
	print("Game paused")
	is_paused = true
	get_tree().paused = true
	if score_label:
		score_label.text = "PAUSED\nE to Exit / R to Restart"
		score_label.add_theme_color_override("font_color", Color.WHITE)

func resume_game():
	print("Game resumed")
	is_paused = false
	get_tree().paused = false
	update_score_display()

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
	check_winner()

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
	
	if player1:
		player1.set_physics_process(false)
	if player2:
		player2.set_physics_process(false)
	if puck:
		puck.linear_velocity = Vector2.ZERO
		puck.set_physics_process(false)
	

	if score_label:
		score_label.text = "PLAYER " + str(winner_id) + " WINS!\nPress R to restart"
		score_label.add_theme_color_override("font_color", Color.YELLOW)
	
	print("Game Over! Player ", winner_id, " wins!")

func restart_game():
	print("Restarting game...")

	if get_tree().paused:
		get_tree().paused = false
	
	score_player1 = 0
	score_player2 = 0
	game_over = false
	is_paused = false
	
	if score_label:
		score_label.add_theme_color_override("font_color", Color.WHITE)
	
	update_score_display()
	
	if player1:
		player1.global_position = Vector2(300, 324)
		player1.set_physics_process(true)
	if player2:
		player2.global_position = Vector2(850, 324)
		player2.set_physics_process(true)
	
	if puck:
		puck.reset_puck()
		puck.set_physics_process(true)
	
	print("Game restarted!")
