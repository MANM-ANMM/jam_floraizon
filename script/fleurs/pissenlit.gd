extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var masse := 0.41
const masse_player := 1.0
const masse_coupe := -0.4
var coupe:= false :
	set(val):
		if coupe == val:
			return
		coupe = val
		if coupe:
			#velocity.y += JUMP_VELOCITY
			masse += masse_coupe


@onready var accroche := $Accroche

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if velocity.y>0:
			velocity.y += gravity * delta * masse * 0.02
		else:
			velocity.y += gravity * delta * masse
	
	if accroche.accroche:
		if is_on_floor() and Input.is_action_just_pressed("jump_player"):
			velocity.y += JUMP_VELOCITY
		
		var direction := Input.get_axis("move_left_player", "move_right_player")
		if direction:
			velocity.x = move_toward(velocity.x, direction*SPEED, delta*SPEED)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED/10)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/100)
	
	move_and_slide()


func _on_accroche_player_accroche(player:Player):
	masse += masse_player
	velocity += player.velocity*0.8
	coupe = true


func _on_accroche_player_decroche(player:Player):
	player.velocity = velocity
	masse -= masse_player
