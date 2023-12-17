extends Area2D


signal player_arrive()

func _on_body_entered(body):
	player_arrive.emit()
