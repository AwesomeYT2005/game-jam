extends Control

@onready var player: CharacterBody2D = $Player
@onready var box: RigidBody2D = $Box
@onready var door: AnimatableBody2D = $ExitDoor
@onready var note: Area2D = $Note
@onready var e_hottip: ColorRect = $Note/EHottip
@onready var note_text: ColorRect = $Note/NoteText
@onready var button: Area2D = $Button
var current_level = preload("res://scenes/level_testing.tscn").instantiate()
var next_level = preload("res://scenes/level_testing_2.tscn").instantiate()

var exit_door_state: bool = true
var e_tooltip_showing: bool = false
var note_readable: bool = false
var note_discovered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_child(current_level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#Door mechanics
	if !exit_door_state:
		door.position = Vector2(1300,563)
	else:
		door.position = Vector2(1136,563)
	#Hottip
	if e_tooltip_showing and !note_discovered:
		e_hottip.visible = true
	else:
		e_hottip.visible = false
	#Reading the note
	if Input.is_action_just_pressed("interact") and note_readable:
		note_discovered = true
		e_hottip.visible = false
		note_text.visible = true
	if !note_discovered:
		note_text.visible = false
	
	
	
####################################

#### SIGNALS

####################################

func _on_button_body_entered(body: Node2D) -> void:
	exit_door_state = false
	if body is not RigidBody2D:
		var button_sprite: AnimatedSprite2D = button.get_node("Sprite2D")
		button_sprite.animation = "on"
	else:
		var button_sprite: AnimatedSprite2D = button.get_node("Sprite2D")
		button_sprite.animation = "on"
		var box_sprite: AnimatedSprite2D = box.get_node("Sprite2D")
		box_sprite.animation = "on"

func _on_button_body_exited(_body: Node2D) -> void:
	exit_door_state = true
	var button_sprite: AnimatedSprite2D = button.get_node("Sprite2D")
	button_sprite.animation = "default"
	var box_sprite: AnimatedSprite2D = box.get_node("Sprite2D")
	box_sprite.animation = "default"


func _on_note_body_entered(_body: Node2D) -> void:
	e_tooltip_showing = true
	note_readable = true


func _on_note_body_exited(_body:Node2D) -> void:
	e_tooltip_showing = false
	note_readable = false
	note_discovered = false

func _on_player_won() -> void:
	pass
