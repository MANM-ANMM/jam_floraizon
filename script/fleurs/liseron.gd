extends Node2D

@onready var accroche := $Accroche
var player :Player = null

func rappeler():
	accroche.decrocher()
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null and accroche.has_overlapping_bodies():
		var dir := Input.get_axis("move_down_player", "move_up_player")
		player.position.y -= dir * 300.0 * delta


func _on_accroche_player_accroche(p:Player):
	player = p


func _on_accroche_player_decroche(p:Player):
	player.velocity.y = player.JUMP_VELOCITY /2.0
	player = null
	
