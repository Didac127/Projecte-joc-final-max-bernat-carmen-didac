extends Area2D


var velocitat=Vector2(0,0)
# Called when the node enters the scene tree for the first time.
var timer_etapes=0
var pendent=0
var eliminar_bola=false
var posicio_inicial=Vector2(0,0)
func _ready():
	eliminar_bola=false
	$AnimatedSprite.animation="foc"
	$AnimatedSprite2.animation="foc"
	$AnimatedSprite3.animation="foc"
	scale=Vector2(0.001,0.001)
	posicio_inicial=global_position
	print(posicio_inicial)
	var posicio_mouse=get_global_mouse_position()
	velocitat=posicio_mouse-global_position
	pendent = velocitat.normalized()
	velocitat=velocitat*2.2
	
func _process(delta):
	if eliminar_bola==true:
		$AnimatedSprite.animation="explosio"
		$AnimatedSprite2.animation="explosio"
		$AnimatedSprite3.animation="explosio"
	elif timer_etapes==0:
		scale += Vector2(0.15,0.15)*delta
	elif timer_etapes>0 and timer_etapes<2:
		position += velocitat*delta
	elif timer_etapes>=2:
		queue_free()


func _on_Timer_timeout():
	timer_etapes=timer_etapes+1


func _on_BolaFoc_body_entered(body):
	if body.is_in_group("Persoantge principal"):
		pass
	else:
		eliminar_bola=true


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation=="explosio":
		queue_free()
