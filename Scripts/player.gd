extends CharacterBody2D

var movement_speed: int
var jump_force: int = 1000
var gravity: int = 2800
var direction: float

func _physics_process(delta: float) -> void:

    if not is_on_floor():
        velocity.y += gravity * delta

