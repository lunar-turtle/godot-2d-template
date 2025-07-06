extends CharacterBody2D

@export var speed = 400

func _enter_tree():
    set_multiplayer_authority(name.to_int())
    
func _ready() -> void:
    if not is_multiplayer_authority():
        return
        
    Logger.debug("Demo player is ready.")
    
func get_input():
    var input_direction = Input.get_vector("left", "right", "up", "down")
    velocity = input_direction * speed

func _physics_process(delta):
    if not is_multiplayer_authority():
        return
        
    get_input()
    move_and_slide()
