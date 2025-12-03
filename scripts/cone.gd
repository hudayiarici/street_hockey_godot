extends Area2D

@export var speed_modifier: float = 0.25
@export var effect_duration: float = 3.0

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body.has_method("apply_speed_modifier"):
		print("Taxi entered slow zone!")
		body.apply_speed_modifier(speed_modifier)

func _on_body_exited(body):
	if body.has_method("remove_speed_modifier"):
		print("Taxi exited slow zone!")
		body.remove_speed_modifier(effect_duration)
