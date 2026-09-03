extends ScrollContainer
class_name WidgetManager

var widgets : Dictionary[String, Widget] = {}

@export var widgetContainer: Control

func _ready() -> void:
	SignalBus.AddWidget.connect(on_add_widget)
	SignalBus.RemoveWidget.connect(on_remove_widget)

func on_add_widget(widgetScene: PackedScene) -> void:
	get_widget(widgetScene).visible = true

func on_remove_widget(widgetScene: PackedScene) -> void:
	get_widget(widgetScene).visible = false

func get_widget(widgetScene: PackedScene) -> Widget:
	if widgets.has(widgetScene.resource_path):
		return widgets.get(widgetScene.resource_path)
	var tempWidget: Widget = widgetScene.instantiate()
	widgets[widgetScene.resource_path] = tempWidget
	widgetContainer.add_child(tempWidget)
	return tempWidget
	
