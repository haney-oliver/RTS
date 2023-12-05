class_name Map
extends TileMap

@onready var astar: AStarGrid2D = AStarGrid2D.new()
var tile_coords: Array[Vector2] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var region: Rect2i = self.get_used_rect()
	astar.region = region
	astar.offset = Vector2i(Vector2(7,-3))
	astar.cell_size = Vector2(32, 32)
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()
	for x in region.size.x:
		for y in region.size.y:
			var tile_map_position: Vector2i = Vector2i(x + region.position.x,y + region.position.y)
			var tile_position: Vector2 = map_to_local(tile_map_position)
			var l1_tile_data: TileData = self.get_cell_tile_data(0, tile_map_position)
			var l3_tile_data: TileData = self.get_cell_tile_data(2, tile_map_position)
			if ((l1_tile_data and l1_tile_data.get_custom_data("Impassible"))
				or (not l1_tile_data and l3_tile_data and l3_tile_data.get_custom_data("Impassible"))
				or (not l1_tile_data and not l3_tile_data)):
				astar.set_point_solid(tile_map_position + Vector2i(0,1))
			else:
				tile_coords.append(tile_position)
	queue_redraw()
				
func _draw():
	for tile_pos in tile_coords:
		draw_circle(tile_pos, 2, Color.WHITE)
		var vec: Vector2 = Vector2(tile_pos.x - 16, tile_pos.y - 16)
		var rect: Rect2 = Rect2(vec, Vector2(32, 32))
		draw_rect(rect, Color.WHITE, false, 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var tile_pos = local_to_map(mouse_pos)
	

