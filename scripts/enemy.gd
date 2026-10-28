class_name Enemy extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area: Area2D = $AttackArea
@onready var attack_cooldown: Timer = $AttackCooldown
@onready var attack_anims: AnimatedSprite2D = $AttackArea/AttackAnims

@export var speed : float = 50.0
@export var damage : float = 1.0
@export var max_health : float = 20.0

var active_status : Array[Status]
	
var health : float:
	set(value):
		health = value
		health_bar.update(health)
		
		if health <= 0:
			death()

@export var health_bar : HealthBar

var flip : bool = false

func _ready() -> void:
	health = max_health
	health_bar.set_max_health(max_health)
	
	if flip:
		speed *= -1
		attack_area.position.x *= -1
		animated_sprite_2d.flip_h = true
		
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = 0
	
	# check for targets
	if not attack_area.get_overlapping_bodies().is_empty():
		attack()
		velocity.x = 0
	else:
		velocity.x = speed
	
	move_and_slide()

func attack() -> void:
	# check if can attack 
	if not attack_cooldown.is_stopped():
		return
		
	for target in attack_area.get_overlapping_bodies():
		# check if target is valid
		if target.is_in_group("ally"):
			DH.attack(target, self)
			attack_anims.play("attack")
			attack_cooldown.start()
			break

func take_damage(dmg : float) -> void:
	health -= dmg
	
	animated_sprite_2d.modulate = Color.CRIMSON
	await get_tree().create_timer(.1).timeout
	animated_sprite_2d.modulate = Color.WHITE
	
func death() -> void:
	queue_free()
