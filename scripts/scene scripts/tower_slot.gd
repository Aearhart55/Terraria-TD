class_name Slot extends VBoxContainer

signal slot_pressed(int)

@export var button : Button
@export var texture : TextureRect
@export var price : Label
var slot_index : int

func _ready() -> void:
	button.pressed.connect(_button_pressed)

func update_slot(sprite : Texture2D, cost : int) -> void:
	texture.texture = sprite
	price.text = str(cost)
	
func _button_pressed() -> void:
	slot_pressed.emit(slot_index)

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("slot_" + str(slot_index + 1)):
		button.pressed.emit()
		button.button_pressed = true
