extends Node
class_name CloudUIAnim

@export var cloudElement1: TextureRect
@export var cloudElement2: TextureRect
@export var cloudElement3: TextureRect

@export var scrollAmount: Vector2 = Vector2(12,0)
var defaultCloud1Pos: Vector2
var defaultCloud2Pos: Vector2
var defaultCloud3Pos: Vector2

func _ready() -> void:
	defaultCloud1Pos = cloudElement1.position
	defaultCloud2Pos = cloudElement2.position
	defaultCloud3Pos = cloudElement3.position
	SignalBus.StartHCloudAnimation.connect(h_scroll_anim)

func h_scroll_anim(direction: int) -> void:
	var tween1: Tween = get_tree().create_tween()
	var tween2: Tween = get_tree().create_tween()
	var tween3: Tween = get_tree().create_tween()
	
	if direction == 1:
		tween1.tween_property(cloudElement1,"position", defaultCloud1Pos, 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
		tween2.tween_property(cloudElement2,"position", defaultCloud2Pos, 0.5).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
		tween3.tween_property(cloudElement3,"position", defaultCloud3Pos, 1.4).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	elif direction == -1:
		tween1.tween_property(cloudElement1,"position", defaultCloud1Pos + (scrollAmount*direction), 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
		tween2.tween_property(cloudElement2,"position", defaultCloud2Pos + (scrollAmount*direction), 0.5).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
		tween3.tween_property(cloudElement3,"position", defaultCloud3Pos + (scrollAmount*direction), 1.4).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
		
	
	
	
