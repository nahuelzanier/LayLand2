extends CanvasLayer

const RAIN = preload("res://elements/enviroment/rain.tscn")

func spawn_rain(vector2):
	var rain = RAIN.instantiate()
	rain.rain_starting_pos = vector2
	rain.rainfall = self
	add_child(rain)
