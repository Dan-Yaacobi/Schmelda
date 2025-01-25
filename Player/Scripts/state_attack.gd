class_name State_Attack extends State

var count = 0
var attacking: bool = false
@export var attack_sound: AudioStream 
@export_range(1,20,0.5) var decelerate_speed: float = 5

@onready var walk: State = $"../Walk"
@onready var idle: State_Idle = $"../Idle"

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_animation: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

@onready var hurt_box: HurtBox = %AttackHurtBox
@onready var stun: State_Stun = $"../Stun"

#what happens when the player enters this state
func Enter() -> void:
	player.UpdateAnimation("attack")
	attack_animation.play("attack_" + player.AnimDirection())

	attack_animation.animation_finished.connect(EndAttack)

	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9,1.1)
	audio.play()

	attacking = true
	#await get_tree().create_timer(0.075).timeout
	if attacking:
		hurt_box.monitoring = true
	pass	


#what happens when the player exits this state
func Exit() -> void:
	attack_animation.animation_finished.disconnect(EndAttack)
	attacking = false
	hurt_box.monitoring = false
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> State:
	return null
	
	#what happens during input events in this state
func HandleInput(_event: InputEvent) -> State:
	return null
	
func EndAttack(_newAnimation: String) -> void:
	attacking = false
	
	
