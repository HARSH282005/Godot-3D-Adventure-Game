extends CharacterBody3D

@export var speed = 7.0
@export var sprint_speed = 14.0
@export var jump_force = 12.0
@export var mouse_sensitivity = 0.003
@export var gravity = -30.0
@export var max_health = 100

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var hud = get_tree().get_first_node_in_group("hud")

var current_health = max_health
var is_sprinting = false
var current_weapon_index = 0
var weapons = []

func _ready():
	add_to_group("player")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	setup_weapons()
	update_hud()

func setup_weapons():
	weapons = [
		{"name": "Pistol", "damage": 10, "fire_rate": 0.1},
		{"name": "Rifle", "damage": 25, "fire_rate": 0.05},
		{"name": "Shotgun", "damage": 50, "fire_rate": 0.3}
	]

func _physics_process(delta):
	velocity.y += gravity * delta
	
	is_sprinting = Input.is_action_pressed("sprint")
	var current_speed = sprint_speed if is_sprinting else speed
	
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force
		
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if Input.is_action_just_pressed("weapon_1"):
		current_weapon_index = 0
	elif Input.is_action_just_pressed("weapon_2"):
		current_weapon_index = 1
	elif Input.is_action_just_pressed("weapon_3"):
		current_weapon_index = 2

func take_damage(amount):
	current_health -= amount
	print("Player Health: ", current_health)
	update_hud()
	if current_health <= 0:
		die()

func heal(amount):
	current_health = min(current_health + amount, max_health)
	update_hud()

func die():
	print("Player Died!")
	get_tree().reload_current_scene()

func update_hud():
	if hud:
		hud.update_health(current_health, max_health)
		hud.update_weapon(weapons[current_weapon_index]["name"])

func get_current_weapon():
	return weapons[current_weapon_index]