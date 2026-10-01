extends Control

func _ready():
	$CenterContainer/VBoxContainer/Button.pressed.connect(_go_to_main)

func _go_to_main():
	print("BUTTON CLICKED")

	var error = get_tree().change_scene_to_file("res://MainScreen.tscn")
	print("Scene change error: ", error)
