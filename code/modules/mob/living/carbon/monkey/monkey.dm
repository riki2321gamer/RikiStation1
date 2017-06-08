/mob/living/carbon/monkey
	name = "monkey"
	voice_name = "monkey"
	verb_say = "says"
	initial_languages = list(/datum/language/common)
	icon = 'icons/mob/monkey.dmi'
	icon_state = ""
	gender = NEUTER
	pass_flags = PASSTABLE
	ventcrawler = VENTCRAWLER_NUDE
	butcher_results = list(/obj/item/weapon/reagent_containers/food/snacks/meat/slab/monkey = 5, /obj/item/stack/sheet/animalhide/monkey = 1)
	type_of_meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/monkey
	gib_type = /obj/effect/decal/cleanable/blood/gibs
	unique_name = 1
	aggressive = FALSE
	bodyparts = list(/obj/item/bodypart/chest/monkey, /obj/item/bodypart/head/monkey, /obj/item/bodypart/l_arm/monkey,
					 /obj/item/bodypart/r_arm/monkey, /obj/item/bodypart/r_leg/monkey, /obj/item/bodypart/l_leg/monkey)



/mob/living/carbon/monkey/Initialize()
	verbs += /mob/living/proc/mob_sleep
	verbs += /mob/living/proc/lay_down

	if(unique_name) //used to exclude pun pun
		gender = pick(MALE, FEMALE)
	real_name = name

	//initialize limbs
	create_bodyparts()

	create_internal_organs()

	..()

/mob/living/carbon/monkey/Initialize()
	..()
	create_dna(src)
	dna.initialize_dna(random_blood_type())

/mob/living/carbon/monkey/create_internal_organs()
	internal_organs += new /obj/item/organ/appendix
	internal_organs += new /obj/item/organ/lungs
	internal_organs += new /obj/item/organ/heart
	internal_organs += new /obj/item/organ/brain
	internal_organs += new /obj/item/organ/tongue
	internal_organs += new /obj/item/organ/eyes
	..()

/mob/living/carbon/monkey/movement_delay()
	if(reagents)
		if(reagents.has_reagent("morphine"))
			return -1

		if(reagents.has_reagent("nuka_cola"))
			return -1

	. = ..()
	var/health_deficiency = (100 - health)
	if(health_deficiency >= 45)
		. += (health_deficiency / 25)

	if (bodytemperature < 283.222)
		. += (283.222 - bodytemperature) / 10 * 1.75
	if (aggressive = TRUE)
		return 0
	else
		return . + config.monkey_delay

/mob/living/carbon/monkey/Stat()
	..()
	if(statpanel("Status"))
		stat(null, "Intent: [a_intent]")
		stat(null, "Move Mode: [m_intent]")
		if(client && mind)
			if(mind.changeling)
				stat("Chemical Storage", "[mind.changeling.chem_charges]/[mind.changeling.chem_storage]")
				stat("Absorbed DNA", mind.changeling.absorbedcount)
	return


/mob/living/carbon/monkey/verb/removeinternal()
	set name = "Remove Internals"
	set category = "IC"
	internal = null
	return


/mob/living/carbon/monkey/IsAdvancedToolUser()//Unless its monkey mode monkeys cant use advanced tools
	if (aggressive = TRUE)
		return 1
	else
		return 0

/mob/living/carbon/monkey/reagent_check(datum/reagent/R) //can metabolize all reagents
	if (aggressive = TRUE)
		return 1
	else
		return 0

/mob/living/carbon/monkey/canBeHandcuffed()
	return 1

/mob/living/carbon/monkey/assess_threat(mob/living/simple_animal/bot/secbot/judgebot, lasercolor)
	if(judgebot.emagged == 2)
		return 10 //Everyone is a criminal!
	var/threatcount = 0

	//Securitrons can't identify monkeys
	if(!lasercolor && judgebot.idcheck )
		threatcount += 4

	//Lasertag bullshit
	if(lasercolor)
		if(lasercolor == "b")//Lasertag turrets target the opposing team, how great is that? -Sieve
			if(is_holding_item_of_type(/obj/item/weapon/gun/energy/laser/redtag))
				threatcount += 4

		if(lasercolor == "r")
			if(is_holding_item_of_type(/obj/item/weapon/gun/energy/laser/bluetag))
				threatcount += 4

		return threatcount

	//Check for weapons
	if(judgebot.weaponscheck)
		for(var/obj/item/I in held_items)
			if(judgebot.check_for_weapons(I))
				threatcount += 4

	//mindshield implants imply trustworthyness
	if(isloyal())
		threatcount -= 1

	return threatcount

/mob/living/carbon/monkey/get_permeability_protection()
	var/protection = 0
	if(head)
		protection = 1 - head.permeability_coefficient
	if(wear_mask)
		protection = max(1 - wear_mask.permeability_coefficient, protection)
	protection = protection/7 //the rest of the body isn't covered.
	return protection

/mob/living/carbon/monkey/fully_heal(admin_revive = 0)
	if(!getorganslot("lungs"))
		var/obj/item/organ/lungs/L = new()
		L.Insert(src)
	if(!getorganslot("tongue"))
		var/obj/item/organ/tongue/T = new()
		T.Insert(src)
	..()

/mob/living/carbon/monkey/IsVocal()
	if(!getorganslot("lungs"))
		return 0
	return 1

/mob/living/carbon/monkey/can_use_guns(var/obj/item/weapon/gun/G)
	return 1

/mob/living/carbon/monkey/angry
	aggressive = TRUE

/mob/living/carbon/monkey/angry/Initialize()
	..()
	if(prob(10))
		var/obj/item/clothing/head/helmet/justice/escape/helmet = new(src)
		equip_to_slot_or_del(helmet,slot_head)
		helmet.attack_self(src) // todo encapsulate toggle


/mob/living/carbon/monkey/security
	name = "security monkey"
	verb_say = "announces"
	health = 999999
	maxHealth = 999999
	butcher_results = list(/obj/item/weapon/grenade/iedcasing = 5, /obj/item/stack/sheet/animalhide/monkey = 1)
	type_of_meat = /obj/item/weapon/grenade/iedcasing
	gib_type = /obj/item/weapon/grenade/iedcasing

/mob/living/carbon/monkey/security/Initialize()
	..()
	var/obj/item/clothing/head/helmet/justice/escape/helmet = new(src)
	equip_to_slot_or_del(helmet,slot_head)
	helmet.attack_self(src) // todo encapsulate toggle
	var/obj/item/clothing/mask/breath/mask = new(src)
	equip_to_slot_or_del(mask,slot_wear_mask)
	var/obj/item/clothing/neck/cloak/qm/back = new(src)
	equip_to_slot_or_del(back,slot_neck)
	var/obj/item/weapon/tank/internals/oxygen/red/storage = new(src)
	equip_to_slot_or_del(storage,slot_back)

	///obj/item/clothing/neck/cloak/cmo

	//wear_neck
	//mask.attack_self(src) // todo encapsulate toggle
	//emergency now
	src.say("Engaging Thot Patrol Mode.")

/mob/living/carbon/alcaro
	name = "alcaro"
	voice_name = "alcaro"
	verb_say = "says"
	initial_languages = list(/datum/language/common)
	icon = 'icons/mob/alcaro.dmi'
	icon_state = ""
	health = 999999
	maxHealth = 999999
	gender = NEUTER
	pass_flags = PASSTABLE
	ventcrawler = VENTCRAWLER_NUDE
	butcher_results = list(/obj/item/weapon/grenade/iedcasing = 5, /obj/item/weapon/grenade/iedcasing = 1)
	type_of_meat = /obj/item/weapon/grenade/iedcasing
	gib_type = /obj/item/weapon/grenade/iedcasing
	unique_name = 1
	var/aggressive = TRUE
	bodyparts = list(/obj/item/bodypart/chest/alcaro, /obj/item/bodypart/head/alcaro)



/mob/living/carbon/alcaro/Initialize()
	verbs += /mob/living/proc/mob_sleep
	verbs += /mob/living/proc/lay_down

	if(unique_name) //used to exclude pun pun
		gender = pick(MALE, FEMALE)
	real_name = name

	//initialize limbs
	create_bodyparts()

	create_internal_organs()

	..()

/mob/living/carbon/alcaro/Initialize()
	..()
	create_dna(src)
	dna.initialize_dna(random_blood_type())

/mob/living/carbon/alcaro/create_internal_organs()
	internal_organs += new /obj/item/organ/appendix
	internal_organs += new /obj/item/organ/lungs
	internal_organs += new /obj/item/organ/heart
	internal_organs += new /obj/item/organ/brain
	internal_organs += new /obj/item/organ/tongue
	internal_organs += new /obj/item/organ/eyes
	..()

/mob/living/carbon/alcaro/movement_delay()
	if(reagents)
		if(reagents.has_reagent("morphine"))
			return -1

		if(reagents.has_reagent("nuka_cola"))
			return -1

	. = ..()
	var/health_deficiency = (100 - health)
	if(health_deficiency >= 45)
		. += (health_deficiency / 25)

	if (bodytemperature < 283.222)
		. += (283.222 - bodytemperature) / 10 * 1.75
	if (aggressive = TRUE)
		return 0
	else
		return . + config.monkey_delay

/mob/living/carbon/alcaro/Stat()
	..()
	if(statpanel("Status"))
		stat(null, "Intent: [a_intent]")
		stat(null, "Move Mode: [m_intent]")
		if(client && mind)
			if(mind.changeling)
				stat("Chemical Storage", "[mind.changeling.chem_charges]/[mind.changeling.chem_storage]")
				stat("Absorbed DNA", mind.changeling.absorbedcount)
	return


/mob/living/carbon/alcaro/verb/removeinternal()
	set name = "Remove Internals"
	set category = "IC"
	internal = null
	return


/mob/living/carbon/alcaro/IsAdvancedToolUser()//Unless its monkey mode monkeys cant use advanced tools
	if (aggressive = TRUE)
		return 1
	else
		return 0

/mob/living/carbon/alcaro/reagent_check(datum/reagent/R) //can metabolize all reagents
	if (aggressive = TRUE)
		return 1
	else
		return 0

/mob/living/carbon/alcaro/canBeHandcuffed()
	return 1

/mob/living/carbon/alcaro/assess_threat(mob/living/simple_animal/bot/secbot/judgebot, lasercolor)
	if(judgebot.emagged == 2)
		return 10 //Everyone is a criminal!
	var/threatcount = 0

	//Securitrons can't identify monkeys
	if(!lasercolor && judgebot.idcheck )
		threatcount += 4

	//Lasertag bullshit
	if(lasercolor)
		if(lasercolor == "b")//Lasertag turrets target the opposing team, how great is that? -Sieve
			if(is_holding_item_of_type(/obj/item/weapon/gun/energy/laser/redtag))
				threatcount += 4

		if(lasercolor == "r")
			if(is_holding_item_of_type(/obj/item/weapon/gun/energy/laser/bluetag))
				threatcount += 4

		return threatcount

	//Check for weapons
	if(judgebot.weaponscheck)
		for(var/obj/item/I in held_items)
			if(judgebot.check_for_weapons(I))
				threatcount += 4

	//mindshield implants imply trustworthyness
	if(isloyal())
		threatcount -= 1

	return threatcount

/mob/living/carbon/alcaro/get_permeability_protection()
	var/protection = 0
	if(head)
		protection = 1 - head.permeability_coefficient
	if(wear_mask)
		protection = max(1 - wear_mask.permeability_coefficient, protection)
	protection = protection/7 //the rest of the body isn't covered.
	return protection

/mob/living/carbon/alcaro/fully_heal(admin_revive = 0)
	if(!getorganslot("lungs"))
		var/obj/item/organ/lungs/L = new()
		L.Insert(src)
	if(!getorganslot("tongue"))
		var/obj/item/organ/tongue/T = new()
		T.Insert(src)
	..()

/mob/living/carbon/alcaro/IsVocal()
	if(!getorganslot("lungs"))
		return 0
	return 1

/mob/living/carbon/alcaro/can_use_guns(var/obj/item/weapon/gun/G)
	return 1