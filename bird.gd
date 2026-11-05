extends CharacterBody2D
const JUMP_VELOCITY = -500.0

var alive = true
var has_gun = false

var hp = 2

var time_i_frame = 0.0
var iframe_en = false
var ifcount = 0

func _process(delta: float) -> void:
	if(iframe_en):
		
		time_i_frame += delta
		ifcount += 1
		
		if(ifcount == 10):
			
			ifcount = 0
			$Sprite2D.visible = not $Sprite2D.visible
		
		if(time_i_frame > 1.0) :
			iframe_en = false
			ifcount = 0
			$Sprite2D.visible = true

func _ready() -> void:
	position = get_viewport_rect().size / 2

func _kill() -> void:
	if(not iframe_en):
		hp -= 1
		time_i_frame = 0.0
		iframe_en = true
		if(hp <= 0):
			alive = false
			iframe_en = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		_kill()

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and alive:
		velocity.y = JUMP_VELOCITY
		$JumpSound.play()
		
	if not is_on_floor():
		var rot = min(-0.2 * PI * velocity.y / JUMP_VELOCITY, 0.3 * PI )
		$Sprite2D.rotation = rot
		$CollisionShape2D.rotation = rot
		
	if(has_gun and alive):
		$gun_sprite.rotation = (get_viewport().get_mouse_position() - position).angle()
		

	move_and_slide()
	if(position.y < 0):
		position.y = 0
	
