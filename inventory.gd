extends Node

var inventory = []
var inventory_limit = 20

func _ready():
	add_to_group("inventory")

func add_item(item_name, quantity = 1):
	for item in inventory:
		if item["name"] == item_name:
			item["quantity"] += quantity
			print("Added to existing item: ", item_name)
			return
	
	if inventory.size() < inventory_limit:
		inventory.append({"name": item_name, "quantity": quantity})
		print("✅ Added to inventory: ", item_name)
	else:
		print("❌ Inventory full!")

func use_item(item_name):
	for i in range(inventory.size()):
		if inventory[i]["name"] == item_name:
			var item = inventory[i]
			match item_name:
				"Health Potion":
					get_tree().get_first_node_in_group("player").heal(50)
					print("💊 Used Health Potion")
				"Ammo Pack":
					get_tree().get_first_node_in_group("weapon").current_ammo = 300
					print("📦 Ammo Restored")
			
			item["quantity"] -= 1
			if item["quantity"] <= 0:
				inventory.remove_at(i)
			return

func get_inventory():
	return inventory