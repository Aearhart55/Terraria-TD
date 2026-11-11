extends CharacterBody2D

const SPEED : float = 300.0
const JUMP_VELOCITY : float = -300.0

var direction : float
var acceleration_percent: float = 0.3

@export var max_health : float = 20.0
var health : float:
	set(value):
		health = value
		health_bar.update(health)
		
		if health <= 0:
			death()
@export_group("Setup Nodes")
@export var respawn_point : Node2D
@export var health_bar : HealthBar
@export var base_sprite : AnimatedSprite2D

var active_status : Array[Status]

@export_group("Debug")
@export var immune : bool = false
@export var infinite_jump : bool = false

var max_jumps : int = 2
var jump_count : int
var can_jump : bool = true

var dead : bool = false


func _ready() -> void:
	health = max_health
	health_bar.set_max_health(max_health)
	
	if immune:
		health_bar.always_show = false
		health_bar.visible = false

func _physics_process(delta: float) -> void:
	if dead:
		return
		
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		if not base_sprite.animation == "fall" and velocity.y > 0:
			base_sprite.play("fall")
		
	else:
		can_jump = true
		if jump_count != max_jumps:
			base_sprite.play("land")
		jump_count = max_jumps
		
	if Input.is_action_just_pressed("up") and (can_jump or infinite_jump):
		velocity.y = JUMP_VELOCITY
		jump_count -= 1
		if jump_count <= 0:
			can_jump = false
		
		base_sprite.play("jump")
	
	direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = lerpf(velocity.x, direction * SPEED, acceleration_percent)
		
		if not base_sprite.is_playing() or base_sprite.animation == "idle":
			base_sprite.play("run")
		
		if direction > 0:
			base_sprite.flip_h = false
		elif direction < 0:
			base_sprite.flip_h = true
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not base_sprite.is_playing() or base_sprite.animation == "run":
			base_sprite.play("idle")
	
	move_and_slide()

func take_damage(dmg : float) -> void:
	if immune or dead:
		return
	health -= dmg
	
	if base_sprite.animation != "death":
		base_sprite.play("hurt")

func death() -> void:
	base_sprite.play("death")
	dead = true
	await base_sprite.animation_finished
	health = max_health
	dead = false
	position = respawn_point.position
	
