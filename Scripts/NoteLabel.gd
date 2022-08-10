extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_AnimationPlayer_animation_finished(_anim_name):
	
	#$CPUParticles.set_emitting(true)
	#$AudioStreamPlayer3D.play(0.0)
	$LabelNumber.queue_free()
	$LabelRect.queue_free()
	yield(get_tree().create_timer(2), "timeout")
	queue_free()
	pass # Replace with function body.
