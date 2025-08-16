extends Resource
class_name PlayerStats

enum ActionState {
	NAV,
	FEEDING, 
	PLAYING,
	DECORATING,
	EXPLORE
	}

@export var action_state: ActionState
@export var current_state: int
@export var batt_level: float = 95
@export var batt_max: float = 100

func in_terrarium() -> bool:
	return current_state <= ActionState.DECORATING
