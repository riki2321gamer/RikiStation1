
//Chef
/obj/item/clothing/head/chefhat
	name = "chef's hat"
	item_state = "chef"
	icon_state = "chef"
	desc = "The commander in chef's head wear."
	strip_delay = 10
	put_on_delay = 10
	dog_fashion = /datum/dog_fashion/head/chef

/obj/item/clothing/head/chefhat/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is donning [src]! It looks like [user.p_theyre()] trying to become a chef.</span>")
	user.say("Bork Bork Bork!")
	sleep(20)
	user.visible_message("<span class='suicide'>[user] climbs into an imaginary oven!</span>")
	user.say("BOOORK!")
	playsound(user, 'sound/machines/ding.ogg', 50, 1)
	return(FIRELOSS)

/obj/item/clothing/head/caphat/attack_self(mob/user)
	if(can_toggle && !user.incapacitated())
		if(world.time > cooldown + toggle_cooldown)
			cooldown = world.time
			up = !up
			flags ^= visor_flags
			flags_inv ^= visor_flags_inv
			flags_cover ^= visor_flags_cover
			icon_state = "[initial(icon_state)][up ? "up" : ""]"
			to_chat(user, "[up ? alt_toggle_message : toggle_message] \the [src]")
			user.say("GET THE FUCK TO THE GROUND NOW RAISE YOUR HANDS RAISE YOUR HANDS THE ACTION YOU'RE DOING IS ILLEGAL AND YOU WILL BE ARRESTED BY THE THOT PATROL")
			user.update_inv_head()
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.head_update(src, forced = 1)

			if(active_sound)
				while(up)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(45)

//Captain
/obj/item/clothing/head/caphat
	name = "THOT PATROL HAT"
	desc = "be gone thottie"
	icon_state = "justice2"
	toggle_message = "TURNED OFF THE"
	alt_toggle_message = "TURNED ON THE"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	can_toggle = 1
	can_flashlight = 1
	toggle_cooldown = 20
	active_sound = 'sound/items/thottiepatrol.ogg'
	armor = list(melee = 40, bullet = 30, laser = 30,energy = 30, bomb = 50, bio = 90, rad = 20, fire = 50, acid = 50)
	strip_delay = 60
	dog_fashion = /datum/dog_fashion/head/captain

/obj/item/clothing/head/bomber/attack_self(mob/user)
	if(can_toggle && !user.incapacitated())
		if(world.time > cooldown + toggle_cooldown)
			cooldown = world.time
			up = !up
			flags ^= visor_flags
			flags_inv ^= visor_flags_inv
			flags_cover ^= visor_flags_cover
			icon_state = "[initial(icon_state)][up ? "up" : ""]"
			to_chat(user, "Are you sure this is good? What are you doing!?")
			user.say("oh god IM GONNA BLOW UP GET AWAY EVERYONE")
			playsound(src.loc, "sound/items/Nuke_toy_lowpower.ogg", 100, 0, 4)
			user.update_inv_head()
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.head_update(src, forced = 1)

			if(active_sound)
				while(up)
					sleep(20)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(20)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(20)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(20)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(20)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(20)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(20)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(20)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(20)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(10)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(10)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(10)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(10)
					playsound(src.loc, "sound/ambience/screaming.ogg", 100, 0, 4)
					sleep(30)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					explosion(src.loc,1,1,512, flame_range = 4)
					up = 0

/obj/item/clothing/head/bomber
	name = "blow the station up"
	desc = "don't activate this fucking shit"
	icon_state = "justice2"
	toggle_message = "TURNED OFF THE"
	alt_toggle_message = "TURNED ON THE"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	can_toggle = 1
	can_flashlight = 1
	toggle_cooldown = 20
	active_sound = 'sound/items/timer.ogg'
	strip_delay = 60

//Captain: This is no longer space-worthy
/obj/item/clothing/head/caphat/parade
	name = "WOOKY UP FOR"
	desc = "virtual penguin"
	icon_state = "capcap"

	dog_fashion = null


//Head of Personnel
/obj/item/clothing/head/hopcap
	name = "head of personnel's cap"
	icon_state = "hopcap"
	desc = "The symbol of true bureaucratic micromanagement."
	armor = list(melee = 25, bullet = 15, laser = 25, energy = 10, bomb = 25, bio = 0, rad = 0, fire = 50, acid = 50)
	dog_fashion = /datum/dog_fashion/head/hop

//Chaplain
/obj/item/clothing/head/nun_hood
	name = "nun hood"
	desc = "Maximum piety in this star system."
	icon_state = "nun_hood"
	flags_inv = HIDEHAIR
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/head/cage
	name = "cage"
	desc = "A cage that restrains the will of the self, allowing one to see the profane world for what it is."
	alternate_worn_icon = 'icons/mob/large-worn-icons/64x64/head.dmi'
	icon_state = "cage"
	item_state = "cage"
	worn_x_dimension = 64
	worn_y_dimension = 64


/obj/item/clothing/head/witchunter_hat
	name = "witchunter hat"
	desc = "This hat saw much use back in the day."
	icon_state = "witchhunterhat"
	item_state = "witchhunterhat"
	flags_cover = HEADCOVERSEYES

//Detective
/obj/item/clothing/head/det_hat
	name = "detective's fedora"
	desc = "There's only one man who can sniff out the dirty stench of crime, and he's likely wearing this hat."
	icon_state = "detective"
	armor = list(melee = 25, bullet = 5, laser = 25, energy = 10, bomb = 0, bio = 0, rad = 0, fire = 30, acid = 50)
	var/candy_cooldown = 0
	pockets = /obj/item/weapon/storage/internal/pocket/small/detective
	dog_fashion = /datum/dog_fashion/head/detective

/obj/item/clothing/head/det_hat/AltClick()
	..()
	if(ismob(loc))
		var/mob/M = loc
		if(candy_cooldown < world.time)
			var/obj/item/weapon/reagent_containers/food/snacks/candy_corn/CC = new /obj/item/weapon/reagent_containers/food/snacks/candy_corn(src)
			M.put_in_hands(CC)
			to_chat(M, "You slip a candy corn from your hat.")
			candy_cooldown = world.time+1200
		else
			to_chat(M, "You just took a candy corn! You should wait a couple minutes, lest you burn through your stash.")


//Mime
/obj/item/clothing/head/beret
	name = "beret"
	desc = "A beret, a mime's favorite headwear."
	icon_state = "beret"

	dog_fashion = /datum/dog_fashion/head/beret

/obj/item/clothing/head/beret/highlander
	desc = "That was white fabric. <i>Was.</i>"
	flags = NODROP
	dog_fashion = null //THIS IS FOR SLAUGHTER, NOT PUPPIES

//Security

/obj/item/clothing/head/HoS
	name = "head of security cap"
	desc = "The robust standard-issue cap of the Head of Security. For showing the officers who's in charge."
	icon_state = "hoscap"
	armor = list(melee = 40, bullet = 30, laser = 25, energy = 10, bomb = 25, bio = 10, rad = 0, fire = 50, acid = 60)
	strip_delay = 80

/obj/item/clothing/head/HoS/beret
	name = "head of security beret"
	desc = "A robust beret for the Head of Security, for looking stylish while not sacrificing protection."
	icon_state = "hosberetblack"

/obj/item/clothing/head/warden
	name = "warden's police hat"
	desc = "It's a special armored hat issued to the Warden of a security force. Protects the head from impacts."
	icon_state = "policehelm"
	armor = list(melee = 40, bullet = 30, laser = 30, energy = 10, bomb = 25, bio = 0, rad = 0, fire = 30, acid = 60)
	strip_delay = 60
	dog_fashion = /datum/dog_fashion/head/warden

/obj/item/clothing/head/beret/sec
	name = "security beret"
	desc = "A robust beret with the security insignia emblazoned on it. Uses reinforced fabric to offer sufficent protection."
	icon_state = "beret_badge"
	armor = list(melee = 40, bullet = 30, laser = 30,energy = 10, bomb = 25, bio = 0, rad = 0, fire = 20, acid = 50)
	strip_delay = 60
	dog_fashion = null

/obj/item/clothing/head/beret/sec/navyhos
	name = "head of security's beret"
	desc = "A special beret with the Head of Security's insignia emblazoned on it. A symbol of excellence, a badge of courage, a mark of distinction."
	icon_state = "hosberet"

/obj/item/clothing/head/beret/sec/navywarden
	name = "warden's beret"
	desc = "A special beret with the Warden's insignia emblazoned on it. For wardens with class."
	icon_state = "wardenberet"
	armor = list(melee = 40, bullet = 30, laser = 30, energy = 10, bomb = 25, bio = 0, rad = 0, fire = 30, acid = 50)
	strip_delay = 60

/obj/item/clothing/head/beret/sec/navyofficer
	desc = "A special beret with the security insignia emblazoned on it. For officers with class."
	icon_state = "officerberet"

//Curator
/obj/item/clothing/head/curator
	name = "treasure hunter's fedora"
	desc = "You got red text today kid, but it doesn't mean you have to like it."
	icon_state = "curator"
	armor = list(melee = 25, bullet = 5, laser = 25, energy = 10, bomb = 0, bio = 0, rad = 0, fire = 30, acid = 50)