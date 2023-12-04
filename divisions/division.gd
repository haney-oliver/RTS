class_name Division
extends CharacterBody2D

const IDLE_BLEND_POS : String = "parameters/Idle/blend_position"
const WALK_BLEND_POS : String = "parameters/Walk/blend_position"

@onready var tile_map: TileMap = $"../../Map"
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

@export var starting_direction : Vector2 = Vector2.DOWN
@export var speed : float = 1
@export var debug_astar: bool = false

var is_selected: bool = false:
	set(_val):
		is_selected = _val
	get:
		return is_selected

var current_path: Array[Vector2i]

func _ready() -> void:
	update_animation_params(starting_direction)
	
func _input(_event) -> void:
	if _event.is_action_pressed("move"):
		if is_selected:
			print("selected")
			var from: Vector2i = tile_map.local_to_map(self.global_position)
			var to: Vector2i = tile_map.local_to_map(self.get_global_mouse_position())
			print(tile_map.astar.is_in_bounds(to.x, to.y))
			var path: Array[Vector2i] = tile_map.astar.get_id_path(from, to).slice(1)
			if !path.is_empty():
				current_path = path
		
func update_animation_params(_move_input : Vector2) -> void:
	if _move_input != Vector2.ZERO:
		animation_tree.set(WALK_BLEND_POS, _move_input)
		animation_tree.set(IDLE_BLEND_POS, _move_input)
		
func pick_new_state() -> void:
	if not self.velocity == Vector2.ZERO:
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
		
func _physics_process(_delta) -> void:
	if not current_path.is_empty():
		var current_pos: Vector2 = self.global_position
		var current_map_pos: Vector2i = tile_map.local_to_map(current_pos)
		var tile_data: TileData = tile_map.get_cell_tile_data(1, current_map_pos)
		var speed_modifier: float = get_terrain_speed_modifier(tile_data)
		var target_pos: Vector2 = tile_map.map_to_local(current_path.front())
		
		update_animation_params(target_pos - current_pos)
		self.global_position = current_pos.move_toward(target_pos, speed * speed_modifier)
		if self.global_position == target_pos:
			current_path.pop_front()

func get_terrain_speed_modifier(_tile_data: TileData) -> float:
	if _tile_data:
		if _tile_data.get_custom_data("Forest"):
			return 0.8
		elif _tile_data.get_custom_data("Hills"):
			return 0.75
		elif _tile_data.get_custom_data("Swamp"):
			return 0.65
		elif _tile_data.get_custom_data("Mountains"):
			return 0.5
	return 1.0
