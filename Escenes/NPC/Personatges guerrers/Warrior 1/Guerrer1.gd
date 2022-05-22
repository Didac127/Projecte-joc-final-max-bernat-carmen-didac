extends KinematicBody2D

const gravity = 10
const speed = 30
const FLOOR = Vector2 (0, -1)

var velocity = Vector2()

var direction = 1



func _ready():
	pass

func _physics_process(delta):
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
		

	
	
	
