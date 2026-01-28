extends CharacterBody3D

@export var speed = 4.0
@export var detection_range = 50.0
@export var attack_range = 5.0
@export var max_health = 200
@export var damage = 20

var current_health = max_health
var target = null
var gravity = -30.0
var can_attack = true
var phase = 1

func _ready():
	add_to_group("boss")
	print("⚔️ BOSS SPAWNED!")

func _physics_process(delta):
	velocity.y += gravity * delta
	
target = get_tree().get_first_node_in_group("player")
	
	if target:
		var distance = global_position.distance_to(target.global_position)
			
		if distance < detection_range:
			var direction = (target.global_position - global_position).normalized()
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
				
			if distance < attack_range and can_attack:
				if phase == 1:
					melee_attack()
				elif phase >= 2:
					ranged_attack()
					
		move_and_slide()

func melee_attack():
	can_attack = false
	target.take_damage(damage)
	print("⚔️ BOSS MELEE ATTACK!")
	await get_tree().create_timer(1.5).timeout
	can_attack = true

func ranged_attack():
	can_attack = false
	print("🔥 BOSS RANGED ATTACK!")
	target.take_damage(damage // 2)
	await get_tree().create_timer(2.0).timeout
	can_attack = true

func take_damage(amount):
	current_health -= amount
	print("Boss Health: ", current_health, "/", max_health)
	
	if current_health <= max_health / 2 and phase == 1:
		phase = 2
		print("⚠️ BOSS ENTERING PHASE 2!")
		speed = 6.0
		
	if current_health <= 0:
		die()

func die():
	print("🏆 BOSS DEFEATED! YOU WIN!")
	get_tree().get_first_node_in_group("game_manager").add_score(500)
	get_tree().get_first_node_in_group("game_manager").load_level(1)
	queue_free()