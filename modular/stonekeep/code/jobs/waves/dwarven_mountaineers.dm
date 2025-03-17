/datum/migrant_role/sk/dwarf_mountaineers/mountaineer
	name = "Mountaineer"
	greet_text = "You are a member of a dwarven's expedition, here to make contact with your kin in the Outpost northeast of the hamlet, and help secure your clans influence in the region."
	outfit = /datum/outfit/job/sk_migration/dwarven_company/mountaineer
	allowed_races = list("Dwarf")
	grant_lit_torch = TRUE
	is_foreigner = FALSE

/datum/migrant_role/sk/dwarf_mountaineers/after_spawn(mob/living/carbon/human/character)
	. = ..()
	character.forceMove(pick(GLOB.mountainroad_starts))

/datum/outfit/job/sk_migration/dwarven_company/mountaineer/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/smelting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
	head = /obj/item/clothing/head/helmet/ironpot
	neck = /obj/item/clothing/neck/coif/cloth
	armor = /obj/item/clothing/armor/chainmail/iron
	pants = /obj/item/clothing/pants/trou
	shoes = /obj/item/clothing/shoes/boots/leather
	shirt = /obj/item/clothing/shirt/shortshirt
	r_hand = /obj/item/weapon/pick/paxe
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/storage/belt/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	backl = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather/rope
	backpack_contents = list(/obj/item/weapon/knife/hunting = 1, /obj/item/rope = 1,/obj/item/natural/cloth = 1, /obj/item/sleepingbag = 1)
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_END, 2)



/datum/migrant_wave/dwarf_mountaineers
	name = "Dwarven Expedition"
	max_spawns = 4
	shared_wave_type = /datum/migrant_wave/dwarf_mountaineers
	downgrade_wave = /datum/migrant_wave/dwarf_mountaineers_down_one
	weight = 15
	roles = list(
	/datum/migrant_role/sk/dwarf_mountaineers/mountaineer = 3
	)
	greet_text = "Stake a claim for your clan in these lands."

/datum/migrant_wave/dwarf_mountaineers_down_one
	name = "Dwarven Expedition"
	max_spawns = 4
	shared_wave_type = /datum/migrant_wave/dwarf_mountaineers
	downgrade_wave = /datum/migrant_wave/dwarf_mountaineers_down_two
	can_roll = FALSE
	roles = list(
	/datum/migrant_role/sk/dwarf_mountaineers/mountaineer = 2
	)
	greet_text = "Stake a claim for your clan in these lands."

/datum/migrant_wave/dwarf_mountaineers_down_two
	name = "Dwarven Expedition"
	max_spawns = 4
	shared_wave_type = /datum/migrant_wave/dwarf_mountaineers
	can_roll = FALSE
	roles = list(
	/datum/migrant_role/sk/dwarf_mountaineers/mountaineer = 1
	)
	greet_text = "Stake a claim for your clan in these lands."


