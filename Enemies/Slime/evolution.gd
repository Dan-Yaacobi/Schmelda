class_name Evolution extends Node

@onready var slime: Enemy = $".."

@onready var stun_state: EnemyStateStun = $"../EnemyStateMachine/Stun"

func _ready() -> void:
	stun_state.enemy_evolved.connect(evolve)


func evolve(success: bool) -> void:
	if success:
		slime.scale *= 2
		slime.hp = 5
		for drop in slime.destroy.drops:
			if drop.item.name == "Gem":
				drop.min_amount = 4
			elif drop.item.name == "Apple":
				drop.probability = 0
			elif drop.item.name == "Potion":
				drop.probability = 50
	else:
		for drop in slime.destroy.drops:
			if drop.item.name == "Gem":
				drop.min_amount = 1
			elif drop.item.name == "Apple":
				drop.probability = 33
			elif drop.item.name == "Potion":
				drop.probability = 0
	pass
	#
