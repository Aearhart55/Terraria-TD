class_name TowerBar extends HBoxContainer

@export var towers : TowerSlots
@export var slots : Array[Slot]
var tower_data := Towers.new()

func _ready() -> void:
	
	Signals.toggled_build_mode.connect(func(is_pressed: bool): visible = is_pressed)
	
	for i in range(0, slots.size()):
		slots[i].update_slot(
				# Tower resource . data dictionary [ array of tower types [i] -> Towers.Type ] [ tower data type ]
				tower_data.data[towers.slots[i]][Towers.DataType.SPRITE],
				tower_data.data[towers.slots[i]][Towers.DataType.COST]
				)
		
		slots[i].slot_index = i
		slots[i].slot_pressed.connect(slot_pressed)

func slot_pressed(index : int) -> void:
	Signals.tower_slot_pressed.emit(towers.slots[index])
