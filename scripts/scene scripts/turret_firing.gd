extends State

@export_category("Bullet Traits")
@export var cooldown: float
@export var damage : float = 1.0
@export var speed:= 300.0
@export var status : Array[PackedScene] = []
@export var life_span := 5.0

@export_group("Setup Nodes")
@export var attack_area: Area2D
@export var idle_state: State
@export var bullet_orgin: Marker2D
@export var cooldown_timer: Timer
@export var turret : Node2D

@export var projectile : PackedScene

@onready var projectile_scene : Resource = load(projectile.resource_path)

var off_cooldown : bool = true
var target: Node2D
var change_state_bool : bool = false

func enter() -> void:
	cooldown_timer.wait_time = cooldown
	cooldown_timer.timeout.connect(func(): off_cooldown = true)
	cooldown_timer.start()

func physics_update(_delta: float) -> void:
	if attack_area.get_overlapping_bodies().is_empty():
		change_state.emit(idle_state)
		
	change_state_bool = true
	for body in attack_area.get_overlapping_bodies():
		if body.is_in_group("enemy"):
			change_state_bool = false
	
	if change_state_bool:
		change_state.emit(idle_state)
	
	if off_cooldown:
		pick_target()
		if target:
			var new_bullet : Bullet = projectile_scene.instantiate()
			new_bullet.position = bullet_orgin.global_position
			new_bullet.look_at(target.position)
			new_bullet.damage = damage
			new_bullet.life_span = life_span
			new_bullet.speed = speed
			new_bullet.status = status
			add_child(new_bullet)
		off_cooldown = false
		cooldown_timer.start()

func pick_target() -> void:
	var target_distance : float
	target = null
	for enemy in attack_area.get_overlapping_bodies():
		if enemy.is_in_group("enemy"):
			if not target_distance:
				target = enemy
				target_distance = bullet_orgin.position.distance_to(target.position)
			
			elif bullet_orgin.position.distance_to(enemy.position) < target_distance:
				target = enemy
				target_distance = bullet_orgin.position.distance_to(target.position)
		
