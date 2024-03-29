extends "res://elements/block/_block_abstract.gd"

var c_layers_floor = []
var c_masks_floor = []
var c_layers_creature = [2]
var c_masks_creature = [2]
var is_empty = false

var hours_to_sprout = GameGlobal.fruit_coconut[1]
var hour_planted
#
#func _ready():
	#$GrowTimer.wait_time = GameGlobal.clock_tick * hours_to_sprout
	#start_growing()
#
##FRUIT
#func start_growing():
	#hour_planted = GameGlobal.world_timer.total_hours
	#$GrowTimer.start()
#
#func ready_to_grow():
	#var iso_pos = IsometricConverter._pos_to_iso(get_parent().get_parent().global_position)
	#return (
		#GameGlobal.world_timer.total_hours - hour_planted >= hours_to_sprout &&
		#( GameGlobal.layers[0][iso_pos].get_block().can_grow_plants() ||
		#GameGlobal.layers[0][iso_pos].get_block().is_sand() )
	#)
#
#func grow_plant():
	#if ready_to_grow():
		#var iso_pos = IsometricConverter._pos_to_iso(get_parent().get_parent().global_position)
		#replace_topping_top(GameGlobal.preload_scenes.BLOCK_COCONUT_PALMTREE.instantiate(), iso_pos)
	#else:
		#hour_planted += hours_to_sprout
		#$GrowTimer.start()
#
#func _on_grow_timer_timeout():
	#grow_plant()
