extends Node


func _on_body_entered(enemy: CharacterBody2D) -> void:
	#if not enemy.is_in_group("Enemy"):
		#return
		
	print("HurtBox...")
	print(enemy)
