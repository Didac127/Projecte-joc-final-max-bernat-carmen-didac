extends Area2D

var velocitat = 4500
var timer_etapes=0

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer_etapes=0
	scale=Vector2(0.001,0.001)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_etapes==0:
		scale += Vector2(0.75,0.75)*delta
	if timer_etapes>0 and timer_etapes<2:
		position.x += velocitat * delta
	if timer_etapes>=2:
		queue_free()


func _on_Timer_timeout():
	timer_etapes=timer_etapes+1
