extends "res://elements/block/_block_abstract.gd"

func _ready():
	disable_collision_shape()
	tag = Tag.wood_piece
	color_gradient()
	unlift_function = "unlift_wood_piece"
