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
			#GameGlobal.layers[0][i].get_block().born_stone()
#
##UNLIFT
#func unlift_default(player, level_layer, mouse_position):
	#player.state_manager.change_state("idle", player.position.direction_to(get_global_mouse_position()))
	#var iso_pos = IsometricConverter._pos_to_iso(mouse_position)
	#deposit_block_on_top(player, iso_pos)
#
#func unlift_empty(player, _level_layer, mouse_position):
	#var pla_iso = IsometricConverter._pos_to_iso(player.feet_position.global_position)
	#var iso_pos = IsometricConverter._pos_to_iso(global_position)
	#var dir = iso_pos - pla_iso
	#if dir.length() == 1:
		#if GameGlobal.layers[0].has(iso_pos + dir):
			#GameGlobal.layers[0][iso_pos + dir].get_block().sliding_stone(iso_pos)
#
##OTHER
##...
