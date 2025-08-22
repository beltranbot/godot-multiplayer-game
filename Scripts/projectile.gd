extends Area2D

var speed: int = 550
var direction: int

func _process(delta):
	position.x += speed * delta * direction

func _ready():
	if direction == 0:
		direction = 1
