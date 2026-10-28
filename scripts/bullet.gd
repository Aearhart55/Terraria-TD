extends Area2D

@export var speed:= 300.0
@export var life_span := 5.0
@export var damage : float = 1.0

func _ready() -> void:
	get_tree().create_timer(life_span).timeout.connect(life_span_end)

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func life_span_end():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		DH.attack(body, self)
		queue_free()
