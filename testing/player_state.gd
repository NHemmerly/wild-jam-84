class_name PlayerState extends StateMachine

const MENU = "menu"
const TERRARIUM = "terrarium"
const EXPLORE = "explore"

var player: PlayerStateMachine

func _ready() -> void:
	print(owner)
	await owner.ready
	player = owner as PlayerStateMachine
	print(player)
	assert(player != null, "The PlayerState type must be used only in the player scene.")
