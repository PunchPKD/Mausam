extends Control
class_name Widget

func _ready() -> void:
	pass
	
func _gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Click"):
		pass

func remove() -> void:
	SignalBus.RemoveWidget.emit(self)
