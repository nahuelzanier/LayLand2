extends "res://elements/block/_block_abstract.gd"

var is_empty = true

func _ready():
	tag = Tag.no_access

func player_unlift_action(iso_mouse): pass
	
func color_gradient(): pass

func set_collisions(layer):
	collision = layer + 1

func disable_collisions(): pass

func disable_collision_shape(): pass

func enable_collision_shape(): pass
