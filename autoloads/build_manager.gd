# build_manager.gd
extends Node

enum BuildingType {NONE, WAREHOUSE, WINDMILL, LUMBER, BLACKSMITH, CASTLE, CAMP, MONUMENT}

@onready var build_sound: AudioStreamPlayer = $BuildSound

var in_build_mode: bool = false
var selected_building: BuildingType = BuildingType.NONE

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("exit_build_mode"):
			in_build_mode = false

		if in_build_mode:
			if event.is_action_pressed("place_building"):
				EventBus.OnPlaceBuilding.emit(selected_building)

func _add_building(building_type: BuildManager.BuildingType) -> void:
	match building_type:
		BuildManager.BuildingType.WINDMILL:
			EconomyManager.blue_generators += 1

		BuildManager.BuildingType.LUMBER:
			EconomyManager.green_generators += 1

		BuildManager.BuildingType.BLACKSMITH:
			EconomyManager.yellow_generators += 1

		BuildManager.BuildingType.CASTLE:
			EconomyManager.red_generators += 1

		BuildManager.BuildingType.WAREHOUSE:
			EconomyManager.warehouses += 1
			EconomyManager.update_coin_cap()

		_:
			pass
	
	build_sound.play()
	await get_tree().create_timer(0.3).timeout
	build_sound.play()

func check_building_cost(building_type: BuildManager.BuildingType) -> bool:
	var building_type_name: String = BuildingType.keys()[building_type].to_lower()
	var cost_type_name: String

	match building_type:
		BuildManager.BuildingType.WINDMILL:
			cost_type_name = "blue"
		BuildManager.BuildingType.LUMBER:
			cost_type_name = "blue"
		BuildManager.BuildingType.BLACKSMITH:
			cost_type_name = "green"
		BuildManager.BuildingType.CASTLE:
			cost_type_name = "yellow"
		BuildManager.BuildingType.WAREHOUSE:
			cost_type_name = "green"
		_:
			cost_type_name = "blue"
	
	if EconomyManager.get(building_type_name + "_cost") <= EconomyManager.get(cost_type_name + "_amount"):
		EconomyManager.set(cost_type_name + "_amount", EconomyManager.get(cost_type_name + "_amount") - EconomyManager.get(building_type_name + "_cost"))
		return true
	else:
		print("Not enough funds!")
		return false
