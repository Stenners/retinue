extends CharacterBody2D

enum State { IDLE, CHASE, TELEGRAPH, LUNGE, RECOVERY, DEAD }
var current_state: State = State.IDLE

@export var speed: float = 110.0
@export var detection_range: float = 220.0
@export var attack_range: float = 40.0
@export var attack_cooldown: float = 1.6

# Lunge attack timing / velocities
var lunge_direction: Vector2 = Vector2.ZERO
var attack_timer: float = 0.0
var state_timer: float = 0.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var player: Node2D
var health_component: HealthComponent
var hurtbox: Hurtbox
var weapon_hitbox: Hitbox

func _ready() -> void:
	# 1. Health Component setup
	if has_node("HealthComponent"):
		health_component = $HealthComponent
	else:
		health_component = HealthComponent.new()
		health_component.name = "HealthComponent"
		health_component.max_health = 30.0
		add_child(health_component)
		
	# 2. Hurtbox setup
	if has_node("Hurtbox"):
		hurtbox = $Hurtbox
	else:
		hurtbox = Hurtbox.new()
		hurtbox.name = "Hurtbox"
		add_child(hurtbox)
	hurtbox.health_component = health_component
	
	if _get_collision_shape_count(hurtbox) == 0:
		var shape_node = CollisionShape2D.new()
		var circle = CircleShape2D.new()
		circle.radius = 12.0
		shape_node.shape = circle
		hurtbox.add_child(shape_node)

	# 3. Weapon Hitbox setup
	if has_node("WeaponHitbox"):
		weapon_hitbox = $WeaponHitbox
	else:
		weapon_hitbox = Hitbox.new()
		weapon_hitbox.name = "WeaponHitbox"
		weapon_hitbox.damage = 15.0
		add_child(weapon_hitbox)
		
	if _get_collision_shape_count(weapon_hitbox) == 0:
		var shape_node = CollisionShape2D.new()
		var circle = CircleShape2D.new()
		circle.radius = 14.0
		shape_node.shape = circle
		weapon_hitbox.add_child(shape_node)

	# Disable hitbox by default
	weapon_hitbox.monitoring = false
	weapon_hitbox.monitorable = false

	# Connect death signal
	health_component.died.connect(_on_died)
	
	# Locate player reference
	_find_player()

func _find_player() -> void:
	var parent = get_parent()
	if parent:
		player = parent.get_node_or_null("Player")

func _get_collision_shape_count(node: Node) -> int:
	var count = 0
	for child in node.get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			count += 1
	return count

func _physics_process(delta: float) -> void:
	if current_state == State.DEAD:
		return
		
	if not player or not is_instance_valid(player):
		_find_player()
		velocity = Vector2.ZERO
		move_and_slide()
		return
		
	if attack_timer > 0.0:
		attack_timer -= delta
		
	var to_player = player.global_position - global_position
	var distance = to_player.length()
	
	match current_state:
		State.IDLE:
			velocity = Vector2.ZERO
			animated_sprite_2d.play("idle_side")
			if distance <= detection_range:
				current_state = State.CHASE
				
		State.CHASE:
			animated_sprite_2d.play("run_side")
			if distance > detection_range:
				current_state = State.IDLE
			elif distance <= attack_range and attack_timer <= 0.0:
				current_state = State.TELEGRAPH
				state_timer = 0.35 # telegraph pause time
				velocity = Vector2.ZERO
				
				# Flash color to telegraph the attack
				var tween = create_tween()
				tween.tween_property(animated_sprite_2d, "modulate", Color(2, 1.5, 1.5, 1), 0.15)
				tween.tween_property(animated_sprite_2d, "modulate", Color.WHITE, 0.15)
			else:
				var dir = to_player.normalized()
				velocity = dir * speed
				animated_sprite_2d.flip_h = dir.x < 0
				
		State.TELEGRAPH:
			state_timer -= delta
			if state_timer <= 0.0:
				current_state = State.LUNGE
				state_timer = 0.15 # duration of active dash/hitbox
				lunge_direction = to_player.normalized()
				velocity = lunge_direction * (speed * 2.8)
				
				# Activate and position the hitbox
				if weapon_hitbox:
					weapon_hitbox.position = lunge_direction * 14.0
					weapon_hitbox.monitoring = true
					weapon_hitbox.monitorable = true
				
		State.LUNGE:
			state_timer -= delta
			if state_timer <= 0.0:
				current_state = State.RECOVERY
				state_timer = 0.3 # recovery stun time
				velocity = Vector2.ZERO
				
				# Disable the hitbox
				if weapon_hitbox:
					weapon_hitbox.monitoring = false
					weapon_hitbox.monitorable = false
				
		State.RECOVERY:
			state_timer -= delta
			if state_timer <= 0.0:
				current_state = State.CHASE
				attack_timer = attack_cooldown
				
	move_and_slide()

func _on_died() -> void:
	current_state = State.DEAD
	velocity = Vector2.ZERO
	
	if hurtbox:
		hurtbox.monitoring = false
		hurtbox.monitorable = false
	if weapon_hitbox:
		weapon_hitbox.monitoring = false
		weapon_hitbox.monitorable = false
		
	# Death animation: spin and shrink out
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(animated_sprite_2d, "rotation", PI * 3.0, 0.6)
	tween.tween_property(animated_sprite_2d, "scale", Vector2.ZERO, 0.6)
	tween.tween_property(animated_sprite_2d, "modulate", Color(0.8, 0.1, 0.1, 0), 0.6)
	
	tween.chain().tween_callback(queue_free)
