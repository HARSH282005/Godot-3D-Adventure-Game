extends CanvasLayer

@onready var health_label = $HealthLabel
@onready var weapon_label = $WeaponLabel
@onready var ammo_label = $AmmoLabel
@onready var score_label = $ScoreLabel
@onready var mission_label = $MissionLabel

func _ready():
	add_to_group("hud")

func _process(delta):
	update_ammo()
	update_score()
	update_mission()

func update_health(current, max_val):
	health_label.text = "HP: %d/%d" % [current, max_val]

func update_weapon(weapon_name):
	weapon_label.text = "Weapon: " + weapon_name

func update_ammo():
	var weapon = get_tree().get_first_node_in_group("weapon")
	if weapon:
		ammo_label.text = "Ammo: %d" % weapon.current_ammo

func update_score():
	var game_manager = get_tree().get_first_node_in_group("game_manager")
	score_label.text = "Score: %d" % game_manager.score

func update_mission():
	var story = get_tree().get_first_node_in_group("story_manager")
	if story:
		var mission = story.get_current_mission()
		mission_label.text = "Mission: " + mission.get("name", "None")

func show_dialog(text):
	var dialog = Label.new()
	dialog.text = text
	add_child(dialog)
	await get_tree().create_timer(3).timeout
	dialog.queue_free()