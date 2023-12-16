extends Area2D
class_name Graine

var scene_fleur:PackedScene
const speed:=500


func _physics_process(delta):
	position.y += delta * speed

func _on_body_entered(body):
	queue_free()
	if not(body.collision_layer & 1):
		return
	var fleur:Node2D= scene_fleur.instantiate()
	fleur.position = position
	add_sibling.call_deferred(fleur)
	#queue_free()
