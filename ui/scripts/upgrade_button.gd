# upgrade_button.gd
class_name UpgradeButton extends Control

enum Upgrade {
	LUMBER_UNLOCK,
	BLACKSMITH_UNLOCK,
	CASTLE_UNLOCK,
	GREEN_UNLOCK,
	YELLOW_UNLOCK,
	RED_UNLOCK,
	CLICK_VALUE,
	WINDMILL_EFF,
	LUMBER_EFF,
	BLACKSMITH_EFF,
	CASTLE_EFF,
	MONUMENT
}

enum UpgradeType { UNLOCK, EFFICIENCY }

@onready var bought_audio: AudioStreamPlayer = $BoughtAudio
@onready var button: TextureButton = $Button
@onready var type_icon: TextureRect = $Button/UpgradeTypeIcon
@onready var cost_label: RichTextLabel = $Cost

@export var upgrade: Upgrade
@export var upgrade_type: UpgradeType
@export var buy_limit: int = 1
@export var cost: float
@export var is_unlocked: bool:
	set(new_value):
		is_unlocked = new_value
		if new_value == false:
			modulate = Color.DIM_GRAY
		else:
			modulate = Color.WHITE

var cur_buys: int = 0

func _ready() -> void:
	is_unlocked = true
	
	match upgrade_type:
		UpgradeType.UNLOCK:
			type_icon.texture = load("uid://c8b733my3oitb")
			
		UpgradeType.EFFICIENCY:
			type_icon.texture = load("uid://b5gg6v3ocb3d3")

func _on_button_pressed() -> void:
	if is_unlocked:
		match upgrade:
			Upgrade.LUMBER_UNLOCK:
				if 600 <= GameManager.blue_amount:
					GameManager.blue_amount -= 600
					cur_buys += 1
					_bought()
					EventBus.OnUnlockBuilding.emit(GameManager.BuildingType.LUMBER)

			Upgrade.BLACKSMITH_UNLOCK:
				if 2000 <= GameManager.green_amount:
					GameManager.green_amount -= 2000
					cur_buys += 1
					_bought()
					EventBus.OnUnlockBuilding.emit(GameManager.BuildingType.BLACKSMITH)

			Upgrade.CASTLE_UNLOCK:
				if 10000 <= GameManager.yellow_amount:
					GameManager.yellow_amount -= 10000
					cur_buys += 1
					_bought()
					EventBus.OnUnlockBuilding.emit(GameManager.BuildingType.CASTLE)

			Upgrade.GREEN_UNLOCK:
				if 500 <= GameManager.blue_amount:
					GameManager.blue_amount -= 500
					cur_buys += 1
					_bought()
					EventBus.OnUnlockGenerator.emit(GameManager.CoinType.GREEN)

			Upgrade.YELLOW_UNLOCK:
				if 1800 <= GameManager.green_amount:
					GameManager.green_amount -= 1800
					cur_buys += 1
					_bought()
					EventBus.OnUnlockGenerator.emit(GameManager.CoinType.YELLOW)

			Upgrade.RED_UNLOCK:
				if 8000 <= GameManager.yellow_amount:
					GameManager.yellow_amount -= 8000
					cur_buys += 1
					_bought()
					EventBus.OnUnlockGenerator.emit(GameManager.CoinType.RED)

			Upgrade.MONUMENT:
				if 1000000 <= GameManager.red_amount:
					GameManager.red_amount -= 1000000
					cur_buys += 1
					_bought()
					EventBus.OnMonumentBuilt.emit()

func _bought() -> void:
	if cur_buys >= buy_limit:
		cost_label.text = "[font_size=32][outline_size=2][color=dark_green]BOUGHT"
		is_unlocked = false
		bought_audio.play()
