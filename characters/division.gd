class_name Player
extends CharacterBody2D

const IDLE_BLEND_POS : String = "parameters/Idle/blend_position"
const WALK_BLEND_POS : String = "parameters/Walk/blend_position"

@export var starting_direction : Vector2 = Vector2(0,1)
@export var speed : float = 100

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	update_animation_params(starting_direction)

func _physics_process(_delta):
	var input_direction :  Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_params(input_direction)
	
	self.velocity = input_direction * speed
	self.move_and_slide()
	pick_new_state()
	
func update_animation_params(_move_input : Vector2):
	if(_move_input != Vector2.ZERO):
		animation_tree.set(WALK_BLEND_POS, _move_input)
		animation_tree.set(IDLE_BLEND_POS, _move_input)
		
func pick_new_state():
	if (self.velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
	
