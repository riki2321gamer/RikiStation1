/datum/round_event_control/wizard/fake_explosion //Oh no the station is gone!
	name = "Fake Nuclear Explosion"
	weight = 15 //Badmin exclusive now because once it's expected its not funny
	typepath = /datum/round_event/wizard/fake_explosion
	max_occurrences = 9
	earliest_start = 0

/datum/round_event/wizard/fake_explosion/start()
	priority_announce("holy shit what have you done", "great", 'sound/machines/Alarm.ogg')
	for(var/mob/M in GLOB.player_list)
		M << 'sound/machines/Alarm.ogg'
	addtimer(CALLBACK(SSticker, /datum/controller/subsystem/ticker/.proc/station_explosion_cinematic, 1, "fake"), 100) //:o)