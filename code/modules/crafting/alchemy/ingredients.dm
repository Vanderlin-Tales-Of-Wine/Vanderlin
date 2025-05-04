/obj/item/alch
	name = "dust"
	desc = ""
	icon = 'icons/roguetown/misc/alchemy.dmi'
	icon_state = "irondust"
	w_class = WEIGHT_CLASS_TINY
	/*
		So, you're here about potions: TLDR - the cauldron takes up to 4 items, from this, makes 1 recipe. Major gives 3 points, med 2 points,minor 1 point.
		If no recipe gets above 5 points, it makes nothing,otherwise It then makes the recipe with the HIGHEST POINTS.
		all 3 of the below variables should be NULL or the type-path of the recipe to make.
	*/
	var/major_pot = null
	var/med_pot = null
	var/minor_pot = null
	//Dont worry, these 3 are just to cache the 'smell' of their pot on initialization to not have to re-look every examine.
	//No need to set them.
	var/major_smell
	var/med_smell
	var/minor_smell
	///Same as the smells, just caching what the potion name is
	var/major_name
	var/med_name
	var/minor_name

/obj/item/alch/Initialize()
	. = ..()
	if(!isnull(major_pot))
		var/datum/alch_cauldron_recipe/rec = locate(major_pot) in GLOB.alch_cauldron_recipes
		major_smell = rec.smells_like
		major_name = rec.recipe_name
	if(!isnull(med_pot))
		var/datum/alch_cauldron_recipe/rec = locate(med_pot) in GLOB.alch_cauldron_recipes
		med_smell = rec.smells_like
		med_name = rec.recipe_name
	if(!isnull(minor_pot))
		var/datum/alch_cauldron_recipe/rec = locate(minor_pot) in GLOB.alch_cauldron_recipes
		minor_smell = rec.smells_like
		minor_name = rec.recipe_name

/obj/item/alch/examine(mob/user)
	. = ..()
	if(user.mind)
		var/alch_skill = user.mind.get_skill_level(/datum/skill/craft/alchemy)
		var/perint = 0
		if(isliving(user))
			var/mob/living/lmob = user
			perint = FLOOR((lmob.STAPER + lmob.STAINT)/2,1)
		if(HAS_TRAIT(user,TRAIT_LEGENDARY_ALCHEMIST))
			if(!isnull(major_name))
				. += span_notice(" Strongly attuned to making [major_name].")
			if(!isnull(med_name))
				. += span_notice(" Moderately attuned to making [med_name].")
			if(!isnull(minor_name))
				. += span_notice(" Minorly attuned to making [minor_name].")
		else
			if(!isnull(major_smell))
				if(alch_skill >= SKILL_LEVEL_NOVICE || perint >= 6)
					. += span_notice(" Smells strongly of [major_smell].")
			if(!isnull(med_smell))
				if(alch_skill >= SKILL_LEVEL_APPRENTICE || perint >= 10)
					. += span_notice(" Smells slightly of [med_smell].")
			if(!isnull(minor_smell))
				if(alch_skill >= SKILL_LEVEL_EXPERT || perint >= 16)
					. += span_notice(" Smells weakly of [minor_smell].")
/obj/item/alch/viscera
	name = "viscera"
	icon_state = "viscera"
	major_pot = /datum/alch_cauldron_recipe/big_health_potion
	med_pot = /datum/alch_cauldron_recipe/health_potion
	minor_pot = /datum/alch_cauldron_recipe/antidote

/obj/item/alch/waterdust
	name = "water essentia"
	icon_state = "water_runedust"
	major_pot = /datum/alch_cauldron_recipe/int_potion
	med_pot = /datum/alch_cauldron_recipe/big_mana_potion
	minor_pot = /datum/alch_cauldron_recipe/per_potion

/obj/item/alch/bonemeal
	name = "bone meal"
	icon_state = "bonemeal"
	major_pot = /datum/alch_cauldron_recipe/mana_potion
	med_pot = /datum/alch_cauldron_recipe/per_potion
	minor_pot = /datum/alch_cauldron_recipe/antidote

/obj/item/alch/seeddust
	name = "seed dust"
	icon_state = "seeddust"
	major_pot = /datum/alch_cauldron_recipe/big_stamina_potion
	med_pot = /datum/alch_cauldron_recipe/stamina_potion
	minor_pot = /datum/alch_cauldron_recipe/disease_cure

/obj/item/alch/runedust
	name = "raw essentia"
	icon_state = "runedust"
	major_pot = /datum/alch_cauldron_recipe/int_potion
	med_pot = /datum/alch_cauldron_recipe/big_mana_potion
	minor_pot = /datum/alch_cauldron_recipe/per_potion

/obj/item/alch/coaldust
	name = "coal dust"
	icon_state = "coaldust"
	major_pot = /datum/alch_cauldron_recipe/antidote
	med_pot = /datum/alch_cauldron_recipe/end_potion
	minor_pot = /datum/alch_cauldron_recipe/str_potion

/obj/item/alch/silverdust
	name = "silver dust"
	icon_state = "silverdust"
	major_pot = /datum/alch_cauldron_recipe/disease_cure
	med_pot = /datum/alch_cauldron_recipe/antidote
	minor_pot = /datum/alch_cauldron_recipe/big_health_potion

/obj/item/alch/magicdust
	name = "pure essentia"
	icon_state = "magic_runedust"
	major_pot = /datum/alch_cauldron_recipe/big_mana_potion
	med_pot = /datum/alch_cauldron_recipe/end_potion
	minor_pot = /datum/alch_cauldron_recipe/con_potion

/obj/item/alch/firedust
	name = "fire essentia"
	icon_state = "fire_runedust"
	major_pot = /datum/alch_cauldron_recipe/str_potion
	med_pot = /datum/alch_cauldron_recipe/con_potion
	minor_pot = /datum/alch_cauldron_recipe/spd_potion

/obj/item/alch/sinew
	name = "sinew"
	icon_state = "sinew"
	dropshrink = 0.9
	major_pot = /datum/alch_cauldron_recipe/stam_poison
	med_pot = /datum/alch_cauldron_recipe/end_potion
	minor_pot = /datum/alch_cauldron_recipe/health_potion

/obj/item/alch/irondust
	name = "iron dust"
	icon_state = "irondust"
	major_pot = /datum/alch_cauldron_recipe/end_potion
	med_pot = /datum/alch_cauldron_recipe/con_potion
	minor_pot = /datum/alch_cauldron_recipe/str_potion

/obj/item/alch/airdust
	name = "air essentia"
	icon_state = "air_runedust"
	major_pot = /datum/alch_cauldron_recipe/spd_potion
	med_pot = /datum/alch_cauldron_recipe/stamina_potion
	minor_pot = /datum/alch_cauldron_recipe/int_potion

/obj/item/alch/swampdust
	name = "swampweed dust"
	icon_state = "swampdust"
	major_pot = /datum/alch_cauldron_recipe/berrypoison
	med_pot = /datum/alch_cauldron_recipe/big_stam_poison
	minor_pot = /datum/alch_cauldron_recipe/end_potion

/obj/item/alch/tobaccodust
	name = "westleach dust"
	icon_state = "tobaccodust"
	major_pot = /datum/alch_cauldron_recipe/per_potion
	med_pot = /datum/alch_cauldron_recipe/stamina_potion
	minor_pot = /datum/alch_cauldron_recipe/spd_potion

/obj/item/alch/earthdust
	name = "earth essentia"
	icon_state = "earth_runedust"
	major_pot = /datum/alch_cauldron_recipe/con_potion
	med_pot = /datum/alch_cauldron_recipe/end_potion
	minor_pot = /datum/alch_cauldron_recipe/str_potion

/obj/item/alch/bone
	name = "tail bone"
	icon_state = "bone"
	desc = "The only bone in creachers with alchemical properties."
	force = 7
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL

	major_pot = /datum/alch_cauldron_recipe/disease_cure
	med_pot = /datum/alch_cauldron_recipe/health_potion
	minor_pot = /datum/alch_cauldron_recipe/con_potion
	grid_height = 32
	grid_width = 32

	attunement_values = list(
		/datum/attunement/death = 0.05,
		/datum/attunement/life = -0.1,
		/datum/attunement/light = -0.1,
	)

/obj/item/alch/horn
	name = "troll horn"
	icon_state = "horn"
	desc = "The horn of a bog troll."
	force = 7
	throwforce = 5
	w_class = WEIGHT_CLASS_NORMAL

	major_pot = /datum/alch_cauldron_recipe/str_potion
	med_pot = /datum/alch_cauldron_recipe/con_potion
	minor_pot = /datum/alch_cauldron_recipe/end_potion
	grid_width = 64
	grid_height = 64

/obj/item/alch/golddust
	name = "gold dust"
	icon_state = "golddust"

	major_pot = /datum/alch_cauldron_recipe/mana_potion
	med_pot = /datum/alch_cauldron_recipe/con_potion
	minor_pot = /datum/alch_cauldron_recipe/per_potion

/obj/item/alch/feaudust
	name = "feau dust"
	icon_state = "feaudust"

	major_pot = /datum/alch_cauldron_recipe/spd_potion
	med_pot = /datum/alch_cauldron_recipe/big_mana_potion
	minor_pot = /datum/alch_cauldron_recipe/disease_cure

/obj/item/alch/ozium
	name = "alchemical ozium"
	desc = "Alchemical processing has left it unfit for consumption."
	icon_state = "darkredpowder"

	major_pot = /datum/alch_cauldron_recipe/big_stamina_potion
	med_pot = /datum/alch_cauldron_recipe/lck_potion
	minor_pot = /datum/alch_cauldron_recipe/int_potion

/obj/item/alch/transisdust
	name = "transis dust"
	desc = "A long mix of herb that product a special powder."
	icon_state = "transisdust"

	major_pot = /datum/alch_cauldron_recipe/gender_potion
	med_pot = /datum/alch_cauldron_recipe/gender_potion
	minor_pot = /datum/alch_cauldron_recipe/gender_potion

//BEGIN THE HERBS

/obj/item/alch/atropa
	name = "atropa"
	icon_state = "atropa"

	major_pot = /datum/alch_cauldron_recipe/doompoison
	med_pot = /datum/alch_cauldron_recipe/berrypoison
	minor_pot = /datum/alch_cauldron_recipe/stam_poison

/obj/item/alch/matricaria
	name = "matricaria"
	icon_state = "matricaria"

	major_pot = /datum/alch_cauldron_recipe/berrypoison
	med_pot = /datum/alch_cauldron_recipe/per_potion
	minor_pot = /datum/alch_cauldron_recipe/doompoison

/obj/item/alch/symphitum
	name = "symphitum"
	icon_state = "symphitum"

	major_pot = /datum/alch_cauldron_recipe/health_potion
	med_pot = /datum/alch_cauldron_recipe/stam_poison
	minor_pot = /datum/alch_cauldron_recipe/antidote

/obj/item/alch/taraxacum
	name = "taraxacum"
	icon_state = "taraxacum"

	major_pot = /datum/alch_cauldron_recipe/stam_poison
	med_pot = /datum/alch_cauldron_recipe/health_potion
	minor_pot = /datum/alch_cauldron_recipe/antidote

/obj/item/alch/euphrasia
	name = "euphrasia"
	icon_state = "euphrasia"

	major_pot = /datum/alch_cauldron_recipe/spd_potion
	med_pot = /datum/alch_cauldron_recipe/stam_poison
	minor_pot = /datum/alch_cauldron_recipe/int_potion

/obj/item/alch/paris
	name = "paris"
	icon_state = "paris"

	major_pot = /datum/alch_cauldron_recipe/big_stam_poison
	med_pot = /datum/alch_cauldron_recipe/berrypoison
	minor_pot = /datum/alch_cauldron_recipe/stam_poison

/obj/item/alch/calendula
	name = "calendula"
	icon_state = "calendula"

	major_pot = /datum/alch_cauldron_recipe/big_health_potion
	med_pot = /datum/alch_cauldron_recipe/end_potion
	minor_pot = /datum/alch_cauldron_recipe/health_potion

/obj/item/alch/mentha
	name = "mentha"
	icon_state = "mentha"

	major_pot = /datum/alch_cauldron_recipe/per_potion
	med_pot = /datum/alch_cauldron_recipe/int_potion
	minor_pot = /datum/alch_cauldron_recipe/stamina_potion

/obj/item/alch/urtica
	name = "urtica"
	icon_state = "urtica"

	major_pot = /datum/alch_cauldron_recipe/health_potion
	med_pot = /datum/alch_cauldron_recipe/spd_potion
	minor_pot = /datum/alch_cauldron_recipe/stamina_potion

/obj/item/alch/salvia
	name = "salvia"
	icon_state = "salvia"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head_items.dmi'
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	body_parts_covered = NONE
	w_class = WEIGHT_CLASS_TINY
	alternate_worn_layer  = 8.9 //On top of helmet

	major_pot = /datum/alch_cauldron_recipe/con_potion
	med_pot = /datum/alch_cauldron_recipe/str_potion
	minor_pot = /datum/alch_cauldron_recipe/end_potion

/obj/item/alch/rosa
	name = "rosa"
	icon_state = "rosa"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head_items.dmi'
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK|ITEM_SLOT_MOUTH
	body_parts_covered = NONE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	alternate_worn_layer  = 8.9 //On top of helmet

	major_pot = /datum/alch_cauldron_recipe/rosawater_potion
	med_pot = /datum/alch_cauldron_recipe/end_potion
	minor_pot = /datum/alch_cauldron_recipe/antidote

/obj/item/alch/rosa/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == SLOT_MOUTH)
		icon_state = "rosa_mouth"
		user.update_inv_mouth()
	else
		icon_state = "rosa"
		user.update_icon()

/obj/item/alch/hypericum
	name = "hypericum"
	icon_state = "hypericum"

	major_pot = /datum/alch_cauldron_recipe/stamina_potion
	med_pot = /datum/alch_cauldron_recipe/mana_potion
	minor_pot = /datum/alch_cauldron_recipe/antidote

/obj/item/alch/benedictus
	name = "benedictus"
	icon_state = "benedictus"

	major_pot = /datum/alch_cauldron_recipe/big_stamina_potion
	med_pot = /datum/alch_cauldron_recipe/stamina_potion
	minor_pot = /datum/alch_cauldron_recipe/int_potion

/obj/item/alch/valeriana
	name = "valeriana"
	icon_state = "valeriana"

	major_pot = /datum/alch_cauldron_recipe/health_potion
	med_pot = /datum/alch_cauldron_recipe/spd_potion
	minor_pot = /datum/alch_cauldron_recipe/stam_poison

/obj/item/alch/artemisia
	name = "artemisia"
	icon_state = "artemisia"

	major_pot = /datum/alch_cauldron_recipe/lck_potion
	med_pot = /datum/alch_cauldron_recipe/spd_potion
	minor_pot = /datum/alch_cauldron_recipe/health_potion

//dust mix crafting
/datum/crafting_recipe/alch/feaudust
	name = "feau dust"
	result = list(/obj/item/alch/feaudust,
				/obj/item/alch/feaudust)
	reqs = list(/obj/item/alch/irondust = 1,
				/obj/item/alch/golddust = 1)
	structurecraft = /obj/structure/table
	verbage = "mix"
	verbage_tp = "mixes"
	craftsound = 'sound/foley/scribble.ogg'
	skillcraft = /datum/skill/craft/alchemy
	craftdiff = 2

/datum/crafting_recipe/alch/magicdust
	name = "magic dust"
	result = list(/obj/item/alch/magicdust)
	reqs = list(/obj/item/alch/waterdust = 1, /obj/item/alch/firedust = 1,
				/obj/item/alch/airdust = 1, /obj/item/alch/earthdust = 1)
	structurecraft = /obj/structure/table
	verbage = "mix"
	verbage_tp = "mixes"
	craftsound = 'sound/foley/scribble.ogg'
	skillcraft = /datum/skill/craft/alchemy
	craftdiff = 3

/datum/crafting_recipe/alch/transistus
	name = "transis dust"
	result = /obj/item/alch/transisdust
	reqs = list(/obj/item/alch/artemisia = 1,
		/obj/item/alch/benedictus = 1,
		/obj/item/alch/hypericum = 1,
		/obj/item/alch/salvia = 1,
		/obj/item/alch/atropa = 1,
		/obj/item/alch/taraxacum =1)
	structurecraft = /obj/structure/table
	verbage = "mix"
	verbage_tp = "mixes"
	skillcraft = /datum/skill/craft/alchemy
	craftdiff = 4
