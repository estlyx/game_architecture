extends Node2D
## Уровень связывает монетки и счётчик.
var score: int = 0
@onready var score_label: Label = $HUD/Score

func _ready() -> void:
    for coin in get_tree().get_nodes_in_group("coins"):
        coin.connect("collected", _on_coin_collected)

func _on_coin_collected() -> void:
    score += 1
    score_label.text = "Монет: %d" % score

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("restart"):
        get_tree().reload_current_scene()
