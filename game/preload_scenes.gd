extends Node2D

const PLAYER = preload("res://player/player.tscn")

const BLOCK_DEFAULT = preload("res://elements/block/block_default.tscn")
const BLOCK_EMPTY = preload("res://elements/block/block_empty.tscn")
const BLOCK_STONE = preload("res://elements/block/block_stone.tscn")
const BLOCK_WATER = preload("res://elements/block/block_water.tscn")
const BLOCK_SAND = preload("res://elements/block/block_sand.tscn")
const BLOCK_SOIL = preload("res://elements/block/block_soil.tscn")
const BLOCK_DRY_GROUND = preload("res://elements/block/block_dry_ground.tscn")

const BLOCK_COCONUT = preload("res://elements/block/block_coconut.tscn")
const BLOCK_COCONUT_SEEDLING = preload("res://elements/block/block_coconut_seedling.tscn")
const BLOCK_COCONUT_PALMTREE = preload("res://elements/block/block_coconut_palmtree.tscn")

const COLUMN_GAME = preload("res://game/column_game.tscn")
const CURSOR = preload("res://game/cursor.tscn")

var PRELOAD = {
	Tag.empty:BLOCK_EMPTY,
	Tag.default:BLOCK_DEFAULT,
	Tag.water:BLOCK_WATER
}

func _ready():
	GameGlobal.preload_scenes = self
	GameGlobal.PRELOAD = PRELOAD
