extends VBoxContainer
class_name RecommendationManager

var recommendations: Array[RecommendationButton]

@export var recomContainer: Control
@export var widgetManager: WidgetManager
@export var recommendationButtonScene: PackedScene

func _ready() -> void:
	SignalBus.AddRecommendation.connect(on_add_recom)
	SignalBus.ResetRecommendation.connect(on_reset_recommendation)
	SignalBus.ToggleRecommendation.connect(on_toggle_recom)

func on_add_recom(_widgetScene: PackedScene) -> void:
	var tempRecom: RecommendationButton = get_recommendation()
	tempRecom.widgetScene = _widgetScene
	var tempText : String = widgetManager.get_widget(_widgetScene).name
	tempRecom.text = tempText.replace("Widget", "")
	tempRecom.visible = true

func on_toggle_recom() -> void:
	self.visible = !self.visible

func on_reset_recommendation() -> void:
	for recom in recommendations:
		if recom.visible == true:
			recom.visible = false

func get_recommendation() -> RecommendationButton:
	for recom in recommendations:
		if recom.visible == false:
			return recom
	var tempRecom: RecommendationButton = recommendationButtonScene.instantiate()
	recommendations.append(tempRecom)
	recomContainer.add_child(tempRecom)
	tempRecom.visible = false
	return tempRecom
