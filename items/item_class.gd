extends Resource
class_name Item

enum ItemUse {
	FOOD,
	DECOR,
	PLAYTHING
}

@export var name: String
#Types yoinked from pokemon contests
#Coolness, Beauty, Cuteness, Cleverness, and Toughness
@export var type: String
@export var usage: ItemUse
@export var icon: Texture2D
@export var count: int
