extends Area2D

var velocitat = 200


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Bola de foc animació bona")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += velocitat * delta


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'Bola de foc animació bona':
		queue_free()
