extends Node2D

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$pipe1.position.x =       get_viewport_rect().size.x
	$pipe2.position.x = 1.5 * get_viewport_rect().size.x
	$pipe3.position.x = 2 *   get_viewport_rect().size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if(not $bird.alive) :
		$pipe1.moving = false
		$pipe2.moving = false
		$pipe3.moving = false
	else :
		$Parallax2D.scroll_offset.x -= 180*delta

func score_plus_1() -> void:
	score += 1
	$Score/Label.text = str(score)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed :
			if event.keycode == KEY_ESCAPE:
				get_tree().quit()
			elif (not $bird.alive and $bird.is_on_floor() and Input.is_action_just_pressed("ui_accept")) :
				get_tree().reload_current_scene()
