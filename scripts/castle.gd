extends StaticBody2D

@export var health_bar : HealthBar
@export var sprite : AnimatedSprite2D

@export var max_health : float = 20.0
var health : float:
	set(value):
		health = value
		health_bar.update(health)
		
		if health <= 0:
			death()

var active_status : Array[Status]

@export_group("Debug")
@export var immune : bool = false

func _ready() -> void:
	health = max_health
	health_bar.set_max_health(max_health)

func take_damage(dmg : float) -> void:
	if immune:
		return
		
	health -= dmg
	sprite.modulate = Color.CRIMSON
	await get_tree().create_timer(.1).timeout
	sprite.modulate = Color.WHITE

func death() -> void:
	SceneSwitcher.switch_scene("res://scenes/lose_screen.tscn")
