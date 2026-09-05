extends Node
class_name UIScaleAnim

var target: Control
var default: Vector2

@export var time: float
@export var amount: Vector2
@export var transitionType: Tween.TransitionType

func _ready() -> void:
	target = self.get_parent()
	default = target.scale
	target.mouse_entered.connect(on_hover)
	target.mouse_exited.connect(off_hover)
	
	call_deferred("set_pivot")

func set_pivot() -> void:
	target.pivot_offset = target.size/2

func on_hover() -> void:
	scale(amount, time)

func off_hover() -> void:
	scale(default, time)

func scale(amount: Vector2, time: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(target, "scale", amount, time).set_trans(transitionType)
	
