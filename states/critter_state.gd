class_name CritterState extends State

const IDLE = "Idle"
const WANDER = "Wander"

var critter: Critter

func _ready() -> void:
	print(owner)
	await owner.ready
	critter = owner as Critter
	print(critter)
	assert(critter != null, "The CritterState type must be used only in the critter scene.")
