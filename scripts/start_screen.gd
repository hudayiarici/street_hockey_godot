extends CanvasLayer

signal start_game
signal quit_game

func _ready():
	show()

func _process(delta):
	if visible:
		if Input.is_action_just_pressed("ui_accept"):  # Space key
			start_game.emit()
			hide()
		elif Input.is_action_just_pressed("KEY_E"):  # E key
			quit_game.emit()
