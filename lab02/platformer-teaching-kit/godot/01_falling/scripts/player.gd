extends CharacterBody2D
## Этап 01: только падение и столкновение с полом.
@export var gravity: float = 1400.0

func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity.y += gravity * delta
    move_and_slide()
