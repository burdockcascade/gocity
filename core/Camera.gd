extends Camera2D

var previousPosition: Vector2 = Vector2(0, 0);
var moveCamera: bool = false;

func _unhandled_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		if (event.is_pressed()):
			on_mouse_button(event)
		else:
			moveCamera = false;

	elif (event is InputEventMouseMotion && moveCamera):
		on_mouse_move(event)

func on_mouse_button(event: InputEvent) -> void:
	match (event.button_index):

		BUTTON_RIGHT:
			previousPosition = event.position
			moveCamera = true

		BUTTON_WHEEL_UP:
			adjust_zoom(-0.5)

		BUTTON_WHEEL_DOWN:
			adjust_zoom(0.5)

func on_mouse_move(event: InputEvent) -> void:
	position += (previousPosition - event.position);
	previousPosition = event.position;

func adjust_zoom(z: float):
	zoom.x += z
	zoom.x = clamp(zoom.x, 0.5, 2)

	zoom.y += z
	zoom.y = clamp(zoom.y, 0.5, 2)


func _on_PoliceStationBtn_toggled(button_pressed):
	pass # Replace with function body.
