extends ScrollContainer
class_name WidgetManager

var widgets : Dictionary[String, Widget] = {}

@export var currentWidgets: BaseWidgetData
@export var widgetContainer: Control

func _ready() -> void:
	SignalBus.AddWidget.connect(on_add_widget)
	SignalBus.RemoveWidget.connect(on_remove_widget)
	SignalBus.AddWidgetList.connect(on_add_widget_list)
	
	await get_tree().process_frame
	for widget in currentWidgets.widgets:
		SignalBus.AddWidget.emit(widget)
	
func on_add_widget_list(widgetData: BaseWidgetData) -> void:
	for widget in currentWidgets.widgets:
		SignalBus.RemoveWidget.emit(widget)
	for widget in widgetData.widgets:
		currentWidgets.widgets.append(widget)
		SignalBus.AddWidget.emit(widget)

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
	
