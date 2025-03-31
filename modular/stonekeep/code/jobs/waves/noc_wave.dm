/datum/migrant_role/sk/nocpriest
	name = "Priest of Noc"
	greet_text = "It is time to replace the Sun Queen with her superior brother as the head of the Pantheon! Inspired by divine command in your dreams, you must take over the local Temple and make them recognize the supremacy of Noc."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = ALL_RACES_FOR_REAL
	outfit = /datum/outfit/job/sk_migration/noc_priest
	grant_lit_torch = TRUE

/datum/migrant_role/sk/nocpriest/after_spawn(mob/living/carbon/human/character)
	. = ..()
	character.forceMove(pick(GLOB.mountainroad_starts))

/datum/outfit/job/sk_migration/noc_priest/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		if(H.patron != /datum/patron/divine/noc) // For some stupid reason this was checking for Dendor before.
			H.set_patron(/datum/patron/divine/noc)

	head = /obj/item/clothing/head/roguehood/nochood/priest
	neck = /obj/item/clothing/neck/psycross/noc
	wrists = /obj/item/clothing/wrists/nocwrappings
	shoes = /obj/item/clothing/shoes/sandals
	armor = /obj/item/clothing/shirt/robe/noc
	shoes = /obj/item/clothing/shoes/boots/furlinedboots
	pants = /obj/item/clothing/pants/trou/leather/heavy
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/flashlight/flare/torch/lantern
	beltl = /obj/item/weapon/knife/villager
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/natural/cloth = 1, /obj/item/needle/thorn = 1, /datum/reagent/medicine/strongmana = 1, /obj/item/storage/belt/pouch/coins/poor = 1)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE) // They get this and a wooden staff to defend themselves
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/magic/holy, 4, TRUE)

		H.cmode_music = 'sound/music/cmode/antag/combat_cult.ogg'

		var/list/spells = list(/obj/effect/proc_holder/spell/self/convertrole/templar, /obj/effect/proc_holder/spell/self/convertrole/monk, /obj/effect/proc_holder/spell/self/convertrole/churchling)
		for(var/S in spells)
			H.mind.AddSpell(new S)

	var/obj/item/weapon/polearm/woodstaff/aries/noc/P = new()
	H.put_in_hands(P, forced = TRUE)

	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron) // This creates the cleric holder used for devotion spells
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
	C.grant_spells_priest(H)

	H.update_icons()

/datum/migrant_wave/noc_cult
	name = "The Noc Apostate"
	max_spawns = 1
	weight = 5
	roles = list(
		/datum/migrant_role/sk/nocpriest = 1
		)
	greet_text = "Too long the Moon Prince has been refused his rightful place as the primary God by the cult of his sister Astrata. It is time to right this wrong. They call you apostate, but you know you see the truth."


