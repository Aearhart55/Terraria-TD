extends CharacterBody2D

const SPEED : float = 300.0
const JUMP_VELOCITY : float = -300.0

var direction : float
var acceleration_percent: float = 0.3

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("up"):
		velocity.y = JUMP_VELOCITY
	
	direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = lerpf(velocity.x, direction * SPEED, acceleration_percent)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
