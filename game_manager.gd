extends Node

var current_level = 1
var player_health = 100
var score = 0
var game_paused = false

func _ready():
	add_to_group("game_manager")
	load_level(1)
	print("🎮 Game Started!")

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_pause()

func load_level(level_num):
	current_level = level_num
	print("Loading Level ", level_num)
	match level_num:
		1:
			get_tree().change_scene_to_file("res://scenes/level1.tscn")
		2:
			get_tree().change_scene_to_file("res://scenes/level2.tscn")
		3:
			get_tree().change_scene_to_file("res://scenes/boss_arena.tscn")

func toggle_pause():
	game_paused = !game_paused
	get_tree().paused = game_paused
	print("Game Paused: ", game_paused)

func add_score(points):
	score += points
	print("Score: ", score)

func damage_player(amount):
	player_health -= amount
	if player_health <= 0:
		end_game()

func end_game():
	print("GAME OVER! Final Score: ", score)
	get_tree().reload_current_scene()