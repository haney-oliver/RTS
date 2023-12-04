class_name Selector
extends ColorRect

var mouse_down: bool
var mouse_start_pos: Vector2
var mouse_end_pos: Vector2
var selected_units: Array[Division] = []
var mouse_pointer_rect: Rect2i

func _input(_event):
	if _event is InputEventMouseButton:
		if _event.button_index == 1 and _event.is_pressed():
			if not selected_units.is_empty():
				for unit in selected_units:
					unit.is_selected = false
				selected_units.resize(0)
			if not mouse_down:
				mouse_down = true
				mouse_start_pos = get_global_mouse_position()
			self.global_position = mouse_start_pos
		elif not _event.is_pressed():
			if mouse_down:
				mouse_down = false
				mouse_end_pos = get_global_mouse_position()
				mouse_pointer_rect = Rect2i(get_global_mouse_position(), Vector2i(5,5))
				store_selection()
				self.size = Vector2.ZERO
	if _event is InputEventMouseMotion:
		if mouse_down:
			_update()
		

func _update():
	if get_global_mouse_position().x < mouse_start_pos.x:
		self.scale.x = -1
	elif get_global_mouse_position().x > mouse_start_pos.x:
		self.scale.x = 1
	if get_global_mouse_position().y < mouse_start_pos.y:
		self.scale.y = -1
	elif get_global_mouse_position().y > mouse_start_pos.y:
		self.scale.y = 1
	self.size = Vector2(
		get_global_mouse_position().x - mouse_start_pos.x,
		get_global_mouse_position().y - mouse_start_pos.y
	) * self.scale

# Called when the node enters the scene tree for the first time.
func _ready():
	self.size = Vector2(0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func store_selection():
	var all_divisions = get_tree().get_nodes_in_group("unit")
	if all_divisions and not all_divisions.is_empty():
		for division in all_divisions:
			if self.get_global_rect().has_point(division.global_position):
				division.is_selected = true
				selected_units.append(division)
			if mouse_pointer_rect.has_point(division.global_position):
				division.is_selected = true
				selected_units.append(division)
