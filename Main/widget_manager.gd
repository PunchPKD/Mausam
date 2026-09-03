extends ScrollContainer
class_name WidgetManager

var widgets : Array[Widget]

@export var widgetContainer: Control

func _ready() -> void:
	for child in widgetContainer.get_children():
		if child is Widget:
			widgets.append(child)
		
	SignalBus.AddWidget.connect(on_add_widget)
	SignalBus.RemoveWidget.connect(on_remove_widget)

func on_add_widget(widgetData: BaseWidgetData) -> void:
	if widgets.has(widgetData.widget.resource_path):
		var tempWidget: Widget = widgets.get(widgetData.widget.resource_path)
		tempWidget.visible = true

func on_remove_widget(widget: Widget) -> void:
	widget.visible = false
