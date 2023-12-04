extends Camera2D

var zoom_speed: float = 0.01
var zoom_min: float = 0.5
var zoom_max: float = 2.0
var drag_sensitivity: float = 1.0

func _input(event):
	var _zoom: Vector2 = self.zoom
	if event is InputEventMouseMotion and (Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE) || event.pressure == 1.00):
		self.position -= event.relative * drag_sensitivity / zoom
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			self.zoom += Vector2(zoom_speed, zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			self.zoom -= Vector2(zoom_speed, zoom_speed)
	if event is InputEventPanGesture:
		if event.delta.y < 0:
			_zoom += Vector2(zoom_speed, zoom_speed)
		elif event.delta.y > 0:
			_zoom -= Vector2(zoom_speed, zoom_speed)
	self.zoom = clamp(_zoom, Vector2(zoom_min, zoom_min), Vector2(zoom_max, zoom_max))
