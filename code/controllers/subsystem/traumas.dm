SUBSYSTEM_DEF(traumas)
	name = "Traumas"
	flags = SS_NO_FIRE
	var/list/phobia_types
	var/list/phobia_words
	var/list/phobia_mobs
	var/list/phobia_objs
	var/list/phobia_turfs
	var/list/phobia_species

#define PHOBIA_FILE "phobia.json"

/datum/controller/subsystem/traumas/Initialize()
	//phobia types is to pull from randomly for brain traumas, e.g. conspiracies is for special assignment only
	phobia_types = sortList(list("spiders", "lizards",
						"skeletons", "snakes",
						"strangers", "birds", "falling", "anime"))

	phobia_words = list(
		"spiders"   = strings(PHOBIA_FILE, "spiders"),
		"lizards"   = strings(PHOBIA_FILE, "lizards"),
		"skeletons" = strings(PHOBIA_FILE, "skeletons"),
		"snakes"	= strings(PHOBIA_FILE, "snakes"),
		"strangers"	= strings(PHOBIA_FILE, "strangers"),
		"conspiracies" = strings(PHOBIA_FILE, "conspiracies"),
		"birds" = strings(PHOBIA_FILE, "birds"),
		"falling" = strings(PHOBIA_FILE, "falling"),
		"religion" = strings(PHOBIA_FILE, "religion")
	)

	phobia_mobs = list(
		"birds"            = typecacheof(list(/mob/living/simple_animal/parrot))
	)

	phobia_objs = list(
		"spiders"   = typecacheof(list(/obj/structure/spider)),

		"lizards"   = typecacheof(list(
									/obj/item/organ/tail/lizard)),

		"skeletons" = typecacheof(list(/obj/item/organ/tongue/bone, /obj/item/alch/bone,

										/obj/effect/decal/remains/human)),

	)

	phobia_species = list(
	)

	return ..()

#undef PHOBIA_FILE
