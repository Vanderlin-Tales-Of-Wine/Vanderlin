/datum/migrant_role/sk/haiduk/khan
	name = "Haiduk Khan"
	greet_text = "The Haiduks are a unstable collection of tribes composed of outcasts and riffraff, held together by personal oaths of loyalty and wealth from plundering and slaving. Often seen serving vampire lords."
	allowed_sexes = list(MALE)
	allowed_races = list(
		"Humen",
		"Ogrun",
		"Undine"
	)
	outfit = /datum/outfit/job/sk_migration/haiduk/khan
	grant_lit_torch = FALSE

/datum/migrant_role/sk/haiduk/after_spawn(mob/living/carbon/human/character)
	. = ..()
	character.forceMove(pick(GLOB.bogevil_starts))

/datum/outfit/job/sk_migration/haiduk/khan/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/boots/furlinedboots
	wrists = /obj/item/clothing/wrists/bracers
	head = /obj/item/clothing/head/helmet/horned
	r_hand = /obj/item/weapon/whip
	neck = /obj/item/clothing/neck/coif
	armor = /obj/item/clothing/armor/cuirass/iron/rust
	cloak = /obj/item/clothing/cloak/raincloak/furcloak
	gloves =  /obj/item/clothing/gloves/angle
	belt = /obj/item/storage/belt/leather/rope/survival
	beltl = /obj/item/flashlight/flare/torch/lantern/bronzelamptern
	beltr = /obj/item/weapon/axe/battle/ono
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/weapon/mace/goden/kanabo
	pants = /obj/item/clothing/pants/trou/leather/heavy
	backpack_contents = list(/obj/item/flint = 1, /obj/item/reagent_containers/food/snacks/fat/salo = 1, /obj/item/sleepingbag = 1)

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)

		H.change_stat(STATKEY_STR, 3)
		H.change_stat(STATKEY_END, 3)
		H.change_stat(STATKEY_CON, 3)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Khan"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"
		H.mind?.AddSpell(new /obj/effect/proc_holder/spell/self/barbrage)
		H.set_patron(/datum/patron/inhumen/graggar)
		H.cmode_music = 'sound/music/cmode/unused/combat_barbarian.ogg'


/datum/migrant_role/sk/haiduk/raider
	name = "Haiduk Raider"
	greet_text = "A brutal warrior."
	allowed_sexes = list(MALE)
	allowed_races = list(
		"Humen",
		"Ogrun",
		"Undine"
	)
	outfit = /datum/outfit/job/sk_migration/haiduk/raider
	grant_lit_torch = TRUE

/datum/outfit/job/sk_migration/haiduk/raider/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/boots/furlinedboots
	wrists = /obj/item/clothing/wrists/bracers
	head = /obj/item/clothing/head/helmet/leather/malgai
	r_hand = /obj/item/weapon/sword/scimitar/haiduk
	armor = /obj/item/clothing/armor/leather/hide
	cloak = /obj/item/clothing/cloak/wickercloak
	belt = /obj/item/storage/belt/leather/rope/survival
	beltl = /obj/item/ammo_holder/quiver/arrows
	beltr = /obj/item/weapon/knife/stone
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	pants = /obj/item/clothing/pants/trou/leather

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/taming, 1, TRUE)

		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_CON, 2)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		H.mind?.AddSpell(new /obj/effect/proc_holder/spell/self/barbrage)
		H.set_patron(/datum/patron/inhumen/graggar)
		H.cmode_music = 'sound/music/cmode/unused/combat_barbarian.ogg'



/datum/migrant_wave/haiduk_raiders
	name = "The Haiduk Raiders"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/evil_knight,/datum/migrant_wave/haiduk_raiders)
	weight = 25
	downgrade_wave = /datum/migrant_wave/haiduk_raiders_down
	roles = list(
		/datum/migrant_role/sk/haiduk/khan = 1,
		/datum/migrant_role/sk/haiduk/raider = 3)
	greet_text = "Haiduk Raiders appear! They may plunder, slave or sell their swords as mercenaries, who knows..."

/datum/migrant_wave/haiduk_raiders_down
	name = "The Haiduk Raiders"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/evil_knight,/datum/migrant_wave/haiduk_raiders)
	can_roll = FALSE
	downgrade_wave = /datum/migrant_wave/haiduk_raiders_down_last
	roles = list(
		/datum/migrant_role/sk/haiduk/khan = 1,
		/datum/migrant_role/sk/haiduk/raider = 2)
	greet_text = "Haiduk Raiders appear! They may plunder, slave or sell their swords as mercenaries, who knows..."


/datum/migrant_wave/haiduk_raiders_down_last
	name = "The Haiduk Raiders"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/evil_knight,/datum/migrant_wave/haiduk_raiders)
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/sk/haiduk/khan = 1,
		/datum/migrant_role/sk/haiduk/raider = 1)
	greet_text = "Haiduk Raiders appear! They may plunder, slave or sell their swords as mercenaries, who knows..."

/obj/item/weapon/sword/scimitar/haiduk
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/chop)
	name = "chopper"
	desc = "A crude iron blade made by unskilled smiths. Used both as a weapon and a tool by the Haiduk raiders."
	icon = 'modular/stonekeep/icons/weapons.dmi'
	icon_state = "haiduk"
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/axe/chop)
	smeltresult = /obj/item/ingot/iron

/obj/item/storage/belt/leather/rope/survival
	populate_contents = list(
		/obj/item/natural/cloth,
	)

