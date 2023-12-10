class_name Map
extends TileMap

@onready var astar: AStarGrid2D = AStarGrid2D.new()
var tile_coords: Array[Vector2] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var region: Rect2i = self.get_used_rect()
	region.size.y += 1
	astar.region = region
	astar.cell_size = tile_set.tile_size
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()
	for x in region.size.x:
		for y in region.size.y:
			var pos = Vector2i(x + region.position.x, y + region.position.y)
			var tile_pos: Vector2 = map_to_local(pos)
			var tile_map_position: Vector2i = pos
			var l1_tile_data: TileData = self.get_cell_tile_data(0, tile_map_position)
			if l1_tile_data:
				if not l1_tile_data.get_custom_data("Walkable"):
					astar.set_point_solid(tile_map_position + Vector2i(0, 1))
				else:
					print("appending")
					tile_coords.append(tile_pos)
	queue_redraw()
				
func _draw():
	for tile_pos in tile_coords:
		draw_circle(tile_pos, 2, Color.WHITE)
		var rect: Rect2 = Rect2(tile_pos - Vector2(16, 16), Vector2(32, 32))
		draw_rect(rect, Color.WHITE, false, 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var tile_pos = local_to_map(mouse_pos)
	

