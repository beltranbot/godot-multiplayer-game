extends Sprite2D

@export var speed : int = 45
@export var start_position: Vector2
@export var end_position: Vector2

func _process(delta: float):
	position.x += speed * delta

	if position > end_position:
		position = start_position
