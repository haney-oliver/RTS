class_name PathDrawer
extends Node2D

@onready var divisions: Array[Node] = $"../Divisions".get_children()

func _process(_delta):
	queue_redraw()

func _draw():
	for division in divisions:
		if not division.current_point_path.is_empty() and division.is_moving:
			draw_polyline(division.current_point_path , Color.DARK_RED, 5)
