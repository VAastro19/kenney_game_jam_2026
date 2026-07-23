# event_bus.gd
extends Node

signal OnPlaceBuilding(type: GameManager.BuildingType)
signal OnUpdateCoin(type: GameManager.CoinType)
signal OnClick(amount: float, type: GameManager.CoinType)
signal OnTick

signal OnUnlockBuilding(type: GameManager.BuildingType)
signal OnUnlockGenerator(type: GameManager.CoinType)
signal OnMonumentBuilt
