extends VBoxContainer
class_name AIOverviwePageManager

@export var summary: RichTextLabel
@export var greetingLabel: Label

func _ready() -> void:
	self.visibility_changed.connect(start_writing_anim)
	start_writing_anim()
	SignalBus.UpdateData.connect(on_update_data)
	
func on_update_data(data: Dictionary[DataTypeEnum.DataTypes, String]) -> void:
	if data.has(DataTypeEnum.DataTypes.Hour):
		var hour: int = int(data.get(DataTypeEnum.DataTypes.Hour))
		if hour >= 0 and hour < 12:
			greetingLabel.text = "Good Morning"
		elif hour >= 12 and hour < 17:
			greetingLabel.text = "Good Afternoon"
		elif hour >= 17 and hour <= 24:
			greetingLabel.text = "Good Evening"
		

func start_writing_anim() -> void:
	if visible == true:
		summary.visible_ratio = 0
		var tween = get_tree().create_tween()
		tween.tween_property(summary, "visible_ratio", 1, 3)
