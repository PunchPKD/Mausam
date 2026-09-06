extends ScrollContainer
class_name WidgetManager

var widgets : Dictionary[String, Widget] = {}
var currentSelectedElement: Control

@export var currentWidgets: BaseWidgetData
@export var widgetContainer: Control

func _ready() -> void:
	SignalBus.AddWidget.connect(on_add_widget)
	SignalBus.RemoveWidget.connect(on_remove_widget)
	SignalBus.AddWidgetList.connect(on_add_widget_list)
	
	await get_tree().process_frame
	var tempWidgetData: BaseWidgetData = currentWidgets
	for widget in tempWidgetData.widgets:
		SignalBus.AddWidget.emit(widget)

func on_add_widget_list(widgetData: BaseWidgetData) -> void:
	var tempWidgetData: Array = currentWidgets.widgets.duplicate()
	for widget in tempWidgetData:
		SignalBus.RemoveWidget.emit(widget)
	for widget in widgetData.widgets:
		SignalBus.AddWidget.emit(widget)

func on_add_widget(widgetScene: PackedScene) -> void:
	var tempWidget: Widget = get_widget(widgetScene)
	tempWidget.visible = true
	widgetContainer.move_child(tempWidget, -1)
	if currentWidgets.widgets.has(widgetScene) == false:
		currentWidgets.widgets.append(widgetScene)
	#reassign_widget_rank()
	ResourceSaver.save(currentWidgets)

func on_remove_widget(widgetScene: PackedScene) -> void:
	var tempWidget: Widget = get_widget(widgetScene)
	get_widget(widgetScene).visible = false
	widgetContainer.move_child(tempWidget, -1)
	currentWidgets.widgets.erase(widgetScene)
	#reassign_widget_rank()
	ResourceSaver.save(currentWidgets)
	
func get_widget(widgetScene: PackedScene) -> Widget:
	if widgets.has(widgetScene.resource_path):
		return widgets.get(widgetScene.resource_path)
	var tempWidget: Widget = widgetScene.instantiate()
	widgets[widgetScene.resource_path] = tempWidget
	widgetContainer.add_child(tempWidget)
	return tempWidget

func reassign_widget_rank() -> void:
	var totalActiveWidget: int = currentWidgets.widgets.size()
	var cycleCount: int = 0
	for widget in currentWidgets.widgets:
		cycleCount += 1
		var tempWidget : Widget = get_widget(widget)
		if cycleCount <= maxi(1, totalActiveWidget/3):
			tempWidget.widgetRank = tempWidget.WidgetRanks.TOP
		elif cycleCount <= maxi(1, (totalActiveWidget/3)*2):
			tempWidget.widgetRank = tempWidget.WidgetRanks.MIDDLE
		else :
			tempWidget.widgetRank = tempWidget.WidgetRanks.BOTTOM
	
func on_select_element(element: Control) -> void:
	if currentSelectedElement == element:
		currentSelectedElement = null
	else:
		currentSelectedElement = element
