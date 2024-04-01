extends Node2D

const COLUMN_BLOCK_HOLDER = preload("res://game/column_block_holder.tscn")

var iso_pos
var column

func _ready():
	column = {}
	for i in range(-1,18):
		column[i] = COLUMN_BLOCK_HOLDER.instantiate()
		add_child(column[i])
		column[i].index = i
		column[i].position.y -= i*IsometricConverter.ISO_HEIGHT/2

#func disable_all_collisions():
	#for k in column.keys():
		#if column[k].has_block:
			#column[k].block.disable_collision_shape()
#
#func enable_all_collisions():
	#for k in column.keys():
		#if column[k].has_block:
			#column[k].block.enable_collision_shape()

func top():
	for i in range(16, -1, -1):
		if column[i].has_block:
			return i
	return -1

func add_top(block_preload):
	GameGlobal.create_tile(block_preload, Vector3i(iso_pos.x, iso_pos.y, top()+1))

func remove_top():
	var top_block = GameGlobal.PRELOAD[column[top()].block.tag].instantiate()
	GameGlobal.erase_tile(Vector3i(iso_pos.x, iso_pos.y, top()))
	return top_block

#func unlift_default():
	#add_top(GameGlobal.PRELOAD[GameGlobal.player.block_held.block_held.tag])
	#GameGlobal.player.block_held.pop_block()
	#var empty_block = GameGlobal.PRELOAD["empty"].instantiate()
	#GameGlobal.player.block_held.pick_block(empty_block)
#
#func unlift_empty():
	#if top() >= 0:
		#var top_block = remove_top()
		#var empty_block = GameGlobal.player.block_held.pop_block()
		#GameGlobal.player.block_held.pick_block(top_block)

