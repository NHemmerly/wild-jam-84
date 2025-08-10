class_name PlayerState extends State

const MENU = "menu"
const TERRARIUM = "terrarium"
const EXPLORE = "explore"

var player: Player

func _ready() -> void:
	print(owner)
	await owner.ready
	player = owner as Player
	print(player)
	assert(player != null, "The PlayerState type must be used only in the player scene.")
