extends KinematicBody2D

var velocitat_base=200
var velocitat=Vector2.ZERO
var direccio=Vector2(1,1)
var gravetat=Vector2.DOWN*1000
var velocitat_salt=-500
var salts=1
var paralitzat=false
var animacio_atacar=false
var gravetat_guardia=false
var vector_gravetat=Vector2(0,0)
var posiscio_guardia=Vector2(0,0)
var nom_guardia=""
var cop_guardia=false
var vida=100
var enemics_derrotats=0

func _ready():
	pass

func _physics_process(delta):
	if enemics_derrotats>5:
		get_tree().change_scene("res://Escenes/escena final boss.tscn")
	if paralitzat==true:
		pass
	else:
		velocitat.x=0
		velocitat+=gravetat*delta
		if Input.is_action_pressed("mou dreta"):
			velocitat+=Vector2.RIGHT*velocitat_base
		if Input.is_action_pressed("mou esquerre"):
			velocitat+=Vector2.LEFT*velocitat_base
		if gravetat_guardia==true:
			posiscio_guardia=nom_guardia.global_position
			vector_gravetat=posiscio_guardia-global_position
			vector_gravetat=vector_gravetat.normalized()
			vector_gravetat.y=0
			velocitat+=vector_gravetat*180
		if is_on_floor():
			salts = 1
		if Input.is_action_just_pressed("salta") and salts>0:
			velocitat.y=velocitat_salt
			salts-=1
		if Input.is_action_just_pressed("atacar"):
			if animacio_atacar==false:
				animacio_atacar=true
				crea_bola_foc()
				

	velocitat=move_and_slide(velocitat,Vector2.UP)
	animacio(velocitat)
func animacio(velocitat):
	if animacio_atacar==true:
		$AnimatedSprite.play("atacar")
	elif velocitat.y<0 or velocitat.y>0 and animacio_atacar==false:
		$AnimatedSprite.play("saltar")
	elif velocitat.x>0 and animacio_atacar==false:
		$AnimatedSprite.play("caminar")
		$AnimatedSprite.flip_h=false
	elif velocitat.x<0 and animacio_atacar==false:
		$AnimatedSprite.play("caminar")
		$AnimatedSprite.flip_h=true
	else:
		$AnimatedSprite.play("quiet")
func crea_bola_foc():
	
	var escena_bola = preload("res://Escenes/Bola_Foc.tscn")
	var nova_bola = escena_bola.instance()
	nova_bola.global_position =$Position2D.global_position
	if get_global_mouse_position()<global_position:
		$AnimatedSprite.flip_h=true
		nova_bola.global_position =Vector2(-90,0)+$Position2D.global_position
	else:
		$AnimatedSprite.flip_h=false
		nova_bola.global_position =$Position2D.global_position
	Global.Boles.add_child(nova_bola)
	
	


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation=="atacar":
		animacio_atacar=false 


func _on_Area2D_area_entered(area):
	if area.is_in_group("area de gravetat"):
		gravetat_guardia=true
		nom_guardia=area.get_parent()
	if area.is_in_group("cop guardia"):
		cop_guardia=true
	if area.is_in_group("passar nivell"):
		get_tree().change_scene("res://Escenes/escena final boss.tscn")
	if area.is_in_group("boles de foc boss"):
		vida=vida-10
		$TextureProgress.value-=10
		if vida<=0:
			get_tree().change_scene("res://Escenes/Menu/Menu_inicial.tscn")

func _on_Area2D_area_exited(area):
	if area.is_in_group("area de gravetat"):
		gravetat_guardia=false
	if area.is_in_group("cop guardia"):
		cop_guardia=false


func _on_Timer2_timeout():
	if cop_guardia==true:
		vida=vida-10
		$TextureProgress.value-=10
		if vida<=0:
			get_tree().change_scene("res://Escenes/Menu/Menu_inicial.tscn")
