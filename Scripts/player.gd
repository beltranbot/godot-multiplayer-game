extends CharacterBody2D

@export var death_particles: PackedScene
@export var projectile: PackedScene
@export var player_index: int
@export var device: int

var movement_speed: int = 600
var jump_force: int = 1000
var gravity: int = 2800
var health: float = 100
var direction: float
var can_shoot: bool = true

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attackRateTimer: Timer = $AttackRateTimer

func _ready() -> void:
	self.reset_players()
	self.update_colors()


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if MultiplayerInput.is_action_just_pressed(device, "shoot"):
		self.shoot_projectile()


	if MultiplayerInput.is_action_just_pressed(device, "jump") and is_on_floor():
		velocity.y -= jump_force

	direction = MultiplayerInput.get_axis(device, "move_left", "move_right")

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


func decreate_health():
	self.health -= 100.0 / 3.0

	if self.health <= 0:
		var death_particles_instance: CPUParticles2D = death_particles.instantiate()
		get_parent().add_child(death_particles_instance)
		death_particles_instance.position = position
		death_particles_instance.emitting = true
		death_particles_instance.color = modulate
		reset_players()
		self.health = 100
		get_parent().scored(self.player_index)

	get_health_bar().value = self.health


func get_health_bar() -> ProgressBar:
	return get_parent().get_node("UI/Container/Player" + str(self.player_index) + "/HealthProgressBar")


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
		var projectile_instance: Area2D = projectile.instantiate()
		projectile_instance.player_index = self.player_index
		get_parent().add_child(projectile_instance)
		projectile_instance.position = position
		projectile_instance.direction = -1 if $AnimatedSprite2D.flip_h else 1
		self.attackRateTimer.start()

	self.can_shoot = false


func update_colors() -> void:
	if player_index == 1:
		modulate = global.player_1_color

	if player_index == 2:
		modulate = global.player_2_color

	var new_style_box: StyleBoxFlat = get_health_bar().get_theme_stylebox("fill").duplicate()
	new_style_box.bg_color = modulate
	get_health_bar().add_theme_stylebox_override("fill", new_style_box)
