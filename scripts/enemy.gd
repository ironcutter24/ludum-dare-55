extends Node2D
class_name BaseEnemy

const STOP_DISTANCE = 40.0

var to_player : Vector2 = Vector2.ZERO
@export var baseUnit: BaseUnit;
var last_seen_player_position: Vector2 = Vector2.ZERO;

func setUnitData(_unitData: UnitData):
	baseUnit.setUnitData(_unitData);
	
func _physics_process(_delta):
	
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(baseUnit.global_position, Global.player_controller.global_position, Global.WALL_MASK)
	var result = space_state.intersect_ray(query)
	
	if result.size() == 0:
		last_seen_player_position = Global.player_controller.global_position;
	
	to_player = (last_seen_player_position - baseUnit.global_position)
	
	if to_player.length() > STOP_DISTANCE and last_seen_player_position != Vector2.ZERO:
		baseUnit.setMoveDirection(to_player.normalized())
		baseUnit.setTargetPosition(last_seen_player_position);
		baseUnit.TryAttack();
	else:
		var moveDirection = Vector2(0,0);
		baseUnit.setMoveDirection(moveDirection)
