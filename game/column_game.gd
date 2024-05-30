extends Node2D

const COLUMN_BLOCK_HOLDER = preload("res://game/column_block_holder.tscn")

var iso_pos
var column
var terrain = Tag.terr_hills

func _ready():
	column = {}
	for i in range(-1,18):
		column[i] = COLUMN_BLOCK_HOLDER.instantiate()
		add_child(column[i])
		column[i].index = i
		column[i].position.y -= i*IsometricConverter.ISO_HEIGHT/2

func top():
	for i in range(16, -1, -1):
		if not column[i].block == null:
			return i
	return -1

func remove_at(z):
	var block = column[z].block
	column[z].remove_child(block)
	return block

func delete_column():
	queue_free()
	GameGlobal.render_layers.erase(iso_pos)
