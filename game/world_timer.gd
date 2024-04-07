extends Timer

var total_hours = 0
var hour = 0

func _ready():
	GameGlobal.world_timer = self
	$CanvasLayer/Label.text = str(hour) + ":00"
	start()

func _on_timeout():
	total_hours += 1
	hour += 1
	if hour == 12:
		hour = 0
	$CanvasLayer/Label.text = str(hour) + ":00"
	if not GameGlobal.born_queue.is_empty():
		var pos = GameGlobal.born_queue.pop_front()
		if (pos.x >= GameGlobal.x_range[0]-1 && pos.y >= GameGlobal.y_range[0]-1 && pos.x < GameGlobal.x_range[-1]+1 && pos.y < GameGlobal.y_range[-1]+1):
			GameGlobal.block_behavior[GameGlobal.map_manager.get_tile(pos)].call_on_adjacents(pos)
