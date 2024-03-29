extends Timer

var total_hours = 0
var hour = 0

func _ready():
	GameGlobal.world_timer = self
	wait_time = GameGlobal.clock_tick
	$CanvasLayer/Label.text = str(hour) + ":00"
	start()

func _on_timeout():
	total_hours += 1
	hour += 1
	if hour == 12:
		hour = 0
	$CanvasLayer/Label.text = str(hour) + ":00"
