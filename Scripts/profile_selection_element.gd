extends Button
class_name ProfileSelectionElement

@export var tags: Array[TagsEnum.WeatherTags]

func _ready() -> void:
	SignalBus.UpdateWidgetScore.connect(on_update_data)

func on_update_data() -> void:
	for tag in tags:
		SignalBus.IncreaseWidgetScore.emit(tag)
