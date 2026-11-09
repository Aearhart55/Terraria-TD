class_name Enemy extends CharacterBody2D

@export var max_health : float = 20.0
@export var damage : float = 1.0
@export var attack_speed : float = 1.0
@export var speed : float = 50.0

@export_group("Setup Nodes")
@export var base_sprite: AnimatedSprite2D
@export var attack_area: Area2D
@export var attack_cooldown: Timer
var active_status : Array[Status]
var base_modulate : Color = Color.WHITE
	
var health : float:
	set(value):
		health = value
		health_bar.update(health)
		
		if health <= 0:
			death()

@export var health_bar : HealthBar

var flip : bool = false
var main_target : StaticBody2D

func _ready() -> void:
	health = max_health
	health_bar.set_max_health(max_health)
	
	attack_cooldown.wait_time = attack_speed
	
	if flip:
		flip_sprites()
		
func flip_sprites() -> void:
	speed *= -1
	attack_area.position.x *= -1
	base_sprite.flip_h = flip
		
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = 0
	
	# check for targets
	if not attack_area.get_overlapping_bodies().is_empty():
		idle()
	else:
		walk()
	
	move_and_slide()

func idle() -> void:
	attack()
	velocity.x = 0

func walk() -> void:
	velocity.x = speed

func attack() -> void:
	# check if can attack 
	if not attack_cooldown.is_stopped():
		return
		
	for target in attack_area.get_overlapping_bodies():
		# check if target is valid
		if target.is_in_group("ally"):
			DH.attack(target, self)
			attack_cooldown.start()
			break

func take_damage(dmg : float) -> void:
	health -= dmg
	
	base_sprite.modulate = Color.CRIMSON
	await get_tree().create_timer(.1).timeout
	base_sprite.modulate = base_modulate
	
func death() -> void:
	queue_free()

func check_direction() -> void:
	if flip and main_target.position.x - position.x > 0.0:
		flip = false
		flip_sprites()
	elif not flip and main_target.position.x - position.x < 0.0:
		flip = true
		flip_sprites()
