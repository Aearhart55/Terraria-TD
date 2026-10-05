extends CharacterBody2D

const GRAVITY : float = 100

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	elif is_on_floor():
		velocity.y = 0
	move_and_slide()
