extends "res://elements/block/_block_abstract.gd"

@onready var drop_timer = $DropTimer
var is_empty = false

func on_creation():
	drop_timer.start()

func _ready():
	tag = "default"
	var white = Color(1, 1, 1, 1)
	var dark = ((8-float(collision)) / 8.0) / 1.1
	$AnimatedSprite2D.self_modulate = white.darkened(dark)

func on_born(): pass

func player_unlift_action(iso_mouse):
	var column = GameGlobal.render_layers[Vector2i(iso_mouse.x, iso_mouse.y)]
	column.column[column.top()].block.unlift_default()

#UNLIFT
func unlift_empty():
	var block = GameGlobal.render_layers[Vector2i(iso_pos.x, iso_pos.y)].remove_top()
	GameGlobal.player.block_held.pop_block()
	GameGlobal.player.block_held.pick_block(block)

func unlift_default():
	var iso_pos_ang = Vector2i(iso_pos.x, iso_pos.y)
	if GameGlobal.render_layers[iso_pos_ang].top() < 16:
		GameGlobal.render_layers[iso_pos_ang].add_top(GameGlobal.PRELOAD[GameGlobal.player.block_held.block_held.tag])
		GameGlobal.player.block_held.replace_player_block(GameGlobal.preload_scenes.BLOCK_EMPTY)

func _on_drop_timer_timeout():
	if not GameGlobal.render_layers[Vector2i(iso_pos.x, iso_pos.y)].column[iso_pos.z-1].has_block:
		GameGlobal.move_tile(GameGlobal.preload_scenes.BLOCK_DEFAULT, iso_pos, iso_pos-Vector3i(0,0,1))

func born_empty(born_iso_pos):
	$DropTimer.start()
