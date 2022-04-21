extends KinematicBody2D

var velocitat_base=200
var velocitat=Vector2.ZERO
var direccio=Vector2(1,1)
var gravetat=Vector2.DOWN*1000
var velocitat_salt=-500
var salts=1
var time=0

func _physics_process(delta):
	if time<3:
		time=time+1*delta
	else:
		velocitat.x=0
		velocitat+=gravetat*delta
		if Input.is_action_pressed("mou dreta"):
			velocitat+=Vector2.RIGHT*velocitat_base
		if Input.is_action_pressed("mou esquerre"):
			velocitat+=Vector2.LEFT*velocitat_base
		if is_on_floor() or is_on_wall():
			salts = 2
		if Input.is_action_just_pressed("mou endavant") and salts>0:
			velocitat.y=velocitat_salt
			salts-=1

	velocitat=move_and_slide(velocitat,Vector2.UP)
	animacio(velocitat)
func animacio(velocitat):
	if velocitat.x>0:
		$AnimatedSprite.play("corre")
		$AnimatedSprite.flip_h=false
	elif velocitat.x<0:
		$AnimatedSprite.play("corre")
		$AnimatedSprite.flip_h=true
	if abs(velocitat.x)<0.1:
		$AnimatedSprite.play("quiet")
	if velocitat.y>0:
		$AnimatedSprite.play("saltar")



func _on_Area2D_body_entered(body):
	if (body.name == "KinematicBody2D"):
		get_tree().change_scene("res://Escenes/Escena portals.tscn")
	


func _on_Area2D2_body_entered(body):
	if (body.name == "KinematicBody2D"):
		get_tree().reload_current_scene()


func _on_Area2D3_body_entered(body):
	get_tree().reload_current_scene()


func _on_Area2D4_body_entered(body):
	get_tree().reload_current_scene()





func _on_Area2D5_body_entered(body):
	get_tree().reload_current_scene()
