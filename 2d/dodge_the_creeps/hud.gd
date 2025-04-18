extends CanvasLayer

signal start_game

func show_message_显示消息(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func show_game_over_显示游戏结束():
	show_message_显示消息("Game Over")
	await $MessageTimer.timeout
	$MessageLabel.text = "Dodge the\nCreeps"
	$MessageLabel.show()
	await get_tree().create_timer(1).timeout
	$StartButton.show()


func update_score_更新分数(score):
	$ScoreLabel.text = str(score)


func _on_StartButton_pressed_启动按钮按下():
	$StartButton.hide()
	start_game.emit()


func _on_MessageTimer_timeout_消息计时器超时():
	$MessageLabel.hide()
