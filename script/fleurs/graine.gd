extends Area2D
class_name Graine

var scene_fleur:PackedScene
const speed:=750

signal fleur_spawned(fleur)
signal graine_wasted()

func _physics_process(delta):
	position.y += delta * speed

func _on_body_entered(body):
	if is_queued_for_deletion(): return
	queue_free()
	
	
	if not (body is TileMap) and not(body.collision_layer & 1):
		graine_wasted.emit()
		return
	
	construire_fleur.call_deferred()

func construire_fleur():
	var fleur:Node2D= scene_fleur.instantiate()
	fleur.position = position+Vector2.UP*5
	add_sibling.call_deferred(fleur)
	fleur_spawned.emit(fleur)

func rappeler():
	queue_free()
