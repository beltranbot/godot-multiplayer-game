extends Area2D

var speed: int = 550
var direction: int

func _process(delta):
	position.x += speed * delta * direction
