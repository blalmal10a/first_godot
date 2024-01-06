extends CharacterBody2D

@onready var sprite_2d = $Sprite2D


const SPEED = 350.0
const JUMP_VELOCITY = -485

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		sprite_2d.animation = "running"
		sprite_2d.flip_h = velocity.x <0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite_2d.animation = "default"


	move_and_slide()
