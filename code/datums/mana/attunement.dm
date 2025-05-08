GLOBAL_LIST_INIT(magic_attunements, create_attunement_list())
/// List of typepaths - to access the singletons, access magic attunements
GLOBAL_LIST_INIT(default_attunements, create_default_attunement_list())

/proc/create_attunement_list()
	. = list()

	var/list/typecache = typecacheof(/datum/attunement, ignore_root_path = TRUE)
	for (var/datum/attunement/typepath as anything in typecache)
		.[typepath] = new typepath

/proc/create_default_attunement_list()
	. = list()
	for (var/datum/attunement/iterated_attunement as anything in GLOB.magic_attunements)
		.[iterated_attunement] = 0 // make it an assoc list

// Not touching subtypes right now or compound attunements

/// The "attunement" a certain spell or piece of mana may have. When mana is consumed, it's attunements will be compared to the attunements of
/// what consumed it, and then the result will be used to generate how much mana will be actually consumed. Matching attunements decreases cost,
/// vice versa.
/datum/attunement
	var/name = "Base attunement"
	var/desc = "Some coder forgot to set desc"

	var/list/alignments = list() // no alignments by default

/datum/attunement/Destroy(force, ...)
	stack_trace("Destroy called on [src], [src.type], a singleton attunement instance!")
	if (!force)
		return QDEL_HINT_LETMELIVE //should not be deleted, ever
	// forced
	. = ..()

	GLOB.magic_attunements[src.type] = new src.type // recover

/// Should return how much we want the cost multiplier on a cast to be incremented by.
/// Inverse - Higher positive increments = lower cost, higher negative increments = higher cost
/datum/attunement/proc/get_bias_mult_increment(atom/caster)
	return 0

/datum/attunement/fire
	name = "Pyromancy"
	desc = "Perhaps the most well-known, and often many a mage's first study of the elements, pyromancy covers any heat or other flame related magic."

	alignments = list(
		/datum/patron/divine/astrata = 1,
		/datum/patron/inhumen/zizo = 0.25,
		/datum/patron/divine/noc = 0.15,
		/datum/patron/divine/malum = 1.2,
	)

/datum/attunement/ice
	name = "Cryomancy"
	desc = "Sibling and eternal rival of Pyromancy, Cryomancy centers on the manipulation of the cold, far beyond just water."

	alignments = list(
		/datum/patron/divine/noc = 1,
		/datum/patron/inhumen/zizo = 0.4,
	)

/datum/attunement/electric
	name = "Electric"
	desc = "An element typically associated with weather, sometimes with divinity, and often technology."

	alignments = list(
		/datum/patron/divine/noc = 0.25,
		/datum/patron/inhumen/zizo = 0.15,
		/datum/patron/divine/abyssor = 0.5,
	)

/datum/attunement/blood
	name = "Hydrosophy"
	desc = "The lifeblood of all organics, water is ubiquitous with any land, and is a core aspect of any town."

	alignments = list(
		/datum/patron/divine/abyssor = 2,
		/datum/patron/divine/pestra = 0.5,
		/datum/patron/divine/dendor = 0.5,
		/datum/patron/inhumen/zizo = 1,
		/datum/patron/inhumen/graggar = 2,
	)

/datum/attunement/life
	name = "Life"
	desc = "The driving force of, and most effectively seen in, all living matter. Life is the most far-reaching of all elements, with its effects seen across the lands."

	alignments = list(
		/datum/patron/divine/pestra = 1,
		/datum/patron/divine/astrata = 0.5,
		/datum/patron/inhumen/baotha = 1,
	)

/datum/attunement/death
	name = "Death"
	desc = "The energy that fuels the end of effectively all living matter."

	alignments = list(
		/datum/patron/divine/necra = 0.5,
		/datum/patron/inhumen/zizo = 0.5,
	)


/datum/attunement/earth
	name = "Earth"
	desc = "The very ground you stand on, a raging earthquake, or an paven roads, earth is all encompassing."

	alignments = list(
		/datum/patron/divine/dendor = 1.2,
		/datum/patron/divine/malum = 0.5,
		/datum/patron/divine/ravox = 1,
	)

/datum/attunement/light
	name = "Light"
	desc = "Light is the natural enemy of the dark."

	alignments = list(
		/datum/patron/divine/astrata = 0.15,
		/datum/patron/divine/noc = 0.15,
		/datum/patron/divine/necra = 0.15,
		/datum/patron/divine/xylix = 0.15,
		/datum/patron/divine/eora = 0.15,
		/datum/patron/divine/ravox = 0.15,
	)

/datum/attunement/dark
	name = "Dark"
	desc = "Able to subtract Light, combine with other elements, and manifest on its own."

	alignments = list(
		/datum/patron/inhumen/zizo = 0.15,
		/datum/patron/inhumen/baotha = 0.15,
		/datum/patron/inhumen/graggar = 0.15,
		/datum/patron/inhumen/matthios = 0.15,
	)

/datum/attunement/time
	name = "Time"
	desc = "A unique and nigh-impossible element to master by all but those with either endless lifespans, or non-euclidian existence. Measured by all civilizations, and the defining aspect of countless realms and systems."

	alignments = list(
		/datum/patron/divine/necra = 1,
		/datum/patron/divine/eora = 0.6,
		/datum/patron/inhumen/matthios = 0.75,
	)

/datum/attunement/aeromancy
	name = "Aeromancy"
	desc =  "Air, breathing, motion, and atmosphere. These are all products of aeromancy."

	alignments = list(
		/datum/patron/divine/abyssor = 0.5
	)

/datum/attunement/arcyne
	name = "Arcyne"
	desc = ""

	alignments = list(
		/datum/patron/divine/noc = 2,
		/datum/patron/inhumen/zizo = 1.2,
	)

/datum/attunement/illusion
	name = "Illusion"
	desc = ""

	alignments = list(
		/datum/patron/divine/xylix = 1,
	)

/datum/attunement/polymorph
	name = "Polymorph"
	desc = ""

	alignments = list(
		/datum/patron/divine/xylix = 1,
	)
