extends Node

var scene_list : Dictionary = {
	"start" : "res://scenes/UI/start_screen.tscn",
	"lose" : "res://scenes/UI/lose_screen.tscn",
	"retry" : "res://scenes/Stages/forest.tscn",
	"level_select_screen" : "res://scenes/UI/level_select_screen.tscn",
	"forest" : "res://scenes/Stages/forest.tscn",
	"forest_two_path" : "res://scenes/Stages/forest_two_path.tscn",
	"forest_cave" : "res://scenes/Stages/forest_cave.tscn",
	"forest1" : "res://scenes/Stages/forest.tscn",
	"forest2" : "res://scenes/Stages/forest.tscn",
	"forest3" : "res://scenes/Stages/forest.tscn",
	"forest4" : "res://scenes/Stages/forest.tscn",
	"forest5" : "res://scenes/Stages/forest.tscn"
}

var current_scene = null

func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	Signals.level_lost.connect(_on_loss)
	
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

func _on_loss() -> void:
	scene_list["retry"] = scene_list[current_scene.name]
	switch_scene("lose")
