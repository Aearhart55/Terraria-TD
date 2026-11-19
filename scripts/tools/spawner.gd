extends Node

signal win_signal

const BIG_SLIME_ENEMY = preload("uid://d4em0ochsyyy1")
const ZOMBIE_ENEMY = preload("uid://cxkie05ud6m2q")
const DEMON_ENEMY = preload("uid://q3qjcof7sawe")
const SKELETON_ENEMY = preload("uid://b8a73je8bi48c")
const SLIME_ENEMY = preload("uid://b4u65kl1bg1kb")
const BAT_ENEMY = preload("uid://nmove52utu6h")
const KING_SLIME_ENEMY = preload("uid://cvlfy1jmgg2iv")

@export_group("Setup Nodes")
@export var hub : StaticBody2D
@export var spawn_points : Array[Marker2D]
var enemy_gap_timer : Timer = Timer.new()
var wave_gap_timer : Timer = Timer.new()

@export_group("Level")
@export var level : Level
var waves : Array[Wave]

var current_wave : Wave
var remaining_enemies : Array[Global.enemies]
var wave_type : Global.wave_types
var spawn_point_index : int
var is_new_wave : bool
var is_final_wave : bool = false
var is_wave_advanced : bool = false
var wave_advance_bonus : float = 1.1

var enemy : Dictionary = {
	Global.enemies.BIG_SLIME : BIG_SLIME_ENEMY,
	Global.enemies.ZOMBIE : ZOMBIE_ENEMY,
	Global.enemies.SKELETON : SKELETON_ENEMY,
	Global.enemies.DEMON : DEMON_ENEMY,
	Global.enemies.SLIME : SLIME_ENEMY,
	Global.enemies.BAT : BAT_ENEMY,
	Global.enemies.KING_SLIME : KING_SLIME_ENEMY
}

func _ready() -> void:
	Global.player_cash = level.starting_cash
	Signals.advance_wave.connect(advance_wave)
	
	add_child(enemy_gap_timer)
	add_child(wave_gap_timer)
	enemy_gap_timer.one_shot = true
	wave_gap_timer.one_shot = true
	enemy_gap_timer.timeout.connect(enemy_gap_timeout)
	wave_gap_timer.timeout.connect(wave_gap_timeout)
	
	waves = level.waves
	current_wave = waves[0]
	wave_type = current_wave.wave_type
	spawn_point_index = 0
	is_new_wave = true
	enemy_gap_timer.wait_time = current_wave.enemy_gap_time
	wave_gap_timer.wait_time = current_wave.wave_gap_time
	remaining_enemies = current_wave.enemy_list
	enemy_gap_timer.start()

func change_wave() -> void:
	waves.pop_front()
	if waves.is_empty():
		is_final_wave = true
		return
	elif waves.size() == 1:
		Signals.final_wave.emit()
	current_wave = waves[0]
	wave_type = current_wave.wave_type
	spawn_point_index = 0
	is_new_wave = true
	enemy_gap_timer.wait_time = current_wave.enemy_gap_time
	wave_gap_timer.wait_time = current_wave.wave_gap_time
	remaining_enemies = current_wave.enemy_list
	enemy_gap_timer.start()

func enemy_gap_timeout() -> void:
	spawn_enemy(pick_spawnpoint())

func wave_gap_timeout() -> void:
	change_wave()

func spawn_enemy(pos : Marker2D) -> void:
	if remaining_enemies.is_empty():
		if current_wave.force_next_wave:
			pass
		else:
			await Signals.wave_finished
		Global.player_cash += current_wave.wave_value
		wave_gap_timer.start()
		return
		
	var new_enemy : Enemy = enemy[remaining_enemies[0]].instantiate()
	if hub.position.x - pos.position.x < 0.0:
		new_enemy.flip = true
	new_enemy.position = pos.position
	owner.add_child(new_enemy)
	
	remaining_enemies.pop_front()
	enemy_gap_timer.start()

func pick_spawnpoint() -> Marker2D:
	var spawn_point : Marker2D = spawn_points[0]
	match wave_type:
		Global.wave_types.RANDOM:
			spawn_point = spawn_points.pick_random()
		Global.wave_types.BURST:
			if is_new_wave:
				is_new_wave = false
				spawn_point_index = randi_range(0, spawn_points.size() - 1)
			spawn_point = spawn_points[spawn_point_index]
		Global.wave_types.EVEN:
			if spawn_point_index >= spawn_points.size():
				spawn_point_index = 0
			spawn_point = spawn_points[spawn_point_index]
			spawn_point_index += 1
			
	return spawn_point

func _process(_delta: float) -> void:
	if get_tree().get_nodes_in_group("enemy").is_empty():
		if is_final_wave:
			win_signal.emit()
			is_final_wave = false
		elif remaining_enemies.is_empty():
			Signals.wave_finished.emit()

func advance_wave() -> void:
	if is_final_wave or is_wave_advanced:
		return
	
	@warning_ignore("narrowing_conversion")
	current_wave.wave_value *= wave_advance_bonus
	enemy_gap_timer.wait_time = 0.2
	wave_gap_timer.wait_time = 1
	current_wave.force_next_wave = true
