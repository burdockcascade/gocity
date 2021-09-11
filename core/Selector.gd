extends TileMap

signal selected(build_command, tilebox, worldbox)

const GOOD_SELECTION_COLOR = Color.white
const BAD_SELECTION_COLOR = Color.red

const DEFAULT_BOX_DIMENSION = Vector2(16, 16)
const DEFAULT_BOX = Vector2(1, 1)

var box_color: Color = GOOD_SELECTION_COLOR

var selected_tile
var current_tile

var button_pressed: bool = false
var can_move = false

var command: Dictionary

################################################################################
## GUI

func _on_Toolbar_selected(command):
	self.command = command
	visible = true


################################################################################
## Draw

func _physics_process(_delta) -> void:
	update()

func _draw() -> void:
	if command.has("worldbox"):
		draw_rect(command.worldbox, box_color, false)


################################################################################
## Inputs

func _unhandled_input(event) -> void:

	if not visible:
		return

	# remember curent tile
	current_tile = world_to_map(get_global_mouse_position())

	# user pressed cancel
	if Input.is_action_pressed("ui_cancel"):
		visible = false

	# mouse moved
	elif event is InputEventMouseMotion:
		_handle_mouse_move(event)

	# mouse drag
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		_handle_mouse_button(event)

func _handle_mouse_button(event) -> void:

	if event.pressed:

		if command.drag:
			button_pressed = true
		else:
			can_move = false

		selected_tile = current_tile

	else:

		button_pressed = false
		can_move = true

		emit_signal("selected", command)

		_handle_mouse_move(event)

func _handle_mouse_move(event) -> void:

	if button_pressed:

		var start_tile = selected_tile
		var end_tile = current_tile

		# calculate box in tilemap
		command.tilebox = Rect2(selected_tile, current_tile - selected_tile).abs()
		command.tilebox.size += Vector2.ONE

		match command.action:

			# restrict selection to single column or row
			BuildCommand.ROAD, BuildCommand.RAIL, BuildCommand.WIRE:

				if command.tilebox.size.x < command.tilebox.size.y:
					start_tile = Vector2(selected_tile.x, command.tilebox.position.y)
					end_tile = Vector2(selected_tile.x, command.tilebox.end.y - 1)
				else:
					start_tile = Vector2(command.tilebox.position.x, selected_tile.y)
					end_tile = Vector2(command.tilebox.end.x - 1, selected_tile.y)

			BuildCommand.DESTROY:
				pass

		command.tilebox = Rect2(start_tile, (end_tile - start_tile) + Vector2.ONE).abs()

		var pos = map_to_world(command.tilebox.position)

		command.worldbox = Rect2(pos, Vector2(command.tilebox.size.x * DEFAULT_BOX_DIMENSION.x, command.tilebox.size.y * DEFAULT_BOX_DIMENSION.y))

	else:

		var pos = map_to_world(current_tile)

		# calculate box in tilemap
		command.tilebox = Rect2(current_tile, command.dimension).abs()

		# calculat box in world
		command.worldbox = Rect2(pos, DEFAULT_BOX_DIMENSION * command.dimension)



