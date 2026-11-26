extends CharacterBody2D
## Правила героя. Столкновения рассчитывает Godot.
@export var speed: float = 240.0
@export var jump_velocity: float = -560.0
@export var gravity: float = 1400.0

var spawn_position: Vector2

func _ready() -> void:
    spawn_position = global_position

func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity.y += gravity * delta

    var direction := Input.get_axis("move_left", "move_right")
    velocity.x = direction * speed

    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_velocity

    move_and_slide()
    global_position.x = clampf(global_position.x, 20.0, 940.0)

    if global_position.y > 700.0:
        global_position = spawn_position
        velocity = Vector2.ZERO
