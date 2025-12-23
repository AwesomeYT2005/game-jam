extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -600.0
const PUSH_FORCE = 100.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Pushing blocks.
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collision_box = collision.get_collider()
		if collision_box is RigidBody2D:
			collision_box.apply_central_impulse(collision.get_normal() * -PUSH_FORCE)

	move_and_slide()
