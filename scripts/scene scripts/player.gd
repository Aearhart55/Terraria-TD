extends CharacterBody2D

const SPEED : float = 300.0
const JUMP_VELOCITY : float = -300.0

@export var max_health : float = 20.0
@export_group("Setup Nodes")
@export var respawn_point : Node2D
@export var health_bar : HealthBar
@export var base_sprite : AnimatedSprite2D
@export var fox_sprite : AnimatedSprite2D

@export_group("Debug")
@export var immune : bool = false
@export var infinite_jump : bool = false

# Combat vars
var health : float:
	set(value):
		health = value
		health_bar.update(health)
		
		if health <= 0:
			death()
var active_status : Array[Status]

# Movement vars
var direction : float
var acceleration_percent: float = 0.3
var max_jumps : int = 2
var jump_count : int
var can_jump : bool = true

# State vars
var dead : bool = false
var fox_fade_rate : float = 0.05

func _ready() -> void:
	# Set health to max and init healthbar
	health = max_health
	health_bar.set_max_health(max_health)
	
	# Hide death animation fox
	fox_sprite.visible = false
	
	# Hide health bar when immune
	if immune:
		health_bar.always_show = false
		health_bar.visible = false

func _physics_process(delta: float) -> void:
	
	# Check for on floor
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		# Play fall anim if not dead
		if not base_sprite.animation == "fall" and velocity.y > 0 and not dead:
			base_sprite.play("fall")
			
		# Allow cloak to fall when dead
		elif dead:
			move_and_slide()
	else:
		can_jump = true
		# check if has jumped for land anim to avoid constant play
		if base_sprite.animation == "fall" and not dead:
			base_sprite.play("land")
		# refresh jumps
		jump_count = max_jumps
	
	if dead:
		# move and fade naked fox
		fox_sprite.self_modulate.a -= fox_fade_rate * delta
		fox_fade_rate += 0.01
		
		# orient fox
		if base_sprite.flip_h:
			fox_sprite.position.x -= 100 * delta
		else:
			fox_sprite.position.x += 100 * delta
		
		# wait for fox to fade to reset
		if fox_sprite.self_modulate.a < 0:
			position = respawn_point.position
			base_sprite.play("respawn")
			await base_sprite.animation_finished
			fox_sprite.visible = false
			fox_sprite.self_modulate.a = 1
			health = max_health
			dead = false
		
		# Stops movement input
		return
	
	# jump func
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
		if not base_sprite.is_playing() and not base_sprite.animation == "fall" or base_sprite.animation == "run":
			base_sprite.play("idle")
	
	move_and_slide()

func take_damage(dmg : float) -> void:
	# immunity conditions to skip
	if immune or dead or (base_sprite.is_playing() and base_sprite.animation == "hurt"):
		return
	health -= dmg
	
	# stops hurt overruling dead
	if base_sprite.animation != "death":
		base_sprite.play("hurt")

func death() -> void:
	# play anim
	base_sprite.play("death")
	# disable input and damage
	dead = true
	
	fox_fade_rate = .00
	# summon fox once anim finishes
	await base_sprite.animation_finished
	fox_sprite.global_position = global_position
	fox_sprite.visible = true
	fox_sprite.flip_h = base_sprite.flip_h
	
	
