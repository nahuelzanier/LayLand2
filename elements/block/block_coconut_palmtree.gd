extends "res://elements/block/_block_abstract.gd"

var c_layers_floor = []
var c_masks_floor = []
var c_layers_creature = [2]
var c_masks_creature = [2]
var is_empty = false

@onready var floor_position = $FloorPosition

var hours_to_sprout = GameGlobal.fruit_coconut[2]
var hours_to_mature = GameGlobal.fruit_coconut[3]
var hours_to_fruit_fall = GameGlobal.fruit_coconut[4]
var hour_planted

var fruit_position
var fruit_phase = 0
var fruits = []

#func _ready():
	#$FruitGrowth.wait_time = GameGlobal.clock_tick * hours_to_sprout
	#fruit_position = [$Fruit01, $Fruit02, $Fruit03, $Fruit04]
	#start_growing()
#
##func player_unlift_action(player, mouse_position):
	##var iso_mouse = IsometricConverter._pos_to_iso(mouse_position)
	##var upper_layer = GameGlobal.upper_layer(iso_mouse)
	##GameGlobal.layers[upper_layer][iso_mouse].get_block().unlift_palmtree(player, upper_layer, mouse_position)
#
#func get_collider_topping():
	#return GameGlobal.preload_scenes.COLLISION_PALMTREE.instantiate()
#
##UNLIFT
#func unlift_empty(player, level_layer, mouse_position):
	#player.state_manager.change_state("idle", player.position.direction_to(get_global_mouse_position()))
	#var iso_pos = IsometricConverter._pos_to_iso(mouse_position)
	#pick_top_block(player, iso_pos)
#
##BORN
##...
#
##OTHER
##...
#
##FRUIT
#func start_growing():
	#hour_planted = GameGlobal.world_timer.total_hours
	#$FruitGrowth.start()
#
#func ready_to_grow():
	#var iso_pos = IsometricConverter._pos_to_iso(floor_position.global_position)
	#return (
		#GameGlobal.world_timer.total_hours - hour_planted >= hours_to_sprout &&
		#( GameGlobal.layers[0][iso_pos].get_block().can_grow_plants() ||
		#GameGlobal.layers[0][iso_pos].get_block().is_sand() )
	#)
#
#func grow_plant():
	#if ready_to_grow():
		#if fruit_phase == 0:
			#for f in fruit_position:
				#if randi()%4 == 0:
					#var fruit = GameGlobal.preload_scenes.BLOCK_COCONUT.instantiate()
					#fruits.push_back(fruit)
					#f.add_child(fruit)
					#fruit.play_animation("green")
			#hour_planted += hours_to_mature
			#$FruitGrowth.wait_time = GameGlobal.clock_tick * hours_to_mature
			#fruit_phase = 1
		#elif fruit_phase == 1:
			#for fruit in fruits:
				#fruit.play_animation("idle")
			#hour_planted += hours_to_fruit_fall
			#$FruitGrowth.wait_time = GameGlobal.clock_tick * hours_to_fruit_fall
			#fruit_phase = 2
		#else:
			#if fruits.size() > 0:
				#var i = randi()%fruits.size()
				#var fruit = fruits[i]
				#var parent = fruit.get_parent()
				#parent.remove_child(fruit)
				#fruits.remove_at(i)
				#var fruit_creature = GameGlobal.add_creature(fruit, parent.global_position)
				#fruit_creature.fall(randi_range(40, 50))
				#hour_planted += hours_to_fruit_fall
				#$FruitGrowth.wait_time = GameGlobal.clock_tick * hours_to_fruit_fall
			#else:
				#fruit_phase = 0
				#hour_planted = GameGlobal.world_timer.total_hours
				#$FruitGrowth.wait_time = GameGlobal.clock_tick * hours_to_sprout
	#$FruitGrowth.start()
#
#func _on_fruit_growth_timeout():
	#grow_plant()
