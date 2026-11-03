extends Node2D

var alive = true
var speed
var shiny = false
var hp = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = randf_range(0, get_viewport_rect().size.y)
	position.x = 200 if(randi() % 2) == 0 else get_viewport_rect().size.x - 200
	
	speed = randf_range(100, 300)
	if(randi() % 3 == 0):
		shiny = true
		hp = 3
	if(not shiny):
		$Area2D/Sprite2D.material = Material.new()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D :
		body._kill()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton :
		hp -= 1
		if(hp <= 0):
			alive = false
