extends CanvasLayer

signal resume_game
signal restart_game
signal quit_game

func _ready():
	hide()

func show_pause():
	print("Pause menu showing...")
	show()

func hide_pause():
	print("Pause menu hiding...")
	hide()

func _process(delta):
	if visible:
		if Input.is_action_just_pressed("ui_accept"):  # SPACE key
			print("Pause menu detected SPACE, emitting resume_game signal")
			resume_game.emit()
		elif Input.is_action_just_pressed("ui_restart"):  # R key
			print("Pause menu detected R, emitting restart_game signal")
			restart_game.emit()
		elif Input.is_action_just_pressed("KEY_E"):  # E key
			print("Pause menu detected E, emitting quit_game signal")
			quit_game.emit()
