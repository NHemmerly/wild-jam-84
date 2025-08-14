class_name TerrariumState extends State

const FEEDING = "Feeding"
const DECORATING = "Decorating"
const NAV = "Nav"
const PLAYING = "Playing"

var player_sm: PlayerStateMachine

func _ready() -> void:
	await owner.ready
	player_sm = owner as PlayerStateMachine
	assert(player_sm != null, "TerrariumState error, owner not player_sm")
