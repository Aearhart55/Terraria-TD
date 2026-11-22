class_name Wave extends Resource

@export var wave_value : int = 100
@export var wave_type : Global.wave_types
@export var portal_index : int = 0
@export var force_next_wave : bool = false
@export var enemy_gap_time : float = 2
@export var wave_gap_time : float = 3

@export_category("Enemies")
@export var enemy_list : Array[Global.enemies]
