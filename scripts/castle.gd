extends StaticBody2D

@export var health_bar : HealthBar
@export var sprite : AnimatedSprite2D

@export var max_health : int = 20
var health : int:
	set(value):
		health = value
		health_bar.update(health)
		
		if health <= 0:
			death()

func _ready() -> void:
	health = max_health
	health_bar.set_max_health(max_health)

func hit(dmg : int) -> void:
	health -= dmg
	sprite.modulate = Color.CRIMSON
	await get_tree().create_timer(.1).timeout
	sprite.modulate = Color.WHITE

func death() -> void:
	SceneSwitcher.switch_scene("res://scenes/lose_screen.tscn")
