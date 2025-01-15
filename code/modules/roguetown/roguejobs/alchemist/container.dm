// Alright. I'm sorting this shit now because Zeth is either a fucking sociopath or incompetent when it comes to tagging.


//////////////////////////
/// ALCHEMICAL POTIONS ///
//////////////////////////

/obj/item/reagent_containers/glass/bottle/rogue/additive
	list_reagents = list(/datum/reagent/additive = 10)

/obj/item/reagent_containers/glass/bottle/rogue/healthpot
	list_reagents = list(/datum/reagent/medicine/healthpot = 45)

/obj/item/reagent_containers/glass/bottle/rogue/stronghealthpot
	list_reagents = list(/datum/reagent/medicine/stronghealth = 45)

/obj/item/reagent_containers/glass/bottle/rogue/manapot
	list_reagents = list(/datum/reagent/medicine/manapot = 45)

/obj/item/reagent_containers/glass/bottle/rogue/strongmanapot
	list_reagents = list(/datum/reagent/medicine/strongmana = 45)

/obj/item/reagent_containers/glass/bottle/rogue/stampot
	list_reagents = list(/datum/reagent/medicine/stampot = 45)

/obj/item/reagent_containers/glass/bottle/rogue/strongstampot
	list_reagents = list(/datum/reagent/medicine/strongstam = 45)

/obj/item/reagent_containers/glass/bottle/rogue/poison
	list_reagents = list(/datum/reagent/berrypoison = 15)

/obj/item/reagent_containers/glass/bottle/rogue/strongpoison
	list_reagents = list(/datum/reagent/strongpoison = 15)

/obj/item/reagent_containers/glass/bottle/rogue/stampoison
	list_reagents = list(/datum/reagent/stampoison = 15)

/obj/item/reagent_containers/glass/bottle/rogue/strongstampoison
	list_reagents = list(/datum/reagent/strongstampoison = 15)

/obj/item/reagent_containers/glass/bottle/rogue/killersice
	list_reagents = list(/datum/reagent/killersice = 15)

/obj/item/reagent_containers/glass/bottle/rogue/wine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 45)

/obj/item/reagent_containers/glass/bottle/rogue/water
	list_reagents = list(/datum/reagent/water = 45)

/obj/item/reagent_containers/glass/bottle/rogue/antidote
	list_reagents = list(/datum/reagent/medicine/antidote = 45)

/obj/item/reagent_containers/glass/bottle/rogue/diseasecure
	list_reagents = list(/datum/reagent/medicine/diseasecure = 45)

/obj/item/reagent_containers/glass/bottle/vial/strpot
	list_reagents = list(/datum/reagent/buff/strength = 30)

/obj/item/reagent_containers/glass/bottle/vial/perpot
	list_reagents = list(/datum/reagent/buff/perception = 30)

/obj/item/reagent_containers/glass/bottle/vial/intpot
	list_reagents = list(/datum/reagent/buff/intelligence = 30)

/obj/item/reagent_containers/glass/bottle/vial/conpot
	list_reagents = list(/datum/reagent/buff/constitution = 30)

/obj/item/reagent_containers/glass/bottle/vial/endpot
	list_reagents = list(/datum/reagent/buff/endurance = 30)

/obj/item/reagent_containers/glass/bottle/vial/spdpot
	list_reagents = list(/datum/reagent/buff/speed = 30)

/obj/item/reagent_containers/glass/bottle/vial/lucpot
	list_reagents = list(/datum/reagent/buff/fortune = 30)

/obj/item/reagent_containers/glass/bottle/vial/genderpot
	list_reagents = list(/datum/reagent/medicine/gender_potion = 5)

/obj/item/reagent_containers/glass/bottle/vial/strongpoison
	list_reagents = list(/datum/reagent/strongpoison = 30)

/obj/item/reagent_containers/glass/bottle/vial/antidote
	list_reagents = list(/datum/reagent/medicine/antidote = 30)

//////////////////////////
/// ALCOHOLIC BOTTLES ///	- add fancy var to retain custom descriptions when corking
//////////////////////////

// BEER - Cheap, Plentiful, Saviours of Family Life
/obj/item/reagent_containers/glass/bottle/rogue/beer
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 70)
	desc = "A bottle that contains a generic housebrewed small-beer. It has an improvised corkseal made of hardened clay."
	fancy = TRUE

/obj/item/reagent_containers/glass/bottle/rogue/beer/spottedhen
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/spottedhen = 70)
	desc = "A bottle with the spotted-hen cork-seal. An extremely cheap lager hailing from a local brewery."

/obj/item/reagent_containers/glass/bottle/rogue/beer/blackgoat
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/blackgoat = 70)
	desc = "A bottle with the black goat kriek cork-seal. A fruit-sour beer brewed with jackberries for a tangy taste."

/obj/item/reagent_containers/glass/bottle/rogue/beer/ratkept
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/onion = 70)
	desc = "A bottle with surprisingly no cork-seal. On the glass is carved the word \"ONI-N\", the 'O' seems to have been scratched out completely. Dubious. On the glass is a paper glued to it showing an illustration of rats guarding a cellar filled with bottles against a hoard of beggars."

/obj/item/reagent_containers/glass/bottle/rogue/beer/hagwoodbitter
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/hagwoodbitter = 70)
	desc = "A bottle with the hagwood bitters cork-seal. The least bitter thing to be exported from the Grenzelhoft occupied state of Zorn."

/obj/item/reagent_containers/glass/bottle/rogue/beer/aurorian
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/aurorian = 70)
	desc = "A bottle with the aurorian brewhouse cork-seal. An Elvish beer brewed from an herbal gruit."

/obj/item/reagent_containers/glass/bottle/rogue/beer/fireleaf
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/fireleaf= 70)
	desc = "A bottle with a generic leaf cork-seal. An Elvish beer formed by distilling cabbages. You're pretty sure you can make your own with certainly higher quality."

/obj/item/reagent_containers/glass/bottle/rogue/beer/butterhairs
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/butterhairs = 70)
	desc = "A bottle with the Dwarven Federation Trade Alliance cork-seal. This beer, known as butterhairs: is widely considered one of the greatest exported by the Dwarves."

/obj/item/reagent_containers/glass/bottle/rogue/beer/stonebeardreserve
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/stonebeards = 70)
	desc = "A bottle with the House Stoutenson cork-seal. Stonebeards Reserve is one of the most legendary beers in existence, with only a few hundred barrels made every year."

/obj/item/reagent_containers/glass/bottle/rogue/beer/voddena
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/voddena = 45)
	desc = "A bottle with the House Stoutenson cork-seal. This strange liquid is considered as the most spicy and alcoholic drink in all the Mountainhomes. Bought by nobles of all ages, mostly those with a deathwish."

// WINES - Expensive, Nobleblooded
/obj/item/reagent_containers/glass/bottle/rogue/wine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/wine = 70)
	desc = "A bottle that contains a generic red-wine, likely from Zybantu. It has a red-clay cork-seal."
	fancy = TRUE

/obj/item/reagent_containers/glass/bottle/rogue/wine/sourwine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/sourwine = 70)
	desc = "A bottle that contains a Grenzelhoftian classic with a black ink cork-seal.. An extremely sour wine that is watered down with mineral water."

/obj/item/reagent_containers/glass/bottle/rogue/redwine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/redwine = 70)
	desc = "A bottle with the Valorian Merchant Guild cork-seal. This one appears to be labelled as a relatively young red-wine from the coinlord state."

/obj/item/reagent_containers/glass/bottle/rogue/whitewine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/whitewine = 70)
	desc = "A bottle with the Valorian Merchant Guild cork-seal. This one appears to be labelled as a sweet wine from the colder northern regions."

/obj/item/reagent_containers/glass/bottle/rogue/elfred
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/elfred = 70)
	desc = "A bottle gilded with a silver cork-seal. It appears to be labelled as a elvish red wine from Valoria. Likely worth more than what an entire village makes!"

/obj/item/reagent_containers/glass/bottle/rogue/elfblue
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/elfblue = 70)
	desc = "A bottle gilded with a golden cork-seal. This is the legendary Valmora Blue from the Vineyard of Valmora, headed by a sainted Dark-Elf swordsmaster. This bottle would swoon Gods over!"
