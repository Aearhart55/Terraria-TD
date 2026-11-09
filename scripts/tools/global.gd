extends Node

signal money_update(int)

enum wave_types {RANDOM, BURST, EVEN}
enum enemies {BIG_SLIME, ZOMBIE, SKELETON, DEMON}
enum turrets {LIGHT, ARCHER, ICE, SLIME, ZOMBIE}

var player_cash : int:
	set(value):
		player_cash = value
		money_update.emit(player_cash)
