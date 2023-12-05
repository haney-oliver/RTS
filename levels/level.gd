class_name Level
extends Node2D

var countries: Array[Country]

# Called when the node enters the scene tree for the first time.
func _ready():
	countries = [
		Country.new(
			"Portugal",
			[],
			Color.BROWN,
			[]
		),
		Country.new(
			"Spain",
			[],
			Color.ANTIQUE_WHITE,
			[]
		),
		Country.new(
			"France",
			[],
			Color.BLUE,
			[]
		),
		Country.new(
			"Belgium",
			[],
			Color.YELLOW,
			[]
		),
		Country.new(
			"Netherlands",
			[],
			Color.CHOCOLATE,
			[]
		),
		Country.new(
			"Switzerland",
			[],
			Color.INDIAN_RED,
			[]
		),
		Country.new(
			"Luxemburg",
			[],
			Color.AQUAMARINE,
			[]
		),
		Country.new(
			"Italy",
			[],
			Color.CADET_BLUE,
			[]
		),
		Country.new(
			"Germany",
			[],
			Color.DIM_GRAY,
			[]
		),
		Country.new(
			"Poland",
			[],
			Color.PINK,
			[]
		),
		Country.new(
			"Yugoslavia",
			[],
			Color.STEEL_BLUE,
			[]
		),
		Country.new(
			"Albania",
			[],
			Color.REBECCA_PURPLE,
			[]
		),
		Country.new(
			"Czechoslovakia",
			[],
			Color.CORNFLOWER_BLUE,
			[]
		),
		Country.new(
			"Greece",
			[],
			Color.DARK_CYAN,
			[]
		),
		Country.new(
			"Romania",
			[],
			Color.LIGHT_YELLOW,
			[]
		),
		Country.new(
			"Hungary",
			[],
			Color.SALMON,
			[]
		),
		Country.new(
			"Bulgaria",
			[],
			Color.GREEN,
			[]
		),
		Country.new(
			"Turkey",
			[],
			Color.SANDY_BROWN,
			[]
		),
		
	]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
