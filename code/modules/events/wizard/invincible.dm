/datum/round_event_control/wizard/invincible //Boolet Proof
	name = "LDA Syndicate attack"
	weight = 90
	typepath = /datum/round_event/wizard/invincible
	max_occurrences = 1
	earliest_start = 0

/datum/round_event/wizard/invincible
	endWhen = 0
	var/started = FALSE

/datum/round_event/wizard/invincible/start()
	if(!started)
		started = TRUE
		priority_announce("LDA Syndicate mans are aboarding the ship. Stop them now.", "Security Monkey Team Warning", 'sound/effects/adminhelp.ogg')
		sleep(20)
		new /mob/living/carbon/human/interactive/greytide(locate(38,138,1))
		new /mob/living/carbon/human/interactive/greytide(locate(37,138,1))
		new /mob/living/carbon/human/interactive/greytide(locate(38,138,1))
		new /mob/living/carbon/human/interactive/greytide(locate(39,138,1))
		new /mob/living/carbon/human/interactive/greytide(locate(37,137,1))
		new /mob/living/carbon/human/interactive/greytide(locate(38,137,1))
		new /mob/living/carbon/human/interactive/greytide(locate(39,137,1))
		sleep(400)
		//new /mob/living/carbon/human/interactive/angry(locate(38,138,1))
		//priority_announce("WE ALSO HAVE DETECTED A SHITTON OF HUMANS COMING INTO THE STATION, THEY DONT SEEM HAPPY AT ALL.", "Security Monkey Team Warning", 'sound/effects/adminhelp.ogg')


		new /obj/effect/mob_spawn/human/corpse/syndicatesoldier(locate(114,170,1))
		new /obj/effect/mob_spawn/human/corpse/syndicatesoldier(locate(136,136,1))
		new /obj/effect/mob_spawn/human/corpse/syndicatesoldier(locate(194,134,1))
		new /obj/effect/mob_spawn/human/corpse/syndicatesoldier(locate(130,163,1))

		var/numberex = rand(1,2)
		if(numberex!=1)
			priority_announce("We have detected that one of the LDA Syndicate mans have placed a bomb at the brig, we're not safe, It is recommended to evacuate.", "Security Monkey Team Warning", 'sound/machines/alarm.ogg')
			sleep(100)
			for(var/mob/M in GLOB.player_list)
				M << 'sound/ambience/screaming.ogg'
			sleep(10)
			for(var/mob/M in GLOB.player_list)
				M << 'sound/effects/explosionfar.ogg'
			explosion(locate(114,170,1),-1,-1,20, flame_range = 4)	// small explosion, plus a very large fireball.
		else
			priority_announce("We have detected that one of the LDA Syndicate mans have placed a bomb at the bar, we're not safe, It is recommended to evacuate.", "Security Monkey Team Warning", 'sound/machines/alarm.ogg')
			sleep(100)
			for(var/mob/M in GLOB.player_list)
				M << 'sound/ambience/screaming.ogg'
			sleep(10)
			for(var/mob/M in GLOB.player_list)
				M << 'sound/effects/explosionfar.ogg'
			explosion(locate(136,136,1),-1,-1,10, flame_range = 4)	// small explosion, plus a very large fireball.


		var/numberexalt = rand(1,2)
		if(numberexalt!=1)
			priority_announce("We have detected that one of the LDA Syndicate mans also have placed a bomb at the escape hall.", "Security Monkey Team Warning", 'sound/effects/adminhelp.ogg')
			sleep(100)
			for(var/mob/M in GLOB.player_list)
				M << 'sound/ambience/screaming.ogg'
			sleep(10)
			for(var/mob/M in GLOB.player_list)
				M << 'sound/effects/explosionfar.ogg'
			explosion(locate(194,134,1),-1,-1,10, flame_range = 4)	// small explosion, plus a very large fireball.
		else
			priority_announce("We have detected that one of the LDA Syndicate mans also have placed a bomb at the court.", "Security Monkey Team Warning", 'sound/effects/adminhelp.ogg')
			sleep(100)
			for(var/mob/M in GLOB.player_list)
				M << 'sound/ambience/screaming.ogg'
			sleep(10)
			for(var/mob/M in GLOB.player_list)
				M << 'sound/effects/explosionfar.ogg'
			explosion(locate(130,163,1),-1,-1,20, flame_range = 4)	// small explosion, plus a very large fireball.

		//194,134