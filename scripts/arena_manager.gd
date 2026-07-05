extends Node2D
class_name ArenaManager

signal wave_started(wave_num: int, total_enemies: int)
signal enemy_killed(remaining_count: int)
signal wave_completed(wave_num: int)
signal room_cleared()

@export var enemy_scene: PackedScene = preload("res://scenes/skele_rogue.tscn")
@export var enemies_per_wave: Array[int] = [2, 4, 6]
@export var wave_cooldown: float = 2.0

var current_wave: int = 0
var active_enemies: Array[Node2D] = []
var spawn_points: Array[Marker2D] = []

func _ready() -> void:
	# Find spawn points (any Marker2D children)
	for child in get_children():
		if child is Marker2D:
			spawn_points.append(child)
			
	# If no spawn points found, use self as the single spawn point
	if spawn_points.is_empty():
		var fallback_marker = Marker2D.new()
		fallback_marker.name = "FallbackSpawnPoint"
		add_child(fallback_marker)
		spawn_points.append(fallback_marker)
		
	# Start first wave after a short warmup delay
	await get_tree().create_timer(1.5).timeout
	_start_wave(0)

func _start_wave(wave_index: int) -> void:
	if wave_index >= enemies_per_wave.size():
		room_cleared.emit()
		return
		
	current_wave = wave_index
	active_enemies.clear()
	
	var count = enemies_per_wave[current_wave]
	wave_started.emit(current_wave + 1, count)
	
	for i in range(count):
		# Round-robin selection of spawn points
		var marker = spawn_points[i % spawn_points.size()]
		_spawn_enemy(marker.global_position)
		# Add a tiny delay between spawns for visual separation
		if i < count - 1:
			await get_tree().create_timer(0.2).timeout

func _spawn_enemy(spawn_pos: Vector2) -> void:
	if not enemy_scene:
		push_error("ArenaManager: No enemy scene selected!")
		return
		
	var enemy = enemy_scene.instantiate() as Node2D
	enemy.global_position = spawn_pos
	
	# Add to the parent level so they are siblings to Player/ArenaManager,
	# preventing visual transformation inheritance issues.
	get_parent().add_child.call_deferred(enemy)
	active_enemies.append(enemy)
	
	# Monitor when the enemy is freed/destroyed
	enemy.tree_exited.connect(func():
		_on_enemy_removed(enemy)
	)

func _on_enemy_removed(enemy: Node2D) -> void:
	# Check if this was an tracked active enemy
	if enemy in active_enemies:
		active_enemies.erase(enemy)
		enemy_killed.emit(active_enemies.size())
		
		# Wave completed check
		if active_enemies.is_empty():
			wave_completed.emit(current_wave + 1)
			
			# Check if there's a next wave
			if current_wave + 1 < enemies_per_wave.size():
				await get_tree().create_timer(wave_cooldown).timeout
				_start_wave(current_wave + 1)
			else:
				# No more waves, arena cleared!
				room_cleared.emit()

func get_remaining_enemies() -> int:
	return active_enemies.size()

func get_current_wave_num() -> int:
	return current_wave + 1

func get_total_waves() -> int:
	return enemies_per_wave.size()
