//AKA cryosleep.

/obj/structure/far_travel //Shamelessly jury-rigged from the way Fallout13 handles this and shamelessly borrowed from AzurePeak's further iteraiton of this system
	name = "far travel"
	desc = "Your heart yearns to wander.\n(Drag your sprite onto this to exit the round!)"
	icon = 'icons/turf/roguefloor.dmi'
	icon_state = "travel"
	layer = BELOW_OBJ_LAYER
	density = FALSE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/in_use = FALSE

/obj/structure/far_travel/MouseDrop_T(atom/dropping, mob/user)
	if(!isliving(user) || user.incapacitated())
		return //No ghosts or incapacitated folk allowed to do this.
	if(!ishuman(dropping))
		return //Only humans have job slots to be freed.
	if(in_use) // Someone's already going in.
		return
	var/mob/living/carbon/human/departing_mob = dropping
	var/datum/job/mob_job
	if(departing_mob != user && departing_mob.client)
		to_chat(user, span_warning("This one retains their free will. It's their choice if they want to leave the round or not."))
		return //prevents people from forceghosting others
	if(departing_mob.stat == DEAD)
		say("The dead cannot leave for Enigma, ensure they get a proper burial")
		return
	if(departing_mob.mind?.assigned_role in GLOB.noble_positions)
		say("The Nobility cannot leave for Enigma, they must stay in Vanderlin.")
		return //prevents noble roles from cryoing as per request of Aberra
	if(alert("Are you sure you want to [departing_mob == user ? "leave for Enigma (you" : "send this person to Enigma (they"] will be removed from the current round, the job slot freed)?", "Departing", "Confirm", "Cancel") != "Confirm")
		return //doublechecks that people actually want to leave the round
	if(user.incapacitated() || QDELETED(departing_mob) || (departing_mob != user && departing_mob.client) || get_dist(src, dropping) > 2 || get_dist(src, user) > 2)
		return //Things have changed since the alert happened.
	say("[user] [departing_mob == user ? "is trying to venture to Enigma!" : "is trying to send [departing_mob] to Enigma!"]")
	in_use = TRUE //Just sends a simple message to chat that some-one is leaving
	if(!do_after(user, 50, target = src))
		in_use = FALSE
		return
	in_use = FALSE
	update_icon() //the section below handles roles and admin logging
	var/dat = "[key_name(user)] has despawned [departing_mob == user ? "themselves" : departing_mob], job [departing_mob.job], at [AREACOORD(src)]. Contents despawned along:"
	if(departing_mob.mind)
		mob_job = SSjob.GetJob(departing_mob.mind.assigned_role)
		mob_job.current_positions = max(0, mob_job.current_positions - 1)
	if(!length(departing_mob.contents))
		dat += " none."
	else
		var/atom/movable/content = departing_mob.contents[1]
		dat += " [content.name]"
		for(var/i in 2 to length(departing_mob.contents))
			content = departing_mob.contents[i]
			dat += ", [content.name]"
		dat += "."
	message_admins(dat)
	log_admin(dat)
	say(span_notice("[departing_mob == user ? "Out of their own volition, " : "Ushered by [user], "][departing_mob] ventures forth."))
	qdel(departing_mob)
