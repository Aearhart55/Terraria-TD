class_name TouchButton extends Button

@export var press_texture : TextureRect
@export var release_texture : TextureRect
@export var action_name : StringName

func _ready() -> void:
	self.button_down.connect(_on_button_down)
	self.button_up.connect(_on_button_up)

func _on_button_down() -> void:
	Input.action_press(action_name)
	press_texture.visible = true
	release_texture.visible = false

func _on_button_up() -> void:
	Input.action_release(action_name)
	press_texture.visible = false
	release_texture.visible = true
