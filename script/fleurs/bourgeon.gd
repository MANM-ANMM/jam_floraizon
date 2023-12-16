extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if Input.is_action_just_pressed("action_player") and has_overlapping_bodies():
		var body = get_overlapping_bodies().front()
		body.velocity.y-=800
		

func rappeler():
	queue_free()
