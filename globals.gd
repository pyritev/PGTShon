extends Node

var top_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	load_save()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_WhatsThis_finished():
	$AudioStreamPlayer.play()

func load_save():
	var data_file = ConfigFile.new()
	
	var err = data_file.load("user://pgtshon.bin")
	
	if err != OK:
		save_data()
		return
	
	top_score = data_file.get_value("sdata", "top_score")

func save_data():
	var data_file = ConfigFile.new()
	data_file.set_value("sdata", "top_score", top_score)
	data_file.save("user://pgtshon.bin")
