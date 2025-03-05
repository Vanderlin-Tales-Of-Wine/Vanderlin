/* * * * * * * * * **
 *					*
 *		 Mobs		*
 *					*
 *					*
 * * * * * * * * * **/

// ======================================================================
/*	..................   Colony Spider Web   ................... */
/obj/structure/innocent_web
	name = ""
	desc = ""
	icon = 'modular/stonekeep/icons/32x64.dmi'
	icon_state = "innocentweb1"
	layer = ABOVE_ALL_MOB_LAYER
	density = FALSE
	max_integrity = 35
	climbable = FALSE
	dir = SOUTH
	debris = list(/obj/item/natural/silk = 1)
	var/lucky_escape

/obj/structure/innocent_web/Initialize()
	. = ..()
	icon_state = "innocentweb[rand(1,2)]"
	return ..()

/obj/structure/innocent_web/attack_hand()
	playsound(src, pick('sound/misc/jumpscare (1).ogg','sound/misc/jumpscare (2).ogg','sound/misc/jumpscare (3).ogg','sound/misc/jumpscare (4).ogg'), 100)
	new /mob/living/simple_animal/hostile/retaliate/spider/hairy (get_turf(src))
	qdel(src)

/obj/structure/innocent_web/attackby(obj/item, /mob/user, params)
	playsound(src, pick('sound/misc/jumpscare (1).ogg','sound/misc/jumpscare (2).ogg','sound/misc/jumpscare (3).ogg','sound/misc/jumpscare (4).ogg'), 100)
	new /mob/living/simple_animal/hostile/retaliate/spider/hairy (get_turf(src))
	qdel(src)

/obj/structure/innocent_web/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	playsound(src, pick('sound/misc/jumpscare (1).ogg','sound/misc/jumpscare (2).ogg','sound/misc/jumpscare (3).ogg','sound/misc/jumpscare (4).ogg'), 100)
	new /mob/living/simple_animal/hostile/retaliate/spider/hairy (get_turf(src))
	qdel(src)

/obj/structure/innocent_web/Crossed(atom/movable/AM)
	..()
	if(isliving(AM))
		var/mob/living/carbon/human/L = AM
		lucky_escape = ( L.STALUC * 4 )
		L.Immobilize(5)
		if(L.m_intent == MOVE_INTENT_WALK)
			L.Immobilize(10)
			if(prob(lucky_escape))
				to_chat(L, "<span class='warning'>The flimsy web breaks.</span>")
				qdel(src)
			else
				playsound(src, pick('sound/misc/jumpscare (1).ogg','sound/misc/jumpscare (2).ogg','sound/misc/jumpscare (3).ogg','sound/misc/jumpscare (4).ogg'), 120)
				new /mob/living/simple_animal/hostile/retaliate/spider/hairy (get_turf(src))
				qdel(src)
		if(L.m_intent == MOVE_INTENT_RUN)
			to_chat(L, "<span class='warning'>I'm stuck in the web!</span>")
			L.Immobilize(20)
			if(prob(lucky_escape))
				to_chat(L, "<span class='warning'>The flimsy web breaks.</span>")
				qdel(src)
			else
				playsound(src, pick('sound/misc/jumpscare (1).ogg','sound/misc/jumpscare (2).ogg','sound/misc/jumpscare (3).ogg','sound/misc/jumpscare (4).ogg'), 120)
				new /mob/living/simple_animal/hostile/retaliate/spider/hairy (get_turf(src))
				qdel(src)
		else
			to_chat(L, "<span class='warning'>I'm stuck in the web!</span>")
			L.Immobilize(5)
			if(prob(lucky_escape))
				to_chat(L, "<span class='warning'>The flimsy web breaks.</span>")
				qdel(src)
			else
				playsound(src, pick('sound/misc/jumpscare (1).ogg','sound/misc/jumpscare (2).ogg','sound/misc/jumpscare (3).ogg','sound/misc/jumpscare (4).ogg'), 120)
				new /mob/living/simple_animal/hostile/retaliate/spider/hairy (get_turf(src))
				qdel(src)


/mob/living/simple_animal/hostile/retaliate/spider/hairy
	name = "hairy spider"
	desc = "The forest canopies hides more than leaves...These creachers make honey from flowers and spin silk from their abdomen, when not consuming prey."
	icon = 'modular/stonekeep/icons/spider.dmi'
	icon_state = "spider"
	icon_living = "spider"
	icon_dead = "spider-dead"
	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/strange = 1,
							/obj/item/natural/silk = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/strange= 2,
							/obj/item/reagent_containers/food/snacks/spiderhoney = 1,
							/obj/item/natural/silk = 2)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/strange = 2,
							/obj/item/reagent_containers/food/snacks/spiderhoney = 2,
							/obj/item/natural/silk = 3)



// ======================================================================
/*	..................   Corpses   ................... */
/obj/effect/mob_spawn/human/orc/corpse
	icon = 'icons/effects/blood.dmi'
	icon_state = "remains"
	color = "#aa9b00"
	mob_type = /mob/living/carbon/human/species/orc

/obj/effect/mob_spawn/human/orc/corpse/savageorc
	mob_name = "Savage Orc"
	name = "Savage Orc"
	skin_tone = "#50715C"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/savageorc

/obj/effect/mob_spawn/human/orc/corpse/savageorc2
	mob_name = "Savage Orc"
	name = "Savage Orc"
	skin_tone = "#50715C"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/savageorc2

/datum/outfit/savageorc
//	shirt = /obj/item/clothing/shirt/tribalrag	Vanderlin clothing
	pants =	/obj/item/clothing/pants/loincloth/brown
	shoes = /obj/item/clothing/shoes/boots/furlinedanklets

/datum/outfit/savageorc2
//	shirt = /obj/item/clothing/shirt/tribalrag
	pants =	/obj/item/clothing/pants/loincloth/brown
	shoes = /obj/item/clothing/shoes/boots/furlinedanklets
	head = /obj/item/clothing/head/helmet/leather

/obj/effect/mob_spawn/human/orc/corpse/orcmarauder
	mob_name = "Orc Marauder"
	name = "Orc Marauder"
	skin_tone = "#50715C"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
//	outfit = /datum/outfit/orcmarauder  doesnt actually equip this TO DO
	mob_type = /mob/living/carbon/human/species/orc/marauder
/*
/datum/outfit/orcmarauder
	armor = /obj/item/clothing/armor/chainmail
	pants =	/obj/item/clothing/pants/chainlegs
	shoes = /obj/item/clothing/shoes/boots/furlinedboots
	head = /obj/item/clothing/head/helmet/leather
*/
/obj/effect/mob_spawn/human/orc/corpse/orcravager
	mob_name = "Orc Ravager"
	name = "Orc Ravager"
	skin_tone = "#50715C"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/orcravager

/datum/outfit/orcravager
	armor = /obj/item/clothing/armor/chainmail
	pants =	/obj/item/clothing/pants/chainlegs
	shoes = /obj/item/clothing/shoes/boots/armor
	head = /obj/item/clothing/head/helmet/skullcap
	gloves = /obj/item/clothing/gloves/chain
	neck = /obj/item/clothing/neck/chaincoif
///	mask = /obj/item/clothing/face/skullmask	Vanderlin clothing TO DO review it

/obj/effect/mob_spawn/human/orc/corpse/dwarfinvasion
	color = "#82aa00"
	mob_type = /mob/living/carbon/human/species/orc/dwarfinvasion

/mob/living/carbon/human/species/orc/dwarfinvasion/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/dead_invader)

/datum/outfit/job/roguetown/npc/orc/dead_invader/pre_equip(mob/living/carbon/human/H)
	..()
	var/loadout = rand(1,5)
	switch(loadout)
		if(1)
			armor = /obj/item/clothing/armor/leather/hide/orc
		if(2)
			armor = /obj/item/clothing/armor/leather/hide/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown
		if(3)
			cloak = /obj/item/clothing/cloak/raincloak/brown
		if(4)
			armor = /obj/item/clothing/armor/leather/hide/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown
		if(5)
			armor = /obj/item/clothing/armor/leather/hide/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown

/*	..................   Dwarf Underdweller Corpse   ................... */
/obj/effect/mob_spawn/human/corpse/damaged/underdweller
	icon = 'icons/effects/blood.dmi'
	icon_state = "remains"
	color = "#aa9b00"
	mob_type = /mob/living/carbon/human/species/dwarf/mountain
	mob_name = "Dwarf Underdweller"
	name = "Dwarf Underdweller"
	hairstyle = "Miner"
	facial_hairstyle = "Pick"
	outfit = /datum/outfit/deadunderdweller

/datum/outfit/deadunderdweller
	armor = /obj/item/clothing/armor/cuirass/iron
	shirt = /obj/item/clothing/shirt/undershirt/sailor/red
	pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/simpleshoes/buckle
	backl = /obj/item/storage/backpack/backpack
	head = /obj/item/clothing/head/helmet/leather/minershelm


// ======================================================================
/*	..................   Cat   ................... */
/mob/living/simple_animal/pet/cat
	TOTALSTR = 2
	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/mince/beef = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/flayedcat = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/flayedcat = 1)

/obj/item/reagent_containers/food/snacks/flayedcat
	name = "flayed cat"
	desc = ""
	icon_state = "flayedcat"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR)
	foodtype = RAW
	w_class = WEIGHT_CLASS_SMALL
	eat_effect = /datum/status_effect/debuff/uncookedfood
	fried_type = /obj/item/reagent_containers/food/snacks/friedcat
	cooked_smell = /datum/pollutant/food/fried_rat
	sellprice = 0
	rotprocess = SHELFLIFE_SHORT

/obj/item/reagent_containers/food/snacks/friedcat
	name = "fried cat"
	icon_state = "cookedcat"
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("burnt flesh" = 1)
	rotprocess = SHELFLIFE_DECENT
	sellprice = 0

// ======================================================================
/*	..................   Mob Intents   ................... */
/datum/intent/simple/trollsmash
	name = "trollsmash"
	icon_state = "instrike"
	attack_verb = list("hammer-punches", "smashes", "headbutts", "rams")
	animname = "blank22"
	blade_class = BCLASS_BLUNT
	hitsound = "punch_hard"
	chargetime = 0
	penfactor = 13
	swingdelay = 4 SECONDS
	candodge = TRUE
	canparry = FALSE


/mob/living/simple_animal/hostile/retaliate/troll
	base_intents = list(/datum/intent/simple/trollrip, /datum/intent/simple/trollsmash)

/mob/living/simple_animal/hostile/retaliate/trollbog
	base_intents = list(/datum/intent/simple/trollsmash, /datum/intent/simple/trollrip)

/mob/living/simple_animal/hostile/retaliate/wolf
	base_intents = list(/datum/intent/simple/critterbite)

/mob/living/simple_animal/hostile/retaliate/bigrat
	base_intents = list(/datum/intent/simple/critterbite)

/mob/living/simple_animal/hostile/retaliate/spider
	base_intents = list(/datum/intent/simple/bite)

/datum/intent/simple/trollrip
	name = "trollrip"
	icon_state = "instrike"
	attack_verb = list("claws", "gnashes", "viciously bites")
	animname = "blank22"
	blade_class = BCLASS_CHOP
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 20
	swingdelay = 2 SECONDS
	candodge = TRUE
	canparry = TRUE

/datum/intent/simple/critterbite
	name = "bite"
	icon_state = "instrike"
	attack_verb = list("bites")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 5
	swingdelay = 1.5 SECONDS
	candodge = TRUE
	canparry = TRUE

/datum/intent/simple/claw_strong
	name = "claw"
	icon_state = "inclaw"
	attack_verb = list("slashes", "claws")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 5
	swingdelay = 2 SECONDS
	candodge = TRUE
	canparry = TRUE
	miss_text = "slashes the air!"

/datum/intent/simple/claw_quick
	name = "claw"
	icon_state = "inclaw"
	attack_verb = list("slashes", "claws")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 3
	swingdelay = 1 SECONDS
	candodge = TRUE
	canparry = TRUE
	miss_text = "slashes the air!"



// ======================================================================
/*	..................   Maybe Mob Spawners   ................... */
/obj/effect/spawner/map_spawner/maybe_saiga
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "animal"
	probby = 50
	spawned = list(
		/mob/living/simple_animal/hostile/retaliate/saiga = 40,
		/mob/living/simple_animal/hostile/retaliate/saigabuck = 50,
		/mob/living/simple_animal/hostile/retaliate/saiga/saigakid = 10)

/obj/effect/spawner/map_spawner/maybe_cabbit
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "animal"
	probby = 50
	spawned = list(
		/mob/living/simple_animal/pet/cat/cabbit = 100)



// ======================================================================
/*	..................   Either Or Spawners   ................... */
/obj/effect/spawner/map_spawner/skel_or_remains
	icon = 'icons/effects/blood.dmi'
	icon_state = "remains"
	probby = 50
	color = "#ffce0b"
	spawned = list(
		/obj/structure/idle_enemy/weak_skelly = 4,
		/obj/effect/decal/remains/human/old = 50,
		/obj/effect/decal/remains/human/old/small = 45,
		/obj/item/clothing/ring/silver = 1
		)

/*	..................   Catacomb Random   ................... */
/obj/effect/spawner/map_spawner/catacomb_random
	icon_state = "srat"
	icon = 'icons/roguetown/mob/monster/rat.dmi'
	probby = 50
	color = "#ffce0b"
	spawned = list(
		/obj/item/coin/silver = 5,
		/obj/item/clothing/pants/trou = 2,
		/obj/item/flashlight/flare/torch/lantern = 1,
		/obj/item/natural/worms = 20,
		/obj/item/reagent_containers/food/snacks/smallrat = 5,
		/obj/item/reagent_containers/food/snacks/smallrat/dead = 5,
		/obj/structure/idle_enemy/bigrat = 1,
		)

/* Ide enemy structures use the new range var in the spawner to only try spawning if a mob containing a mind is inside the
range. How much processing this saves is unclear */
/*	..................   Big Rat Spawner   ................... */
/obj/structure/idle_enemy/bigrat
/obj/structure/idle_enemy/bigrat/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/bigrat)
/datum/component/spawner/bigrat
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/bigrat)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""

/*	..................   Weak Skelly Spawner   ................... */
/obj/structure/idle_enemy/weak_skelly
/obj/structure/idle_enemy/weak_skelly/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/weak_skelly)
/datum/component/spawner/weak_skelly
//	mob_types = list(/mob/living/carbon/human/species/skeleton/skilled/unarmed)
	mob_types = list(/mob/living/simple_animal/hostile/skeleton)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""
