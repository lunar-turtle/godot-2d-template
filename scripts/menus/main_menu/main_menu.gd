extends Control

const DEMO_SCENE = "res://scenes/demo/demo.tscn"

func _on_button_pressed():
    SceneManager.change_scene(DEMO_SCENE)
