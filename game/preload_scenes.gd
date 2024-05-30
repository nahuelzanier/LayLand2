extends Node

const PLAYER = preload("res://player/player.tscn")

#const BLOCK_NO_ACCESS = preload("res://elements/block/block_no_access.tscn")
const BLOCK_EMPTY = preload("res://elements/block/block_empty.tscn")
const BLOCK_DEFAULT = preload("res://elements/block/block_default.tscn")
const BLOCK_WATER = preload("res://elements/block/block_water.tscn")
const BLOCK_SAND = preload("res://elements/block/block_sand.tscn")
const BLOCK_STONE = preload("res://elements/block/block_stone.tscn")
const BLOCK_WOOD_PIECE = preload("res://elements/block/block_wood_piece.tscn")
const BLOCK_PALM_LEAVES = preload("res://elements/block/block_palm_leaves.tscn")

const BLOCK_SOIL = preload("res://elements/block/block_soil.tscn")
const BLOCK_DRY_GROUND = preload("res://elements/block/block_dry_ground.tscn")

const BLOCK_COCONUT = preload("res://elements/block/block_coconut.tscn")
const BLOCK_COCONUT_SEEDLING = preload("res://elements/block/block_coconut_seedling.tscn")
const BLOCK_COCONUT_PALMTREE = preload("res://elements/block/block_coconut_palmtree.tscn")

const COLUMN_GAME = preload("res://game/column_game.tscn")
const CURSOR = preload("res://game/cursor.tscn")

var PRELOAD = {
	Tag.default:BLOCK_DEFAULT,
	Tag.water:BLOCK_WATER,
	Tag.sand:BLOCK_SAND,
	Tag.stone:BLOCK_STONE,
	Tag.wood_piece:BLOCK_WOOD_PIECE,
	Tag.palm_leaves:BLOCK_PALM_LEAVES
}

func _ready():
	GameGlobal.preload_scenes = self
	GameGlobal.PRELOAD = PRELOAD
