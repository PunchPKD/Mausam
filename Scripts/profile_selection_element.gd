extends Button
class_name ProfileSelectionElement

@export var tags: Array[TagsEnum.WeatherTags]
@export var selected: bool = false

func _ready() -> void:
	SignalBus.UpdateWidgetScore.connect(on_update_data)

func on_update_data() -> void:
	if selected:
		for tag in tags:
			SignalBus.IncreaseWidgetScore.emit(tag)

func _on_toggled(toggled_on: bool) -> void:
	selected = !selected
