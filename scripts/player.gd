extends CharacterBody2D

const SPEED : float = 300.0
const JUMP_VELOCITY : float = -300.0

var direction : float
var acceleration_percent: float = 0.3

@export var max_health : float = 20.0
var health : float:
	set(value):
		health = value
		
		if health <= 0:
			death()

var active_status : Array[Status]

func _ready() -> void:
	health = max_health

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

func take_damage(dmg : float) -> void:
	health -= dmg
	
	modulate = Color.CRIMSON
	await get_tree().create_timer(.1).timeout
	modulate = Color.WHITE

func death() -> void:
	health = max_health
	position.y -= 50
