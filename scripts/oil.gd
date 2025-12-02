extends Area2D

@export var traction_modifier: float = 0.50 # %10 tutuş (çok kaygan)

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body.has_method("apply_traction_modifier"):
		print("Taxi entered oil! Sliding...")
		body.apply_traction_modifier(traction_modifier)

func _on_body_exited(body):
	if body.has_method("remove_traction_modifier"):
		print("Taxi exited oil.")
		body.remove_traction_modifier()
