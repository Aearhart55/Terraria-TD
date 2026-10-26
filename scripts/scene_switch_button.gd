class_name SceneSwitchButton extends Button

@export var target_scene : PackedScene

var scene_path : String

func _ready() -> void:
	pressed.connect(switch_scene)
	scene_path = target_scene.resource_path
	
func switch_scene() -> void:
	SceneSwitcher.switch_scene(scene_path)
