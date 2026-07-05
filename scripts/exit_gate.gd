extends Area2D
class_name ExitGate

@export var arena_manager_path: NodePath = NodePath("../ArenaManager")

var arena_manager: ArenaManager
var is_open: bool = false
var solid_barrier: StaticBody2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
	# Setup default placeholder shape/color rect if no sprite exists
	_setup_visuals()
	
	# Find ArenaManager
	if arena_manager_path:
		arena_manager = get_node_or_null(arena_manager_path)
	if not arena_manager:
		arena_manager = get_parent().get_node_or_null("ArenaManager")
		
	if arena_manager:
		arena_manager.room_cleared.connect(_on_room_cleared)
	else:
		push_warning("ExitGate: ArenaManager not found. Gate will default to open!")
		_on_room_cleared()
		
	# Create programmatic collision barrier if none is designed
	_setup_solid_barrier()
	
	# Start as locked
	_set_locked_state(true)

func _setup_visuals() -> void:
	var has_visual = false
	for child in get_children():
		if child is Sprite2D or child is AnimatedSprite2D or child is ColorRect:
			has_visual = true
			break
	if not has_visual:
		var rect = ColorRect.new()
		rect.name = "PlaceholderVisual"
		rect.size = Vector2(32, 32)
		rect.position = Vector2(-16, -16)
		add_child(rect)

func _setup_solid_barrier() -> void:
	# Look for existing StaticBody2D
	for child in get_children():
		if child is StaticBody2D:
			solid_barrier = child
			break
			
	if not solid_barrier:
		solid_barrier = StaticBody2D.new()
		solid_barrier.name = "SolidBarrier"
		add_child(solid_barrier)
		
		var shape_node = CollisionShape2D.new()
		var box = RectangleShape2D.new()
		box.size = Vector2(32, 32)
		shape_node.shape = box
		solid_barrier.add_child(shape_node)

	# Ensure the Area2D has a collision trigger shape
	var has_trigger = false
	for child in get_children():
		if child is CollisionShape2D and child.get_parent() == self:
			has_trigger = true
			break
	if not has_trigger:
		var trigger_shape = CollisionShape2D.new()
		var box = RectangleShape2D.new()
		box.size = Vector2(40, 40) # slightly larger than the barrier
		trigger_shape.shape = box
		add_child(trigger_shape)

func _set_locked_state(locked: bool) -> void:
	if solid_barrier:
		for child in solid_barrier.get_children():
			if child is CollisionShape2D:
				child.set_deferred("disabled", not locked)
				
	# If we have the placeholder rect, modulate it. Otherwise modulate the whole gate.
	var visual = get_node_or_null("PlaceholderVisual")
	if visual and visual is ColorRect:
		visual.color = Color(0.9, 0.2, 0.2, 0.8) if locked else Color(0.2, 0.9, 0.2, 0.8)
	else:
		modulate = Color(1.0, 0.4, 0.4, 1.0) if locked else Color(0.4, 1.0, 0.4, 1.0)

func _on_room_cleared() -> void:
	is_open = true
	_set_locked_state(false)
	
	# Tiny visual bump effect
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.15, 1.15), 0.1)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)

func _on_body_entered(body: Node2D) -> void:
	if not is_open:
		return
		
	# Check if player entered the trigger area
	if body.name == "Player" or body.has_method("attacks"):
		_trigger_victory()

func _trigger_victory() -> void:
	is_open = false # prevent duplicate triggering
	print("Victory! Entering gate.")
	
	# Update HUD text if available
	var hud = get_tree().current_scene.get_node_or_null("HUD")
	if hud and hud.has_node("Label"):
		var label = hud.get_node("Label") as Label
		if label:
			label.text = "STAGE CLEARED! Waking the region..."
			
	# Fade out player and gate
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 1.0)
	
	await get_tree().create_timer(1.8).timeout
	get_tree().reload_current_scene()
