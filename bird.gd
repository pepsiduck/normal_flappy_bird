extends CharacterBody2D
const JUMP_VELOCITY = -500.0

var alive = true

func _ready() -> void:
	position = get_viewport_rect().size / 2

func _kill() -> void:
	alive = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		_kill()

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and alive:
		velocity.y = JUMP_VELOCITY
		
	if not is_on_floor():
		rotation = min(-0.2 * PI * velocity.y / JUMP_VELOCITY, 0.3 * PI )

	move_and_slide()
	if(position.y < 0):
		position.y = 0
	
