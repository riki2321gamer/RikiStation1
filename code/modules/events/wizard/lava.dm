/datum/round_event_control/wizard/lava //THE LEGEND NEVER DIES
	name = "Alien drone ship explosion"
	weight = 0
	typepath = /datum/round_event/wizard/lava
	max_occurrences = 1
	earliest_start = 0

/datum/round_event/wizard/lava
	endWhen = 0
	var/started = FALSE

/datum/round_event/wizard/lava/start()
	if(!started)
		started = TRUE
		priority_announce("We have detected a problem, we will inform you guys real quick.", "Security Monkey Team Warning", 'sound/effects/adminhelp.ogg')
		//34,169,1
		//34,175,1
		//33,183,1
		//39,189,1
		//31,198,1
		//31,205,1
		sleep(100)
		explosion(locate(34,169,1),-1,-1,10, flame_range = 4)	// small explosion, plus a very large fireball.
		sleep(10)
		explosion(locate(34,175,1),-1,-1,10, flame_range = 4)	// small explosion, plus a very large fireball.
		sleep(10)
		explosion(locate(33,183,1),-1,-1,10, flame_range = 4)	// small explosion, plus a very large fireball.
		sleep(10)
		explosion(locate(39,189,1),-1,-1,10, flame_range = 4)	// small explosion, plus a very large fireball.
		sleep(10)
		explosion(locate(31,198,1),-1,-1,10, flame_range = 4)	// small explosion, plus a very large fireball.
		sleep(10)
		explosion(locate(31,205,1),-1,-1,30, flame_range = 4)	// small explosion, plus a very large fireball.
		sleep(100)
		priority_announce("SEVERE DAMAGE DETECTED AT THE ALIEN DRONE SHIP. IS IT INFORMED TO BE CAREFUL.", "Security Monkey Team Warning", 'sound/effects/adminhelp.ogg')