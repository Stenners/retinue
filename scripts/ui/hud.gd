extends CanvasLayer
class_name HUD

@export var player_path: NodePath = NodePath("../Player")
@export var arena_manager_path: NodePath = NodePath("../ArenaManager")

var player: CharacterBody2D
var arena_manager: ArenaManager

var health_bar: ProgressBar
var health_label: Label

# Stats to track and display
var hp_current: int = 100
var hp_max: int = 100
var wave_current: int = 1
var wave_total: int = 3
var enemies_remaining: int = 0
var room_is_cleared: bool = false

func _ready() -> void:
	# 1. Locate Player
	if player_path:
		player = get_node_or_null(player_path)
	if not player:
		player = get_parent().get_node_or_null("Player")
		
	# 2. Locate ArenaManager
	if arena_manager_path:
		arena_manager = get_node_or_null(arena_manager_path)
	if not arena_manager:
		arena_manager = get_parent().get_node_or_null("ArenaManager")

	# 3. Locate UI Nodes (first ProgressBar / Label in hierarchy)
	health_bar = _find_child_by_type(self, "ProgressBar") as ProgressBar
	health_label = _find_child_by_type(self, "Label") as Label

	# Connect Player signals
	if player:
		if player.get("health_component"):
			_connect_health(player.health_component)
		else:
			player.ready.connect(func():
				if player.get("health_component"):
					_connect_health(player.health_component)
			)
			
	# Connect ArenaManager signals
	if arena_manager:
		wave_total = arena_manager.get_total_waves()
		arena_manager.wave_started.connect(_on_wave_started)
		arena_manager.enemy_killed.connect(_on_enemy_killed)
		arena_manager.room_cleared.connect(_on_room_cleared)

	_update_ui()

func _connect_health(health_comp: HealthComponent) -> void:
	health_comp.health_changed.connect(_on_health_changed)
	hp_current = int(health_comp.current_health)
	hp_max = int(health_comp.max_health)
	_update_ui()

func _on_health_changed(current: float, max_health: float) -> void:
	hp_current = int(current)
	hp_max = int(max_health)
	_update_ui()

func _on_wave_started(wave_num: int, total_enemies: int) -> void:
	wave_current = wave_num
	enemies_remaining = total_enemies
	room_is_cleared = false
	_update_ui()

func _on_enemy_killed(remaining_count: int) -> void:
	enemies_remaining = remaining_count
	_update_ui()

func _on_room_cleared() -> void:
	room_is_cleared = true
	_update_ui()

func _update_ui() -> void:
	if health_bar:
		health_bar.max_value = hp_max
		health_bar.value = hp_current
		
	if health_label:
		if room_is_cleared:
			health_label.text = "HP: %d/%d | ROOM CLEAR! Enter the Gate!" % [hp_current, hp_max]
		else:
			health_label.text = "HP: %d/%d | Wave %d/%d | Skeletons: %d" % [
				hp_current, hp_max, wave_current, wave_total, enemies_remaining
			]

func _find_child_by_type(node: Node, type_name: String) -> Node:
	if node.is_class(type_name):
		return node
	for child in node.get_children():
		var found = _find_child_by_type(child, type_name)
		if found:
			return found
	return null
