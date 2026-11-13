class_name MeleeEnemy extends Enemy

@export var attack_sprite: AnimatedSprite2D

func flip_sprites() -> void:
	super.flip_sprites()
	attack_sprite.flip_h = flip
func attack() -> void:
	# check if can attack 
	if not attack_cooldown.is_stopped():
		return
		
	for target in attack_area.get_overlapping_bodies():
		# check if target is valid
		if target.is_in_group("ally"):
			DH.attack(target, self)
			attack_sprite.play("attack")
			attack_cooldown.start()
			break
