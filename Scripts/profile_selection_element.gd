extends Button
class_name ProfileSelectionElement

@export var tags: Array[TagsEnum.WeatherTags]
@export var selected: bool = false

var time: float

func _gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Click"):
		time = 0
	if Input.is_action_pressed("Click"):
		time += 0.1

func _ready() -> void:
	SignalBus.UpdateWidgetScore.connect(on_update_data)

func on_update_data() -> void:
	if selected:
		for tag in tags:
			SignalBus.IncreaseWidgetScore.emit(tag)

func _on_toggled(toggled_on: bool) -> void:
	if time < 2:
		selected = !selected
