extends CharacterBody2D

const SPEED = 300.0
var last_direction: Vector2 = Vector2.RIGHT
var is_attacking: bool = false
var is_dead: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Combat components
var health_component: HealthComponent
var hurtbox: Hurtbox
var weapon_hitbox: Hitbox

# ===============================================
#  INITIALIZATION
# ===============================================

func _ready() -> void:
	# 1. Health Component setup
	if has_node("HealthComponent"):
		health_component = $HealthComponent
	else:
		health_component = HealthComponent.new()
		health_component.name = "HealthComponent"
		add_child(health_component)
		
	# 2. Hurtbox setup
	if has_node("Hurtbox"):
		hurtbox = $Hurtbox
	else:
		hurtbox = Hurtbox.new()
		hurtbox.name = "Hurtbox"
		add_child(hurtbox)
	hurtbox.health_component = health_component
	
	# Setup fallback collision shape for Hurtbox if none exists
	if _get_collision_shape_count(hurtbox) == 0:
		var shape_node = CollisionShape2D.new()
		var circle = CircleShape2D.new()
		circle.radius = 16.0
		shape_node.shape = circle
		hurtbox.add_child(shape_node)

	# 3. Weapon Hitbox setup
	if has_node("WeaponHitbox"):
		weapon_hitbox = $WeaponHitbox
	else:
		weapon_hitbox = Hitbox.new()
		weapon_hitbox.name = "WeaponHitbox"
		add_child(weapon_hitbox)
		
	# Setup fallback collision shape for Hitbox if none exists
	if _get_collision_shape_count(weapon_hitbox) == 0:
		var shape_node = CollisionShape2D.new()
		var circle = CircleShape2D.new()
		circle.radius = 20.0
		shape_node.shape = circle
		weapon_hitbox.add_child(shape_node)

	# Disable hitbox by default
	weapon_hitbox.monitoring = false
	weapon_hitbox.monitorable = false

	# Connect signals
	health_component.died.connect(_on_died)

func _get_collision_shape_count(node: Node) -> int:
	var count = 0
	for child in node.get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			count += 1
	return count

# ===============================================
#  MOVEMENT & ANIMATION
# ===============================================

func _physics_process(_delta: float) -> void:
	if is_dead:
		velocity = Vector2.ZERO
		return

	if Input.is_action_just_pressed("attack_1") and not is_attacking:
		attacks("attack_1")
		
	# No movement if attacking
	if is_attacking:
		velocity = Vector2.ZERO
		return

	process_movement()
	process_animation()
	move_and_slide()

func process_movement() -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		last_direction = direction
	else:
		velocity = Vector2.ZERO

func process_animation() -> void:
	if is_attacking:
		return
	if velocity != Vector2.ZERO:
		play_animation("run", last_direction)
	else:
		play_animation("idle", last_direction)

func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x != 0:
		animated_sprite_2d.flip_h = dir.x < 0
		animated_sprite_2d.play(prefix + "_side")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "_up")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "_down")

# ===============================================
#  ATTACKS
# ===============================================

func attacks(type: String) -> void: 
	is_attacking = true
	play_animation(type, last_direction)
	
	# Position the weapon hitbox based on direction
	if weapon_hitbox:
		var offset_dist = 24.0
		weapon_hitbox.position = last_direction.normalized() * offset_dist
		weapon_hitbox.monitoring = true
		weapon_hitbox.monitorable = true

func _on_animated_sprite_2d_animation_finished() -> void:
	# Make sure the finished animation is indeed an attack
	if animated_sprite_2d.animation.begins_with("attack_1"):
		is_attacking = false
		if weapon_hitbox:
			weapon_hitbox.monitoring = false
			weapon_hitbox.monitorable = false

# ===============================================
#  COMBAT EVENTS
# ===============================================

func _on_died() -> void:
	is_dead = true
	velocity = Vector2.ZERO
	if animated_sprite_2d:
		animated_sprite_2d.play("idle_down")
		animated_sprite_2d.modulate = Color.DARK_GRAY
	
	# Reload current level after short delay
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()

