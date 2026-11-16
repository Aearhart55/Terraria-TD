extends Node

var scene_list : Dictionary = {
	"start" : "res://scenes/UI/start_screen.tscn",
	"lose" : "res://scenes/UI/lose_screen.tscn",
	"forest" : "res://scenes/Stages/forest.tscn"
}

var current_scene = null

func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func switch_scene(res_path : String) -> void:
	call_deferred("_deferred_switch_scene", res_path)
	
func _deferred_switch_scene(res_path : String):
	current_scene.free()
	var new_scene = load(scene_list[res_path])
	current_scene = new_scene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	if get_tree().paused:
		get_tree().paused = false
