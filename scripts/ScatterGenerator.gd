@tool
extends NoiseGenerator
class_name ScatterGenerator

@export var chunk_padding := 4;
@export var placement_diameter := 1;

func generate(starting_grid: GaeaGrid = null) -> void:
	if Engine.is_editor_hint() and not editor_preview:
		push_warning("%s: Editor Preview is not enabled so nothing happened!" % name)
		return

	generation_started.emit()

	var time_now :int = Time.get_ticks_msec()

	if starting_grid == null:
		erase()
	else:
		grid = starting_grid

	_set_grid()
	_apply_modifiers(settings.modifiers)

	if is_instance_valid(next_pass):
		next_pass.generate(grid)
		return

	var time_elapsed: int = Time.get_ticks_msec() - time_now
	if OS.is_debug_build():
		print("%s: Generating took %s seconds" % [name, float(time_elapsed) / 1000])

	grid_updated.emit()
	generation_finished.emit()
	
func _set_grid_area(rect: Rect2i) -> void:
	var gridCircle = get_grid_circle(placement_diameter);
	
	for chunk in get_chunks_in_range(rect):
		var finalPos = get_scatter_center_in_chunk(chunk);
		for circVec in gridCircle:
			if (settings.tiles.size() > 0):
				grid.set_valuexy(finalPos.x + circVec.x, finalPos.y + circVec.y, settings.tiles[0].tile);
			on_place(finalPos + circVec);

func on_place(pos: Vector2i):
	pass

func get_scatter_center_in_chunk(chunk: Vector2i) -> Vector2i:
	var rng = RandomNumberGenerator.new();
	var x: int = chunk.x;
	var y: int = chunk.y;

	rng.seed = int(str(get_seed()) + str(x) + "9999" + str(y));
	var xPosInChunk = rng.randi_range(chunk_padding, chunk_size.x - 1 - chunk_padding);
	var yPosInChunk = rng.randi_range(chunk_padding, chunk_size.y - 1 - chunk_padding);
	return chunk_to_position(chunk) + Vector2i(xPosInChunk, yPosInChunk);
	

func get_grid_circle(diameter: int) -> Array[Vector2i]:
	var start = ceil(-diameter / 2.0);
	var result: Array[Vector2i] = []
	for x in range(start, start+diameter):
		for y in range(start, start+diameter):
			result.push_back(Vector2i(x, y));
			
	return result;
