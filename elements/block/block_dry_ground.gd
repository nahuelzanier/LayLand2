extends "res://elements/block/_block_abstract.gd"

var c_layers_floor = []
var c_masks_floor = []
var c_layers_creature = []
var c_masks_creature = []
var is_empty = false

func on_born():
	var iso_pos = IsometricConverter._pos_to_iso(global_position)
	var adjacent_tiles = [iso_pos + Vector2(1,0), iso_pos + Vector2(-1,0), iso_pos + Vector2(0,1), iso_pos + Vector2(0,-1)]
	for i in adjacent_tiles:
		if GameGlobal.layers[0].has(i):
			GameGlobal.layers[0][i].get_block().born_dry_ground()

##UNLIFT
#func unlift_empty(player, _level_layer, mouse_position): pass
#
#func unlift_default(player, _level_layer, mouse_position):
	#player.state_manager.change_state("idle", player.position.direction_to(get_global_mouse_position()))
	#var iso_pos = IsometricConverter._pos_to_iso(mouse_position)
	#deposit_block_on_top(player, iso_pos)
#
##BORN
#func born_water():
	#water_ground()
##OTHER
##...
#
##SPECIFIC TO DRY_GROUND
#func drying_up():
	#$AnimatedSprite2D.animation = "drying_up"
	#$AnimatedSprite2D.play()
#
#func water_ground():
	#$AnimatedSprite2D.animation = "get_wet"
	#$AnimatedSprite2D.play()
#
#func _on_animated_sprite_2d_animation_finished():
	#if $AnimatedSprite2D.animation == "get_wet":
		#replace_block_on_floor(GameGlobal.preload_scenes.BLOCK_SOIL.instantiate(), IsometricConverter._pos_to_iso(global_position))
