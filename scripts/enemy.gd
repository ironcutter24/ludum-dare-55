extends CharacterBody2D

const SPEED = 25.0

var to_player : Vector2 = Vector2.ZERO


func _physics_process(delta):
	
	to_player = (Global.player_controller.global_position - global_position)
	
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(global_position, Global.player_controller.global_position, Global.WALL_MASK)
	var result = space_state.intersect_ray(query)
	
	if result.size() == 0 && to_player.length() > 50.0:
		velocity = to_player.normalized() * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()
