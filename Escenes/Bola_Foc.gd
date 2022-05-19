extends Area2D

var velocitat = 200
var timer_etapes=0

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer_etapes=0
	scale=Vector2(0.001,0.001)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_etapes==0:
		scale += Vector2(0.3,0.3)*delta
	if timer_etapes==1:
		position.x += velocitat * delta


func _on_AnimationPlayer_animation_finished(anim_name):
	if timer_etapes>1:
		queue_free()


func _on_Timer_timeout():
	timer_etapes=timer_etapes+1