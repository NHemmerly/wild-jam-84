class_name ExploreState extends State

var player_sm: PlayerStateMachine

func _ready() -> void:
	await owner.ready
	player_sm = owner as PlayerStateMachine
	assert(player_sm != null, "ExploreState error, owner not player_sm")
