# build_manager.gd
extends Node

enum BuildingType {NONE, WAREHOUSE, WINDMILL, LUMBER, BLACKSMITH, CASTLE, CAMP, MONUMENT}

@onready var build_sound: AudioStreamPlayer = $BuildSound

var in_build_mode: bool = false
var selected_building: BuildingType = BuildingType.NONE

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit_build_mode"):
		in_build_mode = false

	if in_build_mode:
		if Input.is_action_just_pressed("place_building"):
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

func _check_building_cost(building_type: BuildManager.BuildingType) -> bool:
	match building_type:
		BuildManager.BuildingType.WINDMILL:
			if EconomyManager.windmill_cost <= EconomyManager.blue_amount:
				EconomyManager.blue_amount -= EconomyManager.windmill_cost
				return true
			else:
				print("Not enough blue coins!")
				print(EconomyManager.blue_amount)
				print(EconomyManager.windmill_cost)
				return false

		BuildManager.BuildingType.LUMBER:
			if EconomyManager.lumber_cost <= EconomyManager.blue_amount:
				EconomyManager.blue_amount -= EconomyManager.lumber_cost
				return true
			else:
				print("Not enough blue coins!")
				return false

		BuildManager.BuildingType.BLACKSMITH:
			if EconomyManager.blacksmith_cost <= EconomyManager.green_amount:
				EconomyManager.green_amount -= EconomyManager.blacksmith_cost
				return true
			else:
				print("Not enough green coins!")
				return false

		BuildManager.BuildingType.CASTLE:
			if EconomyManager.castle_cost <= EconomyManager.yellow_amount:
				EconomyManager.yellow_amount -= EconomyManager.castle_cost
				return true
			else:
				print("Not enough yellow coins!")
				return false

		BuildManager.BuildingType.WAREHOUSE:
			if EconomyManager.warehouse_cost <= EconomyManager.green_amount:
				EconomyManager.green_amount -= EconomyManager.warehouse_cost
				return true
			else:
				print("Not enough green coins!")
				return false

		_:
			print("Unknown building")
			return false
