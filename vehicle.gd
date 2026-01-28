extends CharacterBody3D

@export var car_speed = 20.0
@export var car_acceleration = 2.0
@export var car_friction = 0.95
@export var car_health = 150

var current_speed = 0
var current_health = car_health
var player = null
var is_driving = false

func _ready():
	add_to_group("vehicle")
	print("🚗 Vehicle Ready!")

func _physics_process(delta):
	if not is_driving:
		return
	
	var input = Input.get_axis("ui_up", "ui_down")
	current_speed += input * car_acceleration
	current_speed = clamp(current_speed, -car_speed, car_speed)
	current_speed *= car_friction
	
	var steering = Input.get_axis("ui_left", "ui_right")
	rotation.y += steering * 0.05
	
	velocity = transform.basis.z * current_speed
	velocity.y += -30 * delta
	move_and_slide()
	
	print("Car Speed: ", current_speed)

func enter_vehicle(player_node):
	is_driving = true
	player = player_node
	print("✅ Entered Vehicle!")

func exit_vehicle():
	is_driving = false
	print("⬅️ Exited Vehicle!")

func take_damage(amount):
	current_health -= amount
	if current_health <= 0:
		destroy()

func destroy():
	print("💥 Vehicle Destroyed!")
	queue_free()