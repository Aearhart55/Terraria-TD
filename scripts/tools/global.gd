extends Node

signal money_update(int)

enum wave_types {RANDOM, BURST, EVEN}
enum enemies {BIG_SLIME, ZOMBIE, SKELETON, DEMON, SLIME, BAT, KING_SLIME}
enum turrets {LIGHT, ARCHER, ICE, POISON, SLIME}

# Settings
var towers_preview_placement : bool = false

# Debug
var player_immunity : bool = false
var player_infinite_jumps : bool = false

var hub_immunity : bool = true

var towers_no_cost : bool = false
var towers_allow_overlap : bool = false

var player_cash : int:
	set(value):
		player_cash = value
		money_update.emit(player_cash)
