/obj/item/clothing/head/crown/serpcrown
	name = "crown of Vanderlin"
	desc = "Heavy is the weight of the crown, and even heavier the responsibility it infers to its wearer."
	icon_state = "serpcrown"
	sellprice = VALUE_EXTREME
	resistance_flags = FIRE_PROOF|ACID_PROOF|LAVA_PROOF|UNACIDABLE|INDESTRUCTIBLE
	/// the trapped spirit inside
	var/mob/camera/ancestral_spirit/possessor

/obj/item/clothing/head/crown/serpcrown/proc/create_ancestral_spirit()
	if(possessor)
		return
	possessor = new /mob/camera/ancestral_spirit(loc, src)

/obj/item/clothing/head/crown/serpcrown/Initialize()
	. = ..()
	name = "crown of [SSmapping.config.map_name]"
	if(type == /obj/item/clothing/head/crown/serpcrown && !istype(loc, /mob/living/carbon/human/dummy)) //dummies spawn this in character setup
		SSroguemachine.crown = src
	become_hearing_sensitive()
	#ifdef LOWMEMORYMODE
	create_ancestral_spirit() // TESTING PROC, DON'T LEAVE THIS IN FOR LIVE
	#endif

/obj/item/clothing/head/crown/serpcrown/proc/anti_stall()
	src.visible_message(span_warning("[src] crumbles to dust, the ashes spiriting away in the direction of the Keep."))
	SSroguemachine.crown = null //Do not harddel.
	qdel(src) //Anti-stall

/obj/item/clothing/head/crown/serpcrown/surplus
	name = "crown"
	desc = "A replacement for the Crown of Vanderlin, every bit as valid as proof of sovereignity as the original."
	icon_state = "serpcrowno"
	sellprice = VALUE_GOLD_ITEM
