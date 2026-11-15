class_name ToggleButton extends Button

@export var press_texture : TextureRect
@export var release_texture : TextureRect
@export var action_name : StringName

func _ready() -> void:
	toggled.connect(_on_toggle)

func _on_toggle(toggle_state):
	button_pressed = toggle_state
	press_texture.visible = toggle_state
	release_texture.visible = !toggle_state
	command()

func command() -> void:
	pass
