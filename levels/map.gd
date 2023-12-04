class_name Map
extends TileMap

@onready var astar : AStarGrid2D = AStarGrid2D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	astar.region = self.get_used_rect()
	astar.cell_size = Vector2(self.tile_set.tile_size)
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
