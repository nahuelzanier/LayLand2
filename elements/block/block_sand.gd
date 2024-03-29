extends "res://elements/block/_block_abstract.gd"

var c_layers_floor = []
var c_masks_floor = []
var c_layers_creature = []
var c_masks_creature = []
var is_empty = false

##func player_unlift_action(_player, _mouse_position): pass
#
#func on_born():
	#var iso_pos = IsometricConverter._pos_to_iso(global_position)
	#var adjacent_tiles = [iso_pos + Vector2(1,0), iso_pos + Vector2(-1,0), iso_pos + Vector2(0,1), iso_pos + Vector2(0,-1)]
	#for i in adjacent_tiles:
		#if GameGlobal.layers[0].has(i):
			#GameGlobal.layers[0][i].get_block().born_sand()
#
##UNLIFT
#func unlift_empty(player, _level_layer, mouse_position):
	#player.state_manager.change_state("idle", player.position.direction_to(get_global_mouse_position()))
	#var iso_pos = IsometricConverter._pos_to_iso(global_position)
	#replace_block_on_floor(player.block_held.pop_block(), iso_pos)
	#var empty_block = GameGlobal.preload_scenes.BLOCK_EMPTY.instantiate()
	#player.block_held.pick_block(empty_block)
	#GameGlobal.layers[0][iso_pos].get_block().on_born()
#
#func unlift_default(player, _level_layer, mouse_position):
	#player.state_manager.change_state("idle", player.position.direction_to(get_global_mouse_position()))
	#var iso_pos = IsometricConverter._pos_to_iso(global_position)
	#replace_block_on_floor(player.block_held.pop_block(), iso_pos)
	#var empty_block = GameGlobal.preload_scenes.BLOCK_EMPTY.instantiate()
	#player.block_held.pick_block(empty_block)
	#GameGlobal.layers[0][iso_pos].get_block().on_born()
#
#func unlift_palmtree(player, level_layer, mouse_position):
	#var iso_pos = IsometricConverter._pos_to_iso(mouse_position)
	#deposit_block_on_top(player, iso_pos)
#
#func is_sand(): return true
#
##BORN
#func born_water():
	#$AnimatedSprite2D.animation = "sand_to_beach"
	#$AnimatedSprite2D.play()
#
##OTHER
##...
