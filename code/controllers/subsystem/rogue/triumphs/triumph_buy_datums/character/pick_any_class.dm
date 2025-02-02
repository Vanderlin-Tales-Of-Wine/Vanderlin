/datum/triumph_buy/pick_any_class
	triumph_buy_id = "PickAny"
	desc = "Get single run of a class that can pick any class BYPASSING CLASS RESTRICTIONS on any class selection! WARNING: MAY BE BUGGY"
	triumph_cost = 20
	category = TRIUMPH_CAT_CHARACTER
	pre_round_only = FALSE
	visible_on_active_menu = TRUE

// We fire this on activate, also DAMN is this nasty
/datum/triumph_buy/pick_any_class/on_activate()
	if(!SSrole_class_handler.special_session_queue[ckey_of_buyer])
		SSrole_class_handler.special_session_queue[ckey_of_buyer] = list()

	var/datum/advclass/pick_everything/turbo_slop
	if(!SSrole_class_handler.special_session_queue[ckey_of_buyer][triumph_buy_id])
		turbo_slop = new()
		turbo_slop.maximum_possible_slots = 1
		SSrole_class_handler.special_session_queue[ckey_of_buyer][triumph_buy_id] = turbo_slop
	else
		turbo_slop = SSrole_class_handler.special_session_queue[ckey_of_buyer][triumph_buy_id]
		turbo_slop.maximum_possible_slots += 1

// It should be there you know? lol
// If not we are desyncing somehow
/datum/triumph_buy/pick_any_class/on_removal()
	SSrole_class_handler.special_session_queue[ckey_of_buyer].Remove(triumph_buy_id)


//For triumph buy pick-all
/datum/advclass/pick_everything
	name = "Pick-Classes"
	tutorial = "This will open up another menu when you spawn allowing you to pick from any class as long as its not disabled."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
	"Humen",
	"Elf",
	"Half-Elf",
	"Dwarf",
	"Tiefling",
	"Dark Elf",
	"Aasimar",
	"Half-Orc"
	)
	maximum_possible_slots = 0

	outfit = null

/datum/advclass/pick_everything/post_equip(mob/living/carbon/human/H)
	..()
	var/list/possible_classes = list()
	for(var/datum/advclass/CHECKS in SSrole_class_handler.sorted_class_categories[CTAG_ALLCLASS])
		if(CTAG_DISABLED in CHECKS.category_tags)
			continue
		// if(CTAG_MERCENARY in CHECKS.category_tags)
		// 	continue
		possible_classes += CHECKS

	var/datum/advclass/C = input(H.client, "What is my class?", "Adventure") as null|anything in possible_classes
	if(!C)
		C = pick(possible_classes)
	C.equipme(H)
