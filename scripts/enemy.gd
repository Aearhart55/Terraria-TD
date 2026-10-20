class_name Enemy extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var speed : float = 50.0
@export var health : int = 20 :
	set(value):
		health = value
		
		if health <= 0:
			death()
		
var flip : bool = false

func _ready() -> void:
	if flip:
		speed *= -1
		animated_sprite_2d.flip_h = true
		
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = speed
	#velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func hit(dmg : int) -> void:
	health -= dmg
	
func death() -> void:
	queue_free()
