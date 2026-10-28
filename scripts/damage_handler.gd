extends Node

func attack(reciever : Node, attacker : Node, status: Array[Status] = []) -> float:
	if reciever == null or attacker == null:
		print("null value")
		return 0.0
	
	if not reciever.has_method("take_damage"):
		print("invalid target: no take damage")
		return 0.0
	
	var final_damage : float = attacker.damage
	var active_status : Array[Status] = reciever.active_status
	
	if not status.is_empty():
		for current_status : Status in active_status:
			for new_status : Status in status:
				if current_status.tag == new_status.tag:
					current_status.reset_status()
				else:
					reciever.add_child(new_status)
					active_status = reciever.active_status
	
	if active_status:
		for current_status in active_status:
			match current_status.tag:
				"slow":
					print("brr")
	
	reciever.take_damage(final_damage)
	
	#print(reciever, attacker)
	
	return final_damage
