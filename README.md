# Godot Template Project

A well-structured Godot 4 template with a clean scene management system.

## Architecture

This template uses a **scene-based architecture** with a centralized scene management system:

### Main Entry Point: `game.gd`
- Located at `scripts/game.gd`
- Serves as the main entry point for the entire game
- Contains a `CurrentScene` node that acts as a container for all game scenes
- Automatically loads the main menu on startup

### Scene Management: `SceneManager`
- Singleton located at `singletons/scene_manager.gd`
- Handles all scene transitions throughout the game
- Provides a clean API for changing scenes without manual node management
- Automatically handles cleanup of previous scenes

### How It Works
1. The `game.tscn` scene is set as the main scene in the project
2. `game.gd` initializes the `SceneManager` with the `CurrentScene` container
3. All scene changes go through the `SceneManager`, which:
   - Removes the current scene from the container
   - Loads and instantiates the new scene
   - Adds it to the container

### Project Structure
```
godot-template/
├── scripts/
│   ├── game.gd              # Main entry point
│   └── menus/
├── scenes/
│   ├── game.tscn            # Root scene with CurrentScene container
│   └── menus/
├── singletons/
│   ├── scene_manager.gd     # Scene transition system
│   ├── signal_manager.gd    # Global signal management
│   └── uuid_manager.gd      # UUID generation utilities
└── assets/
```

### Usage
To change scenes in your game, simply call:
```gdscript
SceneManager.change_scene("res://path/to/your/scene.tscn")
```
