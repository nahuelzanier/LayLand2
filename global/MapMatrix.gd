extends Node

var map = {}

func mod_tile(vector3, data):
	map[vector3] = data

func switch_tiles(v3_a, v3_b):
	var temp = map[v3_a]
	map[v3_a] = map[v3_b]
	map[v3_b] = temp

