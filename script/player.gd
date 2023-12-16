extends CharacterBody2D
class_name Player

const SPEED := 300.0
const JUMP_VELOCITY := -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var accroche := false

@onready var animated_sprite := $AnimatedSprite2D

func _process(delta):
	if (sign(velocity.x) != 0):
		animated_sprite.scale.x = sign(velocity.x)
	
	if is_on_floor():
		animated_sprite.play("run", 3*velocity.x/SPEED)
	
	if accroche:
		animated_sprite.stop()


func _physics_process(delta):
	if accroche:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump_player") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("jump", 1.2)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left_player", "move_right_player")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
