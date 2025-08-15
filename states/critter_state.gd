class_name CritterState extends State

const IDLE = "Idle"
const WANDER = "Wander"
const FEEDING = "Feeding"

var critter: Critter

func _ready() -> void:
	await owner.ready
	critter = owner as Critter
	assert(critter != null, "The CritterState type must be used only in the critter scene.")
	
