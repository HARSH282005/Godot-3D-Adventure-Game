extends Node3D

@export var base_damage = 10
@export var max_ammo = 300
@export var current_ammo = 300

var player = null
var can_shoot = true
var shots_fired = 0

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if can_shoot and current_ammo > 0:
			shoot()

func shoot():
	can_shoot = false
	current_ammo -= 1
	shots_fired += 1
	
	var weapon = player.get_current_weapon()
	var damage = weapon["damage"]
	var fire_rate = weapon["fire_rate"]
	
	var camera = player.get_node("Head/Camera3D")
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(
		camera.global_position,
		camera.global_position + camera.global_transform.basis.z * -100
	)
	
	var result = space_state.intersect_ray(query)
	
	if result:
		if result.collider.is_in_group("enemies"):
			result.collider.take_damage(damage)
			print("💥 Enemy hit! Damage: ", damage)
			get_tree().get_first_node_in_group("game_manager").add_score(10)
		elif result.collider.is_in_group("boss"):
			result.collider.take_damage(damage)
			print("⚔️ BOSS HIT! Damage: ", damage)
			get_tree().get_first_node_in_group("game_manager").add_score(100)
		
	play_gun_sound()
	await get_tree().create_timer(fire_rate).timeout
	can_shoot = true

func play_gun_sound():
	var audio = AudioStreamPlayer3D.new()
	audio.position = global_position
	add_child(audio)
	await get_tree().create_timer(0.5).timeout
	audio.queue_free()

func reload():
	current_ammo = max_ammo
	print("🔄 Reloaded! Ammo: ", current_ammo)