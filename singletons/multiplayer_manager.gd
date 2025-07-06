extends Node

# Default game server port. Can be any number between 1024 and 49151.
# Not present on the list of registered or common ports as of December 2022:
# https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers
const DEFAULT_PORT = 8910
const MAX_CLIENTS = 10

# Server is always 1
const SERVER_PEER_ID: int = 1

var peer = null
var connected_players: Dictionary = {}

func _ready():
    multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func _player_connected(_id):
    Logger.debug("Player (%d) connected." % _id)
    
func _on_peer_disconnected(peer_id: int):
    if multiplayer.is_server():
        Logger.debug("Player (%d) disconnected exeucting on %d." % [peer_id, multiplayer.get_unique_id()])

        var disconnected_player = connected_players[str(peer_id)]
        
        # TODO: Save player who disconnected position to database here. 
        # TODO: Save player who disconnected skills to database here.
        # Can access via 
        # disconnected_player.player_position
        # disconnected_player.player_skills
        #disconnected_player.player_skills.save_skill_data()

        disconnected_player.queue_free()
        connected_players.erase(peer_id)

        # This isn't used but keeping it here in case we need it.        
        SignalManager.on_player_disconnected.emit(peer_id)
        
func host():
    peer = ENetMultiplayerPeer.new()
    
    peer.create_server(DEFAULT_PORT, MAX_CLIENTS)
    multiplayer.multiplayer_peer = peer
    multiplayer.peer_connected.connect(_add_player)
    

func join(ip: String):
    peer = ENetMultiplayerPeer.new()

    # TODO: Need to figure out how to do the proper reserved ip address
    peer.create_client(ip, DEFAULT_PORT)
    
    multiplayer.multiplayer_peer = peer

func leave_game():
    if multiplayer.multiplayer_peer and not multiplayer.is_server():
        multiplayer.multiplayer_peer.disconnect_peer(SERVER_PEER_ID)

# This should only execute on the server and the spawned player will be synced to all clients
# via the multiplayer spawner on the world
func _add_player(peer_id: int):
    Logger.debug("Adding player (%d). This is running on %d." % [peer_id, multiplayer.get_unique_id()])
    
    # Get the game node and call spawn_player
    if multiplayer.is_server():
        Logger.debug("Player (%d) awaiting ready." % peer_id)
        connected_players[str(peer_id)] = peer_id
        SignalManager.on_update_player_count.emit(len(connected_players))
        SignalManager.on_player_joined_world.emit(peer_id)
