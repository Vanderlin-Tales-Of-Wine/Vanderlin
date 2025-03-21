/datum/advclass/combat/sk/bulwark
	name = "Immortal Bulwark"
	tutorial = "You have marched and fought in formations since the ancient war that nearly destroyed Psydonia. There are few in the world who can match your expertise in a shield wall, but all you have ever known is battle and obedience..."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list("Aasimar")
	outfit = /datum/outfit/job/sk/adventurer/bulwark
	maximum_possible_slots = 1
	pickprob = 10
	category_tags = list(CTAG_ADVENTURER)
	min_pq = 0
	cmode_music = 'sound/music/cmode/adventurer/CombatIntense.ogg'


/datum/outfit/job/sk/adventurer/bulwark/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 2)
		H.change_stat("speed", -1)

	// Despite extensive combat experience, this class is exceptionally destitute. The only luxury besides combat gear that it possesses is a lantern for a source of light
	// Beneath the arms and armor is a simple loincloth, and it doesn't start with any money. This should encourage them to find someone to serve or work alongside with very quickly
	pants = /obj/item/clothing/pants/loincloth/brown
	beltr = /obj/item/flashlight/flare/torch/lantern
	shoes = /obj/item/clothing/shoes/hoplite
	cloak = /obj/item/clothing/cloak/half/red
	belt = /obj/item/storage/belt/leather/rope
	armor = /obj/item/clothing/armor/rare/hoplite
	head = /obj/item/clothing/head/rare/hoplite
	wrists = /obj/item/clothing/wrists/bracers/hoplite
	neck = /obj/item/clothing/neck/gorget/hoplite
	backl = /obj/item/weapon/shield/tower/hoplite
	var/weapontype = pickweight(list("Khopesh" = 5, "Spear" = 3, "WingedSpear" = 2)) // Rolls for various weapon options based on weighted list
	switch(weapontype) // We either get a spear (winged or regular), or a khopesh sword. The weapon we get is what we get our training in
		if("Khopesh")
			beltl = /obj/item/weapon/sword/khopesh
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		if("Spear")
			backr = /obj/item/weapon/polearm/spear/hoplite
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		if("WingedSpear")
			backr = /obj/item/weapon/polearm/spear/hoplite/winged
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
