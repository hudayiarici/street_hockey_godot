extends CanvasLayer

signal restart_game
signal quit_game

@onready var title_label = $VBoxContainer/Title
@onready var distance_label = $VBoxContainer/DistanceLabel

func _ready():
	hide()

func show_game_over(distance: float):
	title_label.text = "OUT OF FUEL!"
	distance_label.text = "Distance: " + str(int(distance)) + " m"
	show()

func show_game_over_fuel(losing_player: int, distance_p1: float, distance_p2: float):
	var winner = 2 if losing_player == 1 else 1
	title_label.text = "PLAYER " + str(losing_player) + " OUT OF FUEL!\nPLAYER " + str(winner) + " WINS!"
	distance_label.text = "P1: " + str(int(distance_p1)) + " m | P2: " + str(int(distance_p2)) + " m"
	show()

func _process(delta):
	if visible:
		if Input.is_action_just_pressed("ui_restart"):  # R key
			print("Game over screen: R pressed, emitting restart_game signal")
			restart_game.emit()
			hide()
		elif Input.is_action_just_pressed("KEY_E"):  # E key
			print("Game over screen: E pressed, emitting quit_game signal")
			quit_game.emit()
