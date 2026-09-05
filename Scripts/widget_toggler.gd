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
		else:
			addIcon.visible = true
			removeIcon.visible = false

func _ready() -> void:
	SignalBus.AddWidget.connect(on_add_widget)
	SignalBus.RemoveWidget.connect(on_remove_widget)

func _gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Click"):
		if isSelected == true:
			SignalBus.RemoveWidget.emit(widgetScene)
		else :
			SignalBus.AddWidget.emit(widgetScene)

func on_add_widget(widget_Scene: PackedScene) -> void:
	if widget_Scene == self.widgetScene:
		isSelected = true

func on_remove_widget(widget_Scene: PackedScene) -> void:
	if widget_Scene == self.widgetScene:
		isSelected = false
	
	
	
	
