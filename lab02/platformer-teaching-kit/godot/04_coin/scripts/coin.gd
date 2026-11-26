extends Area2D
## Монетка сообщает о подборе. Она не обращается к интерфейсу.
signal collected

var taken: bool = false

func _ready() -> void:
    body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
    if taken or not body.is_in_group("player"):
        return
    taken = true
    collected.emit()
    queue_free()
