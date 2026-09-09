extends Control
class_name PersonaToggler

@export var widgetData: BaseWidgetData
@export var panel: Panel
@export var label: Label

func _gui_input(event: InputEvent) -> void:
	if Input.is_action_just_released("Click"):
		SignalBus.AddWidgetList.emit(widgetData)
