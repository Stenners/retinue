extends Node
class_name HealthComponent

signal health_changed(current: float, max: float)
signal damaged(amount: float)
signal healed(amount: float)
signal died()

@export var max_health: float = 100.0

var current_health: float

func _ready() -> void:
	current_health = max_health
	health_changed.emit(current_health, max_health)

func take_damage(amount: float) -> void:
	if amount <= 0:
		return
	
	current_health = max(0.0, current_health - amount)
	health_changed.emit(current_health, max_health)
	damaged.emit(amount)
	
	if current_health <= 0.0:
		died.emit()

func heal(amount: float) -> void:
	if amount <= 0 or current_health <= 0.0:
		return
	
	current_health = min(max_health, current_health + amount)
	health_changed.emit(current_health, max_health)
	healed.emit(amount)

func get_health_percent() -> float:
	if max_health <= 0:
		return 0.0
	return current_health / max_health
