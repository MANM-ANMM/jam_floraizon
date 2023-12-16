extends Area2D
class_name Graine

var scene_fleur:PackedScene
const speed:=500

signal fleur_spawned(fleur)

func _physics_process(delta):
	position.y += delta * speed

func _on_body_entered(body):
	queue_free()
	$CollisionShape2D.disabled = true
	if not(body.collision_layer & 1):
		return
	
	construire_fleur.call_deferred()

func construire_fleur():
	var fleur:Node2D= scene_fleur.instantiate()
	fleur.position = position
	add_sibling.call_deferred(fleur)
	fleur_spawned.emit(fleur)
