extends Control
class_name ProfileManager

func _on_button_button_up() -> void:
	SignalBus.update_widget_score()
