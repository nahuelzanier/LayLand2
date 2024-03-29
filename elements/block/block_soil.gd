extends "res://elements/block/_block_abstract.gd"

var c_layers_floor = []
var c_masks_floor = []
var c_layers_creature = []
var c_masks_creature = []
var is_empty = false

var dug = false

#func _ready():
	#$DryTimer.wait_time = GameGlobal.clock_tick
	#$DryTimer.start()
#
#func on_born():
	#var iso_pos = IsometricConverter._pos_to_iso(global_position)
	#var adjacent_tiles = [iso_pos + Vector2(1,0), iso_pos + Vector2(-1,0), iso_pos + Vector2(0,1), iso_pos + Vector2(0,-1)]
	#for i in adjacent_tiles:
		#if GameGlobal.layers[0].has(i):
			#GameGlobal.layers[0][i].get_block().born_soil()
#
##UNLIFT
#func unlift_empty(player, _level_layer, mouse_position):
	#if not dug:
		#$AnimatedSprite2D.play("dug")
		#dug = true
#
#func unlift_default(player, _level_layer, mouse_position):
	#player.state_manager.change_state("idle", player.position.direction_to(get_global_mouse_position()))
	#var iso_pos = IsometricConverter._pos_to_iso(global_position)
	#replace_block_on_floor(player.block_held.pop_block(), iso_pos)
	#var empty_block = GameGlobal.preload_scenes.BLOCK_EMPTY.instantiate()
	#player.block_held.pick_block(empty_block)
	#GameGlobal.layers[0][iso_pos].get_block().on_born()
#
#func unlift_fruit(player, level_layer, mouse_position):
	#player.state_manager.change_state("idle", player.position.direction_to(get_global_mouse_position()))
	#if dug:
		#var iso_pos = IsometricConverter._pos_to_iso(mouse_position)
		#deposit_block_on_top(player, iso_pos)
		#GameGlobal.layers[1][iso_pos].get_block().been_planted = true
	#else:
		#super(player, level_layer, mouse_position)
#
#
##OTHER
#func can_grow_plants(): return dug
#
##SPECIFIC TO SOIL
#func there_is_water_around():
	#var iso_pos = IsometricConverter._pos_to_iso(global_position)
	#return (
		#tile_provides_water(iso_pos + Vector2(1,0)) ||
		#tile_provides_water(iso_pos - Vector2(1,0)) ||
		#tile_provides_water(iso_pos + Vector2(0,1)) ||
		#tile_provides_water(iso_pos - Vector2(0,1))
	#)
#
#func tile_provides_water(iso_pos):
	#if GameGlobal.layers[0].has(iso_pos):
		#return GameGlobal.layers[0][iso_pos].get_block().provides_water()
#
#func drying_up():
	#if there_is_water_around():
		#$DryTimer.start()
	#else:
		#var iso_pos = IsometricConverter._pos_to_iso(global_position)
		#replace_block_on_floor(GameGlobal.preload_scenes.BLOCK_DRY_GROUND.instantiate(), iso_pos)
		#GameGlobal.layers[0][iso_pos].get_block().drying_up()
#
#func _on_dry_timer_timeout():
	#drying_up()
