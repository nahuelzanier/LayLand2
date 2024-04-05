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
		#if i == -1 || i == GameGlobal.max_z_value:
			#column[i].start_tile = Tag.no_access


func top():
	for i in range(16, -1, -1):
		if not column[i].block.is_empty:
			return i
	return -1

func remove_at(z):
	var block = column[z].block
	column[z].remove_child(block)
	return block

func add_at(block, z):
	column[z].block = block
	column[z].add_child(block)

#func add_top(block_preload):
	#GameGlobal.create_tile(block_preload, Vector3i(iso_pos.x, iso_pos.y, top()+1))

func remove_top():
	var top_block = GameGlobal.PRELOAD[column[top()].block.tag].instantiate()
	GameGlobal.erase_tile(Vector3i(iso_pos.x, iso_pos.y, top()))
	return top_block

func delete_column():
	queue_free()
	GameGlobal.render_layers.erase(iso_pos)
