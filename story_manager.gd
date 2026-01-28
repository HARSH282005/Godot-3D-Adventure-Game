extends Node

var current_mission = 1
var story_complete = false
var dialogs = {
	1: "Welcome, soldier! The enemy has taken over the base. Eliminate them!",
	2: "You've cleared the first area. Head to the vault for supplies.",
	3: "The boss is in the chamber ahead. Use your best weapons!",
	4: "Victory! The base is secure. Well done, operative."
}

var missions = {
	1: {"name": "Clear Sector A", "enemies": 10, "complete": false},
	2: {"name": "Retrieve Keycard", "complete": false},
	3: {"name": "Defeat Boss", "complete": false},
	4: {"name": "Escape Base", "complete": false}
}

func _ready():
	add_to_group("story_manager")
	print("📖 Story Started")

func advance_story():
	if dialogs.has(current_mission):
		print("📢 ", dialogs[current_mission])
	
	current_mission += 1

func complete_mission(mission_num):
	if missions.has(mission_num):
		missions[mission_num]["complete"] = true
		print("✅ Mission Complete: ", missions[mission_num]["name"])
		get_tree().get_first_node_in_group("game_manager").add_score(200)

func get_current_mission():
	return missions.get(current_mission, {})