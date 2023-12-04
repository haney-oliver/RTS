class_name Map
extends TileMap

@onready var astar : AStarGrid2D = AStarGrid2D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var region: Rect2i = self.get_used_rect()
	print(region)
	astar.region = region
	astar.cell_size = Vector2(self.tile_set.tile_size)
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	astar.update()
	for x in region.size.x:
		for y in region.size.y:
			var tile_position: Vector2i = Vector2i(x + region.position.x,y + region.position.y)
			var tile_data: TileData = self.get_cell_tile_data(0, tile_position)
			if not tile_data or tile_data.get_custom_data("Impassible"):
				astar.set_point_solid(tile_position)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
