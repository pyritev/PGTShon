extends KinematicBody2D

var size_properties = {
	1: {"scale": 1, "life": 1},
	2: {"scale": 1.3, "life": 2},
	3: {"scale": 1.5, "life": 3}
	}

var size = 1
var life
var motion = Vector2.ZERO
var speed = 100
var died = false

# Called when the node enters the scene tree for the first time.
func _ready():
	life = size
	self.scale.x = size_properties[size]["scale"]
	self.scale.y = size_properties[size]["scale"]


func _process(delta):
	$Label.set_text(str(life))
	move_and_slide(motion, Vector2.UP)
	motion.y = speed
	
	if life <= 0 and !died:
		get_parent().get_parent().score += size
		$CollisionShape2D.disabled = true
		$Area2D/CollisionShape2D.disabled = true
		$AnimationPlayer.play("FadeOut")
		speed = 0
		died = true
		


func _on_Area2D_input_event(viewport, event, shape_idx):
	if !$Timer.get_time_left():
		life -= 1
		$Punch.play()
		$Timer.start()


func _on_Timer_timeout():
	queue_free()


func _on_Punch_finished():
	queue_free()
