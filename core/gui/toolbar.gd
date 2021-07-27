extends Node

signal selected(command)

func _on_ResidentialBtn_toggled(button_pressed):
	emit_signal("selected", {
		action = BuildCommand.PLOT,
		drag = false,
		dimension = Vector2(3, 3),
		scene = "res://assets/residential/ResidentialZone.tscn"
	})


func _on_CommercialBtn_toggled(button_pressed):
	emit_signal("selected", {
		action = BuildCommand.PLOT,
		drag = false,
		dimension = Vector2(3, 3),
		scene = "res://assets/commercial/CommercialZone.tscn"
	})


func _on_IndustryBtn_toggled(button_pressed):
	emit_signal("selected", {
		action = BuildCommand.PLOT,
		drag = false,
		dimension = Vector2(3, 3),
		scene = "res://assets/industrial/IndustrialZone.tscn"
	})


func _on_FireStationBtn_toggled(button_pressed):
	emit_signal("selected", {
		action = BuildCommand.PLOT,
		drag = false,
		dimension = Vector2(3, 3),
		scene = "res://assets/firestation/FireStation.tscn"
	})


func _on_QueryBtn_toggled(button_pressed):
	pass # Replace with function body.


func _on_PoliceStationBtn_toggled(button_pressed):
		emit_signal("selected", {
		action = BuildCommand.PLOT,
		drag = false,
		dimension = Vector2(3, 3),
		scene = "res://assets/policestation/PoliceStation.tscn"
	})


func _on_WiresBtn_toggled(button_pressed):
	emit_signal("selected", {
		action = BuildCommand.WIRE,
		drag = true,
		dimension = Vector2(1, 1),
	})


func _on_BulldozeBtn_toggled(button_pressed):
	emit_signal("selected", {
		action = BuildCommand.DESTROY,
		drag = true,
		dimension = Vector2(1, 1),
	})


func _on_ParkBtn_toggled(button_pressed):
	pass # Replace with function body.


func _on_RailBtn_toggled(button_pressed):
	emit_signal("selected", {
		action = BuildCommand.RAIL,
		drag = true,
		dimension = Vector2(1, 1),
	})


func _on_RoadBtn_toggled(button_pressed):
	emit_signal("selected", {
		action = BuildCommand.ROAD,
		drag = true,
		dimension = Vector2(1, 1),
	})


func _on_CoalPowerBtn_toggled(button_pressed):
	emit_signal("selected", {
		action = BuildCommand.PLOT,
		drag = false,
		dimension = Vector2(4, 4),
		scene = "res://assets/coalpower/CoalPowerStation.tscn"
	})


func _on_NuclearPowerBtn_toggled(button_pressed):
		emit_signal("selected", {
		action = BuildCommand.PLOT,
		dimension = Vector2(4, 4),
		drag = false,
		scene = "res://assets/nuclearpower/NuclearPowerStation.tscn"
	})


func _on_StadiumBtn_toggled(button_pressed):
	pass # Replace with function body.


func _on_SeaportBtn_toggled(button_pressed):
	emit_signal("selected", {
		action = BuildCommand.PLOT,
		dimension = Vector2(4, 4),
		drag = false,
		scene = "res://assets/seaport/Seaport.tscn"
	})


func _on_AirportBtn_toggled(button_pressed):
	emit_signal("toolbar_selected", {
		action = BuildCommand.PLOT,
		dimension = Vector2(6, 6),
		drag = false,
		scene = "res://assets/airport /Airport.tscn"
	})



