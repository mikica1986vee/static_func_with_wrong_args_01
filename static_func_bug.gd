
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
const Utils = preload("res://Utils.gd")

func _ready():
	# Initialization here
	Utils.find_nodes_by_type(Node2D)
	pass


