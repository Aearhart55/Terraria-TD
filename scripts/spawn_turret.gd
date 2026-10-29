extends Node2D

const ICE_TURRET = preload("uid://cv13uq7diugin")
const ARCHER_TURRET = preload("uid://tmht4gutufgl")
const LIGHT_TURRET = preload("uid://c7ec65aq7g0h")
const GROUND_TOLERANCE : int = 100
const ENEMY = preload("uid://d4em0ochsyyy1")

var width_tolerance : int = 5
var active_turret : Resource
@export_group("preview")
@export var preview_placement : bool
@export var touch_sprite : ColorRect
@export var place_sprite : ColorRect

func _ready() -> void:
	active_turret = LIGHT_TURRET
	touch_sprite.color = Color.CHARTREUSE
	place_sprite.color = Color.CHARTREUSE

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("lmb") and preview_placement:
		touch_sprite.visible = true
		place_sprite.visible = true
		preview_spawn()
	
	# Detects mouse release
	if Input.is_action_just_released("lmb"):
		touch_sprite.visible = false
		place_sprite.visible = false
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
	ground_finder.target_position = Vector2(0, GROUND_TOLERANCE)
	ground_finder.hit_from_inside = true
	
	# check for spawn inside
	ground_finder.force_raycast_update()
	if ground_finder.is_colliding() and ground_finder.get_collision_normal() == Vector2(0,0):
		ground_finder.queue_free()
		return
	
	# spawn turret if valid surface
	if ground_finder.is_colliding():
		if check_sides(ground_finder.get_collision_point()):
			pass
		else:
			var turret = active_turret.instantiate()
			turret.position = ground_finder.get_collision_point()
			add_child(turret)
	
	# clean raycast
	ground_finder.queue_free()

func check_sides(collision_point : Vector2) -> bool:
	var hit_side := false
	
	var side_check := RayCast2D.new()
	add_child(side_check)
	side_check.position = collision_point
	side_check.set_collision_mask_value(6, true)
	side_check.set_collision_mask_value(1, false)
	
	# establishes fail condition for spawning inside obj
	side_check.target_position = Vector2(-width_tolerance, 0)
	side_check.hit_from_inside = true
	side_check.collide_with_areas = true
	
	# check for spawn inside
	side_check.force_raycast_update()
	if side_check.is_colliding():
		hit_side = true
		
	side_check.target_position = Vector2(width_tolerance, 0)
	side_check.force_raycast_update()
	
	if side_check.is_colliding():
		hit_side = true
	
	side_check.queue_free()
	
	return hit_side

func preview_spawn() -> void:
	touch_sprite.position = get_global_mouse_position()
	touch_sprite.position.x -= touch_sprite.size.x / 2
	touch_sprite.position.y -= touch_sprite.size.y / 2
	
	var ground_finder := RayCast2D.new()
	add_child(ground_finder)
	ground_finder.position = get_local_mouse_position()
	ground_finder.set_collision_mask_value(5, true)
	ground_finder.set_collision_mask_value(1, false)
	
	ground_finder.target_position = Vector2(0, GROUND_TOLERANCE)
	ground_finder.hit_from_inside = true
	
	# check for spawn inside
	ground_finder.force_raycast_update()
	if ground_finder.is_colliding() and ground_finder.get_collision_normal() == Vector2(0,0):
		touch_sprite.color = Color.CRIMSON
		place_sprite.color = Color.CRIMSON
	else:
		touch_sprite.color = Color.CHARTREUSE
		place_sprite.color = Color.CHARTREUSE
		
	if ground_finder.is_colliding():
		if check_sides(ground_finder.get_collision_point()):
			touch_sprite.color = Color.CRIMSON
			place_sprite.color = Color.CRIMSON
		place_sprite.position = ground_finder.get_collision_point()
		place_sprite.position.x -= place_sprite.size.x / 2
		place_sprite.position.y -= place_sprite.size.y / 2
	else:
		touch_sprite.color = Color.CRIMSON
		place_sprite.color = Color.CRIMSON
		place_sprite.position = ground_finder.position + ground_finder.target_position
		place_sprite.position.x -= place_sprite.size.x / 2
		place_sprite.position.y -= place_sprite.size.y / 2
	
	ground_finder.queue_free()
