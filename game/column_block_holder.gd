extends Node2D

var index
var block
var has_block = false

func add_block(block_par):
	block = block_par
	add_child(block)
	has_block = true

func delete_block():
	block.queue_free()
	has_block = false
