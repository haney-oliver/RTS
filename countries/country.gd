class_name Country
extends Object

var name: String
var starting_divisions: Array[Division]
var color: Color
var owned_tiles: Array[Vector2i]

func _init(_name: String, _starting_divisions: Array[Division], _color: Color, _owned_tiles: Array[Vector2i]):
	name = _name
	starting_divisions = _starting_divisions
	color = _color
	owned_tiles = _owned_tiles
