extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var animationStartTime= 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

# these will be for the alternate method where 
# the notes all get created, and then when they are
# all dont, they will fire the animations based off 
# of these values that are gotten from their respective
# time arrays. 
# TODO - shorten this explanation
func set_animationStartTime(startTime):
	animationStartTime = startTime

func get_animationStartTime():
	return animationStartTime

func _on_AnimationPlayer_animation_finished(_anim_name):
	
	#$CPUParticles.set_emitting(true)
	#$AudioStreamPlayer3D.play(0.0)
	$LabelNumber.queue_free()
	$LabelRect.queue_free()
	yield(get_tree().create_timer(2), "timeout")
	queue_free()
	pass # Replace with function body.
