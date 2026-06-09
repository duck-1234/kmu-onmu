extends Node

var artifact_count := 0

var cleared = {
	"chang_game": false,
	"jimsung_giwa": false,
	"dojagicatch": false,
	"excavation": false,
	"cam": false
}

func clear_artifact(name: String):
	if !cleared[name]:
		cleared[name] = true
		artifact_count += 1


func reset_game():
	artifact_count = 0

	for key in cleared.keys():
		cleared[key] = false
