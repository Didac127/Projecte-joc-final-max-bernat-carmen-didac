extends KinematicBody2D

var velocitat_base=200
var velocitat=Vector2.ZERO
var direccio=Vector2(1,1)
var gravetat=Vector2.DOWN*1000
var velocitat_salt=-500
var salts=1
var time=0
var dins_herba = false


func _physics_process(delta):
	if time<3:
		time=time+1*delta
	else:
		velocitat.x=0
		velocitat+=gravetat*delta
		if Input.is_action_pressed("mou dreta"):
			velocitat+=Vector2.RIGHT*velocitat_base
			print("a")
		if Input.is_action_pressed("mou esquerre"):
			velocitat+=Vector2.LEFT*velocitat_base
			print("b")
		if is_on_floor() or is_on_wall():
			salts = 2
		if Input.is_action_just_pressed("salta") and salts>0:
			velocitat.y=velocitat_salt
			salts-=1
			print("c")
	if dins_herba:
		velocitat *= 0.5
	velocitat=move_and_slide(velocitat,Vector2.UP)
	animacio(velocitat)
func animacio(velocitat):
	if velocitat.x>0:
		$AnimatedSprite.play("caminar")
		$AnimatedSprite.flip_h=false
	elif velocitat.x<0:
		$AnimatedSprite.play("caminar")
		$AnimatedSprite.flip_h=true
	if abs(velocitat.x)<0.1:
		$AnimatedSprite.play("quiet")
	if velocitat.y>0:
		$AnimatedSprite.play("saltar")


func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://Escenes/Personatges principals/Personatge1/PNG Sequences/nivell1.tscn")
	dins_herba = true

func _on_Trampa_de_Punxes_body_entered(body):
	get_tree().reload_current_scene()


func _on_Trampa_de_Punxes_2_body_entered(body):
	get_tree().reload_current_scene()
	


func _on_cofre1_body_entered(body):
	get_tree().change_scene("res://Escenes/Menu Principal.tscn")


func _on_killzone_body_entered(body):
	pass # Replace with function body.
