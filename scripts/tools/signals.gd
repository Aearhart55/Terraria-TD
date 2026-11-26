extends Node

@warning_ignore_start("unused_signal")
# interactions
signal interaction_area_entered(Area2D)
signal player_interact

# wave states
signal wave_finished
signal final_wave
signal level_won
signal advance_wave

signal level_lost

# towers
signal tower_slot_pressed() # passes Towers.Type
signal toggled_build_mode(bool)
