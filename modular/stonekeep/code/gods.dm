// ===========================	PANTHEON	=======================================

/datum/patron/divine/astrata
	name = "Astrata"
	domain = "Goddess of Order, the Sun Queen"
	desc = "The Firstborn of the Forgotten God, twin of Noc, gifted mankind the Sun."
	flaws = "Tyrannical, Ill-Tempered, Uncompromising"
	worshippers = "Nobles, Zealots, Commoners"
	sins = "Betrayal, Sloth, Witchcraft"
	boons = "Your stamina regeneration delay is lowered during daytime."
	added_traits = list(TRAIT_APRICITY)
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t1 = /obj/effect/proc_holder/spell/invoked/sacred_flame_rogue
	t2 = /obj/effect/proc_holder/spell/invoked/heal
	t3 = /obj/effect/proc_holder/spell/invoked/revive
	confess_lines = list(
		"ASTRATA IS MY LIGHT!",
		"ASTRATA BRINGS LAW!",
		"I SERVE THE GLORY OF THE SUN!",
	)

/datum/patron/divine/noc
	name = "Noc"
	domain = "God of Knowledge, the Moon Prince"
	desc = "The Firstborn of the Forgotten God, twin of Astrata, gifted mankind divine wisdom."
	flaws = "Cynical, Isolationist, Unfiltered Honesty"
	worshippers = "Magic Practitioners, Scholars, Scribes"
	sins = "Suppressing Truth, Indulging Lust, Destroying Books"
	boons = "You learn and teach apprentices slightly better."
	added_traits = list(TRAIT_TUTELAGE)
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t1 = /obj/effect/proc_holder/spell/invoked/invisibility
	t2 = /obj/effect/proc_holder/spell/invoked/blindness
	t3 = /obj/effect/proc_holder/spell/invoked/projectile/moondagger
	confess_lines = list(
		"NOC IS NIGHT!",
		"NOC SEES THE TRUTH!",
		"I SEEK THE MYSTERIES OF THE MOON!",
	)

/datum/patron/divine/dendor
	name = "Dendor"
	domain = "God of Nature and Beasts"
	desc = "The manifestation of the Force of the chaotic natural world. Driven mad with time."
	flaws = "Madness, Rebelliousness, Disorderliness"
	worshippers = "Druids, Beasts, Madmen"
	sins = "Deforestation, Overhunting, Disrespecting Nature"
	boons = "You are immune to kneestingers."
	added_traits = list(TRAIT_KNEESTINGER_IMMUNITY)
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t1 = /obj/effect/proc_holder/spell/targeted/blesscrop
	t2 = /obj/effect/proc_holder/spell/self/beastsense
	t3 = /obj/effect/proc_holder/spell/targeted/beasttame
	confess_lines = list(
		"DENDOR PROVIDES!",
		"THE TREEFATHER BRINGS BOUNTY!",
		"I ANSWER THE CALL OF THE WILD!",
	)

/datum/patron/divine/abyssor
	name = "Abyssor"
	domain = "God of Seas and Storms"
	desc = "The World-Whale, the sovereign Force of the seas and storms."
	flaws= "Unforgiving, Stubborn, Destructive"
	worshippers = "Sailors of the Sea and Sky, Horrid Sea-Creachers, Fog Islanders"
	sins = "Fear, Hubris, Forgetfulness"
	boons = "Leeches will not latch onto you in dirty water."
	added_traits = list(TRAIT_LEECHIMMUNE)
/* NEEDS KAIZOKU TO WORK ROGTODO
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal/abyssal
	t1 = /obj/effect/proc_holder/spell/invoked/projectile/purify
	t2 = /obj/effect/proc_holder/spell/invoked/icebind
	t3 = /obj/effect/proc_holder/spell/invoked/ocean_embrace
*/
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t1 = /obj/effect/proc_holder/spell/invoked/projectile/swordfish
	t2 = /obj/effect/proc_holder/spell/self/summon_trident
	t3 = /obj/effect/proc_holder/spell/invoked/ocean_embrace
	confess_lines = list(
		"ABYSSOR COMMANDS THE WAVES!",
		"THE OCEAN'S FURY IS ABYSSOR'S WILL!",
		"I AM DRAWN BY THE PULL OF THE TIDE!",
	)

/datum/patron/divine/necra
	name = "Necra"
	domain = "God of Death and Decay"
	desc = "The Undermaiden, also known as the Veiled Lady. A feared and respected Force and keeper of the dead."
	flaws = "Unchanging, Apathetic, Strict"
	worshippers = "Dark Elves, Gravekeepers, Mourners"
	sins = "Undeath"
	boons = "You may see the presence of a soul in a body."
	added_traits = list(TRAIT_SOUL_EXAMINE)
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t1 = /obj/effect/proc_holder/spell/targeted/burialrite
	t2 = /obj/effect/proc_holder/spell/targeted/soulspeak
	t3 = /obj/effect/proc_holder/spell/targeted/churn
	confess_lines = list(
		"ALL SOULS FIND THEIR WAY TO NECRA!",
		"THE UNDERMAIDEN IS OUR FINAL REPOSE!",
		"I FEAR NOT DEATH, MY LADY AWAITS ME!",
	)

/datum/patron/divine/ravox
	name = "Ravox"
	domain = "Saint of Warfare, Struggle, and Chivalry"
	desc = "The blade of the Pantheon, a patron of all who have to face their fears in the maelstrom of battle."
	flaws = "Careless, Aggressive, Prideful"
	worshippers = "Warriors, Sellswords, Guardsmen"
	sins = "Cowardice, Hesitation, Stagnation"
	boons = "Your used weapons dull slower."
	added_traits = list(TRAIT_SHARPER_BLADES)
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t1 = /obj/effect/proc_holder/spell/self/call_to_arms
	t2 = /obj/effect/proc_holder/spell/self/divine_strike
	t3 = /obj/effect/proc_holder/spell/invoked/persistence
	confess_lines = list(
		"RAVOX IS JUSTICE!",
		"THROUGH STRIFE, GRACE!",
		"THE DRUMS OF WAR BEAT IN MY CHEST!",
	)

/datum/patron/divine/xylix
	name = "Xylix"
	domain = "Saint of Trickery, Freedom, and Inspiration"
	desc = "Perhaps the strangest Jester to have ever lived. Some say the greatest trick he ever pulled was making the world believe he never existed."
	flaws = "Petulance, Deception, Gambling-Prone"
	worshippers = "Cheats, Performers, The Hopeless"
	sins = "Boredom, Predictability, Routine"
	boons = "You can rig different forms of gambling in your favor."
	added_traits = list(TRAIT_BLACKLEG)
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t1 = /obj/effect/proc_holder/spell/invoked/vicious_mimicry
	t2 = /obj/effect/proc_holder/spell/invoked/wheel
	confess_lines = list(
		"ASTRATA IS MY LIGHT!",
		"NOC IS NIGHT!",
		"DENDOR PROVIDES!",
		"ABYSSOR COMMANDS THE WAVES!",
		"RAVOX IS JUSTICE!",
		"ALL SOULS FIND THEIR WAY TO NECRA!",
		"HAHAHAHA! AHAHAHA! HAHAHAHA!", //the only xylix-related confession
		"PESTRA SOOTHES ALL ILLS!",
		"MALUM IS MY FORGE!",
		"EORA BRINGS US TOGETHER!",
	)

/datum/patron/divine/pestra
	name = "Pestra"
	domain = "Saint of Healing, Alchemy, and Prophecy"
	desc = "A legendary alchemist, they claim she invented the very art. Said to have been a hunchback."
	flaws = "Drunkard, Crude, Sloppy"
	worshippers = "The Ill and Infirm, Alchemists, Physicians"
	sins = "´Curing´ Abnormalities, Refusing to help the ill, Failure to prepare"
	boons = "You may consume rotten food without being sick."
	added_traits = list(TRAIT_ROT_EATER)
	t0 = /obj/effect/proc_holder/spell/invoked/diagnose
	t1 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t2 = /obj/effect/proc_holder/spell/invoked/attach_bodypart
	t3 = /obj/effect/proc_holder/spell/invoked/cure_rot
	confess_lines = list(
		"PESTRA SOOTHES ALL ILLS!",
		"THE SECRETS OF ALCHEMY WILL BE MINE!",
		"NO SICKNESS WILL OVERTAKE ME!",
	)

/datum/patron/divine/malum
	name = "Malum"
	domain = "Saint of Toil, Industry, and Skill"
	desc = "The perfect dwarf, said to have died while still working at the anvil, despite having become blind from age half a century earlier."
	flaws = "Obsessive, Exacting, Overbearing"
	worshippers = "Smiths, Miners, Sculptors"
	sins = "Cheating, Shoddy Work, Suicide"
	boons = "You recover more energy when sleeping."
	added_traits = list(TRAIT_BETTER_SLEEP)
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t1 = /obj/effect/proc_holder/spell/invoked/vigorouscraft
	t2 = /obj/effect/proc_holder/spell/invoked/hammerfall
	t3 = /obj/effect/proc_holder/spell/invoked/heatmetal
	confess_lines = list(
		"MALUM BREAK MY BONDS!",
		"TRUE VALUE IS IN THE TOIL!",
		"I AM AN INSTRUMENT OF CREATION!",
	)

/datum/patron/divine/eora
	name = "Eora"
	domain = "Saint of Love, Life, and Beauty"
	desc = "The Mother, devoted to love and beauty. Bonds forged by love is truer than any steel."
	flaws= "Naive, Impulsive, Ignorant"
	worshippers = "Mothers, Artists, Married Couples"
	sins = "Sadism, Abandonment, Ruining Beauty"
	boons = "You can understand others' needs better."
	added_traits = list(TRAIT_EXTEROCEPTION)
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t1 = /obj/effect/proc_holder/spell/invoked/instill_perfection
	t2 = /obj/effect/proc_holder/spell/invoked/projectile/eoracurse
	t3 = /obj/effect/proc_holder/spell/invoked/bud
	confess_lines = list(
		"EORA BRINGS US TOGETHER!",
		"HER BEAUTY IS EVEN IN THIS TORMENT!",
		"I LOVE YOU, EVEN AS YOU TRESPASS AGAINST ME!",
	)


/datum/patron/psydon
	name = "Forgotten God"
	domain = "God of Humenity, Dreams and Creation"
	desc = "Forgotten but not gone, the Great Hero has left his realm to battle the Forbidden in Hell."
	flaws = "Secretive, Judgemental, Self-Sacrificing"
	worshippers = "Grenzelhofters, Inquisitors, Heroes"
	sins = "Apostasy, Demon Worship, Betraying thy Father"
	boons = "None. True strength comes from within."
	associated_faith = /datum/faith/psydon
	confess_lines = list(
		"THERE IS ONLY ONE GOD!",
		"THE FALSE GODS WILL FADE WHEN HE RETURNS!",
		"PSYDON LIVES!",
	)


/datum/faith/divine_pantheon
	name = "Divine Pantheon"
	desc = "The common religion of Enigma. The Ten aids us and protects us from the evil of Zizo and the Inhumen!"
	godhead = /datum/patron/divine/astrata

/datum/faith/psydon
	name = "Old God"
	desc = "Worship of the Forgottten God as the primary diety. Popular among the Grenzelhofters, but can be found in all Humen Kingdoms."
	godhead = /datum/patron/psydon
	preference_accessible = FALSE

/datum/faith/inhumen_pantheon
	name = "Inhumen Gods"
	desc = "The Pantheon are for weak fools!.\n\
		You follow one of the Inhumen Gods, basking in selfish fulfilment at the expense of others. \
		These Gods have no care for each other, and may be rivals just as well as allies, depending on their whims.\n\
		In silent mastery Zizo sits on the top, watching, weaving dark strands of doom for those too weak or stupid to reach for power absolute."
	godhead = /datum/patron/inhumen/zizo

/datum/faith/godless
	name = "Apostasy"
	desc = "Although gods obviously exist in this world, you refuse to bow down to them! Due to spite, ignorance, or your own ego; you are completely godless."
	godhead = /datum/patron/godless




/datum/patron/inhumen/zizo
	name = "Zizo"
	domain = "The Eternal Beast of Chaos"
	desc = "Z-Who-Must-Not-Be-Named, the true creator and force behind all reality!"
	flaws = "Insanity"
	worshippers = "Apostates, Anarchists, Psychopaths"
	sins = "None, Zizo welcomes all to see the truth."
	boons = "You know other followers of Zizo when you see them."
	added_traits = list(TRAIT_CABAL)
	confess_lines = list(
		"I FOLLOW THE PATH OF ZIZO!",
		"I TRUST THE COUNSEL OF DAEMONS!",
		"ZIZO SHOWED ME THE WAY!",
	)

/datum/patron/inhumen/graggar
	name = "Graggar"
	domain = "The Dark Sini-Star of Murder, Defilement, and Hatred"
	desc = "The Father of Orcs and Goblins, a brutal tyrant bent to destruction."
	flaws = "Rage, Hatred, Bloodthirsty"
	worshippers = "Greenskins, The Revenge-Driven, Sadists"
	sins = "Compassion, Frailty, Servility"
	boons = "You are drawn to the flavour of raw flesh and organs, and may consume without worry."
	added_traits = list(TRAIT_ORGAN_EATER)
	confess_lines = list(
		"GRAGGAR IS THE BEAST I WORSHIP!",
		"GRAGGAR WILL RAVAGE YOU!",
		"GRAGGAR WILL SATE MY HUNGER!"
	)

/datum/patron/inhumen/matthios
	name = "Matthios"
	domain = "God of Thievery, Ill-Gotten Gains, and Highwaymen"
	desc = "Said to have stolen a spark of the divine, taking fire from the jealous gods and giving it to humenkind. Gifted his lessons of thievery and subversion to his devoted followers, his influence on the world tangible."
	flaws = "Pride, Greed, Reckless"
	worshippers = "Outlaws, Noble-Haters, Downtrodden Peasantry"
	sins = "Clumsiness, Hesitation, Humility"
	boons = "You can see the most expensive item someone is carrying."
	added_traits = list(TRAIT_MATTHIOS_EYES)
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t1 = /obj/effect/proc_holder/spell/invoked/slowdown_spell_aoe
	t2 = null
	t3 = null
	confess_lines = list(
		"MATTHIOS STEAL MY PAIN!",
		"MATTHIOS WILL SAVE ME!",
		"MATTHIOS, MUST I BE YOUR MARTYR?!",
	)

/datum/patron/inhumen/baotha
	non_faith = TRUE
