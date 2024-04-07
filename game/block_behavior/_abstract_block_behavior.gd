extends Node

var on_adjacent_func

func call_on_adjacents(iso_pos):
	var adjacents = [iso_pos+Vector3i(1,0,0), iso_pos+Vector3i(-1,0,0),
					iso_pos+Vector3i(0,1,0), iso_pos+Vector3i(0,-1,0),
					iso_pos+Vector3i(0,0,1), iso_pos+Vector3i(0,0,-1)]
	for v in adjacents:
		if v.x < GameGlobal.map_width && v.x > -GameGlobal.map_width && v.y < GameGlobal.map_width && v.y > -GameGlobal.map_width:
			GameGlobal.block_behavior[GameGlobal.map_manager.get_tile(v)].call(on_adjacent_func, iso_pos, v)

##UNLIFT
func unlift_empty(iso_loc): pass

func unlift_default(iso_loc): pass

#BORN
func born_empty(born_iso_pos, target_iso_pos): pass
func born_default(born_iso_pos, target_iso_pos): pass
func born_water(born_iso_pos, target_iso_pos): pass
