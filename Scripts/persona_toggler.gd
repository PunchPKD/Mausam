extends Control
class_name PersonaToggler

@export var widgetData: BaseWidgetData
@export var panel: Panel
@export var label: Label

var time: float

func _gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Click"):
		time = 0
	if Input.is_action_pressed("Click"):
		time += 0.1
	if Input.is_action_just_released("Click") and time < 6:
		SignalBus.AddWidgetList.emit(widgetData)
