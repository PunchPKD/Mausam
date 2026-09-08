extends Control
class_name TimeDataModel

@export var hour: SpinBox
@export var minute: SpinBox

var hr: int
var min: int

func set_data() -> void:
	SignalBus.set_data(DataTypeEnum.DataTypes.Hour, str(hr))
	SignalBus.set_data(DataTypeEnum.DataTypes.Minute, str(min))

func _on_spin_box_value_changed(value: float) -> void:
	hr = value
	set_data()

func _on_spin_box_2_value_changed(value: float) -> void:
	min = value
	set_data()
