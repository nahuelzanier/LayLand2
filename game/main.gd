extends Node2D

@onready var render = $Render
@onready var enviroment = $Enviroment
@onready var preload_scenes = $PreloadScenes
@onready var camera_state_manager = $CameraStateManager
@onready var map_manager = $MapManager

var x_range = GameGlobal.x_range
var y_range = GameGlobal.y_range
var z_range = range(0,17)

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	GameGlobal.player_render = $Render/PlayerRender

	for x in x_range:
		for y in y_range:
			var column = preload_scenes.COLUMN_GAME.instantiate()
			column.iso_pos = Vector2i(x, y)
			GameGlobal.render_layers[Vector2i(x,y)] = column
			column.position = IsometricConverter._iso_to_pos(Vector2i(x,y))
			render.add_child(column)
			GameGlobal.create_tile(preload_scenes.BLOCK_EMPTY, Vector3i(x,y,-1))
			GameGlobal.create_tile(preload_scenes.BLOCK_EMPTY, Vector3i(x,y,17))
			
	for x in x_range:
		for y in y_range:
			for z in z_range:
				if randi()%400==0:
					map_manager.sphere("default", Vector3i(x, y, z), randi()%3+1)

	for x in x_range:
		for y in y_range:
			for z in z_range:
				if GameGlobal.tag_map.has(Vector3i(x, y, z)):
					GameGlobal.create_tile(preload_scenes.PRELOAD[GameGlobal.tag_map[Vector3i(x,y,z)]], Vector3i(x,y,z))
				else:
					if z<5:
						GameGlobal.create_tile(preload_scenes.BLOCK_WATER, Vector3i(x,y,z))
	#for x in x_range:
		#for y in y_range:
			#for z in range(0,6):
				#GameGlobal.create_tile(preload_scenes.BLOCK_DEFAULT, Vector3i(x,y,z))

	for x in x_range:
		for y in y_range:
			for z in z_range:
				if GameGlobal.render_layers[Vector2i(x,y)].column[z].has_block:
					GameGlobal.render_layers[Vector2i(x,y)].column[z].block.on_creation()

	var player = GameGlobal.preload_scenes.PLAYER.instantiate()
	$Render/PlayerRender.add_child(player)

func tags_to_blocks(tag):
	return preload_scenes.PRELOAD[tag]
