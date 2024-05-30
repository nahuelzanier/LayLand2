extends Node2D

@onready var render = $Render
@onready var preload_scenes = $PreloadScenes
@onready var camera_state_manager = $CameraStateManager
@onready var map_manager = $MapManager


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	GameGlobal.player_render = $Render/PlayerRender
	GameGlobal.render = $Render
	GameGlobal.main = self

	var x_range = GameGlobal.x_range
	var y_range = GameGlobal.y_range
	var z_range = GameGlobal.z_range

	var w = GameGlobal.map_width

	map_manager.generate_map()
	map_manager.random.generate_terrain(200, Vector3i(-w, -w, 0), Vector3i(w-1, w-1, 0))
	#map_manager.hills.generate_terrain(200, Vector3i(-w, -w, 0), Vector3i(w-1, w-1, 0))
	#map_manager.dunes.generate_terrain(100, Vector3i(-w, -w, 0), Vector3i(w-1, w-1, 0))
	#map_manager.stone.generate_terrain(20, Vector3i(-w, -w, randi()%7), Vector3i(w-1, w-1, 0))

	for x in x_range:
		for y in y_range:
			camera_state_manager.create_column(x, y)
			for z in z_range:
				GameGlobal.render_block(Vector3i(x, y, z))

