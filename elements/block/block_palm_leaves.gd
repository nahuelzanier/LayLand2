extends "res://elements/block/_block_abstract.gd"

func _ready():
	disable_collision_shape()
	tag = Tag.palm_leaves
	color_gradient()
	unlift_function = "unlift_palm_leaves"
