/datum/round_event_control/processor_overload
	name = "Processor Overload"
	typepath = /datum/round_event/processor_overload
	weight = 15
	min_players = 20

/datum/round_event/processor_overload
	announceWhen	= 1

/datum/round_event/processor_overload/announce()
	var/alert = pick(	"OOPS YOU FUCKED UP NOW ITS GONNA FUCKIG EXPLODE!!!!!!!!!!!!!!!!!!!!!!!!!", \
						"WHAT THE FUCK DYID YOU DO", \
						"OH SHIT ITS OVERHEATING", \
						"The LDA Syndicate Has ATtacked THe FUCKIN GCORE NOW ITs gonna eXXXXXXXXXXXXXPLOD!!!!!!!!!!!!!!!!!!!!", \
						"NIGGA WHAT DID U DO", \
						"O SHIT")

	for(var/mob/living/silicon/ai/A in GLOB.ai_list)
	//AIs are always aware of processor overload
		to_chat(A, "<br><span class='warning'><b>[alert]</b></span><br>")

	// Announce most of the time, but leave a little gap so people don't know
	// whether it's, say, a tesla zapping tcomms, or some selective
	// modification of the tcomms bus
	if(prob(80))
		priority_announce(alert)


/datum/round_event/processor_overload/start()
	for(var/obj/machinery/telecomms/T in GLOB.telecomms_list)
		if(istype(T, /obj/machinery/telecomms/processor))
			var/obj/machinery/telecomms/processor/P = T
			if(prob(10))
				// Damage the surrounding area to indicate that it popped
				explosion(get_turf(P), 0, 0, 2)
				// Only a level 1 explosion actually damages the machine
				// at all
				P.ex_act(1)
			else
				P.emp_act(1)
