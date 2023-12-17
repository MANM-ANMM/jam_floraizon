extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
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


@onready var player_shape := $PlayerShape2D
@onready var accroche := $Accroche

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func rappeler():
	accroche.decrocher()
	
	queue_free()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if velocity.y>0:
			velocity.y += gravity * delta * masse * 0.02
			$Node2D.rotation = (0.04*sin(Time.get_ticks_usec()/112000.0)*sin(Time.get_ticks_usec()/500000.0))
		else:
			velocity.y += gravity * delta * masse * 1.2
	
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
	print("test")
	var p_shape : CollisionShape2D = player.get_node("CollisionShape2D")
	player_shape.global_position = p_shape.global_position
	player_shape.shape = p_shape.shape
	player_shape.disabled = false


func _on_accroche_player_decroche(player:Player):
	player.velocity = velocity
	masse -= masse_player
	player_shape.disabled = true
