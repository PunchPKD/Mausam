extends Control
class_name AlertManager

@export var thunderstromAlert: Control

func _ready() -> void:
	SignalBus.UpdateData.connect(on_update_data)

func on_update_data(data: Dictionary[DataTypeEnum.DataTypes, String]) -> void:
	if data.has(DataTypeEnum.DataTypes.ThunderAlrt):
		#print(bool(int(data.get(DataTypeEnum.DataTypes.ThunderAlrt))))
		thunderstromAlert.visible = str_to_var(data.get(DataTypeEnum.DataTypes.ThunderAlrt))
