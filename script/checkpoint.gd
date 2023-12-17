extends Area2D

@export var gradient_active:GradientTexture1D

func _on_body_entered(body):
	(body as Player).last_checkpoint = global_position
	$Sprite2D.texture = gradient_active
