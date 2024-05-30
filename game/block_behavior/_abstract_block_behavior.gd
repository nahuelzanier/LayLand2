extends Node

var tag
var block_preload
var born_function

func call_on_adjacents(iso_pos, function): #original calls function on the adjacent tiles
	var adjacents = [iso_pos+Vector3i(1,0,0), iso_pos+Vector3i(-1,0,0),
					iso_pos+Vector3i(0,1,0), iso_pos+Vector3i(0,-1,0),
					iso_pos+Vector3i(0,0,1), iso_pos+Vector3i(0,0,-1)]
	adjacents.shuffle()
	for v in adjacents:
		if v.x < GameGlobal.map_width && v.x > -GameGlobal.map_width && v.y < GameGlobal.map_width && v.y > -GameGlobal.map_width:
			GameGlobal.block_behavior[GameGlobal.map_manager.get_tile(v)].call(function, iso_pos, v)

func call_on_born(iso_pos):
	call_on_adjacents(iso_pos, born_function)

func get_a_block():
	return block_preload.instantiate()

func switch_tiles(born_iso_pos, target_iso_pos):
	GameGlobal.map_manager.switch_tiles(born_iso_pos, target_iso_pos)
	GameGlobal.rerender_block(born_iso_pos)
	GameGlobal.rerender_block(target_iso_pos)

#BORN
func born_empty(born_iso_pos, target_iso_pos): pass
func born_water(born_iso_pos, target_iso_pos): pass
func born_default(born_iso_pos, target_iso_pos): pass
