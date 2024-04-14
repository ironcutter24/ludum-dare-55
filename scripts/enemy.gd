extends Node2D

const STOP_DISTANCE = 20.0

var to_player : Vector2 = Vector2.ZERO
@export var baseUnit: BaseUnit;


func _physics_process(delta):
	
	to_player = (Global.player_controller.global_position - global_position)
	
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(global_position, Global.player_controller.global_position, Global.WALL_MASK)
	var result = space_state.intersect_ray(query)
	
	if result.size() == 0 && to_player.length() > STOP_DISTANCE:
		baseUnit.setMoveDirection(to_player.normalized())
	else:
		var moveDirection = Vector2(0,0);
		baseUnit.setMoveDirection(moveDirection)

