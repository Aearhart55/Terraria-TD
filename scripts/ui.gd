class_name UI extends Control

const SPR_TOWER_ARCHER = preload("uid://bcotwe2k8grdn")
const SPR_TOWER_CANNON = preload("uid://cdiwy2e8g3vc6")
const SPR_TOWER_CROSSBOW = preload("uid://bwlaw6gqaina")
const SPR_TOWER_ICE_WIZARD = preload("uid://kr5x5qxgcp6l")
const SPR_TOWER_LIGHTNING_TOWER = preload("uid://b47kiy5m3rwui")
const SPR_TOWER_POISON_WIZARD = preload("uid://mff3pak1iokh")
const SLIME_ICO = preload("uid://dyigttfk5ho1m")

signal select_tower()
signal toggle_build_mode(bool)

@export var current_turrets : Array[Global.turrets]

@export_group("Setup Nodes")
@export var tower_bar : HBoxContainer
@export var slots : Array[VBoxContainer]
@export var tower_placer : Node2D
@export var build_button : Button

var tower : Dictionary = {
	Global.turrets.ARCHER : [SPR_TOWER_ARCHER, 10],
	Global.turrets.ICE : [ SPR_TOWER_ICE_WIZARD, 20],
	Global.turrets.LIGHT : [SPR_TOWER_LIGHTNING_TOWER, 30],
	Global.turrets.SLIME : [SLIME_ICO, 0]
}

func _ready() -> void:
	tower_placer.slot_changed.connect(_pressed_slot)
	build_button.toggled.connect(build_mode_toggle)
	
	for i in range(4):
		update_slot(i)
		match i:
			0:
				slots[i].get_child(0).pressed.connect(_pressed_slot1)
			1:
				slots[i].get_child(0).pressed.connect(_pressed_slot2)
			2:
				slots[i].get_child(0).pressed.connect(_pressed_slot3)
			3:
				slots[i].get_child(0).pressed.connect(_pressed_slot4)
		
func update_slot(i : int) -> void:
	slots[i].get_child(1).text = str(tower[current_turrets[i]][1])
	slots[i].get_child(0).get_child(0).texture = tower[current_turrets[i]][0]

func build_mode_toggle(toggle_state : bool) -> void:
	toggle_build_mode.emit(toggle_state)
	tower_bar.visible = toggle_state
	build_button.get_child(0).visible = toggle_state
	build_button.get_child(1).visible = !toggle_state
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("build_mode_input"):
		build_button.button_pressed = !build_button.button_pressed
		
func _pressed_slot(i : int) -> void:
	select_tower.emit(current_turrets[i])
	slots[i].get_child(0).button_pressed = true
	
func _pressed_slot1() -> void:
	select_tower.emit(current_turrets[0])
	
func _pressed_slot2() -> void:
	select_tower.emit(current_turrets[1])

func _pressed_slot3() -> void:
	select_tower.emit(current_turrets[2])

func _pressed_slot4() -> void:
	select_tower.emit(current_turrets[3])
