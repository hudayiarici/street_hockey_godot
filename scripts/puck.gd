extends RigidBody2D

signal goal_scored(player_id: int)
signal puck_hit(player_id: int)

@export var MAX_SPEED = 16000.0
const FRICTION_FORCE = 1.0
const MARGIN = 50.0
const SCREEN_WIDTH = 1280.0
const SCREEN_HEIGHT = 720.0
const GOAL_TOP = 240.0
const GOAL_BOTTOM = 480.0
const MIN_VELOCITY = 5.0
const BOUNDS_MARGIN = 100.0

var can_score = true
var score_cooldown_timer: Timer
@onready var trail_emitter = $TrailEmitter

func _ready():
	contact_monitor = true
	max_contacts_reported = 10
	linear_damp = 0.1
	print("Puck ready! Mass: ", mass)

	score_cooldown_timer = Timer.new()
	add_child(score_cooldown_timer)
	score_cooldown_timer.wait_time = 1.0
	score_cooldown_timer.one_shot = true
	score_cooldown_timer.timeout.connect(_on_score_cooldown_timeout)

	# Connect body entered signal for fuel refill
	body_entered.connect(_on_body_entered)

func apply_speed_modifier(modifier: float):
	print("Puck Boosted! Modifier: ", modifier)
	if linear_velocity.length() < 50:
		# If almost stopped, launch it in a random direction
		var random_dir = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		linear_velocity = random_dir * 500 * modifier
	else:
		linear_velocity *= modifier

func _on_score_cooldown_timeout():
	can_score = true
	print("Puck ready for next goal!")

func _on_body_entered(body):
	# Check if the body is a taxi/player
	if body.get("player_id") != null:
		var player_id = body.player_id
		print("Puck hit by Player ", player_id, "! Refilling fuel...")
		puck_hit.emit(player_id)

func _physics_process(delta):
	var vel = linear_velocity
	var speed = vel.length()
	
	if speed > MAX_SPEED:
		linear_velocity = vel.normalized() * MAX_SPEED
	
	if speed > MIN_VELOCITY:
		linear_velocity *= FRICTION_FORCE
		if trail_emitter:
			var material = trail_emitter.process_material as ParticleProcessMaterial
			if material:
				material.direction = Vector3(-vel.normalized().x, -vel.normalized().y, 0)
			trail_emitter.emitting = true
	else:
		linear_velocity = Vector2.ZERO
		if trail_emitter:
			trail_emitter.emitting = false
	
	check_goal()
	check_bounds()

func check_bounds():
	var pos = global_position
	if pos.x < -BOUNDS_MARGIN or pos.x > SCREEN_WIDTH + BOUNDS_MARGIN or \
	   pos.y < -BOUNDS_MARGIN or pos.y > SCREEN_HEIGHT + BOUNDS_MARGIN:
		print("Puck is out of bounds! Resetting.")
		reset_puck()

func check_goal():
	var pos = global_position
	var is_in_goal_area_y = pos.y > GOAL_TOP and pos.y < GOAL_BOTTOM
	
	if pos.x < MARGIN and is_in_goal_area_y and can_score:
		can_score = false
		print("LEFT GOAL! Player 2 scores!")
		goal_scored.emit(2)
		reset_puck()
	
	elif pos.x > SCREEN_WIDTH - MARGIN and is_in_goal_area_y and can_score:
		can_score = false
		print("RIGHT GOAL! Player 1 scores!")
		goal_scored.emit(1)
		reset_puck()

func reset_puck():
	print("Resetting puck position...")
	global_position = Vector2(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	score_cooldown_timer.start()
