extends Control
class_name LocationSelector

@export var saveFile: BaseSaveFile
@export var tempLabel: Label
@export var weatherLabel: Label

func _ready() -> void:
	SignalBus.UpdateData.connect(on_update_data)
	tempLabel.text = saveFile.widgetsData.get(DataTypeEnum.DataTypes.Temp)
	weatherLabel.text = WeatherTypeEnum.WeatherType.find_key(int(saveFile.widgetsData.get(DataTypeEnum.DataTypes.Weather)))

func _gui_input(event: InputEvent) -> void:
	if Input.is_action_just_released("Click"):
		SaveManager.load_save_file(saveFile)
		SignalBus.ToggleLocationSelectionOverlay.emit()

func on_update_data(data:Dictionary[DataTypeEnum.DataTypes, String]) -> void:
	if SaveManager.currentSaveFile == saveFile:
		tempLabel.text = data.get(DataTypeEnum.DataTypes.Temp)
		weatherLabel.text = WeatherTypeEnum.WeatherType.find_key(int(data.get(DataTypeEnum.DataTypes.Weather)))
