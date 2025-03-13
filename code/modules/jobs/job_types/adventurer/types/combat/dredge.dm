//shield sword
/datum/advclass/combat/dredge
	name = "Dredge"
	tutorial = "Peasants and nobles. Saints, sinners, madmen and thieves - who you once were is now irrelevant. \
	Cast from your home for what is undoubtedly a heinous act of violence, your travels have washed you up upon this \
	shiteheap. All you have are your possessions from your former life. Make some coin for yourself, lest you end up dead and gone."
	//tutorial = "You were once an average person - and yet, in your restless dreams, the ecstacy of gold has fettered your \
	mind to a tomb in a faraway land. Long have you traveled, and only now are you on the precipice of your own death. \
	Unbeknownst to you, a false god wants all of your mortal posessions. Your one life's goal is to die in the depths \
	of the Tomb of Matthios."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Dark Elf",
		"Tiefling",
		"Aasimar",
		"Half-Orc"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/dredge
	category_tags = list(CTAG_ADVENTURER)
	min_pq = 0


/datum/outfit/job/roguetown/adventurer/dredge/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, pick (1,2), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/shields, pick(2,3), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, pick(1,2), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, pick(1,2,3), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/riding, pick(1,1,2), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, pick(0,1), TRUE)

	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather
	pants = /obj/item/clothing/pants/tights/black
	backl = /obj/item/storage/backpack/satchel
	var/armortype = pickweight(list("Warrior" = 5, "Splint" = 5, "HeavyG" = 4, "Hide" = 3, "Jacket" = 3, "Ironplate" = 1, "Freak" = 3, "Psy" = 2, "Destitute" = 2, "Copper" = 1, "Noble" = 1)) // At best they can get an iron breastplate over mail and iron chainleggings
	var/weapontype = pickweight(list("Axe" = 3, "BigAxe" = 2, "Mace" = 3, "Mage" = 1, "Shield" = 1, "BigMace" = 2, "Spear" = 2, "Messer" = 2, "Shovel" = 1, "Falx" = 2, "Rapier" = 1, "Sword" = 3, "Sword2" = 2, "Flail" = 1, "Bow" = 1, "Fist" = 1, "Daggers" = 2, "MFlail" = 2,)) // Rolls for various weapons, all of these are iron tier
	var/randomjob = pickweight (list("Farmer" = 3, "Sailor" = 2, "Pickpocket" = 2, "Smith" = 2, "Fisher" = 3, "Doctor" = 2, "Steppes" = 2, "Smart" = 1, "Grappler" = 1, "Lumber" = 2, "Guard" = 2, "Bard" = 2, "Paranoiac" = 1,))
	var/randomperk = pickweight (list("Fat" = 3, "Cyclops" = 2, "Normal" = 3, "Packrat" = 2, "Strong" = 1, "Zizo" = 2, "Atheist" = 1, "Graggar" = 1, "Stupid" = 1, "Lockpicks" = 2, "Traps" = 2, "Ring" = 2, "Knives" = 2, "Heel" = 1, "Heel" = 2, "Invisible" = 2, "Bomb" = 1, "Blind" = 2,))
	switch(armortype)
		if("Warrior")
			armor = /obj/item/clothing/armor/chainmail/iron
			shirt = /obj/item/clothing/armor/gambeson
			gloves = /obj/item/clothing/gloves/leather
			pants = /obj/item/clothing/pants/tights/uncolored
			head = /obj/item/clothing/head/roguehood
			H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			to_chat(H,span_info("\
			I am a sellsword. A greenhorn, but a sellsword nonetheless.")
			)
		if("Ironplate")
			armor = /obj/item/clothing/armor/cuirass/iron
			shirt = /obj/item/clothing/armor/gambeson/heavy
			neck = /obj/item/clothing/neck/gorget
			pants = /obj/item/clothing/pants/tights/black
			head = /obj/item/clothing/head/roguehood
			H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.change_stat(STATKEY_END, -1)
			H.change_stat(STATKEY_STR, -1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			to_chat(H,span_info("\
			I am a sellsword by trade. I've held a weapon in my hand for longer than I can remember.")
			)
		if("Splint")
			armor = /obj/item/clothing/armor/leather/splint
			shirt = /obj/item/clothing/shirt/tunic/black
			wrists = /obj/item/clothing/wrists/bracers/leather
			pants = /obj/item/clothing/pants/tights/uncolored
			H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.change_stat(STATKEY_END, 1)
			to_chat(H,span_info("\
			Heavier armors do not suit my brand of mercenarywork.")
			)
		if("Jacket")
			armor = /obj/item/clothing/armor/leather/jacket
			neck = /obj/item/clothing/neck/coif
			shirt = /obj/item/clothing/shirt/tunic/red
			wrists = /obj/item/clothing/wrists/bracers/leather
			gloves = /obj/item/clothing/gloves/angle
			head = /obj/item/clothing/head/roguehood
			pants = /obj/item/clothing/pants/trou/leather
			H.change_stat(STATKEY_LCK, 1)
			H.change_stat(STATKEY_SPD, 1)
			H.change_stat(STATKEY_CON, -1)
			H.change_stat(STATKEY_STR, -1)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
			to_chat(H,span_info("\
			I'm a stone-cold motherfucker. Nothing fazes me.")
			)
		if("HeavyG")
			shirt = /obj/item/clothing/armor/gambeson/heavy
			neck = /obj/item/clothing/neck/chaincoif/iron
			gloves = /obj/item/clothing/gloves/leather/advanced
			wrists = /obj/item/clothing/wrists/bracers/leather
			pants = /obj/item/clothing/pants/trou/leather
			H.change_stat(STATKEY_STR, -1)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			to_chat(H,span_info("\
			I'm light on my feet, I dare somebody to try and hit me.")
			)
		if("Psy")
			neck = /obj/item/clothing/neck/psycross
			head = /obj/item/clothing/head/brimmed
			shirt = /obj/item/clothing/shirt/undershirt/puritan
			gloves = /obj/item/clothing/gloves/leather/advanced
			wrists = /obj/item/clothing/wrists/bracers/leather
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			pants = /obj/item/clothing/pants/tights/black
			H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
			if(!H.has_language(/datum/language/oldpsydonic))
				H.grant_language(/datum/language/oldpsydonic)
				to_chat(H, "<span class='info'>I can speak Old Psydonic with ,m before my speech.</span>")
			H.set_patron(/datum/patron/psydon)
			to_chat(H,span_info("\
			The Ten are false gods, and I loathe those that worship the corpse god. Psydon lives, my life for Psydon.")
			)
		if("Hide")
			shirt = /obj/item/clothing/shirt/undershirt/uncolored
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
			cloak = /obj/item/clothing/cloak/raincloak/brown
			gloves = /obj/item/clothing/gloves/leather/advanced
			pants = /obj/item/clothing/under/roguetown/tights/random
			H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.change_stat(STATKEY_SPD, 1)
			H.change_stat(STATKEY_CON, 1)
			to_chat(H,span_info("\
			Dendor provides. The only armor I need are hides taken from the backs of beasts.")
			)
		if("Freak")
			head = /obj/item/clothing/head/menacing
			neck = /obj/item/clothing/neck/chaincoif/iron
			pants = /obj/item/clothing/pants/tights/black
			ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
			H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
			H.change_stat(STATKEY_CON, 1)
			H.change_stat(STATKEY_INT, -2)
			H.change_stat(STATKEY_SPD, -2)
			to_chat(H,span_info("\
			I like the pain.")
			)
		if("Destitute") // Fuck you, die. Welcome to Heartcrit. Dark souls challenge run.
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
			H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
			neck = /obj/item/clothing/neck/gorget
			mask = /obj/item/clothing/mask/rogue/facemask
			pants = /obj/item/clothing/under/roguetown/loincloth/black
			H.change_stat(STATKEY_CON, -2)
			H.change_stat(STATKEY_STR, 1)
			H.change_stat(STATKEY_END, -2)
			H.change_stat(STATKEY_INT, -2)
			H.change_stat(STATKEY_PER, -1)
			H.change_stat(STATKEY_SPD, 2)
			H.change_stat(STATKEY_LCK, -1)
			to_chat(H,span_info("\
			God won't let me die. My life is a momentary lapse of reason.")
			)
		if("Noble") // Congratulations, you're important! Or were, rather.
			armor = /obj/item/clothing/suit/roguetown/armor/cuirass/iron
			shirt = /obj/item/clothing/shirt/tunic/black/random
			cloak = /obj/item/clothing/cloak/raincloak/furcloak
			pants = /obj/item/clothing/pants/tights/black
			neck = /obj/item/clothing/neck/chaincoif/iron
			head = /obj/item/clothing/head/roguetown/fancyhat
			id = /obj/item/clothing/ring/silver
			H.mind?.adjust_skillrank(/datum/skill/misc/reading, pick(2,3), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
			H.change_stat(STATKEY_INT, 2)
			H.change_stat(STATKEY_END, -2)
			H.change_stat(STATKEY_CON, -1)
			ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			to_chat(H,span_info("\
			I'm an unloved bastard. Calloused hands do not suit me.")
			)
		if("Copper") // Heavy Copper Armor. The fattest fuck.
			head = /obj/item/clothing/head/roguetown/helmet/coppercap
			neck = /obj/item/clothing/neck/gorget/copper
			armor = /obj/item/clothing/suit/roguetown/armor/cuirass/copperchest
			mask = /obj/item/clothing/mask/rogue/facemask/copper
			wrists = /obj/item/clothing/wrists/roguetown/bracers/copper
			neck = /obj/item/clothing/neck/gorget/copper
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
			pants = /obj/item/clothing/under/roguetown/chainlegs/iron
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE) // fat
			H.change_stat(STATKEY_CON, 1)
			H.change_stat(STATKEY_STR, 1)
			H.change_stat(STATKEY_PER, -3)
			H.change_stat(STATKEY_SPD, -5)
			to_chat(H,span_info("\
			I'm a champion amongst my people. Grab me, see what happens.")
			)
	switch(weapontype)
		if("Axe")
			beltl = /obj/item/weapon/axe/iron
			beltr = /obj/item/weapon/knife/dagger
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
			H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'
			to_chat(H,span_info("\
			I prefer a practical instrument.")
			)
		if("BigAxe")
			backr = /obj/item/weapon/polearm/halberd/bardiche/woodcutter
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.change_stat(STATKEY_SPD, -1) // big boy
			H.cmode_music = 'sound/music/cmode/adventurer/CombatIntense.ogg'
			to_chat(H,span_info("\
			Only the strong can survive in the wilds, Dendor fears my axe.")
			)
		if("Mace")
			beltl = /obj/item/weapon/mace
			beltr = /obj/item/weapon/knife/dagger
			wrists = /obj/item/rope/chain
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
			H.cmode_music = 'sound/music/cmode/adventurer/CombatWarrior.ogg'
			to_chat(H,span_info("\
			I do not need skill to win a fight, only strength. Clubs are my tool of war.")
			)
		if("Shovel") // Rare roll, might as well get some stat benefits
			beltr = /obj/item/flashlight/flare/torch/lantern
			backr = /obj/item/weapon/shovel
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
			H.change_stat(STATKEY_LCK, 1)
			H.change_stat(STATKEY_SPD, 1)
			H.change_stat(STATKEY_END, 2)
			H.cmode_music = 'sound/music/cmode/church/CombatGravekeeper.ogg'
			to_chat(H,span_info("\
			I can clobber, I can cut, and I can bury the evidence. I don't leave home without my shovel.")
			)
		if("BigMace")
			backr =	/obj/item/weapon/hammer/sledgehammer
			beltl = /obj/item/weapon/knife/dagger
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
			H.change_stat(STATKEY_SPD, -1) // big boy
			H.cmode_music = 'sound/music/cmode/nobility/CombatKnight.ogg'
			to_chat(H,span_info("\
			I've known nobody who can stop the might of my hammer.")
			)
		if("Messer") // Nobody uses these goddamn things.
			beltl = /obj/item/weapon/sword/scimitar/messer
			beltr = /obj/item/weapon/sword/scimitar/messer
			r_hand = /obj/item/weapon/sword/scimitar/messer
			l_hand = /obj/item/weapon/sword/scimitar/messer
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.change_stat(STATKEY_STR, 1)
			H.change_stat(STATKEY_SPD, -2)
			H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'
			to_chat(H,span_info("\
			I dare a motherfucker to try and disarm me.")
			)
		if("Daggers")
			beltl = /obj/item/weapon/knife/dagger
			beltr = /obj/item/weapon/knife/dagger
			r_hand = /obj/item/weapon/knife/dagger
			l_hand = /obj/item/weapon/knife/dagger
			H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.change_stat(STATKEY_STR, -1)
			H.change_stat(STATKEY_SPD, 2)
			H.cmode_music = 'sound/music/cmode/nobility/CombatSpymaster.ogg'
			to_chat(H,span_info("\
			I'm a whirlwind of chaos. Walk into me and die.")
			)
		if("MFlail")
			r_hand = /obj/item/rogueweapon/flail/militia
			H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.change_stat(STATKEY_STR, 1)
			H.change_stat(STATKEY_END, 1)
			H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'
			to_chat(H,span_info("\
			The flail is an ancient weapon. If it's good enough for my ancestors, it's good enough for me.")
			)
		if("Shield") // THE WALL
			beltl = /obj/item/rogueweapon/shield/tower/buckleriron
			backr = /obj/item/rogueweapon/shield/tower
			H.mind?.adjust_skillrank(/datum/skill/combat/shields, pick(1,2), TRUE)
			H.change_stat(STATKEY_CON, 2)
			H.change_stat(STATKEY_SPD, -2)
			H.change_stat(STATKEY_PER, -3)
			H.change_stat(STATKEY_END, 2)
			H.cmode_music = 'sound/music/cmode/church/CombatAstrata.ogg'
			to_chat(H,span_info("\
			No man on earth can make me fall.")
			)
		if("Spear")
			backr = /obj/item/rogueweapon/polearm/spear
			beltr = /obj/item/rogueweapon/shield/tower/buckleriron
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.cmode_music = 'sound/music/cmode/towner/CombatInn.ogg'
			to_chat(H,span_info("\
			I'm a cautious sort, I prefer to keep my enemies at range.")
			)
		if("Rapier")
			beltl = /obj/item/rogueweapon/sword/rapier
			beltr = /obj/item/rogueweapon/shield/tower/buckleriron
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'
			to_chat(H,span_info("\
			Fighting is an art, and my canvas is the body of my enemy.")
			)
		if("Falx")
			backr = /obj/item/rogueweapon/sword/long/rider/copper
			beltl = /obj/item/rogueweapon/mace/copperbludgeon
			beltr = /obj/item/flashlight/flare/torch/lantern
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
			H.cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'
			to_chat(H,span_info("\
			I prefer the weaponry of a bygone age.")
			)
		if("Sword")
			beltl = /obj/item/weapon/sword/iron
			backr = /obj/item/rogueweapon/shield/wood
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.cmode_music = 'sound/music/cmode/adventurer/CombatWarrior.ogg'
			to_chat(H,span_info("\
			I'm a practical person, the sword is my weapon of choice.")
			)
		if("Mage")
			r_hand = /obj/item/rogueweapon/polearm/woodstaff
			head = /obj/item/clothing/head/roguetown/roguehood/mage
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
			beltl = /obj/item/reagent_containers/glass/bottle/rogue/manapot
			beltr = /obj/item/weapon/knife/dagger
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
			H.change_stat(STATKEY_INT, 3)
			H.change_stat(STATKEY_CON, -2)
			H.change_stat(STATKEY_SPD, -2)
			H.mind.adjust_spellpoints(6)
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/learnspell)
			H.cmode_music = 'sound/music/cmode/adventurer/CombatSorcerer.ogg'
			to_chat(H,span_info("\
			I've studied the arcane by chance, those who step to me shall perish.")
			)
		if("Sword2")
			beltl = /obj/item/weapon/sword/short
			beltr = /obj/item/weapon/sword/short
			H.change_stat(STATKEY_END, 1)
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.cmode_music = 'sound/music/cmode/adventurer/CombatWarrior.ogg'
			to_chat(H,span_info("\
			Two swords, nothing beats that!")
			)
		if("Flail")
			beltl = /obj/item/rogueweapon/flail
			beltr = /obj/item/rogueweapon/whip
			wrists = /obj/item/rope/chain
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
			shirt = /obj/item/clothing/shirt/undershirt/uncolored/black
			head = /obj/item/clothing/head/menacing
			H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
			H.change_stat(STATKEY_CON, 1)
			H.change_stat(STATKEY_END, 2)
			H.change_stat(STATKEY_SPD, -1)
			H.change_stat(STATKEY_PER, -2)
			H.cmode_music = 'sound/music/cmode/towner/CombatInn.ogg'
			to_chat(H,span_info("\
			I am an instrument of pain.")
			)
		if("Fist")
			wrists = /obj/item/clothing/wrists/bracers/leather
			H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.change_stat(STATKEY_SPD, 1)
			H.change_stat(STATKEY_STR, 1)
			H.cmode_music = 'sound/music/cmode/Adventurer/CombatMonk.ogg'
			to_chat(H,span_info("\
			My mind is a temple, and my body is a weapon of war.")
			)
		if("Bow")
			beltl = /obj/item/ammo_holder/quiver/arrows
			beltr = /obj/item/rogueweapon/knife/hunting
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
			H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.cmode_music = 'sound/music/cmode/towner/CombatPrisoner.ogg'
			H.change_stat(STATKEY_PER, 2)
			ADD_TRAIT(H, TRAIT_LIGHT_STEP, TRAIT_GENERIC)
			to_chat(H,span_info("\
			The wind guides my strikes, arrows dot acrost my enemies.")
			)
	switch(randomjob)
		if("Farmer")
			H.mind?.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/taming, 1, TRUE)
			ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)
			to_chat(H,span_info("\
			I toiled the fields in my youth. Farmwork made me sturdy.")
			)
		if("Sailor")
			H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.change_stat(STATKEY_STR, -1)
			to_chat(H,span_info("\
			I've worked on ships defending their cargo. I am no stranger to Abyssor's wrath.")
			)
		if("Pickpocket")
			H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
			H.change_stat(STATKEY_STR, -1)
			to_chat(H,span_info("\
			Some people in this city are too rich for their own good. Luckily they have me to give them a hand.")
			)
		if("Smith")
			H.mind?.adjust_skillrank(/datum/skill/labor/mining, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/smelting, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, 2, TRUE)
			H.change_stat(STATKEY_INT, -1)
			H.change_stat(STATKEY_CON, 1)
			to_chat(H,span_info("\
			The heat of the forge yet warms my body. I yearn for the mines.")
			)
		if("Cook")
			H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
			r_hand = /obj/item/reagent_containers/glass/bucket/pot
			l_hand = /obj/item/cooking/pan
			to_chat(H,span_info("\
			I'm a natural in the kitchen.")
			)
		if("Fisher")
			H.mind?.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			r_hand = /obj/item/fishingrod/fisher
			H.change_stat(STATKEY_PER, 1)
			to_chat(H,span_info("\
			Fish fear me. I've lived off Abyssor's bounty, both salt-and-freshwater.")
			)
		if("Doctor")
			H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.change_stat(STATKEY_INT, 1)
			ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
			to_chat(H,span_info("\
			I've studied anatomy, and used to practice medicine.")
			)
		if("Grappler")
			H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.change_stat(STATKEY_INT, -1)
			to_chat(H,span_info("\
			I'm a professional grappler. I made money beating the snot out of idiots.")
			)
		if("Guard")
			H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.change_stat(STATKEY_INT, -1)
			l_hand = /obj/item/rope/chain
			r_hand = /obj/item/rogueweapon/mace/cudgel
			H.verbs |= /mob/proc/haltyell
			to_chat(H,span_info("\
			I used to be part of a town militia. I'm used to apprehending unsavory sorts.")
			)
		if("Lumber")
			H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
			H.change_stat(STATKEY_INT, 1)
			to_chat(H,span_info("\
			I was a lumberjack once in my life, wise as an oak too.")
			)
		if("Paranoiac")
			l_hand = /obj/item/flashlight/flare/torch/lantern
			H.change_stat(STATKEY_PER, 3)
			H.change_stat(STATKEY_CON, -2)
			ADD_TRAIT(H, TRAIT_FASTSLEEP, TRAIT_GENERIC)
			to_chat(H,span_info("\
			It's hard to sleep. In the dark corners of every hallway I see that man. I don't sleep without a light-source.")
			)
		if("Bard")
			H.mind?.adjust_skillrank(/datum/skill/misc/music, 3, TRUE)
			H.change_stat(STATKEY_INT, 1)
			H.change_stat(STATKEY_END, 1)
			l_hand = /obj/item/rogue/instrument/guitar
			ADD_TRAIT(H, TRAIT_BARDIC_TRAINING, TRAIT_GENERIC)
			to_chat(H,span_info("\
			I used to be a bard, the skills never left me. I'm a silver-tongued devil!")
			)
		if("Smart")
			H.mind?.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/music, rand(2,3), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
			l_hand = /obj/item/clothing/mask/spectacles
			H.change_stat(STATKEY_INT, 3)
			H.change_stat(STATKEY_CON, -1)
			H.change_stat(STATKEY_PER, -2)
			H.virginity = TRUE
			H.grant_language(/datum/language/elvish)
			H.grant_language(/datum/language/celestial)
			H.grant_language(/datum/language/oldpsydonic)
			to_chat(H,span_info("\
			I was a scribe in my former years, I'm well-educated.")
			)
		if("Steppes")
			H.mind?.adjust_skillrank(/datum/skill/labor/taming, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
			H.change_stat(STATKEY_PER, 1)
			H.change_stat(STATKEY_INT, -2)
			H.change_stat(STATKEY_END, 1)
			to_chat(H,span_info("\
			I'm from the steppes, civilized society is unbeknownst to me.")
			)
	switch(randomperk)
		if("Fat")
			backpack_contents = list(/obj/item/reagent_containers/glass/bottle/rogue/wine = 1, /obj/item/reagent_containers/food/snacks/hardtack = 2)
			H.change_stat(STATKEY_SPD, -1)
			to_chat(H,span_info("\
			I packed enough supplies to last the week. I eat well.")
			)
		if("Lockpicks")
			backpack_contents = list(/obj/item/lockpickring = 1, /obj/item/weapon/knife/dagger = 1)
			to_chat(H,span_info("\
			Who am I, and how did I get here? Well, I'm a locksmith, and I'm a locksmith.")
			)
		if("Traps")
			backpack_contents = list(/obj/item/restraints/legcuffs/beartrap/crafted = 2)
			H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
			to_chat(H,span_info("\
			I'm paranoid. I don't leave home without some traps.")
			)
		if("Ring")
			backpack_contents = list(/obj/item/clothing/ring/gold = 1)
			H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
			to_chat(H,span_info("\
			I was married once. I don't want to talk about it. There's a hole in my heart even the gods cannot mend.")
			)
		if("Knives")
			backpack_contents = list(/obj/item/weapon/knife/dagger= 6)
			H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			to_chat(H,span_info("\
			You want my weapons? Go on, take them from me.")
			)
		if("Cyclops")
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.change_stat(STATKEY_PER, -2)
			if(rand(0,1)==0)
				H.equip_to_slot_or_del(new /obj/item/clothing/face/eyepatch(H), SLOT_WEAR_MASK)
				ADD_TRAIT(H, TRAIT_CYCLOPS_RIGHT, TRAIT_GENERIC)
			else
				H.equip_to_slot_or_del(new /obj/item/clothing/face/eyepatch/left(H), SLOT_WEAR_MASK)
				ADD_TRAIT(H, TRAIT_CYCLOPS_LEFT, TRAIT_GENERIC)
			H.update_fov_angles()
			to_chat(H,span_info("\
			I lost an eye in a grave battle. I've honed my senses to compensate.")
			)
		if("Normal")
			to_chat(H,span_info("\
			There's nothing too odd with me. I'm mostly normal... Mostly.")
			)
		if("Packrat")
			ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
			to_chat(H,span_info("\
			I'll sell anything not nailed down. Anything that's nailed down is being sold, even the floorboards. Even the nails.")
			)
		if("Strong")
			H.change_stat(STATKEY_STR, 4)
			H.change_stat(STATKEY_SPD, -3)
			H.change_stat(STATKEY_INT, -2)
			to_chat(H,span_info("\
			YOU ARE UP AGAINST THE WALL, AND I AM THE FUCKING WALL.")
			)
		if("Zizo")
			H.change_stat(STATKEY_INT, 1)
			H.set_patron(/datum/patron/inhumen/zizo)
			to_chat(H,span_info("\
			CHAOS REIGNS! HAIL ZIZO!")
			)
		if("Graggar")
			H.change_stat(STATKEY_END, 1)
			H.change_stat(STATKEY_CON, 1)
			H.set_patron(/datum/patron/inhumen/graggar)
			l_hand = /obj/item/clothing/head/roguetown/helmet/heavy/sinistar
			to_chat(H,span_info("\
			FOR ALL WHO DENY THE STRUGGLE, THE TRIUMPHANT OVERCOME! GRAGGAR IS THE BEAST I WORSHIP!")
			)
		if("Atheist")
			H.change_stat(STATKEY_INT, 4)
			H.change_stat(STATKEY_END, -2)
			H.change_stat(STATKEY_STR, -1)
			H.set_patron(/datum/faith/godless)
			to_chat(H,span_info("\
			In this moment, I am euphoric. Not because of any phony god's blessing, but because I am englightened by my intelligence.")
			)
		if("Stupid")
			H.change_stat(STATKEY_INT, -4)
			H.change_stat(STATKEY_CON, 4)
			H.change_stat(STATKEY_SPD, -4)
			H.set_patron(/datum/faith/godless)
			to_chat(H,span_info("\
			If I'm going to be dumb, I'm going to be tough. Nothing gets past me.")
			)
		if("Heel")
			H.change_stat(STATKEY_CON, 3)
			H.change_stat(STATKEY_STR, 2)
			ADD_TRAIT(H, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
			to_chat(H,span_info("\
			I've been cursed by a witch. Any victory of mine shall be pyrrhic.")
			)
		if("Meek")
			H.change_stat(STATKEY_LCK, -1)
			H.change_stat(STATKEY_END, 1)
			ADD_TRAIT(H, TRAIT_DECEIVING_MEEKNESS, TRAIT_GENERIC)
			to_chat(H,span_info("\
			Nobody knows how capable I am of great violence. Anyone who accosts me shall regret it.")
			)
		if("Invisible") // METAL GEAR SOLID V?!!
			H.change_stat(STATKEY_LCK, -1)
			H.change_stat(STATKEY_CON, -2)
			H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
			r_hand = /obj/item/clothing/mask/rogue/facemask
			ADD_TRAIT(H, TRAIT_DISFIGURED, TRAIT_GENERIC)
			to_chat(H,span_info("\
			I forgot to remember to forget. I don't know who I am anymore.")
			)
		if("Bomb")
			backpack_contents = list(/obj/item/bomb = 1, /obj/item/flint = 1)
			to_chat(H,span_info("\
			If I am ever struck down, my last act of defiance shall be sending me and my enemy straight to the depths of hell.")
			)
		if("Blind") // lol, lmao, get fucked dipshit
			var/mob/living/carbon/human/H = owner
			if(owner)
				var/obj/item/organ/eyes/eyes = owner.current.getorganslot(ORGAN_SLOT_EYES)
				if(eyes)
					eyes.Remove(H.current,1)
					QDEL_NULL(eyes)
			H.change_stat(STATKEY_STR, 5)
			H.change_stat(STATKEY_CON, 5)
			H.change_stat(STATKEY_INT, 5)
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2,)
			H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
			to_chat(H,span_info("\
			My compatriots must guide me to my ultimate fate. My eyes are blind, but through them, I can see.")
			)

