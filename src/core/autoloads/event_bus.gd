# event_bus.gd
extends Node

signal OnClick(amount: float, type: Enums.CoinType)
signal OnUpdateCoin(type: Enums.CoinType)
signal OnUnlockGenerator(type: Enums.CoinType)

signal OnPlaceBuilding(type: Enums.BuildingType)
signal OnUnlockBuilding(type: Enums.BuildingType)

signal OnMonumentBuilt
signal OnTick
