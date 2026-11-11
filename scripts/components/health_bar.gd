class_name HealthBar extends TextureProgressBar

@export var visibility_time : float
@export var always_show : bool = false

var health_visibility_timer : Timer = Timer.new()

var ignore_first_set_health : bool = true

func _ready() -> void:
	health_visibility_timer.wait_time = visibility_time
	health_visibility_timer.one_shot = true
	health_visibility_timer.timeout.connect(func(): visible = false)
	add_child(health_visibility_timer)
	
	if not always_show:
		visible = false
	
func update(health : float) -> void:
	if ignore_first_set_health:
		ignore_first_set_health = false
		value = health
		return
		
	value = health
	if not always_show:
		visible = true
		health_visibility_timer.start()
	
func set_max_health(max_health : float) -> void:
	max_value = max_health
	value = max_value
