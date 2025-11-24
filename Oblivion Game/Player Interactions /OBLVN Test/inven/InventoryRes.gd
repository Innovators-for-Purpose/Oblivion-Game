extends Resource


class_name InventoryRes

signal items_changed(indexes)

export(Array) var items = []

func add_item(item):
	items.append(item)
	emit_signal("items_changed", [items.size() - 1])
