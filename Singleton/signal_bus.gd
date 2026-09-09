extends Node

var Datas: Dictionary[DataTypeEnum.DataTypes, String]

signal AddWidget(widgetScene: PackedScene)
signal RemoveWidget(widgetScene: PackedScene)
signal AddWidgetList(widgetData: BaseWidgetData)
signal SelectElement(element: Control)
signal StartHCloudAnimation(direction: int)
signal StartCloudColorAnimation(color: Color)
signal ToggleLocationSelectionOverlay()
signal UpdateData(datas: Dictionary[DataTypeEnum.DataTypes, String])
signal SaveFileChanged(file: BaseSaveFile)

func set_data(dataType: DataTypeEnum.DataTypes, value: String) -> void:
	Datas[dataType] = value

func update_data() -> void:
	await get_tree().process_frame
	UpdateData.emit(Datas)
	SaveManager.save_widget_data(Datas)
