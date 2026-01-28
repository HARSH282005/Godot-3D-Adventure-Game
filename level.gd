extends Node3D

@export var num_enemies = 10
@export var num_platforms = 15
@export var level_size = 100

func _ready():
	create_ground()
	create_platforms()
	spawn_enemies()
	spawn_items()
	print("✅ Level Loaded!")

func create_ground():
	var ground = MeshInstance3D.new()
	ground.mesh = BoxMesh.new()
	ground.mesh.size = Vector3(level_size, 1, level_size)
	ground.position.y = -1
	add_child(ground)
	
	var ground_collider = StaticBody3D.new()
	var shape = CollisionShape3D.new()
	shape.shape = BoxShape3D.new()
	shape.shape.size = Vector3(level_size, 1, level_size)
	shape.position.y = -1
	ground_collider.add_child(shape)
	add_child(ground_collider)

func create_platforms():
	for i in range(num_platforms):
		var platform = MeshInstance3D.new()
		platform.mesh = BoxMesh.new()
		platform.mesh.size = Vector3(5, 0.5, 5)
		platform.position = Vector3(
			randf_range(-level_size/2, level_size/2),
			randf_range(2, 10),
			randf_range(-level_size/2, level_size/2)
		)
		add_child(platform)
		
		var collider = StaticBody3D.new()
		var shape = CollisionShape3D.new()
		shape.shape = BoxShape3D.new()
		shape.shape.size = Vector3(5, 0.5, 5)
		collider.add_child(shape)
		collider.position = platform.position
		add_child(collider)

func spawn_enemies():
	var enemy_scene = preload("res://scenes/enemy.tscn")
	for i in range(num_enemies):
		var enemy = enemy_scene.instantiate()
		enemy.position = Vector3(
			randf_range(-level_size/2, level_size/2),
			5,
			randf_range(-level_size/2, level_size/2)
		)
		add_child(enemy)

func spawn_items():
	var items = ["Health Potion", "Ammo Pack", "Key Card"]
	for i in range(5):
		var item = Label3D.new()
		item.text = items[randi() % items.size()]
		item.position = Vector3(
			randf_range(-level_size/2, level_size/2),
			3,
			randf_range(-level_size/2, level_size/2)
		)
		add_child(item)
		print("Item spawned: ", item.text)