extends CharacterBody2D

@export var player_id: int = 1
@export var use_wasd: bool = true

# HUD reference for showing notifications
var hud_reference: CanvasLayer = null

const MAX_SPEED = 1000.0  
var current_max_speed = MAX_SPEED
const ACCELERATION = 1500.0
var current_acceleration = ACCELERATION
const HIT_FORCE_MULTIPLIER = 50.0 

const MARGIN = 50.0
const SCREEN_WIDTH = 1280.0
const SCREEN_HEIGHT = 720.0
const CENTER_X = SCREEN_WIDTH / 2

@onready var animated_sprite = $AnimatedSprite2D
@onready var exhaust_particles = $GPUParticles2D

var speed_reset_timer: Timer
var traction_reset_timer: Timer
const EFFECT_DURATION = 5.0

func _ready():
	# Setup Speed Reset Timer
	speed_reset_timer = Timer.new()
	speed_reset_timer.wait_time = EFFECT_DURATION
	speed_reset_timer.one_shot = true
	speed_reset_timer.timeout.connect(_on_speed_reset_timeout)
	add_child(speed_reset_timer)

	# Setup Traction Reset Timer
	traction_reset_timer = Timer.new()
	traction_reset_timer.wait_time = EFFECT_DURATION
	traction_reset_timer.one_shot = true
	traction_reset_timer.timeout.connect(_on_traction_reset_timeout)
	add_child(traction_reset_timer)

func set_hud_reference(hud: CanvasLayer):
	hud_reference = hud

func show_hud_notification(message: String, duration: float = 2.0, color: Color = Color.YELLOW):
	if hud_reference and hud_reference.has_method("show_notification"):
		hud_reference.show_notification(message, duration, color)

func apply_speed_modifier(modifier: float):
	speed_reset_timer.stop() # Cancel reset if we enter a new zone
	current_max_speed = MAX_SPEED * modifier

	# Show notification based on modifier with color
	if modifier > 1.0:
		show_hud_notification("SPEED BOOST!", 3.0, Color.GREEN)
	elif modifier < 1.0:
		show_hud_notification("SLOWED DOWN!", 3.0, Color.ORANGE)

func remove_speed_modifier(duration: float = 1.0):
	speed_reset_timer.wait_time = duration
	speed_reset_timer.start() # Start cooldown to reset

func _on_speed_reset_timeout():
	current_max_speed = MAX_SPEED

func apply_traction_modifier(modifier: float):
	traction_reset_timer.stop() # Cancel reset if we enter a new zone
	current_acceleration = ACCELERATION * modifier

	# Show notification for low traction with red color
	if modifier < 1.0:
		show_hud_notification("OIL! LOW TRACTION!", 1.0, Color.RED)

func remove_traction_modifier(duration: float = 1.0):
	traction_reset_timer.wait_time = duration
	traction_reset_timer.start() # Start cooldown to reset

func _on_traction_reset_timeout():
	current_acceleration = ACCELERATION

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
		# Use current_acceleration here
		velocity = velocity.move_toward(input_vector * current_max_speed, current_acceleration * delta)
		update_animation(input_vector)
	else:
		if exhaust_particles:
			exhaust_particles.emitting = false
		# Use current_acceleration here for stopping too (sliding effect)
		velocity = velocity.move_toward(Vector2.ZERO, current_acceleration * delta)
		if animated_sprite:
			# Keep the frame but don't play an animation sequence if distinct frames aren't available
			animated_sprite.stop()
	
	move_and_slide()
	
	# Handle Screen Bounds (Clamping) and Reset Velocity on Impact
	var target_x = position.x
	if player_id == 1:
		target_x = clamp(position.x, MARGIN, CENTER_X - 10)
	else:
		target_x = clamp(position.x, CENTER_X + 10, SCREEN_WIDTH - MARGIN)
	
	if position.x != target_x:
		position.x = target_x
		velocity.x = 0 # Hit the wall, stop horizontal movement

	var target_y = clamp(position.y, MARGIN, SCREEN_HEIGHT - MARGIN)
	if position.y != target_y:
		position.y = target_y
		velocity.y = 0 # Hit the wall, stop vertical movement
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider and collider.is_in_group("puck"):
			var puck = collider as RigidBody2D
			if puck:

				var hit_direction = (puck.global_position - global_position).normalized()
				puck.linear_velocity = hit_direction * puck.MAX_SPEED
				print("Puck hit! New velocity set.")
		else:
			# Hit a wall/house/obstacle -> Stop completely
			velocity = Vector2.ZERO

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
