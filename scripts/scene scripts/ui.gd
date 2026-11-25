class_name UI extends Control

signal toggle_build_mode(bool)

@export_group("Setup Nodes")
@export var tower_placer : Node2D

@export_group("Internal Setup Nodes")
@export var build_button : Button
@export var money_label : Label
@export var next_button : SceneSwitchButton
@export var remaining_enemies_label : Label

var towers = Towers.new()

func _ready() -> void:
	build_button.toggled.connect(build_mode_toggle)
	Global.money_update.connect(func(value : int): money_label.text = "$" + str(value))
	money_label.text = "$" + str(Global.player_cash)
	next_button.hide()
		

func build_mode_toggle(toggle_state : bool) -> void:
	toggle_build_mode.emit(toggle_state)
	build_button.get_child(0).visible = toggle_state
	build_button.get_child(1).visible = !toggle_state

func level_won(next_stage : String) -> void:
	next_button.scene_name = next_stage
	if next_stage == "start":
		next_button.text = "You Won!"
	next_button.show()
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("build_mode_input"):
		build_button.button_pressed = !build_button.button_pressed

func _process(_delta: float) -> void:
	remaining_enemies_label.text = str(get_tree().get_node_count_in_group("enemy"))
