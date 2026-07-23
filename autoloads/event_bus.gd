# event_bus.gd
extends Node

signal OnClick(amount: float, type: EconomyManager.CoinType)
signal OnUpdateCoin(type: EconomyManager.CoinType)
signal OnUnlockGenerator(type: EconomyManager.CoinType)

signal OnPlaceBuilding(type: BuildManager.BuildingType)
signal OnUnlockBuilding(type: BuildManager.BuildingType)

signal OnMonumentBuilt
signal OnTick
