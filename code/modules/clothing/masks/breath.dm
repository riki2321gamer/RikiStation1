/obj/item/clothing/mask/breath
	desc = "A default mask, but edited enough to be anti toxin."
	name = "Anti Toxin breathing mask"
	icon_state = "breath"
	item_state = "m_mask"
	body_parts_covered = 0
	flags = MASKINTERNALS
	visor_flags = MASKINTERNALS
	w_class = WEIGHT_CLASS_SMALL
	gas_transfer_coefficient = 0.10
	permeability_coefficient = 0.50
	actions_types = list(/datum/action/item_action/adjust)
	flags_cover = MASKCOVERSMOUTH
	visor_flags_cover = MASKCOVERSMOUTH
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 100, rad = 100, fire = 100, acid = 100)
	resistance_flags = 0

/obj/item/clothing/mask/breath/attack_self(mob/user)
	adjustmask(user)
	user.say("Internals settings being changed.")

/obj/item/clothing/mask/breath/AltClick(mob/user)
	..()
	if(!user.canUseTopic(src, be_close=TRUE))
		to_chat(user, "<span class='warning'>You can't do that right now!</span>")
		return
	else
		adjustmask(user)
	user.say("Internals settings being changed.")

/obj/item/clothing/mask/breath/examine(mob/user)
	..()
	to_chat(user, "<span class='notice'>Alt-click [src] to adjust it.</span>")

/obj/item/clothing/mask/breath/medical
	desc = "A close-fitting sterile mask that can be connected to an air supply."
	name = "medical mask"
	icon_state = "medical"
	item_state = "m_mask"
	permeability_coefficient = 0.01
	put_on_delay = 10

/obj/item/clothing/mask/breath/alien
	name = "Alien Breathing Mask"
	desc = "Is it not nice having a pet in your face and also be able to breath with it?, it seems to have some sort of tube at the end.. the probabilities of you getting intoxicated are %100"
	icon = 'icons/mob/alien.dmi'
	icon_state = "facehugger"
	item_state = "facehugger"