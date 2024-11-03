class_name ActionPickupItem extends ItemOnEnteredFunc_R

@export var count: int

func function(actor: Node2D, item_data: ItemData_R) -> void:
	print("PICKUP")
	actor.add_to_inventory(item_data)
