class_name HealthBar extends ProgressBar

@export var visibility_time : float

var health_visibility_timer : Timer = Timer.new()

var ignore_first_set_health : bool = true

func _ready() -> void:
	health_visibility_timer.wait_time = visibility_time
	health_visibility_timer.one_shot = true
	health_visibility_timer.timeout.connect(func(): visible = false)
	add_child(health_visibility_timer)
	
	visible = false
	get_theme_stylebox("fill")
	
func update(health : float) -> void:
	if ignore_first_set_health:
		ignore_first_set_health = false
		value = health
		return
		
	value = health
	visible = true
	health_visibility_timer.start()
	
	if value / max_value >= 0.50:
		get_theme_stylebox("fill").bg_color = Color("30b800")
	elif value / max_value >= 0.25:
		get_theme_stylebox("fill").bg_color = Color("d2b800")
	elif value / max_value < 0.25:
		get_theme_stylebox("fill").bg_color = Color("d20d00")
		
func set_max_health(max_health : float) -> void:
	max_value = max_health
	value = max_value
