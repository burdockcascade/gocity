extends Node2D

onready var terrain = $Terrain
onready var selector = $Selector
onready var plots = $Plots

################################################################################
## Tile Selection

func _on_Selector_selected(command):

	match command.action:

		BuildCommand.ROAD:
			terrain.build_road(command.tilebox)

		BuildCommand.RAIL:
			terrain.build_rail(command.tilebox)

		BuildCommand.WIRE:
			terrain.build_wire(command.tilebox)

		BuildCommand.PLOT:
			plots.add(command.scene, command.worldbox.position)

		BuildCommand.DESTROY:
			terrain.destroy(command.tilebox)
			plots.remove(command.worldbox)


################################################################################
## Simulation Run

func _on_Simulator_timeout():

	var power_comsumption = 0
	var power_production = 0

	# loop through each city plot
	for plot in get_tree().get_nodes_in_group("plot"):

		# calculate total power production
		power_production += plot.power_production

		# calculate total power consumption
		power_comsumption += plot.power_consumption



	printt("power", power_comsumption, power_production)
