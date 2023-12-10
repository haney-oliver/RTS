extends Camera2D

var zoom_speed: float = 0.01
var zoom_min: float = 0.2
var zoom_max: float = 2.0
var drag_sensitivity: float = 1.0

func _input(event):
	var _zoom: Vector2 = self.zoom
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		self.position -= event.relative * drag_sensitivity / zoom
	if event is InputEventPanGesture:
		self.position -= event.delta * drag_sensitivity * 3 / zoom
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_zoom += Vector2(zoom_speed, zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_zoom -= Vector2(zoom_speed, zoom_speed)
	if event is InputEventMagnifyGesture:
		if event.factor > 1:
			_zoom += Vector2(zoom_speed, zoom_speed)
		elif event.factor < 1:
			_zoom -= Vector2(zoom_speed, zoom_speed)
	self.zoom = clamp(_zoom, Vector2(zoom_min, zoom_min), Vector2(zoom_max, zoom_max))
