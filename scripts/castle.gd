extends StaticBody2D

@export var max_health : int = 20
var health : int:
	set(value):
		health = value
		
		if health <= 0:
			death()

func _ready() -> void:
	health = max_health

func hit(dmg : int) -> void:
	health -= dmg
	modulate = Color.CRIMSON
	await get_tree().create_timer(.1).timeout
	modulate = Color.WHITE

func death() -> void:
	health = max_health
	scale *= .95
