@tool
@icon("../chunk_aware_generator.svg")
class_name ChunkAwareGenerator2D
extends GaeaGenerator2D


## Emitted when any update to a chunk is made. Either erasing it or generating it.
signal chunk_updated(chunk_position: Vector2i)
## Emitted when a chunk is finished generated. [signal chunk_updated] is also called.
signal chunk_generation_finished(chunk_position: Vector2i)
## Emitted when a chunk is erased. [signal chunk_updated] is also called.
signal chunk_erased(chunk_position: Vector2i)


## The size of the Chunks. [br]
## [b]Warning: Cannot be set to 0[/b]
@export var chunk_size: Vector2i = Vector2i(16, 16)

var generated_chunks: Array[Vector2i] = []


func _ready() -> void:
	if chunk_size.x <= 0 or chunk_size.y <= 0:
		push_error("Invalid chunk size!")

	super._ready()


func generate_chunk(chunk_position: Vector2i, starting_grid: GaeaGrid = null) -> void:
	push_warning("generate_chunk method not overriden at %s" % name)


func erase_chunk(chunk_position: Vector2i) -> void:
	for x in get_chunk_axis_range(chunk_position.x, chunk_size.x):
		for y in get_chunk_axis_range(chunk_position.y, chunk_size.y):
			for layer in grid.get_layer_count():
				grid.erase(Vector2i(x, y), layer)

	chunk_updated.emit(chunk_position)
	chunk_erased.emit(chunk_position)


func _apply_modifiers_chunk(modifiers: Array[Modifier2D], chunk_position: Vector2i) -> void:
	for modifier in modifiers:
		if not (modifier is ChunkAwareModifier2D):
			push_error("%s is not a Chunk compatible modifier!" % modifier.resource_name)
			continue

		modifier.apply_chunk(grid, self, chunk_position)


func unload_chunk(chunk_position: Vector2i) -> void:
	erase_chunk(chunk_position)
	generated_chunks.erase(chunk_position)

	if is_instance_valid(next_pass) and next_pass is ChunkAwareGenerator2D:
		next_pass.unload_chunk(chunk_position)
		return


### Utils ###
func get_chunks_in_range(rect: Rect2i) -> Array[Vector2i]: 
	var returnArray: Array[Vector2i] = [];
	var minX = floori(rect.position.x / chunk_size.x);
	var maxX = floori((rect.position.x + rect.size.x)/chunk_size.x);
	var minY = floori(rect.position.y / chunk_size.y);
	var maxY = floori((rect.position.y + rect.size.y)/chunk_size.y);

	for x in range(minX, maxX+1):
		for y in range(minY, maxY+1):
			returnArray.push_back(Vector2i(x,y));
	
	return returnArray;
	
func has_chunk(chunk_position: Vector2i) -> bool:
	return generated_chunks.has(chunk_position)
	
func chunk_to_position(chunk: Vector2i) -> Vector2i:
	return Vector2i(chunk.x * chunk_size.x, chunk.y * chunk_size.y);
	
func position_to_chunk(position: Vector2i) -> Vector2i:
	return Vector2i(position.x / chunk_size.x, position.y / chunk_size.y);

func get_chunk_axis_range(position: int, axis_size: int) -> Array:
	return range(
		position * axis_size,
		(position + 1) * axis_size,
		1
	)