class_name Stage extends Node

signal hub_changed
signal win_signal(String)

@export var hub : StaticBody2D:
	set(value):
		hub = value
		hub_changed.emit()
@export var player : CharacterBody2D
@export var ui : UI
@export var spawner : Node

@export var next_stage : String = "start"

func _ready() -> void:
	win_signal.connect(ui.level_won)
	spawner.win_signal.connect(level_won)
	
func level_won() -> void:
	win_signal.emit(next_stage)
