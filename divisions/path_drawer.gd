class_name PathDrawer
extends Node2D

const LINE_WIDTH: int = 5

@onready var divisions: Array[Node] = $"../Divisions".get_children()




func _process(_delta):
	queue_redraw()

func _draw():
	for division in divisions:
		var point_path: Array[Vector2] = []
		if not division.current_point_path.is_empty() and division.is_moving:
			for point in division.current_point_path:
				point += Vector2(LINE_WIDTH + 2, -2.5)
				point_path.append(point)
			if point_path.size() >= 2:
				draw_polyline(point_path, Color.DARK_RED, LINE_WIDTH)
