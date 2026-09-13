extends Node
class_name CloudUIAnim

@export var cloudElement1: TextureRect
@export var cloudElement2: TextureRect
@export var cloudElement3: TextureRect
@export var parentCloud: Control
@export var scrollAmount: Vector2 = Vector2(12,0)
@export var scrollContainer: ScrollContainer
@export var vScrollAmount: float = 0.4
@export var weatherTypes: Array[WeatherTypeEnum.WeatherType]

var defaultCloud1Pos: Vector2
var defaultCloud2Pos: Vector2
var defaultCloud3Pos: Vector2
var defaultParentCloudPos: Vector2

func _ready() -> void:
	parentCloud = cloudElement1.get_parent()
	defaultCloud1Pos = cloudElement1.position
	defaultCloud2Pos = cloudElement2.position
	defaultCloud3Pos = cloudElement3.position
	SignalBus.StartHCloudAnimation.connect(h_scroll_anim)
	SignalBus.StartCloudColorAnimation.connect(color_anim)
	SignalBus.UpdateData.connect(on_update_data)
	if scrollContainer:
		scrollContainer.get_v_scroll_bar().value_changed.connect(_on_scroll_changed)

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

func _on_scroll_changed(_value: float) -> void:
	var scroll_pos = scrollContainer.scroll_vertical
	
	parentCloud.position.y = -scroll_pos * vScrollAmount

func on_update_data(data: Dictionary[DataTypeEnum.DataTypes, String]) -> void:
	for type in weatherTypes:
		if type == int(data.get(DataTypeEnum.DataTypes.Weather)):
			color_anim(Color(1.0, 1.0, 1.0, 1.0))
			return
	color_anim(Color(1.0, 1.0, 1.0, 0.0))

func color_anim(color: Color) -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(parentCloud,"modulate",color,0.3)
	
	
