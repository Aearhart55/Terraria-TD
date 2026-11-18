extends StaticBody2D

@export var health_bar : HealthBar
@export var sprite : AnimatedSprite2D
@export var passive_heal_timer : Timer
@export var passive_heal_value : float = 0.5
@export var passive_heal_rate : float = 1

@export var max_health : float = 20.0
var health : float:
	set(value):
		health = value
		health_bar.update(health)
		
		if health <= 0:
			death()

var active_status : Array[Status]

# Debug
var immune : bool = Global.hub_immunity

func _ready() -> void:
	health = max_health
	health_bar.set_max_health(max_health)
	
	passive_heal_timer.wait_time = passive_heal_rate
	passive_heal_timer.timeout.connect(func(): heal(passive_heal_value))

func take_damage(dmg : float) -> void:
	if immune:
		return
		
	health -= dmg
	passive_heal_timer.start()
	sprite.modulate = Color.CRIMSON
	await get_tree().create_timer(.1).timeout
	sprite.modulate = Color.WHITE

func death() -> void:
	SceneSwitcher.switch_scene("lose")

func heal(hp : float) -> void:
	if health + hp >= max_health:
		health = max_health
		passive_heal_timer.stop()
	else:
		health += hp
	
	sprite.modulate = Color.AQUAMARINE
	await get_tree().create_timer(.1).timeout
	sprite.modulate = Color.WHITE
