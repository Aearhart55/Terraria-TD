class_name InteractionArea extends Area2D

@export var connected_nodes : Array[Node]

var player : CharacterBody2D

func _ready() -> void:
	body_entered.connect(player_enter)
	body_exited.connect(player_exit)
	Signals.interaction_area_entered.connect(interaction_area_check)
	
func player_enter(new_player: Node2D) -> void:
	if new_player.is_in_group("player"):
		player = new_player
		Signals.interaction_area_entered.emit(self)

func player_exit(new_player: Node2D) -> void:
	if player == new_player:
		if Signals.player_interact.is_connected(interaction):
			Signals.player_interact.disconnect(interaction)

func interaction_area_check(entered_area : Area2D) -> void:
	if entered_area == self:
		Signals.player_interact.connect(interaction)
	elif player != null:
		if Signals.player_interact.is_connected(interaction):
			Signals.player_interact.disconnect(interaction)
		
func interaction() -> void:
	pass

func disable() -> void:
	set_deferred("monitoring", false)
	if player != null:
		if Signals.player_interact.is_connected(interaction):
			Signals.player_interact.disconnect(interaction)

func _process(_delta: float) -> void:
	if connected_nodes.is_empty():
		return
	if Signals.player_interact.is_connected(interaction):
		for node in connected_nodes:
			node.show()
	else:
		for node in connected_nodes:
			node.hide()
