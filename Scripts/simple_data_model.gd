extends Control
class_name SimpleDataModel

@export var dataType: DataTypeEnum.DataTypes
@export var saveFile: BaseSaveFile
@export var spinBox: SpinBox

func _ready() -> void:
	SignalBus.SaveFileChanged.connect(on_save_file_change)
	if saveFile.widgetsData.get(dataType):
		spinBox.value = int(saveFile.widgetsData.get(dataType))

func update_data(value: String) -> void:
	SignalBus.set_data(dataType, value)

func _on_spin_box_value_changed(value: float) -> void:
	update_data(str(int(value))+spinBox.suffix)

func on_save_file_change(file: BaseSaveFile) -> void:
	if file.widgetsData.get(dataType):
		spinBox.value = int(file.widgetsData.get(dataType))
