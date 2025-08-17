class_name CritterRes
extends Resource

enum Type {
	COOLNESS,
	BEAUTY,
	CUTENESS,
	CLEVERNESS,
	TOUGHNESS,
	COUNT
}
@export var name: String
@export var type: Type
@export var t_string: String
@export var speed: float
@export var speed_scale: int
@export var happiness: float = 100
@export var hunger: float = 100
@export var happiness_rate: float = 1.0
@export var hunger_rate: float = 1.0
@export var status_max: float = 100
@export var sprite: Texture2D

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
