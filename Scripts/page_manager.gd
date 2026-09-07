extends Control
class_name PageManager

@export var personalisedPage: Control
@export var aiOverViwePage: Control
@export var pageScroller: ScrollContainer
@export var scrollAnimTime: float = 100

func _on_ai_over_view_page_button_button_up() -> void:
	scroll(360)
	SignalBus.StartHCloudAnimation.emit(-1)


func _on_personalised_page_button_button_up() -> void:
	scroll(0)
	SignalBus.StartHCloudAnimation.emit(1)

func scroll(value: int) -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(pageScroller,"scroll_horizontal",value,scrollAnimTime)
