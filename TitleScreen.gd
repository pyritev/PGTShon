extends Node

var secret = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.save_data()
	$Score/ScoreLabel.set_text(str(Globals.top_score))


func _process(delta):
	if !Globals.get_node("AudioStreamPlayer").is_playing() and !Globals.get_node("WhatsThis").is_playing():
		Globals.get_node("AudioStreamPlayer").play()
		
	if secret >= 10:
		if Globals.get_node("WhatsThis").stream_paused == true:
			Globals.get_node("WhatsThis").stream_paused = false
		Globals.get_node("WhatsThis").play()
		Globals.get_node("AudioStreamPlayer").stop()
		secret = 0


func _on_Button_pressed():
	get_tree().change_scene("res://Game.tscn")

func _on_WhatsThis_pressed():
	if secret <= 10:
		secret += 1


func _on_TouchScreenButton_pressed():
	$CreditText.visible = not $CreditText.visible
	$Score.visible = not $Score.visible
	$PlayButton.visible = not $PlayButton.visible
