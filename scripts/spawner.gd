extends Sprite2D

const ENEMY = preload("uid://d4em0ochsyyy1")

var flip := false

func _on_cooldown_timeout() -> void:
	var new_enemy : Enemy = ENEMY.instantiate()
	new_enemy.flip = flip
	new_enemy.position = position
	owner.add_child(new_enemy)
