extends Button
class_name RecommendationButton

var widgetScene: PackedScene

func _on_button_up() -> void:
	self.visible = false
	if widgetScene:
		SignalBus.AddWidget.emit(widgetScene)
