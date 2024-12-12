extends Area2D

func _on_body_entered(player: CharacterBody2D) -> void:
	#if not player.is_in_group("Enemy"):
		#return
		
	print("HitBox")
	print(player)
	
