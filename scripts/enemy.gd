class_name Enemy extends CharacterBody2D

@export var speed : float = 50.0
var flip : bool = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = speed
	#velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
