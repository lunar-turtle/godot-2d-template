extends Node

var current_scene_container: Node = null

func setup_scene_container(container: Node) -> void:
    current_scene_container = container

func change_scene(scene_path: String) -> void:
    if not current_scene_container:
        push_error("SceneManager: Scene container not set up! Call setup_scene_container first.")
        return
        
    # Remove current scene
    if current_scene_container.get_child_count() > 0:
        var old_scene = current_scene_container.get_child(0)
        old_scene.queue_free()
    
    # Load and add new scene
    var new_scene = load(scene_path).instantiate()
    current_scene_container.add_child(new_scene)
