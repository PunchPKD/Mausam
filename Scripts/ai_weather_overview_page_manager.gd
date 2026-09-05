extends VBoxContainer
class_name AIOverviwePageManager

@export var summary: RichTextLabel

func _ready() -> void:
	self.visibility_changed.connect(start_writing_anim)
	start_writing_anim()

func start_writing_anim() -> void:
	if visible == true:
		summary.visible_ratio = 0
		var tween = get_tree().create_tween()
		tween.tween_property(summary, "visible_ratio", 1, 3)
