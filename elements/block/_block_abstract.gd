extends CharacterBody2D

var collision
var tag
var unlift_function

#func on_creation(): pass

func color_gradient():
	var white = Color(1, 1, 1, 1)
	var dark = ((8-float(collision)) / 8.0) / 1.1
	$AnimatedSprite2D.self_modulate = white.darkened(dark)

func player_unlift_action(iso_mouse):
	var vec = Vector3i(iso_mouse.x, iso_mouse.y, GameGlobal.render_layers[iso_mouse].top() - 2 + GameGlobal.cursor_scroll)
	GameGlobal.block_behavior[GameGlobal.map_manager.get_tile(vec)].call(unlift_function, vec)
	#var column = GameGlobal.render_layers[Vector2i(iso_mouse.x, iso_mouse.y)]
	#column.column[column.top()].block.call(unlift_function, iso_mouse)

func play_animation(animation):
	var anim = $AnimatedSprite2D
	anim.animation = animation
	anim.play()

#func get_iso_pos():
	#var v2 = get_parent().get_parent().iso_pos
	#iso_pos = Vector3i(v2.x, v2.y, collision-1)

#func call_on_adjacents(function):
	#var adjacents = [iso_pos+Vector3i(1,0,0), iso_pos+Vector3i(-1,0,0),
					#iso_pos+Vector3i(0,1,0), iso_pos+Vector3i(0,-1,0),
					#iso_pos+Vector3i(0,0,1), iso_pos+Vector3i(0,0,-1)]
	#for v in adjacents:
		#if v.x < GameGlobal.x_range[-1] && v.x > GameGlobal.x_range[0] && v.y < GameGlobal.y_range[-1] && v.y > GameGlobal.y_range[0]:
			#GameGlobal.render_layers[Vector2i(v.x, v.y)].column[v.z].block.call(function, iso_pos)

func set_collisions(layer):
	collision = layer + 1
	set_collision_layer_value(collision, true)

func disable_collisions():
	set_collision_layer_value(collision, false)

func disable_collision_shape():
	get_node("CollisionPolygon2D").disabled = true
	get_node("CollisionPolygon2D").hide()

func enable_collision_shape():
	get_node("CollisionPolygon2D").disabled = false
	get_node("CollisionPolygon2D").show()

##UNLIFT
#func unlift_empty(iso_loc): pass
#func unlift_default(iso_loc): pass
#func unlift_water(iso_loc): pass
#
##ON_BORN
#func born_empty(born_iso_pos): pass
#func born_default(born_iso_pos): pass
#func born_water(born_iso_pos): pass
