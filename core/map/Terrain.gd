extends TileMap

var map_size: Vector2 = Vector2(64, 64)

# naybe there is a btter way to identify these tiles
const TILES_RAIL = 8
const TILES_ROAD = 23
const TILES_GROUND = 43
const TILES_WIRE = 106

# data
var celldata: Dictionary = {}

# bitmasks for neighbours
var connectors: Dictionary = {
	Vector2.UP: 1,
	Vector2.RIGHT: 2,
	Vector2.DOWN: 4,
	Vector2.LEFT: 8,
}

################################################################################
## INIT

func _ready() -> void:
	for x in map_size.x:
		for y in map_size.y:
			set_cell(x, y, TILES_GROUND)
			celldata[Vector2(x, y)] = {
				water = false,
				wire = 0,
				road = 0,
				rail = 0
			}

################################################################################
## PAINT TILES

func build_road(box: Rect2) -> void:
	_paint(TILES_ROAD, "road", box)

func build_rail(box: Rect2) -> void:
	_paint(TILES_RAIL, "rail", box)

func build_wire(box: Rect2) -> void:
	_paint(TILES_WIRE, "wire", box)

func destroy(box: Rect2) -> void:

	# for every tile in box
	for x in range(box.position.x, box.end.x):
		for y in range(box.position.y, box.end.y):

			# reset tile
			set_cell(x, y,  TILES_GROUND)

			# reset data
			var data : Dictionary = celldata[Vector2(x, y)]
			data.wire = 0
			data.road = 0
			data.rail = 0


func _paint(tile_type: int, param: String, box: Rect2) -> void:

	var start_tile: int = 0
	var end_tile: int = 0

	# horizontal or vert
	if box.size.x > box.size.y:
		start_tile = connectors[Vector2.RIGHT]
		end_tile = connectors[Vector2.LEFT]
	else:
		start_tile = connectors[Vector2.DOWN]
		end_tile = connectors[Vector2.UP]

	var default_tile: int = start_tile|end_tile

	# for each tile
	for x in range(box.position.x, box.end.x):
		for y in range(box.position.y, box.end.y):

			var current_tile: Vector2 = Vector2(x, y)
			var image_id: int = 0

			if current_tile == box.position:
				image_id = start_tile
			elif current_tile == box.end - Vector2.ONE:
				image_id = end_tile
			else:
				image_id = default_tile

			# for each neighbour check if incomming road connections
			for n in connectors.keys():

				# coordinates for neighbour
				var neighbour_tile: Vector2 = Vector2(current_tile + n)

				# skip if tile not valid
				if not celldata.has(neighbour_tile):
					continue

				# get data for neighbour cell
				var ndata: Dictionary = celldata[neighbour_tile]

				# check if neighbour cell has roads connecting to current tile
				if _contains_bits(ndata[param], connectors[-n]):
					image_id |= connectors[n]

			# update current tile data
			celldata[current_tile][param] = image_id
			set_cell(x, y,  tile_type + image_id-1)

# Check if bist are set
func _contains_bits(bitmask: int, mask: int) -> bool:
	return (bitmask & mask) == mask
