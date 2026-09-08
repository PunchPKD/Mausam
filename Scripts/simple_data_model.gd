extends Control
class_name SimpleDataModel

@export var dataType: DataTypeEnum.DataTypes
@export var saveFile: BaseSaveFile
@export var spinBox: SpinBox

func _ready() -> void:
	spinBox.value = int(saveFile.widgetsData.get(dataType))

func update_data(value: String) -> void:
	SignalBus.set_data(dataType, value)

func _on_spin_box_value_changed(value: float) -> void:
	update_data(str(int(value))+spinBox.suffix)
