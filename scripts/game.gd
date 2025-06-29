extends Node

@onready var current_scene: Node = $CurrentScene

const MAIN_MENU = "res://scenes/menus/main_menu/main_menu.tscn"

func _ready() -> void:
    SceneManager.setup_scene_container(current_scene)
    SceneManager.change_scene(MAIN_MENU)
