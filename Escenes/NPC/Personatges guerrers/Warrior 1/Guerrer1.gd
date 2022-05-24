extends KinematicBody2D

const gravity = 10
const speed = 60
const FLOOR = Vector2 (0, -1)

var velocity = Vector2()

var direction = 1
var atac=false
var atac_dreta=false
var atac_esquerre=false
var mantenir_atac=false
var health=100
var direccio_personatge=1
var enemic=false
var nom_enemic=""

func _ready():
	pass

func _physics_process(delta):
	if health <=0:
		$AnimatedSprite.play("Morir")
	elif atac==true:
		if atac_dreta==true:
			$AnimatedSprite.play("Atac1")
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.play("Atac1")
			$AnimatedSprite.flip_h = true
	else:
		velocity.x = speed * direction
		
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		
		$AnimatedSprite.play("Caminar")
		
		
		velocity.y += gravity
		
		
		velocity= move_and_slide(velocity,FLOOR)
		
		
	if enemic==true:
		if global_position>nom_enemic.global_position:
			direction=-1
		else:
			direction=1
	
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
	
	

	



func _on_Area2D_body_entered(body):
	if body.is_in_group("Persoantge principal") and atac==false:
		atac=true
		atac_dreta=true
		mantenir_atac=true
		


func _on_Area2D3_body_entered(body):
	if body.is_in_group("Persoantge principal") and atac==false:
		atac=true
		atac_esquerre=true
		mantenir_atac=true


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation=="Atac1" and mantenir_atac==false:
		atac=false
		atac_dreta=false
		atac_esquerre=false
	if $AnimatedSprite.animation=="Morir":
		queue_free()

func _on_Area2D_body_exited(body):
	if body.is_in_group("Persoantge principal"):
		mantenir_atac=false


func _on_Area2D3_body_exited(body):
	if body.is_in_group("Persoantge principal"):
		mantenir_atac=false

func _on_Area2D4_area_entered(area):
	if area.is_in_group("bola de foc"):
		health=health-10



func _on_Area2D2_body_entered(body):
	if body.is_in_group("Persoantge principal"):
		enemic=true
		nom_enemic=body
		
