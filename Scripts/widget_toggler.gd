extends Control
class_name WidgetToggler

@export var widgetScene: PackedScene
@export var addIcon: TextureRect
@export var removeIcon: TextureRect

var isSelected: bool = false :
	set(value):
		isSelected = value
		if value == true:
			addIcon.visible = false
			removeIcon.visible = true
			SignalBus.AddWidget.emit(widgetScene)
		else:
			addIcon.visible = true
			removeIcon.visible = false
			SignalBus.RemoveWidget.emit(widgetScene)

func _gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Click"):
		isSelected = !isSelected
