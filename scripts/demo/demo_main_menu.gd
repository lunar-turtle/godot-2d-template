extends Control

const DEMO_SCENE = "res://scenes/demo/demo_world.tscn"
const DEMO_MULTIPLAYER = "res://scenes/demo/demo_world_multiplayer.tscn"

@onready var ip_text_input = $MultiplayerMenu/VBoxContainer/HBoxContainer/JoinVbox/IpTextInput
@onready var multiplayer_menu = $MultiplayerMenu

func _ready():
    multiplayer_menu.hide()


func _on_button_pressed():
    SceneManager.change_scene(DEMO_SCENE)

func find_hosted_games():
    pass

func _on_play_multiplayer_demo_button_pressed():
    #SceneManager.change_scene(DEMO_MULTIPLAYER)
    multiplayer_menu.show()


func _on_hide_multiplayer_menu_button_pressed():
    multiplayer_menu.hide()


func _on_host_game_button_pressed():
    MultiplayerManager.host()
    SceneManager.change_scene(DEMO_MULTIPLAYER)


func _on_join_game_button_pressed():
    MultiplayerManager.join(ip_text_input.text)
    SceneManager.change_scene(DEMO_MULTIPLAYER)
