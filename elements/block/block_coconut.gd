extends "res://elements/block/_block_abstract.gd"

var c_layers_floor = []
var c_masks_floor = []
var c_layers_creature = [2]
var c_masks_creature = [2]
var is_empty = false

var been_planted = false
var hours_to_sprout = GameGlobal.fruit_coconut[0]
var current_rot_ticks = 0
var ticks_to_rot = GameGlobal.fruit_coconut[5]
var hour_planted

#func _ready():
	#topping_height_modifier = 0
	#hour_planted = GameGlobal.world_timer.total_hours
	#$GrowTimer.wait_time = GameGlobal.clock_tick * hours_to_sprout
#
##func player_unlift_action(player, mouse_position):
	##var iso_mouse = IsometricConverter._pos_to_iso(mouse_position)
	##var upper_layer = GameGlobal.upper_layer(iso_mouse)
	##GameGlobal.layers[upper_layer][iso_mouse].get_block().unlift_fruit(player, upper_layer, mouse_position)
#
#func get_collider_topping():
	#return GameGlobal.preload_scenes.COLLISION_COCONUT.instantiate()
#
#func get_collider_character():
	#return GameGlobal.preload_scenes.COLLISION_COCONUT.instantiate()
#
##UNLIFT
#func unlift_empty(player, level_layer, mouse_position):
	#player.state_manager.change_state("lift", player.position.direction_to(get_global_mouse_position()))
	#var iso_pos = IsometricConverter._pos_to_iso(mouse_position)
	#been_planted = false
	#if level_layer == 0:
		#exchange_floor_block(player, iso_pos)
		#GameGlobal.layers[level_layer][iso_pos].get_block().on_born()
	#if level_layer == 1:
		#pick_top_block(player, iso_pos)
#
##OTHER
#func on_ground():
	#start_growing()
#
##FRUIT
#func start_growing():
	#hour_planted = GameGlobal.world_timer.total_hours
	#$GrowTimer.start()
#
#func grow_plant():
	#if been_planted:
		#var iso_pos = IsometricConverter._pos_to_iso(get_parent().get_parent().global_position)
		#replace_topping_top(GameGlobal.preload_scenes.BLOCK_COCONUT_SEEDLING.instantiate(), iso_pos)
	#elif current_rot_ticks < ticks_to_rot:
		#current_rot_ticks += 1
		#hour_planted += hours_to_sprout
		#$GrowTimer.start()
	#else:
		#get_parent().get_parent().queue_free()
#
#func _on_grow_timer_timeout():
	#grow_plant()
