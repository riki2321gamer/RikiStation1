// This is to replace the previous datum/disease/alien_embryo for slightly improved handling and maintainability
// It functions almost identically (see code/datums/diseases/alien_embryo.dm)
/obj/item/organ/body_egg/alien_embryo
	name = "alien embryo"
	icon = 'icons/mob/alien.dmi'
	icon_state = "larva0_sleep"
	var/stage = 0
	var/bursting = FALSE

/obj/item/organ/body_egg/alien_embryo/on_find(mob/living/finder)
	..()
	if(stage < 4)
		to_chat(finder, "So this is the thing that's making this person spin, Holy crap. It's not even developed yet. Would be nice to get rid of.")
	else
		to_chat(finder, "So this is the thing that's making this person spin, Holy crap.")
		if(prob(10))
			AttemptGrow(0)

/obj/item/organ/body_egg/alien_embryo/prepare_eat()
	var/obj/S = ..()
	//S.reagents.add_reagent("sacid", 10)
	return S

/obj/item/organ/body_egg/alien_embryo/on_life()
	switch(stage)
		if(2, 3)
			if(prob(2))
				owner.emote("spin")
			if(prob(2))
				owner.emote("spin")
			if(prob(2))
				owner.emote("spin")
			if(prob(2))
				owner.emote("spin")
		if(4)
			if(prob(2))
				owner.emote("spin")
			if(prob(2))
				owner.emote("spin")
			if(prob(4))
				owner.emote("spin")
			if(prob(4))
				owner.emote("spin")
		if(5)
			to_chat(owner, "<span class='danger'>You feel like a fidget spinner. Spinning and spinning..</span>")
			owner.emote("spin")

/obj/item/organ/body_egg/alien_embryo/egg_process()
	if(stage < 5 && prob(3))
		stage++
		INVOKE_ASYNC(src, .proc/RefreshInfectionImage)

	if(stage == 5 && prob(50))
		for(var/datum/surgery/S in owner.surgeries)
			if(S.location == "chest" && istype(S.get_surgery_step(), /datum/surgery_step/manipulate_organs))
				AttemptGrow(0)
				return
		AttemptGrow()



/obj/item/organ/body_egg/alien_embryo/proc/AttemptGrow(gib_on_success=TRUE)
	if(!owner || bursting)
		return

	bursting = TRUE

	var/list/candidates = pollCandidates("Do you want to play as an alien larva that will come out of [owner]?", ROLE_ALIEN, null, ROLE_ALIEN, 100, POLL_IGNORE_ALIEN_LARVA)

	if(QDELETED(src) || QDELETED(owner))
		return

	if(!candidates.len || !owner)
		bursting = FALSE
		stage = 4
		return

	var/mob/dead/observer/ghost = pick(candidates)

	var/overlay = image('icons/mob/alien.dmi', loc = owner, icon_state = "burst_lie")
	owner.add_overlay(overlay)

	var/atom/xeno_loc = get_turf(owner)
	var/mob/living/carbon/alien/larva/new_xeno = new(xeno_loc)
	new_xeno.key = ghost.key
	new_xeno << sound('sound/ambience/screaming.ogg',0,0,0,100)	//To get the player's attention
	new_xeno.canmove = 0 //so we don't move during the bursting animation
	new_xeno.notransform = 1
	new_xeno.invisibility = INVISIBILITY_MAXIMUM

	sleep(6)

	if(QDELETED(src) || QDELETED(owner))
		return

	if(new_xeno)
		new_xeno.canmove = 1
		new_xeno.notransform = 0
		new_xeno.invisibility = 0

	if(gib_on_success)
		new_xeno.visible_message("<span class='danger'>[new_xeno] wriggles out of [owner]!</span>", "<span class='userdanger'>You exit [owner], your previous host.</span>")
		owner.cut_overlay(overlay)
	else
		new_xeno.visible_message("<span class='danger'>[new_xeno] wriggles out of [owner]!</span>", "<span class='userdanger'>You exit [owner], your previous host.</span>")
		owner.cut_overlay(overlay)
	qdel(src)


/*----------------------------------------
Proc: AddInfectionImages(C)
Des: Adds the infection image to all aliens for this embryo
----------------------------------------*/
/obj/item/organ/body_egg/alien_embryo/AddInfectionImages()
	for(var/mob/living/carbon/alien/alien in GLOB.player_list)
		if(alien.client)
			var/I = image('icons/mob/alien.dmi', loc = owner, icon_state = "infected[stage]")
			alien.client.images += I

/*----------------------------------------
Proc: RemoveInfectionImage(C)
Des: Removes all images from the mob infected by this embryo
----------------------------------------*/
/obj/item/organ/body_egg/alien_embryo/RemoveInfectionImages()
	for(var/mob/living/carbon/alien/alien in GLOB.player_list)
		if(alien.client)
			for(var/image/I in alien.client.images)
				if(dd_hasprefix_case(I.icon_state, "infected") && I.loc == owner)
					qdel(I)