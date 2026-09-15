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
	if event.is_action_released("Click") and event.device == -1:
		SaveManager.load_save_file(saveFile)
		SignalBus.ToggleLocationSelectionOverlay.emit()

func on_update_data(data:Dictionary[DataTypeEnum.DataTypes, String]) -> void:
	if SaveManager.currentSaveFile == saveFile:
		tempLabel.text = data.get(DataTypeEnum.DataTypes.Temp)
		weatherLabel.text = WeatherTypeEnum.WeatherType.find_key(int(data.get(DataTypeEnum.DataTypes.Weather)))
