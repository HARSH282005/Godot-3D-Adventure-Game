extends Node

var players = []
var is_host = false
var game_state = "lobby"

func _ready():
	add_to_group("multiplayer_manager")
	print("🌐 Multiplayer Manager Ready")

func start_local_game(num_players = 2):
	print("Starting local game with ", num_players, " players")
	game_state = "playing"

func sync_player_position(player_id, position):
	for player in players:
		if player["id"] != player_id:
			player["position"] = position

func send_message(player_id, message):
	print("[Player ", player_id, "]: ", message)

func damage_other_player(player_id, amount):
	for player in players:
		if player["id"] == player_id:
			player.take_damage(amount)
			print("Player ", player_id, " took ", amount, " damage")