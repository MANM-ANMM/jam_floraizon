extends Area2D

signal player_accroche(player:Player)
signal player_decroche(player:Player)

var accroche := false
var player : Player = null
var player_parent :Node2D = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("action_player"):
		if accroche:
			decrocher()
		elif not get_overlapping_bodies().is_empty():
			var p :Node2D= get_overlapping_bodies().front()
			if not p.accroche:
				accrocher(p)

func accrocher(p):
	player = p
	var offset = player.global_position - global_position
	player_parent = player.get_parent()
	player_parent.remove_child(player)
	player.accroche = true
	accroche = true
	player.position = offset
	add_child(player)
	player_accroche.emit(player)

func decrocher():
	if not accroche: return
	var offset = player.global_position - global_position
	remove_child(player)
	player.global_position = offset + global_position
	player_parent.add_child(player)
	player.accroche = false
	accroche = false
	player_decroche.emit(player)

