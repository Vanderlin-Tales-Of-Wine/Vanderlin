/obj/item/rune
	var/list/remarks = list() //things to read about while learning.
	var/pages_to_mastery = 5 //Essentially controls how long a mob must keep the rune in his hand to actually successfully learn
	var/reading = FALSE //sanity
	var/oneuse = TRUE //default this is true, but admins can var this to 0 if we wanna all have a pass around of the rod form rune
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/roguetown/items/books.dmi'

/obj/item/rune/proc/turn_page(mob/user)
	if(do_after(user, 5 SECONDS))
		return TRUE
	return FALSE

/obj/item/rune/proc/already_known(mob/user)
	return FALSE

/obj/item/rune/proc/on_start(mob/user)
	to_chat(user, "<span class='notice'>I start reading [name]...</span>")

/obj/item/rune/proc/on_stopped(mob/user)
	to_chat(user, "<span class='notice'>I stop reading...</span>")

/obj/item/rune/proc/on_finished(mob/user)
	to_chat(user, "<span class='notice'>I finish reading [name]!</span>")

/obj/item/rune/proc/onlearned(mob/user)
	qdel(src)

/obj/item/rune/attack_self(mob/user)
	if(reading)
		//to_chat(user, "<span class='warning'>You're already reading this!</span>")
		return FALSE
	if(already_known(user))
		to_chat(user, "<span class='notice'>I already know this spell.</span>")
		return FALSE
	if(!user.mind?.get_skill_level(/datum/skill/magic/arcane))
		to_chat(user, "<span class='warning'>I don't have the knowledge to learn this spell.</span>")
		return FALSE
	on_start(user)
	reading = TRUE
	if(remarks.len)
		to_chat(user, "<span class='notice'>[pick(remarks)]</span>")
	for(var/i=1, i<=pages_to_mastery, i++)
		if(!turn_page(user))
			on_stopped()
			reading = FALSE
			return
	if(do_after(user, 5 SECONDS))
		on_finished(user)
		reading = FALSE
	return TRUE

//Spells
/obj/item/rune/spell
	name = "rune"
	pages_to_mastery = 3
	var/spell
	var/spellname = "no spell"
	icon_state = "spellbookpower1_0" //temporary sprite

/obj/item/rune/spell/on_start(mob/user)
	user.visible_message("<span class='warning'>[user] begins siphoning the rune.</span>")

/obj/item/rune/spell/on_finished(mob/user)
	for(var/obj/effect/proc_holder/spell/knownspell in user.mind.spell_list)
		if(knownspell.type == spell)
			spell = null
	if(spell)
		to_chat(user, "<span class='notice'>The power of [spellname] is emblazened in your mind!</span>")
		var/obj/effect/proc_holder/spell/S = new spell
		user.mind.AddSpell(S)
		if(user.mind.get_skill_level(/datum/skill/magic/arcane) <= 5)
			user.mind.adjust_experience(/datum/skill/magic/arcane, 100, FALSE)
	else if(user.mind.get_skill_level(/datum/skill/magic/arcane) <= 5)
		to_chat(user, "<span class='notice'>Arcane power is emblazened in your mind!</span>")
		user.mind.adjust_experience(/datum/skill/magic/arcane, 150, FALSE)
	user.visible_message("<span class='warning'>[src] glows dark, and then crumbles!</span>")
	qdel(src)

/obj/item/rune/spell/fire_rune
	spell = /obj/effect/proc_holder/spell/invoked/projectile/fireball
	spellname = "fireball"
	// icon_state = "fire_rune"
	name = "fire rune"
	desc = "Warm with power."
	remarks = list("To understand these archaic things...", "Just catching them on fire won't do...", "Accounting for crosswinds... really?", "I think I just burned my hand...")

/obj/item/rune/spell/water_rune
	spell = /obj/effect/proc_holder/spell/targeted/ethereal_jaunt
	spellname = "ethereal jaunt"
	// icon_state = "water_rune"
	name = "water rune"
	desc = "A bit moist."
	remarks = list("To understand these archaic things...", "Mana flows through all living things...", "This spell will fatigue me...", "The spell should flow like water...")

/obj/item/rune/spell/air_rune
	spell = /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt
	spellname = "lightning"
	// icon_state = "air_rune"
	name = "air rune"
	desc = "Cool to the touch."
	remarks = list("To understand these archaic things...", "Done properly this could...", "I think I just shocked my hand...")

/obj/item/rune/spell/earth_rune
	spell = /obj/effect/proc_holder/spell/invoked/projectile/fetch
	spellname = "fetch"
	// icon_state = "earth_rune"
	name = "earth rune"
	desc = "Heavier than it looks."
	remarks = list("To understand these archaic things...", "I can only pull, not push...", "My mind feels like mud...")

/obj/item/rune/spell/blank_rune
	spell = null
	spellname = "arcane magic"
	// icon_state = "blank_rune"
	name = "rune essence"
	desc = "The source of magic in our world."
	remarks = list("My head hurts...", "I'll never understand this!", "I don't want to look away...")
