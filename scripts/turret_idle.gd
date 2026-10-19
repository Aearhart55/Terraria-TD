extends State

@export var attack_area: Area2D
@export var attack_state: State

func physics_update(_delta: float) -> void:
	if not attack_area.get_overlapping_bodies().is_empty():
		for body in attack_area.get_overlapping_bodies():
			if body.is_in_group("enemy"):
				change_state.emit(attack_state)
