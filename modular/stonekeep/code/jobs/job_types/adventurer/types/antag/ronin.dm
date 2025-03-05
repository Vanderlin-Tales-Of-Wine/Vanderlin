/datum/advclass/sk_ronin
	name = "Ronin"
	tutorial = "You are a person of the waves, the one who drifters as the ocean. Now with your link to Abyssor broken, you've bonded to Matthios to avoid the dai-corruption."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
	"Humen",
	"Changeling",
	"Skylancer",
	"Ogrun",
	"Undine")
	outfit = /datum/outfit/job/roguetown/bandit/ronin
	category_tags = list(CTAG_BANDIT)
	cmode_music = list('modular/stonekeep/kaizoku/sound/combat/combat_changeling.ogg','modular/stonekeep/kaizoku/sound/combat/combat_stormwarrior.ogg','modular/stonekeep/kaizoku/sound/combat/combat_searaider.ogg','modular/stonekeep/kaizoku/sound/combat/combat_oldtides.ogg','modular/stonekeep/kaizoku/sound/combat/combat_decapitator.ogg','modular/stonekeep/kaizoku/sound/combat/combat_emperor.ogg','modular/stonekeep/kaizoku/sound/combat/combat_traditional.ogg','modular/stonekeep/kaizoku/sound/combat/combat_navalretainers.ogg','modular/stonekeep/kaizoku/sound/combat/combat_kyudo.ogg')


/datum/outfit/job/roguetown/bandit/ronin/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE) //for the sake of duelism trope, there is a chance to get 4xp sword.
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.burakumin = TRUE //Other abyssariads will easily notice a Ronin, compared to other races. This is partially intended.

	pants = /obj/item/clothing/pants/chainlegs/iron/haidate_tatami
	shirt = /obj/item/clothing/armor/gambeson/light/hitatare/ronin
	cloak = /obj/item/clothing/shirt/tunic/kimono/ronin
	wrists = /obj/item/clothing/wrists/bracers/leather/khudagach
	armor = /obj/item/clothing/armor/chainmail/iron/tatami
	mask = /obj/item/clothing/face/kaizoku/menpo/half
	head = /obj/item/clothing/head/tengai/roningasa //Not protective
	if(prob(35))
		beltr = /obj/item/weapon/sword/short/wakizashi //Higher Daisho
	else
		beltr = /obj/item/weapon/knife/steel/tanto //Lesser Daisho
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/needle/thorn = 1, /obj/item/natural/cloth = 1)

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_INT, -1)

	var/background = pickweight(list("Fulldaisho" = 6, "Savagekiller" = 3, "Antidaisho" = 2, "Reformed" = 1))
	switch(background)
		if("Fulldaisho")
			beltl = /obj/item/weapon/sword/uchigatana
			to_chat(H, "<span class='info'>I managed to retain my full Daisho, even without masters to finance my activities.</span>")
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Reformed")
			beltl = /obj/item/weapon/flail/sflail/kusarifundo
			to_chat(H, "<span class='info'>My sword was broken during battle, and from the blade, I made one anew. This is all what remains of my deceased master.</span>")
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		if("Savagekiller")
			beltr = /obj/item/weapon/axe/battle/ono
			to_chat(H, "<span class='info'>I killed a sanguinary savage and took from him his axe, and grinded the steel into a more efficient Ono. I've conquered a WHALER's soul, and will DOMINATE HIS WAYS.</span>")
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		if("Antidaisho")
			beltr = /obj/item/weapon/sword/scimitar/falchion/yuntoudao
			to_chat(H, "<span class='info'>The Daisho is obsolete. My sword is made to do more than draw blood - It should grind my enemies into mince.</span>")
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)

	H.verbs |= /mob/proc/haltyell
	H.ambushable = FALSE
	if(!HAS_TRAIT(H, TRAIT_KAIZOKU))
		ADD_TRAIT(H, TRAIT_KAIZOKU, TRAIT_GENERIC)
		to_chat(H, "<span class='info'I am an Islander, and I respectively have the culture of one.</span>")
	if(H.dna.species.id == "human")
		H.skin_tone = SKIN_COLOR_TROPICALDRY
		H.grant_language(/datum/language/abyssal)
