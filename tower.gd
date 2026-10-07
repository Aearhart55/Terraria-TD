extends CharacterBody2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif is_on_floor():
		velocity = Vector2(0,0)
	
	move_and_slide()

# this should be a static no collision entity 
# unless health is involved
# the spawing proccess should send a raycast
# to check valid placement on floor
