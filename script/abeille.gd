extends Node2D

const speed := 500

const nombre_fleurs_max:=3
var fleurs_placees : Array

@export var scene_bourgeon : PackedScene
@export var scene_pissenlit : PackedScene
@export var scene_liseron : PackedScene
@export var scene_tournesol : PackedScene
@export var scene_graine : PackedScene

@export var fleurs_container : Node2D

@onready var map_input_fleurs : Dictionary = {
	"bourgeon_abeille":scene_bourgeon,
	"pissenlit_abeille":scene_pissenlit, 
	"liseron_abeille": scene_liseron,
	"tournesol_abeille": scene_tournesol,
}

func _physics_process(delta):
	var dir := Input.get_vector("move_left_abeille", "move_right_abeille", "move_up_abeille", "move_down_abeille")
	
	for action in map_input_fleurs:
		if Input.is_action_just_pressed(action):
			spawn_graine(map_input_fleurs[action])
	
	position += dir * delta * speed
	limit_pos()

func spawn_graine(scene_fleur:PackedScene):
	var graine : Graine = scene_graine.instantiate()
	graine.scene_fleur = scene_fleur
	graine.global_position = global_position
	fleurs_container.add_child(graine)

func limit_pos():
	var limits := get_viewport_rect().size/2
	if (abs(position.x) > limits.x):
		position.x = sign(position.x)*limits.x
	if (abs(position.y) > limits.y):
		position.y = sign(position.y)*limits.y