class_name MenuState extends State

const MAIN_MENU = "main_menu"
const SETTINGS = "settings"

var player_sm: PlayerStateMachine

func _ready() -> void:
	await owner.ready
	player_sm = owner as PlayerStateMachine
	assert(player_sm != null, "MenuState error, owner not player_sm")
