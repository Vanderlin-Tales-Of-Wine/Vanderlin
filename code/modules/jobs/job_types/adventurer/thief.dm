/datum/job/thief
	title = "Thief"
	flag = ADVENTURER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 5
	spawn_positions = 5

	tutorial = "<br>Maybe you were an orphan taken in by the matron. Maybe you're an ex-bandit looking to lie low. Or just maybe, you've recognized how broken this world is, and the tyranny of nobility. Whatever the reason, it's landed you in the sewers - the Thieves Guild to be precise.<br><br> \
	You and your syndicate are responsible for the underworld activities of Vanderlin. Stealing, fencing, intimidation, drug dealing, kidnapping - the possibilities for profit are nearly endless... so long as you're not caught.<br>"
	display_order = JDO_THIEF
	bypass_lastclass = TRUE
	min_pq = 8
	shows_in_list = FALSE
	allowed_races = ALL_PLAYER_RACES_BY_NAME
	advclass_cat_rolls = list(CTAG_THIEF = 20)
	job_reopens_slots_on_death = FALSE
	always_show_on_latechoices = TRUE

	wanderer_examine = TRUE


	outfit = /datum/outfit/job/thief
	cmode_music = 'sound/music/cmode/adventurer/CombatRogue.ogg'

/datum/outfit/job/thief
	pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/boots
	backr = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/storage/belt/pouch/coins/poor

/datum/job/thief/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

		if(GLOB.thieves_guild_doors.len > 0)
			addtimer(CALLBACK(src, PROC_REF(know_password), H), 50)

/datum/job/thief/proc/know_password(mob/living/carbon/human/H)
	var/obj/structure/mineral_door/secret/D = GLOB.thieves_guild_doors[1]
	to_chat(H, span_notice("The Thieves Guild Door Password is: '[D.get_open_phrase()]'"))


/datum/advclass/thief/rogue
	name = "Rogue"
	tutorial = "You're a standard thief. Light on your feet, and trained with a lockpick and your dagger. You handle most of the inconspicuous operations outside the guild. Just see to it you're not caught doing so, and, of course, you don't lure trouble back to the guild."
	outfit = /datum/outfit/job/thief/rogue
	category_tags = list(CTAG_THIEF)
	maximum_possible_slots = 3

/datum/outfit/job/thief/rogue/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, pick(0,0,1), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
	shirt = /obj/item/clothing/shirt/undershirt/black
	gloves = /obj/item/clothing/gloves/fingerless
	beltr = /obj/item/weapon/mace/cudgel // TEMP until I make a blackjack- for now though this will do.
	backpack_contents = list(/obj/item/lockpick, /obj/item/weapon/knife/dagger/steel, /obj/item/key/thieves_guild)
	ADD_TRAIT(H, TRAIT_THIEVESGUILD, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LIGHT_STEP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, type)
	H.change_stat(STATKEY_STR, -2)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_SPD, 2)
	H.grant_language(/datum/language/thievescant)
	to_chat(H, "<span class='info'>I can gesture in thieves' cant with ,t before my speech.</span>")

/datum/outfit/job/thief/rogue/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(H)
		// Give them their cloak- as well as the ability to choose what color they want.
		var/obj/item/clothing/cloak/raincloak/thiefcloak = new()
		thiefcloak.color = get_thief_color(H)
		H.equip_to_slot(thiefcloak, SLOT_CLOAK, TRUE)

		var/obj/item/clothing/head/roguehood/thiefhood = new()
		thiefhood.color = thiefcloak.color
		H.equip_to_slot(thiefhood, SLOT_HEAD, TRUE)

		var/obj/item/clothing/face/shepherd/clothmask/thiefmask = new()
		thiefmask.color = thiefcloak.color
		H.equip_to_slot(thiefmask, SLOT_WEAR_MASK, TRUE)
		thiefmask.ToggleHood()


/datum/advclass/thief/ruffian
	name = "Blackguard"
	tutorial = "Subtle was never your approach. That's why you're down in the sewers instead of the rooftops. You're in charge of the underworld operations. From serving drinks, to fencing, to taking job offers... to keeping undesirables the fuck out of your bar. You're the only line of defense. Try to make sure things stay clandestine, aye?"
	outfit = /datum/outfit/job/thief/ruffian
	category_tags = list(CTAG_THIEF)
	maximum_possible_slots = 3

/datum/outfit/job/thief/ruffian/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
	neck = /obj/item/clothing/neck/gorget
	armor = /obj/item/clothing/armor/cuirass/iron
	shirt = /obj/item/clothing/shirt/undershirt/black
	gloves = /obj/item/clothing/gloves/angle
	beltr = /obj/item/weapon/mace/steel/morningstar
	backl = /obj/item/weapon/shield/tower/buckleriron
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel, /obj/item/key/thieves_guild)

	ADD_TRAIT(H, TRAIT_THIEVESGUILD, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LIGHT_STEP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, type)
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_END, 1)
	H.grant_language(/datum/language/thievescant)
	to_chat(H, "<span class='info'>I can gesture in thieves' cant with ,t before my speech.</span>")

/datum/outfit/job/thief/ruffian/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(H)
		var/obj/item/clothing/cloak/cape/thief/thiefcape = new()
		thiefcape.color = get_thief_color(H)
		H.equip_to_slot(thiefcape, SLOT_CLOAK, TRUE)

		var/obj/item/clothing/head/headband/thiefhood = new()
		thiefhood.color = thiefcape.color
		H.equip_to_slot(thiefhood, SLOT_HEAD, TRUE)

		var/obj/item/clothing/face/shepherd/clothmask/thiefmask = new()
		thiefmask.color = thiefcape.color
		H.equip_to_slot(thiefmask, SLOT_WEAR_MASK, TRUE)
		thiefmask.ToggleHood()

/datum/advclass/thief/cutthroat
	name = "Cutthroat"
	tutorial = "Not everyone has the luxury of the clergy or the clinic. This is where you come in. You never went to school to become a doctor, but that didn't stop you from trying anyway. You serve as the guild's physicker, as well as their cook. You've also learned the ways of drug production and are capable of doing so for your clientelle."
	outfit = /datum/outfit/job/thief/cutthroat
	category_tags = list(CTAG_THIEF)
	maximum_possible_slots = 1

/datum/outfit/job/thief/cutthroat/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/bombs, 2 TRUE)
	neck = /obj/item/clothing/neck/phys
	armor = /obj/item/clothing/armor/leather/jacket/apothecary
	gloves = /obj/item/clothing/gloves/leather/phys
	beltr = /obj/item/weapon/mace/cudgel // TEMP until I make a blackjack- for now though this will do.
	backl = /obj/item/storage/backpack/satchel/surgbag
	backpack_contents = list(/obj/item/natural/cloth = 2, /obj/item/key/thieves_guild, /obj/item/weapon/knife/dagger/steel)
	ADD_TRAIT(H, TRAIT_THIEVESGUILD, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LIGHT_STEP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, type)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
	H.change_stat(STATKEY_INT, 3)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_PER, 1)
	if(H.age == AGE_OLD)
		H.change_stat("speed", -1)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 1)
	H.grant_language(/datum/language/thievescant)
	to_chat(H, "<span class='info'>I can gesture in thieves' cant with ,t before my speech.</span>")

/datum/outfit/job/thief/cutthroat/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(H)
		var/obj/item/clothing/shirt/tunic/thiefcloak = new()
		thiefcloak.color = get_thief_color(H)
		H.equip_to_slot(thiefcloak, SLOT_SHIRT, TRUE)

		var/obj/item/clothing/face/shepherd/clothmask/thiefmask = new()
		thiefmask.color = thiefcloak.color
		H.equip_to_slot(thiefmask, SLOT_WEAR_MASK, TRUE)
		thiefmask.ToggleHood()


/datum/outfit/job/thief/proc/get_thief_color(mob/living/carbon/human/H)
	var/list/thief_colors = list("Bleached White"	="#FFFFFF")
	thief_colors |= GLOB.peasant_dyes
	thief_colors |= GLOB.noble_dyes
	var/color_selection = input(H,"What color was I again?","Thief Color","Ash Grey") in thief_colors
	return thief_colors[color_selection]

