class_name ItemActionHealFunc extends ItemActionFunc_R

@export var heal_amount: int = 1

func function(actor: Node2D, action: String, item_data: ItemData_R) -> void:
	print("HEAL " + str(heal_amount))
