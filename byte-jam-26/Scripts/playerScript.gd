extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var direction = Vector2.ZERO

@onready var animation = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var get_direction := Input.get_axis("ui_left", "ui_right")
	if get_direction:
		velocity.x = get_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)



	# Animation logic
	if velocity.normalized():
		animation.play("walkAnimation")
	else:
		animation.play("idleAnimation")
		
			# Flip when negative logic
	if direction.x < 0:
		animation.flip_h = true
	elif direction.x > 0:
		animation.flip_h = false
	move_and_slide()
