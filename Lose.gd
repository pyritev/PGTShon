extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$LoseSound.seek(1)


func _process(delta):
	if Globals.get_node("AudioStreamPlayer").is_playing():
		Globals.get_node("AudioStreamPlayer").stop()


func _on_LoseSound_finished():
	get_tree().change_scene("res://TitleScreen.tscn")
