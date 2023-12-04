class_name Selector
extends ColorRect

var mouse_down: bool
var mouse_start_pos: Vector2
var mouse_end_pos: Vector2

func _input(_event):
	if _event is InputEventMouseButton:
		if _event.button_index == 1 and _event.is_pressed():
			if not mouse_down:
				mouse_down = true
				mouse_start_pos = _event.global_position
				self.global_position = mouse_start_pos
		elif not _event.is_pressed():
			if mouse_down:
				mouse_down = false
				mouse_end_pos = _event.global_position
	if _event is InputEventMouseButton:
		if mouse_down:
			_update()

func _update():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
