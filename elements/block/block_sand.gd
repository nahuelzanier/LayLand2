extends "res://elements/block/_block_abstract.gd"

func _ready():
	disable_collision_shape()
	tag = Tag.sand
	color_gradient()
	unlift_function = "unlift_sand"
