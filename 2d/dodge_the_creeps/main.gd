extends Node

@export var mob_scene_敌人计数: PackedScene = preload("res://Mob.tscn")
var score_分数

func _on_game_over_游戏结束():
	$ScoreTimer_分数计时器.stop()
	$MobTimer_敌人计时器.stop()
	$HUD.show_game_over()
	$Music_音乐.stop()
	$DeathSound_音效.play()


func _on_new_game_新游戏():
	get_tree().call_group(&"mobs", &"queue_free")
	score_分数 = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score_分数)
	$HUD.show_message("Get Ready")
	$Music_音乐.play()


func _on_MobTimer_timeout_敌人计时器超时():
	# Create a new instance of the Mob scene.
	var mob = mob_scene_敌人计数.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node(^"MobPath/MobSpawnLocation")
	mob_spawn_location.progress = randi()

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func _on_ScoreTimer_timeout_分数计时器超时():
	score_分数 += 1
	$HUD.update_score(score_分数)


func _on_StartTimer_timeout_启动计时器超时():
	$MobTimer_敌人计时器.start()
	$ScoreTimer_分数计时器.start()
