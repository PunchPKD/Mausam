extends Control
class_name InformationPageManager

@export var informationPage: Control
@export var widgetSelectionPage: Control

func toggle_visiblity(element: Control) -> void:
	element.visible = !element.visible

func _on_toggle_edit_mode_button_button_up() -> void:
	toggle_visiblity(widgetSelectionPage)
