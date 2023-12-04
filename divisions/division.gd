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

var current_path: Array[Vector2i]

func _ready():
	update_animation_params(starting_direction)
	
func _input(_event):
	if _event.is_action_pressed("select"):
		var from: Vector2i = tile_map.local_to_map(self.global_position)
		var mouse_pos: Vector2 = self.get_global_mouse_position()
		if mouse_pos.x > 0 && mouse_pos.y > 0:
			var to: Vector2i = tile_map.local_to_map(self.get_global_mouse_position())
			var path: Array[Vector2i] = tile_map.astar.get_id_path(from, to).slice(1)
			if !path.is_empty():
				current_path = path
		
func update_animation_params(_move_input : Vector2):
	if _move_input != Vector2.ZERO:
		animation_tree.set(WALK_BLEND_POS, _move_input)
		animation_tree.set(IDLE_BLEND_POS, _move_input)
		
func pick_new_state():
	if self.velocity != Vector2.ZERO:
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
		
func _physics_process(_delta):
	if !current_path.is_empty():
		var current_pos: Vector2 = self.global_position
		var target_pos: Vector2 = tile_map.map_to_local(current_path.front())
		
		update_animation_params(target_pos - current_pos)
		
		self.global_position = current_pos.move_toward(target_pos, speed)
		if self.global_position == target_pos:
			current_path.pop_front()
