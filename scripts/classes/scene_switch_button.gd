class_name SceneSwitchButton extends Button

@export var scene_name : String

func _ready() -> void:
	pressed.connect(switch_scene)
	
func switch_scene() -> void:
	SceneSwitcher.switch_scene(scene_name)
