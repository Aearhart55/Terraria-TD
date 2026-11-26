class_name UI extends Control

@export_group("Internal Setup Nodes")
@export var next_button : SceneSwitchButton


func _ready() -> void:
	next_button.hide()
		
func level_won(next_stage : String) -> void:
	next_button.scene_name = next_stage
	if next_stage == "start":
		next_button.text = "You Won!"
	next_button.show()
	
