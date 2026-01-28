extends CharacterBody3D

@export var speed = 3.0
@export var detection_range = 20.0
@export var attack_range = 2.0
@export var health = 30
@export var damage = 5

var target = null
var gravity = -30.0
var can_attack = true
var attack_cooldown = 1.0

func _ready():
	add_to_group("enemies")

func _physics_process(delta):
	velocity.y += gravity * delta
	
target = get_tree().get_first_node_in_group("player")
	
	if target and global_position.distance_to(target.global_position) < detection_range:
		var direction = (target.global_position - global_position).normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
			
		if global_position.distance_to(target.global_position) < attack_range:
			if can_attack:
				attack()
	else:
			velocity.x = 0
			velocity.z = 0
		
	move_and_slide()

func attack():
	can_attack = false
	target.take_damage(damage)
	print("🔴 Enemy attacks! Damage: ", damage)
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

func take_damage(amount):
	health -= amount
	if health <= 0:
		die()

func die():
	print("💀 Enemy defeated!")
	get_tree().get_first_node_in_group("game_manager").add_score(50)
	queue_free()