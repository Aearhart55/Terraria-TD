extends Node2D

const ICE_TURRET = preload("uid://cv13uq7diugin")
const ARCHER_TURRET = preload("uid://tmht4gutufgl")
const LIGHT_TURRET = preload("uid://c7ec65aq7g0h")
const GROUND_TOLERANCE : int = 100
const SLIME_ENEMY = preload("uid://d4em0ochsyyy1")
const ZOMBIE_ENEMY = preload("uid://cxkie05ud6m2q")

signal slot_changed(int)

@export var UI_node : UI

@export_group("preview")
@export var preview_placement : bool
@export var touch_sprite : ColorRect
@export var place_sprite : ColorRect

@export_group("debug")
@export var allow_turret_overlap : bool = false

var build_mode_active :bool = true

var placement_position : Vector2
var active_turret : Global.turrets = Global.turrets.ARCHER
enum tower_data {TURRET, COST, WIDTH}

var tower : Dictionary = {
	Global.turrets.ARCHER : [ARCHER_TURRET, 10, 6],
	Global.turrets.ICE : [ICE_TURRET, 20, 6],
	Global.turrets.LIGHT : [LIGHT_TURRET, 25, 8],
	Global.turrets.SLIME : [SLIME_ENEMY, 0, 0],
	Global.turrets.ZOMBIE : [ZOMBIE_ENEMY, 0, 0]
}

func _ready() -> void:
	UI_node.select_tower.connect(switch_turrets)
	UI_node.toggle_build_mode.connect(func(state: bool) : build_mode_active = state)
	touch_sprite.color = Color.CHARTREUSE
	place_sprite.color = Color.CHARTREUSE

func switch_turrets(new_turret : Global.turrets) -> void:
	active_turret = new_turret

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("lmb") and preview_placement and build_mode_active:
		touch_sprite.visible = true
		place_sprite.visible = true
		placement_position = get_local_mouse_position()
		preview_spawn()
	
	# Detects mouse release
	if Input.is_action_just_released("lmb") and build_mode_active:
		touch_sprite.visible = false
		place_sprite.visible = false
		placement_position = get_local_mouse_position()
		spawn()
	
	#if _event is InputEventScreenTouch and _event.is_released():
	#	touch_sprite.visible = false
	#	place_sprite.visible = false
	#	placement_position = _event.position
	#	spawn()
	#	print("release")
		
	#if _event is InputEventScreenTouch and _event.is_pressed() and preview_placement and build_mode_active:
	#	touch_sprite.visible = true
	#	place_sprite.visible = true
	#	placement_position = get_local_mouse_position()
	#	preview_spawn()
	#	
	#	print("touch")
	
	if Input.is_action_just_released("slot_1"):
		slot_changed.emit(0)
	elif Input.is_action_just_released("slot_2"):
		slot_changed.emit(1)
	elif Input.is_action_just_released("slot_3"):
		slot_changed.emit(2)
	elif Input.is_action_just_released("slot_4"):
		slot_changed.emit(3)
	
func spawn():
	# creates "ground finder" raycast at mouse
	# to locate nearest safe ground
	var ground_finder := RayCast2D.new()
	add_child(ground_finder)
	ground_finder.position = placement_position
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
		if allow_turret_overlap:
			var turret = tower[active_turret][tower_data.TURRET].instantiate()
			turret.position = ground_finder.get_collision_point()
			add_child(turret)
		elif check_sides(ground_finder.get_collision_point()):
			pass
		else:
			var turret = tower[active_turret][tower_data.TURRET].instantiate()
			turret.position = ground_finder.get_collision_point()
			owner.add_child(turret)
	
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
	side_check.target_position = Vector2(-tower[active_turret][tower_data.WIDTH], 0)
	side_check.hit_from_inside = true
	side_check.collide_with_areas = true
	
	# check for spawn inside
	side_check.force_raycast_update()
	if side_check.is_colliding():
		hit_side = true
		
	side_check.target_position = Vector2(tower[active_turret][tower_data.WIDTH], 0)
	side_check.force_raycast_update()
	
	if side_check.is_colliding():
		hit_side = true
	
	side_check.queue_free()
	
	return hit_side

func preview_spawn() -> void:
	touch_sprite.position = placement_position
	touch_sprite.position.x -= touch_sprite.size.x / 2
	touch_sprite.position.y -= touch_sprite.size.y / 2
	
	var ground_finder := RayCast2D.new()
	add_child(ground_finder)
	ground_finder.position = placement_position
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
