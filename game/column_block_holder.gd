extends Node2D

var index
#var start_tile
var block

func add_block(block_par):
	block = block_par
	add_child(block)

func delete_block():
	block.queue_free()

#func detach_block():
	#if block:
		#remove_child(block)
