extends Camera2D

var zoom_in := true

func _ready() -> void:
	zoom = Vector2(2, 2)

func _process(delta: float) -> void:
	if zoom_in:
		zoom = zoom.move_toward(Vector2(.75 , .75), delta * 4)
		if zoom == Vector2(.75 , .75):
			zoom_in = false
