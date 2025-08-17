extends Resource
class_name Item

enum ItemUse {
	FOOD,
	DECOR,
	PLAYTHING
}

enum Type {
	COOLNESS,
	BEAUTY,
	CUTENESS,
	CLEVERNESS,
	TOUGHNESS,
	COUNT
}

@export var name: String
#Types yoinked from pokemon contests
#Coolness, Beauty, Cuteness, Cleverness, and Toughness
@export var type: Type
@export var t_string: String
@export var usage: ItemUse
@export var icon: Texture2D
@export var count: int
@export var base_restore: float = 10
@export var likes_restore_scale: float = 1.5
@export var hates_restore_scale: float = 0.5
@export var critter_item: CritterRes

func _init() -> void:
	set_type_string()

func set_type_string() -> void:
	match type:
		Type.COOLNESS:
			t_string = "Coolness"
		Type.BEAUTY:
			t_string = "Beauty"
		Type.CLEVERNESS:
			t_string = "Cleverness"
		Type.TOUGHNESS:
			t_string = "Toughness"
		Type.CUTENESS:
			t_string = "Cuteness"
			
func is_food() -> bool:
	return usage == ItemUse.FOOD
	
func is_toy() -> bool:
	return usage == ItemUse.PLAYTHING
