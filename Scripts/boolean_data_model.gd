extends Control
class_name BooleanDataModel

@export var checkButton: CheckButton
@export var dataType: DataTypeEnum.DataTypes

func _ready() -> void:
	SignalBus.SaveFileChanged.connect(on_save_file_change)

func _on_check_button_toggled(toggled_on: bool) -> void:
	SignalBus.set_data(dataType, str(toggled_on))

func on_save_file_change(file: BaseSaveFile) -> void:
	if file.widgetsData.get(dataType):
		checkButton.button_pressed = str_to_var(file.widgetsData.get(dataType))
