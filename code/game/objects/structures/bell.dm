/obj/structure/warningbell
	name = "Warning Bell"
	desc = "A large bell used to warn everyone in the vicinity of impending danger."
	icon = 'icons/roguetown/misc/96x96.dmi'  // Ensure you have an appropriate icon for the bell
	icon_state = "churchbell"
	density = FALSE
	anchored = TRUE
	var/last_ring_time = 0
	var/ring_cooldown = 50 // Cooldown in deciseconds before the bell can be rung again
	var/ring_range = 50    // Define the range within which players will be alerted

/obj/structure/warningbell/attack_hand(mob/user)
	if(world.time < last_ring_time + ring_cooldown)
		to_chat(user, "<span class='warning'>The bell is still resonating from the last ring.</span>")
		return

	// Ring the bell
	last_ring_time = world.time
	user.visible_message(
		"<span class='notice'>[user] rings the [src].</span>",
		"<span class='notice'>You ring the [src].</span>"
	)

	// Play bell sound for everyone in the vicinity
	playsound(src, 'sound/misc/deadbell.ogg', 100, TRUE)

	// Alert all players in the area
	var/list/nearby_players = get_hearers_in_view(ring_range, src)
	for(var/mob/M in nearby_players)
		if(ismob(M))
			to_chat(M, "<span class='warning'>Alert! The warning bell rings ominously, signaling danger nearby!</span>")


/obj/structure/warningbell/townhall
	name = "Town Hall Bell"
	desc = "A large bell used to summon townsfolk for gathering."
	icon = 'icons/roguetown/misc/96x96.dmi'  // Ensure you have an appropriate icon for the bell

/obj/structure/warningbell/townhall/attack_hand(mob/user)
	if(world.time < last_ring_time + ring_cooldown)
		to_chat(user, "<span class='warning'>The bell is still resonating from the last ring.</span>")
		return

	// Ring the bell
	last_ring_time = world.time
	user.visible_message(
		"<span class='notice'>[user] rings the [src].</span>",
		"<span class='notice'>You ring the [src].</span>"
	)

	// Play bell sound for everyone in the vicinity
	playsound(src, 'sound/misc/deadbell.ogg', 100, TRUE)

	// Alert all players in the area
	var/list/nearby_players = get_hearers_in_view(ring_range, src)
	for(var/mob/M in nearby_players)
		if(ismob(M))
			to_chat(M, "<span class='warning'>The town hall bell chimes, summoning the townsfolk to the tavern for a gathering!</span>")
