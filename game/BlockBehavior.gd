extends Node


var born_functions = {
	[Tag.water, Tag.empty] : 'exchange'
}

func _ready():
	GameGlobal.block_behavior = self

func call_on_adjacents(iso_pos):
	var adjacents = [iso_pos+Vector3i(1,0,0), iso_pos+Vector3i(-1,0,0),
					iso_pos+Vector3i(0,1,0), iso_pos+Vector3i(0,-1,0),
					iso_pos+Vector3i(0,0,1), iso_pos+Vector3i(0,0,-1)]
	for v in adjacents:
		if v.x < GameGlobal.map_width && v.x > -GameGlobal.map_width && v.y < GameGlobal.map_width && v.y > -GameGlobal.map_width:
			if born_functions.has([GameGlobal.map_manager.get_tile(iso_pos), GameGlobal.map_manager.get_tile(v)]):
				var on_adjacent_func = born_functions[[GameGlobal.map_manager.get_tile(iso_pos), GameGlobal.map_manager.get_tile(v)]]
				GameGlobal.block_behavior.call(on_adjacent_func, iso_pos, v)

#OTHER
func exchange(iso_loc, next_loc):
	var tag01 = GameGlobal.map_manager.get_tile(iso_loc)
	var tag02 = GameGlobal.map_manager.get_tile(next_loc)
	GameGlobal.map_manager.set_tile(iso_loc, tag02)
	GameGlobal.map_manager.set_tile(next_loc, tag01)
	GameGlobal.rerender_block(iso_loc)
	GameGlobal.rerender_block(next_loc)
	GameGlobal.born_queue.push_back(iso_loc)
	GameGlobal.born_queue.push_back(next_loc)
