class_name Status extends Node

@export var duration : float
@export var tag : String

var status_timer : Timer = Timer.new()

func _ready() -> void:
	name = tag
	
	get_parent().active_status.append(tag)
	
	add_child(status_timer)
	status_timer.wait_time = duration
	status_timer.timeout.connect(_on_status_timer_timeout)
	status_timer.start()
	
func reset_status():
	status_timer.start()

func _on_status_timer_timeout() -> void:
	get_parent().active_status.erase(tag)
	queue_free()
