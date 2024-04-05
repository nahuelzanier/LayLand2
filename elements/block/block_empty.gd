extends "res://elements/block/_block_abstract.gd"

var is_empty = true

func _ready():
	tag = Tag.empty
	unlift_function = "unlift_empty"
#
func disable_collision_shape(): pass

func enable_collision_shape(): pass

##UNLIFT
#func unlift_default():
	#get_iso_pos()
	#if GameGlobal.render_layers[Vector2i(iso_pos.x, iso_pos.y)].top() < 17:
		#GameGlobal.render_layers[Vector2i(iso_pos.x, iso_pos.y)].add_top(GameGlobal.player.block_held.block_held.tag)
		#GameGlobal.player.block_held.replace_player_block(GameGlobal.preload_scenes.BLOCK_EMPTY)

