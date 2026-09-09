extends Node
class_name UIScrollAnim

@export var parent: Control
@export var scroller: ScrollContainer

func _process(delta: float) -> void:
	parent.position = lerp(parent.position, parent.position+Vector2(0, 100), scroller.scroll_vertical/644)
