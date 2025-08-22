extends CharacterBody2D

@export var projectile: PackedScene

var movement_speed: int = 600
var jump_force: int = 1000
var gravity: int = 2800
var direction: float
var can_shoot: bool = true

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attackRateTimer: Timer = $AttackRateTimer

func _ready() -> void:
	self.reset_players()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("shoot"):
		self.shoot_projectile()


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


func reset_players() -> void:
	var spawn_points: Node = get_parent().get_node("SpawnPoints")

	if name.contains("2"):
		position = spawn_points.get_child(1).position
	else:
		position = spawn_points.get_child(0).position


func _on_attack_rate_timer_timeout() -> void:
	self.can_shoot = true


func shoot_projectile() -> void:
	if self.can_shoot:
		var projectile_instance : Area2D = projectile.instantiate()
		get_parent().add_child(projectile_instance)
		projectile_instance.position = position
		projectile_instance.direction = -1 if $AnimatedSprite2D.flip_h else 1
		self.attackRateTimer.start()

	self.can_shoot = false
