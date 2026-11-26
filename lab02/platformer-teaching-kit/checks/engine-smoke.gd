extends SceneTree
## Run with the final project's --path and an absolute --script path.
var failures: int = 0

func _initialize() -> void:
    _run.call_deferred()

func check(condition: bool, message: String) -> void:
    if not condition:
        failures += 1
        push_error(message)

func _run() -> void:
    var packed := load("res://scenes/world.tscn") as PackedScene
    if packed == null:
        push_error("Cannot load world.tscn")
        quit(1)
        return
    var world := packed.instantiate()
    root.add_child(world)
    var player := world.get_node("Player") as CharacterBody2D
    for frame in range(90):
        await physics_frame
    check(player.is_on_floor(), "Player must settle on the ground")
    var start_x: float = player.position.x
    Input.action_press("move_right")
    for frame in range(15):
        await physics_frame
    Input.action_release("move_right")
    await physics_frame
    check(player.position.x > start_x + 25.0, "Move-right action must move the player")
    var floor_y: float = player.position.y
    Input.action_press("jump")
    await physics_frame
    await physics_frame
    Input.action_release("jump")
    for frame in range(10):
        await physics_frame
    check(player.position.y < floor_y - 20.0, "Jump must raise the player")
    player.position = Vector2(710, 208)
    player.velocity = Vector2.ZERO
    for frame in range(5):
        await physics_frame
    check(world.get("score") == 1, "Coin must increment score once")
    check(not world.has_node("Coin"), "Collected coin must leave the tree")
    print("Engine smoke failures: ", failures)
    quit(1 if failures > 0 else 0)
