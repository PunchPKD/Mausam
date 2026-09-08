extends Control
class_name WeatherSelectionDataModel

func _on_option_button_item_selected(index: int) -> void:
	SignalBus.set_data(DataTypeEnum.DataTypes.Weather, str(index))
