extends Button

@export var item: Item

#func _ready():
#	if item:
#		icon = item.icon

func update():
	if item != null:
		set_button_icon(item.icon)


func _on_pressed() -> void:
	if item != null:
		print(item.name)
