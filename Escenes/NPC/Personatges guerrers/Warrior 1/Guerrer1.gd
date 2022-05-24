extends KinematicBody2D

const gravity = 10
const speed = 60
const FLOOR = Vector2 (0, -1)

var velocity = Vector2()

var direction = 1
var atac=false
var atac_dreta=false
var atac_esquerre=false


func _ready():
	pass

func _physics_process(delta):
	if atac==true:
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
		


func _on_Area2D3_body_entered(body):
	if body.is_in_group("Persoantge principal") and atac==false:
		atac=true
		atac_esquerre=true


func _on_AnimatedSprite_animation_finished():
	
