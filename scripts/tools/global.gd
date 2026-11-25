extends Node

signal money_update(int)

enum wave_types {RANDOM, BURST, EVEN, ONE}
enum enemies {BIG_SLIME, ZOMBIE, SKELETON, DEMON, SLIME, BAT, KING_SLIME}

var player_cash : int:
	set(value):
		player_cash = value
		money_update.emit(player_cash)
