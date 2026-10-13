extends State

@export var attack_area: Area2D
@export var idle_state: State
@export var bullet_orgin: Marker2D
@export var cooldown_timer: Timer
@export var cooldown: float

var off_cooldown : bool = true
var target: Node2D

func enter() -> void:
	cooldown_timer.wait_time = cooldown
	cooldown_timer.timeout.connect(func(): off_cooldown = true)
	cooldown_timer.start()

func physics_update(_delta: float) -> void:
	if attack_area.get_overlapping_bodies().is_empty():
		change_state.emit(idle_state)
	
	if off_cooldown:
		pick_target()
		print(target)
		off_cooldown = false
		cooldown_timer.start()

func pick_target() -> void:
	var target_distance : float
	for enemy in attack_area.get_overlapping_bodies():
		if not target_distance:
			target = enemy
			target_distance = bullet_orgin.position.distance_to(target.position)
		
		elif bullet_orgin.position.distance_to(enemy.position) < target_distance:
			target = enemy
			target_distance = bullet_orgin.position.distance_to(target.position)
		
