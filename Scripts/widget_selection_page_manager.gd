extends Control
class_name WidgetSelectionPageManager

@export var widgetCoustomizationPage: Control
@export var widgetPersonaPage: Control


func _on_customization_button_button_up() -> void:
	widgetCoustomizationPage.visible = true
	widgetPersonaPage.visible = false


func _on_persona_button_button_up() -> void:
	widgetCoustomizationPage.visible = false
	widgetPersonaPage.visible = true
