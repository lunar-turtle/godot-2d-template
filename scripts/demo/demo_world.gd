extends Node2D

func _ready():
    Logger.debug("Demo Log statement %s" % UuidManager.v4())
