//// Sleep Specials
//// these should still be in the round-start/late join specials as well! It's just these are contextually fitting for Sleep Specials as well!
/datum/special_trait/nothing
	name = "Nothing"
	greet_text = span_notice("You're not special")
	weight = 7 //As rare as Vengant Bum, just to remind you it could have been it

/datum/special_trait/nightvision
	name = "Night Vision"
	greet_text = span_notice("I can easily see in the dark.")
	weight = 100

/datum/special_trait/nightvision/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/organ/eyes/eyes = character.getorganslot(ORGAN_SLOT_EYES)
	if(!eyes)
		return
	eyes.see_in_dark = 3
	eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	character.update_sight()

/datum/special_trait/thickskin
	name = "Tough"
	greet_text = span_notice("I feel it. Thick Skin. Dense Flesh. Durable Bones. I'm a punch-taking machine.")
	weight = 100

/datum/special_trait/thickskin/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_BREADY, "[type]")
	character.change_stat("constitution", 2)

/datum/special_trait/curseofcain
	name = "Flawed Immortality"
	greet_text = span_notice("I feel like I don't need to eat anymore, and my veins feel empty... Is this normal?")
	weight = 25

/datum/special_trait/curseofcain/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOHUNGER, "[type]")
	ADD_TRAIT(character, TRAIT_NOBREATH, "[type]")

/datum/special_trait/deadened
	name = "Deadened"
	greet_text = span_notice("Ever since <b>it</b> happened, I've never been able to feel anything. Inside or out")
	weight = 25

/datum/special_trait/deadened/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOMOOD, "[type]")
	ADD_TRAIT(character, TRAIT_CRITICAL_RESISTANCE, "[type]")

/datum/special_trait/latentmagic
	name = "Latent Magic"
	greet_text = span_notice("I have innate magical potential.")
	weight = 25

/datum/special_trait/latentmagic/on_apply(mob/living/carbon/human/character, silent)
	character.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)

/datum/special_trait/value
	name = "Coin Counter"
	greet_text = span_notice("I know how to estimate an item's value.")
	weight = 100
	restricted_traits = list(TRAIT_SEEPRICES)

/datum/special_trait/value/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_SEEPRICES, "[type]")

/datum/special_trait/lightstep
	name = "Light Step"
	greet_text = span_notice("I am quiet, nobody can hear my steps.")
	weight = 100

/datum/special_trait/lightstep/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_LIGHT_STEP, "[type]")

/datum/special_trait/night_owl
	name = "Night Owl"
	greet_text = span_notice("I've always preferred Noc over his other half.")
	weight = 100

/datum/special_trait/night_owl/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NIGHT_OWL, "[type]")

/datum/special_trait/beautiful
	name = "Beautiful"
	greet_text = span_notice("My face is a work of art")
	weight = 100

/datum/special_trait/beautiful/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_BEAUTIFUL, "[type]")

//positive
/datum/special_trait/duelist
	name = "Swordmaster Apprentice"
	greet_text = span_notice("I was the student of a legendary sword master, my skill is rivalled by few! I've also hidden a rapier.")
	weight = 50

/datum/special_trait/duelist/on_apply(mob/living/carbon/human/character, silent)
	character.cmode_music = 'sound/music/combat_duelist.ogg'
	character.change_stat("speed", 2)
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 6, TRUE) //will make a unique trait later on
	character.mind.special_items["Rapier"] = /obj/item/rogueweapon/sword/rapier

/datum/special_trait/eagle_eyed
	name = "Eagle Eyed"
	greet_text = span_notice("With my sharp aim I could always hit distant targets, I've also hidden a crossbow and some bolts.")
	weight = 50

/datum/special_trait/eagle_eyed/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("perception", 2)
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/crossbows, 5, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/bows, 4, TRUE)
	character.mind.special_items["Crossbow"] = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	character.mind.special_items["Bolts"] = /obj/item/quiver/bolts

/datum/special_trait/mule
	name = "Mule"
	greet_text = span_notice("I've been dealing drugs and I have a stash hidden away")
	weight = 100

/datum/special_trait/mule/on_apply(mob/living/carbon/human/character, silent)
	character.mind.special_items["Stash One"] = /obj/item/storage/backpack/rogue/satchel/mule
	character.mind.special_items["Stash Two"] = /obj/item/storage/backpack/rogue/satchel/mule
	character.mind.special_items["Dagger"] = /obj/item/rogueweapon/huntingknife/idagger
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 2, TRUE)

/datum/special_trait/cunning_linguist
	name = "Cunning Linguist"
	greet_text = span_notice("I know an extra language, and I can be quite seductive")
	weight = 100

/datum/special_trait/cunning_linguist/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_GOODLOVER, "[type]")
	switch(rand(1,3))
		if(1)
			character.grant_language(/datum/language/elvish)
		if(2)
			character.grant_language(/datum/language/hellspeak)
		if(3)
			character.grant_language(/datum/language/draconic)

/datum/special_trait/corn_fed
	name = "Corn Fed"
	greet_text = span_notice("My diet was quite rich in corn.")
	weight = 100

/datum/special_trait/corn_fed/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("constitution", 2)
	character.change_stat("intelligence", -2)

/datum/special_trait/bookworm
	name = "Bookworm"
	greet_text = span_notice("I'm a fan of books and I enjoy reading them regularly.")
	weight = 100

/datum/special_trait/bookworm/on_apply(mob/living/carbon/human/character, silent)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 4, TRUE)

/datum/special_trait/limpdick
	name = "Lazy Soldier"
	greet_text = span_crit("My 'little soldier' can't seem to stand at attention! Curses!")
	weight = 100

/datum/special_trait/screenshake
	name = "Tremors"
	greet_text = span_crit("I'm not too steady any more...")
	weight = 100

/datum/special_trait/maniac_awoken
	name = "HELP ME"
	greet_text = span_cult("THEY'RE COMING FOR ME")
	weight = 100

/datum/special_trait/schizo_ambience
	name = "Shizophrenic"
	greet_text = span_suicide("MY TUMOR gives me sight BEYOND THE VEIL!")
	weight = 100

/datum/special_trait/arsonist
	name = "Arsonist"
	greet_text = span_notice("I like seeing things combust and burn. I have hidden around two firebombs.")
	weight = 100

/datum/special_trait/arsonist/on_apply(mob/living/carbon/human/character, silent)
	character.mind.special_items["Firebomb One"] = /obj/item/bomb
	character.mind.special_items["Firebomb Two"] = /obj/item/bomb
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/alchemy, 1, TRUE)

/datum/special_trait/pineapple
	name = "The safeword is \"Pineapple\""
	greet_text = span_notice("I enjoy whipping people until they squirm and whine, their pain makes my pleasure. I also have a hidden a whip")
	weight = 50

/datum/special_trait/pineapple/on_apply(mob/living/carbon/human/character, silent)
	character.mind.special_items["Whip"] = /obj/item/rogueweapon/whip
	character.mind.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 6, TRUE)

/datum/special_trait/psydons_rider
	name = "Psydon's Drunkest Rider"
	greet_text = span_notice("I ride! None of the laws shall stop me for that is Psydon's divine will!")
	req_text = "Worship Psydon"
	allowed_patrons = list(/datum/patron/old_god)
	weight = 100

/datum/special_trait/psydons_rider/on_apply(mob/living/carbon/human/character, silent)
	character.drunkenness = 50
	for(var/i in 1 to 2)
		var/obj/item/bottle = new /obj/item/reagent_containers/glass/bottle/rogue/wine(get_turf(character))
		character.put_in_hands(bottle, forced = TRUE)

	character.mind.adjust_skillrank_up_to(/datum/skill/misc/riding, 4, TRUE)
	new /mob/living/simple_animal/hostile/retaliate/rogue/saiga/tame/saddled(get_turf(character))

/datum/special_trait/spring_in_my_step
	name = "Spring in my Step"
	greet_text = span_notice("My legs are quite strong and where most have to climb, I can just jump")
	weight = 25

/datum/special_trait/spring_in_my_step/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_ZJUMP, "[type]")

/datum/special_trait/tolerant
	name = "Tolerant"
	greet_text = span_notice("I dream of an ideal future, one with peace between all races")
	weight = 100

/datum/special_trait/tolerant/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_TOLERANT, "[type]")

/datum/special_trait/thief
	name = "Thief"
	greet_text = span_notice("Life's not easy around here, but I've made mine a little easier by taking things of others")
	weight = 100

/datum/special_trait/thief/on_apply(mob/living/carbon/human/character, silent)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/stealing, 5, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/sneaking, 4, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/climbing, 3, TRUE)

/datum/special_trait/languagesavant
	name = "Polyglot"
	greet_text = span_notice("I have always picked up on languages easily, even those that are forbidden to mortals... except that accursed beastial chatter. What even is that nonsense?")
	weight = 100

/datum/special_trait/languagesavant/on_apply(mob/living/carbon/human/character, silent)
	character.grant_language(/datum/language/dwarvish)
	character.grant_language(/datum/language/elvish)
	character.grant_language(/datum/language/hellspeak)
	character.grant_language(/datum/language/celestial)
	character.grant_language(/datum/language/orcish)
	character.grant_language(/datum/language/draconic)

/datum/special_trait/civilizedbarbarian
	name = "Tavern Brawler"
	greet_text = span_notice("My fists feel heavier!")
	weight = 100

/datum/special_trait/civilizedbarbarian/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC) //Need to make trait improve hitting people with chairs, mugs, goblets.

/datum/special_trait/mastercraftsmen
	name = "Master Crasftman"
	greet_text = "In my youth, I've decided I'd get a grasp on every trade, and pursued the 10 arts of the craft."
	req_text = "Middle-aged or Old"
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	weight = 100

/datum/special_trait/mastercraftsmen/on_apply(mob/living/carbon/human/character)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/crafting, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/weaponsmithing, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/armorsmithing, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/blacksmithing, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/carpentry, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/masonry, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/traps, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/cooking, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/engineering, 2, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/craft/tanning, 2, TRUE)

/datum/special_trait/bleublood
	name = "Noble Lineage"
	greet_text = span_notice("I come of noble blood.")
	restricted_traits = list(TRAIT_NOBLE)
	weight = 100

/datum/special_trait/bleublood/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOBLE, "[type]")
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 2, TRUE)

/datum/special_trait/richpouch
	name = "Rich Pouch"
	greet_text = span_notice("I've recently found a pouch filled with mammons, probably belonging to some noble.")
	weight = 100

/datum/special_trait/richpouch/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/pouch = new /obj/item/storage/belt/rogue/pouch/coins/rich(get_turf(character))
	character.put_in_hands(pouch, forced = TRUE)

/datum/special_trait/swift
	name = "Speedster"
	greet_text = span_notice("I feel like the fastest person alive and I can probably dodge anything, as long as I'm not weighed down by medium or heavy armor")
	weight = 50

/datum/special_trait/swift/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_DODGEEXPERT, "[type]")
	character.mind.adjust_skillrank(/datum/skill/misc/athletics, 6, TRUE)
	character.change_stat("speed", 3)

/datum/special_trait/gourmand
	name = "Gourmand"
	greet_text = span_notice("I can eat even the most spoiled, raw, or toxic food and water as if they were delicacies..")
	weight = 100

/datum/special_trait/gourmand/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NASTY_EATER, "[type]")

/datum/special_trait/lucky
	name = "Fortune's Grace"
	greet_text = span_notice("Xylix favor me, I am extremely lucky.")
	req_text = "Have Xylix as your Patron"
	allowed_patrons = list(/datum/patron/divine/xylix)
	weight = 7

/datum/special_trait/lucky/on_apply(mob/living/carbon/human/character, silent)
	character.STALUC = rand(15, 20) //In other words, In the next round following the special, you are effectively lucky.

//neutral
/datum/special_trait/backproblems
	name = "Giant"
	greet_text = span_notice("I've always been called a giant. I am valued for my stature, but, this world made for smaller folk has forced me to move cautiously.")
	req_text = "Not a kobold, verminvolk or a dwarf"
	restricted_races = list(/datum/species/anthromorphsmall, /datum/species/dwarf/mountain, /datum/species/kobold)
	weight = 50

/datum/special_trait/backproblems/on_apply(mob/living/carbon/human/character)
	character.change_stat("strength", 2)
	character.change_stat("constitution", 1)
	character.change_stat("speed", -2)
	character.transform = character.transform.Scale(1.25, 1.25)
	character.transform = character.transform.Translate(0, (0.25 * 16))
	character.update_transform()

/datum/special_trait/atheism
	name = "Godless"
	greet_text = span_notice("Gods may exist, but know what? I care not.")
	req_text = "Non-Church Role"
	restricted_jobs = list(CHURCH_ROLES)
	weight = 100

/datum/special_trait/atheism/on_apply(mob/living/carbon/human/character, silent)
	character.set_patron(/datum/patron/godless)

//negative
/datum/special_trait/nimrod
	name = "Nimrod"
	greet_text = span_boldwarning("In the past I learned slower than my peers, and I tend to be clumsy.")
	weight = 100

/datum/special_trait/nimrod/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat("speed", -2)
	character.change_stat("intelligence", -4)

/datum/special_trait/nopouch
	name = "No Pouch"
	greet_text = span_boldwarning("I lost my pouch recently, I'm without a zenny..")
	weight = 200

/datum/special_trait/nopouch/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/pouch = locate(/obj/item/storage/belt/rogue/pouch) in character
	if(character.wear_neck == pouch)
		character.wear_neck = null
	if(character.beltl == pouch)
		character.beltl = null
	if(character.beltr == pouch)
		character.beltr = null
	qdel(pouch)

/datum/special_trait/hussite
	name = "Known Heretic"
	greet_text = span_boldwarning("I've been denounced by the church for either reasons legitimate or not!")
	req_text = "Non-church role"
	weight = 20
	restricted_jobs = list(CHURCH_ROLES)

/datum/special_trait/hussite/on_apply(mob/living/carbon/human/character, silent)
	GLOB.excommunicated_players += character.real_name

/datum/special_trait/bounty
	name = "Hunted Man"
	greet_text = span_boldwarning("Someone put a bounty on my head!")
	weight = 20

/datum/special_trait/bounty/on_apply(mob/living/carbon/human/character, silent)
	var/reason = ""
	var/employer = "unknown employer"
	var/employer_gender
	if(prob(65))
		employer_gender = MALE
	else
		employer_gender = FEMALE
	if(employer_gender == MALE)
		employer = pick(list("Baron", "Lord", "Nobleman", "Prince"))
	else
		employer = pick(list("Duchess", "Lady", "Noblelady", "Princess"))
	employer = "[employer] [random_human_name(employer_gender, FALSE, FALSE)]"
	var/amount = rand(40,100)
	switch(rand(1,7))
		if(1)
			reason = "murder"
		if(2)
			reason = "kinslaying"
		if(3)
			reason = "besmirching a noble's name"
		if(4)
			reason = "treason"
		if(5)
			reason = "arson"
		if(6)
			reason = "heresy"
		if(7)
			reason = "robbing a noble"
	add_bounty(character.real_name, amount, FALSE, reason, employer)
	if(!silent)
		to_chat(character, span_notice("Whether I done it or not, I have been accused of [reason], and the [employer] put a bounty on my head!"))

/datum/special_trait/outlaw
	name = "Known Outlaw"
	greet_text = span_boldwarning("Whether for crimes I did or was accused of, I have been declared an outlaw!")
	weight = 20

/datum/special_trait/outlaw/on_apply(mob/living/carbon/human/character, silent)
	make_outlaw(character.real_name, TRUE)

/datum/special_trait/unlucky
	name = "Unlucky"
	greet_text = span_boldwarning("Ever since you knocked over that glass vase, you just feel... off")
	weight = 100

/datum/special_trait/unlucky/on_apply(mob/living/carbon/human/character, silent)
	character.STALUC = rand(1, 10)


/datum/special_trait/jesterphobia
	name = "Jesterphobic"
	greet_text = span_boldwarning("I have a severe, irrational fear of Jesters")
	weight = 50

/datum/special_trait/jesterphobia/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_JESTERPHOBIA, "[type]")

/datum/special_trait/wild_night
	name = "Wild Night"
	greet_text = span_boldwarning("I don't remember what I did last night, and now I'm lost!")
	weight = 200

/datum/special_trait/wild_night/on_apply(mob/living/carbon/human/character, silent)
	var/turf/location = get_spawn_turf_for_job("Pilgrim")
	character.forceMove(location)
	grant_lit_torch(character)

/datum/special_trait/atrophy
	name = "Atrophy"
	greet_text = span_boldwarning("When growing up I could barely feed myself... this left me weak and fragile")
	weight = 50

/datum/special_trait/atrophy/on_apply(mob/living/carbon/human/character)
	character.change_stat("strength", -2)
	character.change_stat("constitution", -2)
	character.change_stat("endurance", -1)

/datum/special_trait/lazy
	name = "Lazy"
	greet_text = span_boldwarning("I don't care, never did")
	weight = 50

/datum/special_trait/lazy/on_apply(mob/living/carbon/human/character)
	character.change_stat("strength", -1)
	character.change_stat("constitution", -1)
	character.change_stat("endurance", -1)
	character.change_stat("speed", -1)
	character.change_stat("perception", -1)

/datum/special_trait/bad_week
	name = "Bad Week"
	greet_text = span_boldwarning("Everything just seems to piss me off")
	weight = 100

/datum/special_trait/bad_week/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_BAD_MOOD, "[type]")

/datum/special_trait/nude_sleeper
	name = "Picky Sleeper"
	greet_text = span_boldwarning("I just can't seem to fall asleep unless I'm <i>truly</i> comfortable...")
	weight = 25

/datum/special_trait/nude_sleeper/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NUDE_SLEEPER, "[type]")

//job specials
/datum/special_trait/punkprincess //I think everyone will like the Rebellous Prince-Like Princess. I'd love to do one for the prince as well that gives him princess loadout, but, up to you!
	name = "Rebellous Daughter"
	greet_text = span_notice("I am quite rebellious for a princess. Screw Noble Customs!")
	req_text = "Be a princess"
	allowed_sexes = list(FEMALE)
	allowed_jobs = list(/datum/job/roguetown/prince)
	weight = 50

/datum/special_trait/punkprincess/on_apply(mob/living/carbon/human/character, silent)
	QDEL_NULL(character.wear_pants)
	QDEL_NULL(character.wear_shirt)
	QDEL_NULL(character.wear_armor)
	QDEL_NULL(character.shoes)
	QDEL_NULL(character.belt)
	QDEL_NULL(character.beltl)
	QDEL_NULL(character.beltr)
	QDEL_NULL(character.backr)
	QDEL_NULL(character.head)
	character.equip_to_slot_or_del(new /obj/item/clothing/under/roguetown/tights/random(character), SLOT_PANTS)
	character.equip_to_slot_or_del(new /obj/item/clothing/suit/roguetown/shirt/undershirt/guard(character), SLOT_SHIRT)
	character.equip_to_slot_or_del(new /obj/item/clothing/suit/roguetown/armor/chainmail(character), SLOT_ARMOR)
	character.equip_to_slot_or_del(new /obj/item/storage/belt/rogue/leather(character), SLOT_BELT)
	character.equip_to_slot_or_del(new /obj/item/storage/belt/rogue/pouch/coins/rich(character), SLOT_BELT_R)
	character.equip_to_slot_or_del(new /obj/item/storage/backpack/rogue/satchel(character), SLOT_BACK_R)
	character.equip_to_slot_or_del(new /obj/item/clothing/shoes/roguetown/boots/nobleboot(character), SLOT_SHOES)
	character.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/misc/reading, -2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/misc/sneaking, -2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/misc/stealing, -2, TRUE)

/datum/special_trait/vengantbum
	name = "Vengant Bum"
	greet_text = span_notice("I was once a nobleman, high on life until my father was murdered right in front of me. Thankfully, my mentor took me to safety and taught me all I needed to survive in these disgusting lands. They think I am a lowlife, but that's just an advantage.")
	req_text = "Be a beggar"
	allowed_jobs = list(/datum/job/roguetown/beggar)
	weight = 7

/datum/special_trait/vengantbum/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_DECEIVING_MEEKNESS, "[type]")
	character.mind.adjust_skillrank(/datum/skill/combat/wrestling, 6, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/unarmed, 6, TRUE)
	character.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 3, TRUE)
	character.STASTR = 20
	character.STACON = 20
	character.STAEND = 20

/datum/special_trait/my_precious
	name = "My Precious"
	greet_text = span_notice("The ring, it's so shiny.. so valuable, I can feel it's power. It's all mine!")
	req_text = "Be a beggar"
	allowed_jobs = list(/datum/job/roguetown/beggar)
	weight = 50

/datum/special_trait/my_precious/on_apply(mob/living/carbon/human/character, silent)
	QDEL_NULL(character.wear_pants)
	QDEL_NULL(character.wear_shirt)
	QDEL_NULL(character.wear_armor)
	QDEL_NULL(character.shoes)
	QDEL_NULL(character.head)
	var/obj/item/ring = new /obj/item/clothing/ring/dragon_ring(get_turf(character))
	character.put_in_hands(ring, forced = TRUE)

/datum/special_trait/illicit_merchant
	name = "Illicit Merchant"
	greet_text = span_notice("I'm sick of working as an underling, I will start my own trade emporium. I've got my hands on a hidden merchant key and a curious magical device")
	req_text = "Be a Shophand"
	allowed_jobs = list(/datum/job/roguetown/shophand)
	weight = 50

/datum/special_trait/illicit_merchant/on_apply(mob/living/carbon/human/character, silent)
	character.mind.special_items["Merchant Key"] = /obj/item/roguekey/merchant
	character.mind.special_items["GOLDFACE Gem"] = /obj/item/gem_device/goldface
