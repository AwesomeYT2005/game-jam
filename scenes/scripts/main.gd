extends Control

@onready var player: CharacterBody2D = $Player
@onready var box: RigidBody2D = $Box
@onready var door: AnimatableBody2D = $ExitDoor
var exit_door_state: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if exit_door_state:
		door.position = Vector2(1300,563)
	else:
		door.position = Vector2(1136,563)


func _on_button_body_entered(body: Node2D) -> void:
	exit_door_state = true



func _on_button_body_exited(body: Node2D) -> void:
	exit_door_state = false
