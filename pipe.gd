extends Node2D

const PIPE_SPEED = 360

var start
var end

var moving = true

var mid
var scored = false

func change_pos() -> void:
	
	var size_y =  get_viewport_rect().size.y
	
	var overture_size = 350
	
	var overture_start = randf_range(100, size_y - 100 - overture_size) #-100-350
	
	$Area2D_up.scale.y   = (size_y - overture_start - overture_size) / 20
	$Area2D_down.scale.y = overture_start / 20
	
	$Area2D_head_up.position.y   = $Area2D_up.position.y - 20 * $Area2D_up.scale.y
	$Area2D_head_down.position.y =                         20 * $Area2D_down.scale.y
	
	scored = false
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	mid = get_viewport_rect().size.x / 2

	$Area2D_up.position.x   = mid
	$Area2D_up.position.y   = get_viewport_rect().size.y
	$Area2D_head_up.position.x   = mid
	
	$Area2D_down.position.x = mid
	$Area2D_down.position.y =   0
	$Area2D_head_down.position.x   = mid
	
	start = get_viewport_rect().size.x
	end =  -(get_viewport_rect().size.x + $Area2D_up/up.shape.size.x) / 2
	
	change_pos()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(moving):
		if(position.x < 0):
			if(not scored):
				get_parent().score_plus_1()
				scored = true
		
		position.x -= delta * PIPE_SPEED 
		
		if(position.x < end):
			position.x = start 
			change_pos()   

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D :
		body._kill()

func _on_area_2d_up_body_entered(body: Node2D) -> void:
	_on_area_2d_body_entered(body)

func _on_area_2d_down_body_entered(body: Node2D) -> void:
	_on_area_2d_body_entered(body)

func _on_area_2d_head_up_body_entered(body: Node2D) -> void:
	_on_area_2d_body_entered(body)
	
func _on_area_2d_head_down_body_entered(body: Node2D) -> void:
	_on_area_2d_body_entered(body)
