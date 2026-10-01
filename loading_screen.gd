extends Control

@onready var progress_bar: ProgressBar = $CenterContainer/VBoxContainer/ProgressBar

func _ready():
	progress_bar.value = 0

	var tween = create_tween()
	tween.tween_property(progress_bar, "value", 100.0, 2.0)

	await tween.finished

	get_tree().change_scene_to_file("res://StartScreen.tscn")
