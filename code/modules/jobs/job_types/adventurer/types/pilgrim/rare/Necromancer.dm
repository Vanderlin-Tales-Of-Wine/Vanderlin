/datum/advclass/pilgrim/rare/Necromancer
name = "Necromancer"
tutorial = "From a young age you have been different, where others see death, you see the raw clay of creation. With every corpse you raise and every soul you shackle, you walk the path of Zizo, dreaming of the day you, too, will claim divinity."
allowed_sexes = list(FEMALE)
allowed_races = list(
"Half-Elf",
"Dark Elf"
)

outfit = /datum/outfit/job/pilgrim/necromancer
maximum_possible_slots = 2
min_pq = 15
category_tags = list(CTAG_PILGRIM)
pickprob = 100
cmode_music = 'sound/music/combat_cult.ogg'

/datum/outfit/job/pilgrim/necromancer/pre_equip(mob/living/carbon/human/H)
..()
shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
armor = /obj/item/clothing/suit/roguetown/shirt/robe/necromancer
pants = /obj/item/clothing/under/roguetown/trou/leather
belt = /obj/item/storage/belt/rogue/leather/rope
backr = /obj/item/storage/backpack/rogue/satchel
beltl = /obj/item/reagent_containers/glass/bottle/rogue/manapot
beltr = /obj/item/rogueweapon/knife/hunting
r_hand = /obj/item/rogueweapon/polearm/woodstaff


if(H.mind)
H.mind?.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
H.mind?.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
H.mind?.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
var/datum/antagonist/new_antag = new /datum/antagonist/necromancer()
H.ambushable = FALSE
H.mind.add_antag_datum(new_antag)


H.change_stat("strength", -1)
H.change_stat("intelligence", 3)
H.change_stat("constitution", -1)
H.change_stat("endurance", -1)
H.change_stat("speed", 0)

H.mind.adjust_spellpoints(0)
H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/learnspell)
H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/command_undead)
H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/strengthen_undead)
H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/raise_undead_lesser)
H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/eyebite)
H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/sickness)
H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/revoke_unlife)

ADD_TRAIT(H, TRAIT_VILLAIN, TRAIT_GENERIC)
ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)

H.faction = list("undead")
H.set_patron(/datum/patron/zizo)
