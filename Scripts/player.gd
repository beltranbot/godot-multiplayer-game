extends CharacterBody2D

var movement_speed: int = 600
var jump_force: int = 1000
var gravity: int = 2800
var direction: float

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jump_force

	direction = Input.get_axis("move_left", "move_right")

	if direction: 
		velocity.x = direction * movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)

	move_and_slide()
