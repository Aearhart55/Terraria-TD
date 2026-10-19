extends Area2D

var speed:= 300.0
var life_span := 5.0

func _ready() -> void:
	get_tree().create_timer(life_span).timeout.connect(life_span_end)

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func life_span_end():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		queue_free()
