extends Camera2D

var zoom_in := true

func _ready() -> void:
	zoom = Vector2(1, 1)

func _process(delta: float) -> void:
	if zoom_in:
		zoom = zoom.move_toward(Vector2(5 , 5), delta * 4)
		if zoom == Vector2(4 , 4):
			zoom_in = false
