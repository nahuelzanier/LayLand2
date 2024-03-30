extends "res://elements/block/_block_abstract.gd"

var is_empty = true

func _ready():
	tag = "empty"

func player_unlift_action(iso_mouse):
	var column = GameGlobal.render_layers[Vector2i(iso_mouse.x, iso_mouse.y)]
	column.column[column.top()].block.unlift_empty()

func drop(): pass

func set_collisions(layer): pass

func disable_collisions(): pass

func disable_collision_shape(): pass

func enable_collision_shape(): pass

#UNLIFT
func unlift_default():
	if GameGlobal.render_layers[Vector2i(iso_pos.x, iso_pos.y)].top() < 17:
		GameGlobal.render_layers[Vector2i(iso_pos.x, iso_pos.y)].add_top(GameGlobal.PRELOAD[GameGlobal.player.block_held.block_held.tag])
		GameGlobal.player.block_held.replace_player_block(GameGlobal.preload_scenes.BLOCK_EMPTY)
