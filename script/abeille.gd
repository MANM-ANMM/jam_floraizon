extends Node2D

const speed := 500

const nombre_fleurs_max:=3

@export var scene_bourgeon : PackedScene
@export var scene_pissenlit : PackedScene
@export var scene_liseron : PackedScene
@export var scene_tournesol : PackedScene
@export var scene_graine : PackedScene

@export var fleurs_container : Node2D

@onready var map_input_fleurs : Dictionary = {
	"bourgeon_abeille":{"scene":scene_bourgeon, "utilise": null},
	"pissenlit_abeille":{"scene" : scene_pissenlit, "utilise" : null},
	"liseron_abeille": {"scene" : scene_liseron, "utilise" : null},
	"tournesol_abeille": {"scene" : scene_tournesol, "utilise" : null},
}

func _physics_process(delta):
	var dir := Input.get_vector("move_left_abeille", "move_right_abeille", "move_up_abeille", "move_down_abeille")
	
	for action in map_input_fleurs:
		if Input.is_action_just_pressed(action):
			if map_input_fleurs[action]["utilise"] == null: 
				spawn_graine(action)
			elif map_input_fleurs[action]["utilise"].has_method("rappeler"):
				rappelle_plante(action)
	
	position += dir * delta * speed
	limit_pos()

func rappelle_plante(action:String):
	var plante = map_input_fleurs[action]["utilise"]
	map_input_fleurs[action]["utilise"] = null
	plante.rappeler()

func spawn_graine(action:String):
	var scene_fleur:PackedScene=map_input_fleurs[action]["scene"]
	var graine : Graine = scene_graine.instantiate()
	map_input_fleurs[action]["utilise"] = graine
	graine.scene_fleur = scene_fleur
	graine.global_position = global_position
	fleurs_container.add_child(graine)
	graine.fleur_spawned.connect(func (f): map_input_fleurs[action]["utilise"] = f)


func limit_pos():
	var limits := get_viewport_rect().size/2
	if (abs(position.x) > limits.x):
		position.x = sign(position.x)*limits.x
	if (abs(position.y) > limits.y):
		position.y = sign(position.y)*limits.y
