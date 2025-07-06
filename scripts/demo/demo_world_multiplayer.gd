extends Node2D

@onready var connected_players_amt = $CanvasLayer/ConnectedPlayersText/ConnectedPlayersAmt
@onready var connected_players = $ConnectedPlayers

func _ready():
    Logger.debug("Demo Log statement %s" % UuidManager.v4())
    SignalManager.on_update_player_count.connect(_on_update_player_count)
    SignalManager.on_player_joined_world.connect(_on_player_joined_world)

    if multiplayer.is_server():
        MultiplayerManager._add_player(1)
    
func _on_update_player_count(count: int):
    connected_players_amt.text = str(count)
    
    
func _on_player_joined_world(peer_id: int):
    Logger.debug("Player %d has joined the world" % peer_id)
    spawn_player(peer_id)
    
func spawn_player(peer_id: int):
    var player = preload("res://scenes/demo/demo_player.tscn").instantiate()
    player.name = str(peer_id)
    player.set_multiplayer_authority(peer_id)
    
    Logger.debug("Spawning player %d at position %s" % [peer_id, Vector3(0, 1.4, 0)])
    
    # Add the player first
    connected_players.add_child(player)

    return player
