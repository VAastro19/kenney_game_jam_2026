# event_bus.gd
extends Node

signal OnPlaceBuilding(type: GameManager.BuildingType)
signal OnUpdateCoin(amount: int, type: GameManager.CoinType)
signal OnUpdateCoinCap
