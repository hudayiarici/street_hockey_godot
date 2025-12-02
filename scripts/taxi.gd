extends CharacterBody2D

@export var player_id: int = 1
@export var use_wasd: bool = true

const MAX_SPEED = 1000.0  
const ACCELERATION = 1500.0  
const HIT_FORCE_MULTIPLIER = 50.0 

const MARGIN = 50.0
const SCREEN_WIDTH = 1152.0
const SCREEN_HEIGHT = 648.0
const CENTER_X = SCREEN_WIDTH / 2

@onready var animated_sprite = $AnimatedSprite2D
@onready var exhaust_particles = $GPUParticles2D

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	if use_wasd:
		input_vector.x = Input.get_action_strength("ui_d") - Input.get_action_strength("ui_a")
		input_vector.y = Input.get_action_strength("ui_s") - Input.get_action_strength("ui_w")
	else:
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input_vector.length() > 0:
		if exhaust_particles:
			var material = exhaust_particles.process_material as ParticleProcessMaterial
			if material:
				material.direction = Vector3(-input_vector.x, -input_vector.y, 0)
			exhaust_particles.emitting = true
		input_vector = input_vector.normalized()
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		update_animation(input_vector)
	else:
		if exhaust_particles:
			exhaust_particles.emitting = false
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
		if animated_sprite:
			animated_sprite.stop()
	
	move_and_slide()
	
	if player_id == 1:
		position.x = clamp(position.x, MARGIN, CENTER_X - 10)
	else:
		position.x = clamp(position.x, CENTER_X + 10, SCREEN_WIDTH - MARGIN)
	
	position.y = clamp(position.y, MARGIN, SCREEN_HEIGHT - MARGIN)
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider and collider.is_in_group("puck"):
			var puck = collider as RigidBody2D
			if puck:

				var hit_direction = (puck.global_position - global_position).normalized()
				puck.linear_velocity = hit_direction * puck.MAX_SPEED
				print("Puck hit! New velocity set.")

func update_animation(direction: Vector2):
	if not animated_sprite:
		return
	
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animated_sprite.play("right")
		else:
			animated_sprite.play("left")
	else:
		if direction.y > 0:
			animated_sprite.play("down")
		else:
			animated_sprite.play("up")
