/mob/var/suiciding = 0

/mob/living/carbon/verb/emptystomach()
	set desc = "Empty your stomach if you have ate someone"
	set name = "Empty Stomach"
	var/oldkey = ckey
	var/confirm = alert("Are you sure you want to empty your stomach?", "Confirm Empty Stomach", "Yes", "No")
	if(confirm == "Yes")
		for(var/mob/A in stomach_contents)
			A.loc = loc
			stomach_contents.Remove(A)
			//A.health = 1000
			//A.revive(full_heal = 1)
			//src.revive(full_heal = 1)

/mob/living/carbon/verb/smaliffy()
	set desc = "Resize your player"
	set name = "Smallify"
	var/oldkey = ckey
	var/confirm = alert("Want to smallify yourself by 0.5x?", "Confirm Smallify", "Yes", "No")
	if(confirm == "Yes")
		src.resize = 0.5 //biggen the idiot who just ate Someone because We Need More Space Right?
		src.update_transform()

/mob/living/carbon/verb/biggen()
	set desc = "Resize your player"
	set name = "Biggen"
	var/oldkey = ckey
	var/confirm = alert("Want to biggen yourself by 2x?", "Confirm Biggen", "Yes", "No")
	if(confirm == "Yes")
		src.resize = 2 //biggen the idiot who just ate Someone because We Need More Space Right?
		src.update_transform()

/mob/living/carbon/verb/scream()
	set desc = "Scream, obviously."
	set name = "Scream"
	var/oldkey = ckey
	var/confirm = alert("Do you want to scream?", "Confirm Screaming", "Yes", "No")
	if(confirm == "Yes")
		playsound(src.loc,'sound/items/bikehorn.ogg', 50, 0)


/mob/living/carbon/verb/turnvampire()
	set desc = "Become a vampire."
	set name = "Be a vampire"
	var/oldkey = ckey
	var/confirm = alert("Do you legit want to do this?", "Confirm transformation", "Yes", "No")
	if(confirm == "Yes")
		playsound(src.loc,'sound/items/bikehorn.ogg', 50, 0)
		internal_organs += new /obj/item/organ/eyes/night_vision
		internal_organs += new /obj/item/organ/vocal_cords/colossus
		internal_organs_slot += new /obj/item/organ/eyes/night_vision
		internal_organs_slot += new /obj/item/organ/vocal_cords/colossus

/mob/living/carbon/verb/masterbate()
	set desc = "..."
	set name = "Do the bird"
	var/oldkey = ckey
	var/confirm = alert("What the fuck", "Don't do this", "Yes", "No")
	if(confirm == "Yes")
		new /obj/effect/decal/cleanable/blood/cum(src.loc)

/mob/living/carbon/verb/dab()
	set desc = "yeah boi"
	set name = "Dab"
	var/confirm = alert("DAB LIKE A TRUE NIGGA", "DAB", "Yes", "No")
	if(confirm == "Yes")
		playsound(src.loc,'sound/ambience/dabbing.ogg', 50, 0)
		src.emote("me",1,"is preparing to dab!")
		sleep(35)
		src.emote("me",1,"dabs")
		for(var/mob/M in GLOB.player_list)
			shake_camera(M, 2 , 2)
			sleep(5)
			shake_camera(M, 2 , 2)
			sleep(5)
			shake_camera(M, 2 , 2)
			sleep(5)
			shake_camera(M, 2 , 2)
			sleep(5)
			shake_camera(M, 2 , 2)
			sleep(5)
			shake_camera(M, 2 , 2)
			sleep(5)
			shake_camera(M, 2 , 2)
			sleep(5)
			shake_camera(M, 2 , 2)
			sleep(5)
			shake_camera(M, 2 , 2)
			sleep(5)

/mob/living/carbon/human/verb/suicide()
	set hidden = 1
	if(!canSuicide())
		return
	var/oldkey = ckey
	var/confirm = alert("Are you sure you want to commit suicide?", "Confirm Suicide", "Yes", "No")
	if(ckey != oldkey)
		return
	if(!canSuicide())
		return
	if(confirm == "Yes")
		suiciding = 1
		log_game("[key_name(src)] (job: [job ? "[job]" : "None"]) commited suicide at [get_area(src)].")
		var/obj/item/held_item = get_active_held_item()
		if(held_item)
			var/damagetype = held_item.suicide_act(src)
			if(damagetype)
				if(damagetype & SHAME)
					adjustStaminaLoss(200)
					suiciding = 0
					return
				var/damage_mod = 0
				for(var/T in list(BRUTELOSS, FIRELOSS, TOXLOSS, OXYLOSS))
					damage_mod += (T & damagetype) ? 1 : 0
				damage_mod = max(1, damage_mod)

				//Do 200 damage divided by the number of damage types applied.
				if(damagetype & BRUTELOSS)
					adjustBruteLoss(200/damage_mod)

				if(damagetype & FIRELOSS)
					adjustFireLoss(200/damage_mod)

				if(damagetype & TOXLOSS)
					adjustToxLoss(200/damage_mod)

				if(damagetype & OXYLOSS)
					adjustOxyLoss(200/damage_mod)

				//If something went wrong, just do normal oxyloss
				if(!(damagetype & (BRUTELOSS | FIRELOSS | TOXLOSS | OXYLOSS) ))
					adjustOxyLoss(max(200 - getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))

				death(0)
				return

		var/suicide_message = pick("[src] is attempting to bite [p_their()] tongue off! It looks like [p_theyre()] trying to commit suicide.", \
							"[src] is jamming [p_their()] thumbs into [p_their()] eye sockets! It looks like [p_theyre()] trying to commit suicide.", \
							"[src] is twisting [p_their()] own neck! It looks like [p_theyre()] trying to commit suicide.", \
							"[src] is holding [p_their()] breath! It looks like [p_theyre()] trying to commit suicide.")

		visible_message("<span class='danger'>[suicide_message]</span>", "<span class='userdanger'>[suicide_message]</span>")

		adjustOxyLoss(max(200 - getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		death(0)

/mob/living/brain/verb/suicide()
	set hidden = 1
	if(!canSuicide())
		return
	var/confirm = alert("Are you sure you want to commit suicide?", "Confirm Suicide", "Yes", "No")
	if(!canSuicide())
		return
	if(confirm == "Yes")
		suiciding = 1
		visible_message("<span class='danger'>[src]'s brain is growing dull and lifeless. [p_they(TRUE)] look[p_s()] like [p_theyve()] lost the will to live.</span>", \
						"<span class='userdanger'>[src]'s brain is growing dull and lifeless. [p_they(TRUE)] look[p_s()] like [p_theyve()] lost the will to live.</span>")
		death(0)

/mob/living/carbon/monkey/verb/suicide()
	set hidden = 1
	if(!canSuicide())
		return
	var/confirm = alert("Are you sure you want to commit suicide?", "Confirm Suicide", "Yes", "No")
	if(!canSuicide())
		return
	if(confirm == "Yes")
		suiciding = 1
		visible_message("<span class='danger'>[src] is attempting to bite [p_their()] tongue. It looks like [p_theyre()] trying to commit suicide.</span>", \
				"<span class='userdanger'>[src] is attempting to bite [p_their()] tongue. It looks like [p_theyre()] trying to commit suicide.</span>")
		adjustOxyLoss(max(200- getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		death(0)

/mob/living/silicon/ai/verb/suicide()
	set hidden = 1
	if(!canSuicide())
		return
	var/confirm = alert("Are you sure you want to commit suicide?", "Confirm Suicide", "Yes", "No")
	if(!canSuicide())
		return
	if(confirm == "Yes")
		suiciding = 1
		visible_message("<span class='danger'>[src] is powering down. It looks like [p_theyre()] trying to commit suicide.</span>", \
				"<span class='userdanger'>[src] is powering down. It looks like [p_theyre()] trying to commit suicide.</span>")
		//put em at -175
		adjustOxyLoss(max(maxHealth * 2 - getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		death(0)

/mob/living/silicon/robot/verb/suicide()
	set hidden = 1
	if(!canSuicide())
		return
	var/confirm = alert("Are you sure you want to commit suicide?", "Confirm Suicide", "Yes", "No")
	if(!canSuicide())
		return
	if(confirm == "Yes")
		suiciding = 1
		visible_message("<span class='danger'>[src] is powering down. It looks like [p_theyre()] trying to commit suicide.</span>", \
				"<span class='userdanger'>[src] is powering down. It looks like [p_theyre()] trying to commit suicide.</span>")
		//put em at -175
		adjustOxyLoss(max(maxHealth * 2 - getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		death(0)

/mob/living/silicon/pai/verb/suicide()
	set category = "pAI Commands"
	set desc = "Kill yourself and become a ghost (You will receive a confirmation prompt)"
	set name = "pAI Suicide"
	var/answer = input("REALLY kill yourself? This action can't be undone.", "Suicide", "No") in list ("Yes", "No")
	if(answer == "Yes")
		var/turf/T = get_turf(src.loc)
		T.visible_message("<span class='notice'>[src] flashes a message across its screen, \"Wiping core files. Please acquire a new personality to continue using pAI device functions.\"</span>", null, \
		 "<span class='notice'>[src] bleeps electronically.</span>")
		death(0)
	else
		to_chat(src, "Aborting suicide attempt.")

/mob/living/carbon/alien/humanoid/verb/suicide()
	set hidden = 1
	if(!canSuicide())
		return
	var/confirm = alert("Are you sure you want to commit suicide?", "Confirm Suicide", "Yes", "No")
	if(!canSuicide())
		return
	if(confirm == "Yes")
		suiciding = 1
		visible_message("<span class='danger'>[src] is thrashing wildly! It looks like [p_theyre()] trying to commit suicide.</span>", \
				"<span class='userdanger'>[src] is thrashing wildly! It looks like [p_theyre()] trying to commit suicide.</span>", \
				"<span class='italics'>You hear thrashing.</span>")
		//put em at -175
		adjustOxyLoss(max(200 - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		death(0)

/mob/living/simple_animal/verb/suicide()
	set hidden = 1
	if(!canSuicide())
		return
	var/confirm = alert("Are you sure you want to commit suicide?", "Confirm Suicide", "Yes", "No")
	if(!canSuicide())
		return
	if(confirm == "Yes")
		suiciding = 1
		visible_message("<span class='danger'>[src] begins to fall down. It looks like [p_theyve()] lost the will to live.</span>", \
						"<span class='userdanger'>[src] begins to fall down. It looks like [p_theyve()] lost the will to live.</span>")
		death(0)


/mob/living/proc/canSuicide()
	if(stat == CONSCIOUS)
		return TRUE
	else if(stat == DEAD)
		to_chat(src, "You're already dead!")
	else if(stat == UNCONSCIOUS)
		to_chat(src, "You need to be conscious to suicide!")
	return

/mob/living/carbon/canSuicide()
	if(!..())
		return
	if(!canmove || restrained())	//just while I finish up the new 'fun' suiciding verb. This is to prevent metagaming via suicide
		to_chat(src, "You can't commit suicide whilst restrained! ((You can type Ghost instead however.))")
		return
	if(has_brain_worms())
		to_chat(src, "You can't bring yourself to commit suicide!")
		return
	return TRUE
