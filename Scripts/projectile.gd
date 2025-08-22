extends Area2D

var speed: int = 550
var direction: int
var player_index: int

func _process(delta):
	position.x += speed * delta * direction

func _ready():
	if direction == 0:
		direction = 1


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return

	if body.player_index != self.player_index:
		body.decreate_health()
		queue_free()
