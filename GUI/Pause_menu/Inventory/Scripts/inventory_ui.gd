class_name InventoryUI extends Control

const INVENTORY_SLOT = preload("res://GUI/Pause_menu/Inventory/InventorySlot.tscn")

@export var data: InventoryData

var focus_index: int = 0

func _ready() -> void:
	PauseMenu.shown.connect(update_inventory)
	PauseMenu.hidden.connect(clear_inventory)
	clear_inventory()	
	data.changed.connect(on_inventory_changed)
	pass
	
	
func clear_inventory() -> void:
	#focus_index = 0
	for c in get_children():
		c.queue_free()
		
		
func update_inventory() -> void:
	for s in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		add_child(new_slot)
		new_slot.slot_data = s
		new_slot.focus_entered.connect(item_focused)
	#get_child(0).grab_focus()
	item_focused()
	
func on_inventory_changed() -> void:
	clear_inventory()
	update_inventory()
	pass

func item_focused() -> void:
	for i in get_child_count():
		if get_child(i).has_focus():
			focus_index = i
	await get_tree().process_frame
	get_child(focus_index).grab_focus()
	pass
