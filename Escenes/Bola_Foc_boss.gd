extends Area2D
var velocitat=400
var direccio=1

func _physics_process(delta):
	$AnimatedSprite.animation="foc"
	$AnimatedSprite2.animation="foc"
	$AnimatedSprite3.animation="foc"
	global_position.x+=velocitat*delta*direccio
	if global_position.x>2000 or global_position.x<-500:
		direccio*=-1
