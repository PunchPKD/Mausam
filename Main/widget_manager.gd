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
	SignalBus.UpdateWidgetScore.connect(on_update_widget_score)
	
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
	ResourceSaver.save(currentWidgets)

func on_remove_widget(widgetScene: PackedScene) -> void:
	var tempWidget: Widget = get_widget(widgetScene)
	get_widget(widgetScene).visible = false
	widgetContainer.move_child(tempWidget, -1)
	currentWidgets.widgets.erase(widgetScene)
	ResourceSaver.save(currentWidgets)
	
func get_widget(widgetScene: PackedScene) -> Widget:
	if widgets.has(widgetScene.resource_path):
		return widgets.get(widgetScene.resource_path)
	var tempWidget: Widget = widgetScene.instantiate()
	widgets[widgetScene.resource_path] = tempWidget
	widgetContainer.add_child(tempWidget)
	return tempWidget

func reassign_widget_rank() -> void:
	print("run")
	currentWidgets.widgets.sort_custom(
		func(a: PackedScene, b: PackedScene) -> bool:
			return get_widget(a).widgetScore > get_widget(b).widgetScore
	)
	
	var i: int = 0
	
	for widgetScene in currentWidgets.widgets:
		var tempwidget: Widget = get_widget(widgetScene)
		widgetContainer.move_child(tempwidget, i)
		i += 1
	
func on_select_element(element: Control) -> void:
	if currentSelectedElement == element:
		currentSelectedElement = null
	else:
		currentSelectedElement = element
	
func on_update_widget_score() -> void:
	await get_tree().create_timer(1).timeout
	reassign_widget_rank()
