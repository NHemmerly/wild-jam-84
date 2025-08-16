extends VBoxContainer

const BATT_LOW_LEVEL: float = 25.0
const BATT_LOW_TEXT: String = "BATT LOW"
var batt_started = false	
var bit_flip := 0

func _process(delta: float) -> void:
	warn_batt_low()

func warn_batt_low() -> void:
	if player_state.stats.batt_level <= BATT_LOW_LEVEL && !batt_started:
		$batt_blink.start()
		batt_started = true
		$Batt.text = BATT_LOW_TEXT

func _on_batt_blink_timeout() -> void:
	bit_flip = ~bit_flip 
	$Batt.modulate.a = -bit_flip 
