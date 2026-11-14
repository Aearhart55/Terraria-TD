class_name Stage extends Node

signal hub_changed

@export var hub : StaticBody2D:
	set(value):
		hub = value
		hub_changed.emit()
@export var player : CharacterBody2D
@export var ui : UI
@export var spawner : Node
