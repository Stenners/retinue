extends Area2D
class_name Hitbox

@export var damage: float = 10.0
@export var knockback_force: float = 100.0

func _init() -> void:
	# Ensure the hitbox only monitors, doesn't get monitored by default
	# to keep physics calculations clean.
	monitoring = true
	monitorable = true
