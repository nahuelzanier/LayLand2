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

	map_manager.generate_map()
	map_manager.hills.generate_terrain(500, Vector3i(-50, -50, 0), Vector3i(50, 50, 0))

	for x in x_range:
		for y in y_range:
			camera_state_manager.create_column(x, y)
			for z in z_range:
				GameGlobal.render_block(Vector3i(x, y, z))

	for x in x_range:
		for y in y_range:
			for z in z_range:
				GameGlobal.block_behavior[GameGlobal.map_manager.get_tile(Vector3i(x, y, z))].call_on_adjacents(Vector3i(x, y, z))
	
	var player = GameGlobal.preload_scenes.PLAYER.instantiate()
	$Render/PlayerRender.add_child(player)

