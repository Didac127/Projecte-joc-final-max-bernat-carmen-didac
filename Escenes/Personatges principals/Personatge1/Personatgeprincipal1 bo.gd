extends KinematicBody2D

var velocitat_base=200
var velocitat=Vector2.ZERO
var direccio=Vector2(1,1)
var gravetat=Vector2.DOWN*1000
var velocitat_salt=-500
var salts=1
var paralitzat=true

func _physics_process(delta):
	if paralitzat==false:
		pass
	else:
		velocitat.x=0
		velocitat+=gravetat*delta
		if Input.is_action_pressed("mou dreta"):
			velocitat+=Vector2.RIGHT*velocitat_base
		if Input.is_action_pressed("mou esquerre"):
			velocitat+=Vector2.LEFT*velocitat_base
		if is_on_floor():
			salts = 1
		if Input.is_action_just_pressed("salta") and salts>0:
			velocitat.y=velocitat_salt
			salts-=1
		if Input.is_action_just_pressed("atacar"):
			crea_bola_foc()

	velocitat=move_and_slide(velocitat,Vector2.UP)
	animacio(velocitat)
func animacio(velocitat):
	if velocitat.x>0:
		$AnimatedSprite.play("caminar")
		$AnimatedSprite.flip_h=false
	elif velocitat.x<0:
		$AnimatedSprite.play("caminar")
		$AnimatedSprite.flip_h=true
	if velocitat.y>0:
		$AnimatedSprite.play("saltar") 
	elif abs(velocitat.x)<0.1:
		$AnimatedSprite.play("quiet")
		
func crea_bola_foc():
	var escena_bola = preload("res://Escenes/Bola_Foc.tscn")
	var nova_bola = escena_bola.instance()
	nova_bola.global_position = $SortidaBola.global_position
	add_child(nova_bola)
