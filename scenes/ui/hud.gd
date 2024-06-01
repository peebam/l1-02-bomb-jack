extends Control

func _ready() -> void:
	Events.score_changed.connect(func(score: int):
		$GridContainer/ScoreValueLabel.text = "%4d" % score
	)

	Events.nb_lives_changed.connect(func(lives: int):
		$GridContainer/LivesNumberLabel.text = "%d" % lives
	)
