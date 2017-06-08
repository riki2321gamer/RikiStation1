/datum/game_mode/sandbox
	name = "sandbox extended"
	config_tag = "sandbox"
	required_players = 0

	announce_span = "info"
	announce_text = "Build your own station... or just shoot each other!... or make a cool minigame.."

/datum/game_mode/sandbox/pre_setup()
	for(var/mob/M in GLOB.player_list)
		M.CanBuild()
	return 1

/datum/game_mode/sandbox/post_setup()
	..()
	SSshuttle.registerHostileEnvironment(src)
	priority_announce("Welcome to the station! Hopefully you will have fun in Riki station's sandbox Have fun!", "Sandbox Announcement", 'sound/AI/commandreport.ogg')
	priority_announce("Thanks to the tireless efforts of our security and intelligence divisions, there are currently no credible threats to [station_name()]. All station construction projects have been authorized. Have a secure shift!", "Security Report", 'sound/AI/commandreport.ogg')

/datum/game_mode/sandbox/announced
	name = "sandbox"
	config_tag = "sandbox"

/datum/game_mode/extended/announced/generate_station_goals()
	for(var/T in subtypesof(/datum/station_goal))
		var/datum/station_goal/G = new T
		station_goals += G
		G.on_report()