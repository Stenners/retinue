extends Area2D
class_name Hurtbox

signal hit_received(damage: float, hitbox: Hitbox)

@export var health_component: HealthComponent
@export var iframe_time: float = 0.4

var is_invincible: bool = false
var _iframe_timer: Timer

func _ready() -> void:
	# Ensure the area is set up to receive collisions
	monitoring = true
	monitorable = true
	area_entered.connect(_on_area_entered)
	
	if iframe_time > 0.0:
		_iframe_timer = Timer.new()
		_iframe_timer.one_shot = true
		_iframe_timer.timeout.connect(_on_iframe_timeout)
		add_child(_iframe_timer)

func _on_area_entered(area: Area2D) -> void:
	if is_invincible:
		return
		
	if area is Hitbox:
		var hitbox := area as Hitbox
		take_hit(hitbox)

func take_hit(hitbox: Hitbox) -> void:
	if is_invincible:
		return
		
	if health_component:
		health_component.take_damage(hitbox.damage)
		
	hit_received.emit(hitbox.damage, hitbox)
	
	# Optional visual indicator (flash red)
	var parent = get_parent()
	if parent and parent.has_node("AnimatedSprite2D"):
		var sprite = parent.get_node("AnimatedSprite2D") as AnimatedSprite2D
		if sprite:
			var tween = create_tween()
			tween.tween_property(sprite, "modulate", Color.RED, 0.1)
			tween.tween_property(sprite, "modulate", Color.WHITE, 0.1)
	
	if iframe_time > 0.0:
		start_invincibility()

func start_invincibility() -> void:
	is_invincible = true
	if _iframe_timer:
		_iframe_timer.start(iframe_time)

func _on_iframe_timeout() -> void:
	is_invincible = false
