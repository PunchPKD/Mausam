extends VBoxContainer
class_name GeneralInformationManager

@export var weatherIcon: TextureRect

@export var clearIcon: Texture2D
@export var cloudyIcon: Texture2D
@export var fogIcon: Texture2D
@export var rainIcon: Texture2D
@export var thunderstromIcon: Texture2D

func _ready() -> void:
	SignalBus.UpdateData.connect(on_update_data)

func on_update_data(data: Dictionary[DataTypeEnum.DataTypes, String]) -> void:
	if data.get(DataTypeEnum.DataTypes.Weather) == null:
		return
	var tempInt: int = int(data.get(DataTypeEnum.DataTypes.Weather))
	if tempInt == WeatherTypeEnum.WeatherType.Clear:
		weatherIcon.texture = clearIcon
	elif tempInt == WeatherTypeEnum.WeatherType.Cloudy:
		weatherIcon.texture = cloudyIcon
	elif tempInt == WeatherTypeEnum.WeatherType.Fog:
		weatherIcon.texture = fogIcon
	elif tempInt == WeatherTypeEnum.WeatherType.Rain:
		weatherIcon.texture = rainIcon
	elif tempInt == WeatherTypeEnum.WeatherType.Thunderstrom:
		weatherIcon.texture = thunderstromIcon
