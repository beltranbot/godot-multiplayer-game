extends CharacterBody2D

var movement_speed: int = 600
var jump_force: int = 1000
var gravity: int = 2800
var direction: float
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jump_force

	direction = Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * movement_speed
		sprite.play("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
		sprite.play("Idle")

	sprite.flip_h = sprite.flip_h if not direction else direction < 0

	if not is_on_floor():
		sprite.play("Jump")

	move_and_slide()
