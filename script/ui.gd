extends Control

@onready var time_label := $MarginContainer/PanelContainer/Label
var time := 0.0
var running:=false
var start_time:int
var stop_time:int

@export var theme_utilise:Theme
@export var theme_non_utilise:Theme

func _ready():
	start()


func _process(delta):
	if running:
		stop_time = Time.get_ticks_msec()
	update_text()

func start():
	running = true
	start_time = Time.get_ticks_msec()

func stop():
	running = false

func update_text():
	var time := stop_time-start_time #miliseconds
	var minutes : int = time / 60000
	time -= minutes * 60000 
	var seconds := time/1000
	time -= seconds * 1000 
	var milliseconds := time
	time_label.text = "%02d:%02d:%03d" % [minutes, seconds, milliseconds]


func _on_arrivee_player_arrive():
	stop()


@onready var map_input_fleurs : Dictionary = {
	"bourgeon_abeille":$MarginContainer/PanelAbeille/HB/HBBourgeon/LabelBourgeon,
	"pissenlit_abeille":$MarginContainer/PanelAbeille/HB/HBPissenlit/LabelPissenlit,
	"liseron_abeille": $MarginContainer/PanelAbeille/HB/HBLiseron/LabelLiseron,
	"tournesol_abeille": $MarginContainer/PanelAbeille/HB/HBTournesol/LabelTournesol,
}


func _on_abeille_fleur_rappelee(action_fleur):
	map_input_fleurs[action_fleur].theme = theme_non_utilise


func _on_abeille_fleur_utilise(action_fleur):
	map_input_fleurs[action_fleur].theme = theme_utilise
