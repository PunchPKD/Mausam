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
		SignalBus.AddWidget.emit(widget)

func on_add_widget(widgetScene: PackedScene) -> void:
	get_widget(widgetScene).visible = true
	currentWidgets.widgets.append(widgetScene)

func on_remove_widget(widgetScene: PackedScene) -> void:
	get_widget(widgetScene).visible = false
	currentWidgets.widgets.erase(widgetScene)

func get_widget(widgetScene: PackedScene) -> Widget:
	if widgets.has(widgetScene.resource_path):
		return widgets.get(widgetScene.resource_path)
	var tempWidget: Widget = widgetScene.instantiate()
	widgets[widgetScene.resource_path] = tempWidget
	widgetContainer.add_child(tempWidget)
	return tempWidget

func reassign_widget_rank(widgetScene: PackedScene) -> void:
	var totalActiveWidget: int = currentWidgets.widgets.size()
	var tempWidget : Widget = get_widget(widgetScene)
	if tempWidget.get_index()+1 <= totalActiveWidget/3:
		tempWidget.widgetRank = tempWidget.WidgetRanks.TOP
	elif tempWidget.get_index()+1 <= (totalActiveWidget/3)*2:
		tempWidget.widgetRank = tempWidget.WidgetRanks.MIDDLE
	else :
		tempWidget.widgetRank = tempWidget.WidgetRanks.BOTTOM
