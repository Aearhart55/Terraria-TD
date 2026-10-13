extends State

@export var attack_area: Area2D
@export var attack_state: State

func physics_update(_delta: float) -> void:
	if not attack_area.get_overlapping_bodies().is_empty():
		change_state.emit(attack_state)
