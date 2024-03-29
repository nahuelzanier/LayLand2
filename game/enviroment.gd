extends Node2D

const RAINFALL = preload("res://elements/enviroment/rainfall.tscn")

func start_raining():
	add_child(RAINFALL.instantiate())
