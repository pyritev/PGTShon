extends Node

const MAX_OBJECTS_EASY = 5
const MAX_OBJECTS_MED = 20
const MAX_OBJECTS_HARD = 20

const DELAY_EASY = 1
const DELAY_MED = 0.5
const DELAY_HARD = 0.3

var max_objects = MAX_OBJECTS_EASY
var delay = DELAY_EASY

var lives = 3
var objects = [preload("res://objects/Burger.tscn")]
var difficulty = 1
var score = 0
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = DELAY_EASY
	rng.randomize()
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Objects.get_child_count() == 0:
		spawn_object()
	
	if lives < 0:
		if score > Globals.top_score:
			Globals.top_score = score
		get_tree().change_scene("res://Lose.tscn")
		
	if score > 50 and difficulty == 1:
		difficulty = 2
		max_objects = MAX_OBJECTS_MED
		$Timer.wait_time = DELAY_MED
	elif score > 100 and difficulty == 2:
		difficulty = 3 
		max_objects = MAX_OBJECTS_HARD
		$Timer.wait_time = DELAY_HARD
	elif score > 300:
		$Timer.wait_time = 0.1
		max_objects += 1

	$HUD/ScoreLabel.set_text(str(score))
	
	if lives == 2 and $HUD/heart1.visible:
		$HUD/heart1.visible = false
	elif lives == 1 and $HUD/heart2.visible:
		$HUD/heart2.visible = false
	elif lives == 0 and $HUD/bigheart.frame == 1:
		$HUD/bigheart.frame = 2

func spawn_object():
	if $Objects.get_child_count() <= max_objects:
		var burg = objects[0].instance()
		burg.position.y = -20
		burg.position.x = rng.randi_range(20,150)
		match difficulty:
			1: burg.speed = 100
			2: burg.speed = 115
			3: burg.speed = 130
		var size_rand = rng.randi_range(1,500)
		if size_rand < 300:
			burg.size = 1
		elif size_rand >= 300 and size_rand <= 450:
			burg.size = 2
		elif size_rand < 450:
			burg.size = 3
		$Objects.add_child(burg)
		$Timer.start()

func _on_Timer_timeout():
	spawn_object()


func _on_KillPlane_body_entered(body):
	lives -= 1
	$AnimationPlayer.play("Flash")
	body.queue_free()
	$Sounds/Crash.play()
