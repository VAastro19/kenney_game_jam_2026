# build_manager.gd
class_name BuildManager extends Node

@onready var economy_manager: Node = %EconomyManager

@onready var build_sound: AudioStreamPlayer = $BuildSound

var in_build_mode: bool = false
var selected_building: Enums.BuildingType = Enums.BuildingType.NONE

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("exit_build_mode"):
			in_build_mode = false

		if in_build_mode:
			if event.is_action_pressed("place_building"):
				EventBus.OnPlaceBuilding.emit(selected_building)

func add_building(building_type: Enums.BuildingType) -> void:
	match building_type:
		Enums.BuildingType.WINDMILL:
			economy_manager.blue_generators += 1

		Enums.BuildingType.LUMBER:
			economy_manager.green_generators += 1

		Enums.BuildingType.BLACKSMITH:
			economy_manager.yellow_generators += 1

		Enums.BuildingType.CASTLE:
			economy_manager.red_generators += 1

		Enums.BuildingType.WAREHOUSE:
			economy_manager.warehouses += 1
			economy_manager.update_coin_cap()

		_:
			pass
	
	build_sound.play()
	await get_tree().create_timer(0.3).timeout
	build_sound.play()

func check_building_cost(building_type: Enums.BuildingType) -> bool:
	var building_type_name: String = Enums.BuildingType.keys()[building_type].to_lower()
	var cost_type_name: String

	match building_type:
		Enums.BuildingType.WINDMILL:
			cost_type_name = "blue"
		Enums.BuildingType.LUMBER:
			cost_type_name = "blue"
		Enums.BuildingType.BLACKSMITH:
			cost_type_name = "green"
		Enums.BuildingType.CASTLE:
			cost_type_name = "yellow"
		Enums.BuildingType.WAREHOUSE:
			cost_type_name = "green"
		_:
			cost_type_name = "blue"
	
	if economy_manager.get(building_type_name + "_cost") <= economy_manager.get(cost_type_name + "_amount"):
		economy_manager.set(cost_type_name + "_amount", economy_manager.get(cost_type_name + "_amount") - economy_manager.get(building_type_name + "_cost"))
		return true
	else:
		print("Not enough funds!")
		return false
