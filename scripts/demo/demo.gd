extends Node2D

const logger = preload("res://scripts/utils/logger.gd")

func _ready():
    logger.debug("Demo Log statement %s" % UuidManager.v4())
