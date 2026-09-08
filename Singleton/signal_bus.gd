extends Node

enum  DataTypes{Test}
var Datas: Dictionary[DataTypes, String]

signal AddWidget(widgetScene: PackedScene)
signal RemoveWidget(widgetScene: PackedScene)
signal AddWidgetList(widgetData: BaseWidgetData)
signal SelectElement(element: Control)
signal StartHCloudAnimation(direction: int)
signal UpdateData(datas: Dictionary[DataTypes, String])

func set_data(dataType: DataTypes, value: String) -> void:
	Datas[dataType] = value

func update_data() -> void:
	UpdateData.emit(Datas)
