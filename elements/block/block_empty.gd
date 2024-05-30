extends "res://elements/block/_block_abstract.gd"

func _ready():
	tag = Tag.empty
	unlift_function = "unlift_empty"
#
func set_collisions(layer):
	collision = layer + 1

func disable_collisions(): pass

func enable_collision_shape(): pass

func disable_collision_shape(): pass

