extends Resource
class_name PlayerStats

enum ActionState {
	NAV,
	FEEDING, 
	PLAYING,
	DECORATING
	}

@export var action_state: ActionState
@export var current_state: int
