extends Button
class_name RecommendationButton

var widgetScene: PackedScene

var time: float

func _gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Click"):
		time = 0
	if Input.is_action_pressed("Click"):
		time += 0.1

func _on_button_up() -> void:
	if time < 2:
		self.visible = false
		if widgetScene:
			SignalBus.AddWidget.emit(widgetScene)
