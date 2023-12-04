class_name UI
extends Control

@onready var map: TileMap = $"../Map"
@onready var division: Division = $"../Divisions/Division"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _draw():
	if map:
		var offset: Vector2i = map.tile_set.tile_size / 2
		if division:
			print("drawing")
			var index: int = 0
			for point in division.current_path:
				if index < division.current_path.size() - 1:
					draw_line(point+offset, division.current_path[index+1]+offset, Color.WHITE, 2)
				index += 1
