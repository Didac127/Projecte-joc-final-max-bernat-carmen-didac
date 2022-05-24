extends Control


func _ready():
	pass


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Escenes/nivell Medieval.tscn")


func _on_boto_exit_pressed():
	get_tree().quit()
