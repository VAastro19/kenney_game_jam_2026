# event_bus.gd
extends Node

signal OnPlaceBuilding(type: GameManager.BuildingType)
signal OnUpdateCoin(amount: float, type: GameManager.CoinType)
signal OnUpdateCoinCap
