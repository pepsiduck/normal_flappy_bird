extends Node2D

var illuminati = preload("res://illuminati.tscn")

var score = 0
var mlg = 0

func _mlg_0() -> void:
	$bird/Sprite2D.texture = load("res://assets/sprites/bird_1.png")
	
func _mlg_1() -> void:
	$bird/Sprite2D.texture = load("res://assets/sprites/bird_2.png")
	
func _mlg_2() -> void:
	$bird/Sprite2D.texture = load("res://assets/sprites/bird_3.png")
	
func _mlg_3() -> void:
	$bird.has_gun = true
	$bird/gun_sprite.visible = true

var mlg_thresholds = [1, 2, 3, 5]

var mlg_funcs = [
	Callable(self, "_mlg_0"),
	Callable(self, "_mlg_1"),
	Callable(self, "_mlg_2"),
	Callable(self, "_mlg_3")
]

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
		
	if($bird.has_gun):
		if($hitmark.visible and not $hitmark/sound.is_playing()):
			$hitmark.visible = false
		
		
	for ill in $illuminatis.get_children():
		if($bird.alive):
			ill.position += ill.speed * delta * ($bird.position - ill.position).normalized()
		if(not ill.alive):
			score += 1 if not ill.shiny else 2
			$Score/Label.text = str(score)
			ill.queue_free()

func score_plus_1() -> void:
	score += 1
	$Score/Label.text = str(score)
	
	if(len(mlg_thresholds) != 0):
		if(score >= mlg_thresholds[0]):
			mlg += 1
			mlg_thresholds.pop_front()
			
			mlg_funcs[0].call()
			mlg_funcs.pop_front()
			
	if(score >= 6):
		var limit = (randi() % 3) + 1
		for i in range(0, limit):
			$illuminatis.add_child(illuminati.instantiate())

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed :
			if event.keycode == KEY_ESCAPE:
				get_tree().quit()
			elif (not $bird.alive and $bird.is_on_floor() and Input.is_action_just_pressed("ui_accept")) :
				get_tree().reload_current_scene()
				
	elif event is InputEventMouseButton and $bird.alive and $bird.has_gun:
		$hitmark.visible = true
		$hitmark.position = event.position
		$hitmark/sound.play()
