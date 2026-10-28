extends Node2D

const ICE_TURRET = preload("uid://cv13uq7diugin")
const ARCHER_TURRET = preload("uid://tmht4gutufgl")
const LIGHT_TURRET = preload("uid://c7ec65aq7g0h")
const GROUND_TOLERANCE : int = 100
const ENEMY = preload("uid://d4em0ochsyyy1")

var active_turret : Resource

func _ready() -> void:
	active_turret = LIGHT_TURRET

func _unhandled_input(_event: InputEvent) -> void:
	# Detects mouse release
	if Input.is_action_just_released("lmb"):
		spawn()
	
	if Input.is_action_just_released("slot_1"):
		active_turret = LIGHT_TURRET
	elif Input.is_action_just_released("slot_2"):
		active_turret = ENEMY
	elif Input.is_action_just_released("slot_3"):
		active_turret = ARCHER_TURRET
	elif Input.is_action_just_released("slot_4"):
		active_turret = ICE_TURRET
	
func spawn():
	# creates "ground finder" raycast at mouse
	# to locate nearest safe ground
	var ground_finder := RayCast2D.new()
	add_child(ground_finder)
	ground_finder.position = get_local_mouse_position()
	ground_finder.set_collision_mask_value(5, true)
	ground_finder.set_collision_mask_value(1, false)
	
	# establishes fail condition for spawning inside obj
	ground_finder.target_position = Vector2(0,0)
	ground_finder.hit_from_inside = true
	
	# check for spawn inside
	ground_finder.force_raycast_update()
	if ground_finder.is_colliding() and ground_finder.get_collision_normal() == Vector2(0,0):
		ground_finder.queue_free()
		return
	
	# extend to nearest surface or max length
	while not ground_finder.is_colliding() and ground_finder.target_position.y < GROUND_TOLERANCE:
		ground_finder.target_position.y += 1
		ground_finder.force_raycast_update()
		
	# spawn turret if valid surface
	if ground_finder.is_colliding():
		var turret = active_turret.instantiate()
		turret.position = ground_finder.position + ground_finder.target_position
		add_child(turret)
	
	# clean raycast
	ground_finder.queue_free()
