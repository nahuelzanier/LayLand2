extends "res://elements/block/_block_abstract.gd"

var is_empty = false

func _ready():
	tag = "default"
	color_gradient()
	$DropTimer.wait_time = GameGlobal.clock_tick

func on_creation():
	get_iso_pos()
	$DropTimer.start()

func player_unlift_action(iso_mouse):
	var column = GameGlobal.render_layers[Vector2i(iso_mouse.x, iso_mouse.y)]
	column.column[column.top()].block.unlift_default()

#UNLIFT
func unlift_empty():
	get_iso_pos()
	var block = GameGlobal.render_layers[Vector2i(iso_pos.x, iso_pos.y)].remove_top()
	GameGlobal.player.block_held.pop_block()
	GameGlobal.player.block_held.pick_block(block)

func unlift_default():
	get_iso_pos()
	var iso_pos_ang = Vector2i(iso_pos.x, iso_pos.y)
	if GameGlobal.render_layers[iso_pos_ang].top() < 16:
		GameGlobal.render_layers[iso_pos_ang].add_top(GameGlobal.player.block_held.block_held.tag)
		GameGlobal.player.block_held.replace_player_block(GameGlobal.preload_scenes.BLOCK_EMPTY)

func _on_drop_timer_timeout():
	get_iso_pos()
	#if not GameGlobal.render_layers[Vector2i(iso_pos.x, iso_pos.y)].column[iso_pos.z-1].has_block:
		#GameGlobal.move_tile(GameGlobal.PRELOAD[tag],iso_pos, Vector3i(iso_pos.x, iso_pos.y, iso_pos.z-1))

func born_empty(born_iso_pos):
	$DropTimer.wait_time = GameGlobal.clock_tick
	$DropTimer.start()
