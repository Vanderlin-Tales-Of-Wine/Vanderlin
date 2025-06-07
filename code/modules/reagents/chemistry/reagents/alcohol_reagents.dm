#define ALCOHOL_THRESHOLD_MODIFIER 1 //Greater numbers mean that less alcohol has greater intoxication potential
#define ALCOHOL_RATE 0.005 //The rate at which alcohol affects you
#define ALCOHOL_EXPONENT 1.6 //The exponent applied to boozepwr to make higher volume alcohol at least a little bit damaging to the liver

////////////// I don't know who made this header before I refactored alcohols but I'm going to fucking strangle them because it was so ugly, holy Christ
// ALCOHOLS //
//////////////

/datum/reagent/consumable/ethanol
	name = "Ethanol"
	description = "A well-known alcohol with a variety of applications."
	color = "#404030" // rgb: 64, 64, 48
	nutriment_factor = 0
	taste_description = "alcohol"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	liquid_fire_power = 10
	hydration_factor = 10
	var/boozepwr = 65 //Higher numbers equal higher hardness, higher hardness equals more intense alcohol poisoning
	var/datum/reagent/age_path
	var/age_time = 10 MINUTES
	var/age_timer

/datum/reagent/consumable/ethanol/New()
	. = ..()
	if(age_path && holder)
		age_timer = addtimer(CALLBACK(src, PROC_REF(age_beer)), age_time, TIMER_OVERRIDE | TIMER_STOPPABLE | TIMER_UNIQUE)

/datum/reagent/consumable/ethanol/on_merge(data, amount)
	. = ..()
	if(age_path && holder)
		var/timeleft = timeleft(age_timer)
		var/total_amount = volume + amount

		var/existing_progress = (volume / total_amount) * (age_time - timeleft)
		var/new_progress = (amount / total_amount) * age_time
		var/adjusted_progress = existing_progress + new_progress

		age_timer = addtimer(CALLBACK(src, PROC_REF(age_beer)), adjusted_progress, TIMER_OVERRIDE | TIMER_STOPPABLE | TIMER_UNIQUE)

/datum/reagent/consumable/ethanol/proc/age_beer()
	var/old_volume = volume
	var/datum/reagents/old_holder = holder
	holder?.remove_reagent(src.type, volume)
	old_holder?.add_reagent(age_path, old_volume)
/*
Boozepwr Chart
Note that all higher effects of alcohol poisoning will inherit effects for smaller amounts (i.e. light poisoning inherts from slight poisoning)
In addition, severe effects won't always trigger unless the drink is poisonously strong
All effects don't start immediately, but rather get worse over time; the rate is affected by the imbiber's alcohol tolerance

0: Non-alcoholic
1-10: Barely classifiable as alcohol - occassional slurring
11-20: Slight alcohol content - slurring
21-30: Below average - imbiber begins to look slightly drunk
31-40: Just below average - no unique effects
41-50: Average - mild disorientation, imbiber begins to look drunk
51-60: Just above average - disorientation, vomiting, imbiber begins to look heavily drunk
61-70: Above average - small chance of blurry vision, imbiber begins to look smashed
71-80: High alcohol content - blurry vision, imbiber completely shitfaced
81-90: Extremely high alcohol content - heavy toxin damage, passing out
91-100: Dangerously toxic - swift death
*/

/datum/reagent/consumable/ethanol/on_mob_life(mob/living/carbon/C)
	if(C.drunkenness < volume * boozepwr * ALCOHOL_THRESHOLD_MODIFIER || boozepwr < 0)
		var/booze_power = boozepwr
		C.drunkenness = max((C.drunkenness + (sqrt(volume) * booze_power * ALCOHOL_RATE)), 0) //Volume, power, and server alcohol rate effect how quickly one gets drunk
	return ..()

/datum/reagent/consumable/ethanol/reaction_obj(obj/O, reac_volume)
	if(istype(O, /obj/item/paper))
		var/obj/item/paper/paperaffected = O
		paperaffected.clearpaper()
		to_chat(usr, "<span class='notice'>[paperaffected]'s ink washes away.</span>")
	if(istype(O, /obj/item/book))
		if(reac_volume >= 5)
			var/obj/item/book/affectedbook = O
			affectedbook.dat = null
			O.visible_message("<span class='notice'>[O]'s writing is washed away by [name]!</span>")
		else
			O.visible_message("<span class='warning'>[O]'s ink is smeared by [name], but doesn't wash away!</span>")
	return

/datum/reagent/consumable/ethanol/reaction_mob(mob/living/M, method=TOUCH, reac_volume)//Splashing people with ethanol isn't quite as good as fuel.
	if(!isliving(M))
		return

	if(method in list(TOUCH, VAPOR, PATCH))
		M.adjust_fire_stacks(reac_volume / 15)

	return ..()

/datum/reagent/consumable/ethanol/beer
	name = "Beer"
	description = ""
	color = "#a17c10" // rgb: 102, 67, 0
	nutriment_factor = 0.1
	boozepwr = 25
	taste_description = "ale"
	glass_name = "glass of beer"
	glass_desc = ""

/datum/reagent/consumable/ethanol/rum
	name = "Rum"
	description = ""
	color = "#5f3b23" // rgb: 102, 67, 0
	boozepwr = 25
	taste_description = "rum"

/datum/reagent/consumable/ethanol/cider
	name = "Apple Cider"
	boozepwr = 40
	taste_description = "cider"
	glass_name = "glass of cider"
	color = "#6aa945"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/cider/pear
	name = "Pear Cider"

/datum/reagent/consumable/ethanol/cider/strawberry
	name = "Strawberry Cider"
	color = "#da4d4d"
	taste_description = "strawberry cider"

/datum/reagent/consumable/ethanol/aqua_vitae
	name = "Aqua Vitae"
	boozepwr = 150
	taste_description = "death"
	color = "#6e6e6e"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/brandy
	name = "Apple Brandy"
	boozepwr = 60
	taste_description = "brandy"
	glass_name = "glass of brandy"
	color = "#6aa945"
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/brandy/pear
	name = "Pear Brandy"

/datum/reagent/consumable/ethanol/brandy/strawberry
	name = "Strawberry Brandy"
	color = "#bb1a1a"

/datum/reagent/consumable/ethanol/brandy/tangerine
	name = "Tangerine Brandy"
	color = "#bb751a"

/datum/reagent/consumable/ethanol/brandy/plum
	name = "Plum Brandy"
	color = "#5c0449"

/datum/reagent/consumable/ethanol/wine
	name = "Wine"
	boozepwr = 30
	taste_description = "wine"
	glass_name = "glass of wine"
	color = "#8a0b0b"

/datum/reagent/consumable/ethanol/light
	name = "Light Beer"
	description = "An alcoholic beverage brewed since ancient times on Old Earth. This variety has reduced calorie and alcohol content."
	boozepwr = 5 //Space Europeans hate it
	taste_description = "dish water"
	glass_name = "glass of light beer"
	glass_desc = ""

/datum/reagent/consumable/ethanol/green
	name = "Green Beer"
	description = "An alcoholic beverage brewed since ancient times on Old Earth. This variety is dyed a festive green."
	color = "#A8E61D"
	taste_description = "green piss water"
	glass_icon_state = "greenbeerglass"
	glass_name = "glass of green beer"
	glass_desc = ""

/datum/reagent/consumable/ethanol/green/on_mob_life(mob/living/carbon/M)
	if(M.color != color)
		M.add_atom_colour(color, TEMPORARY_COLOUR_PRIORITY)
	return ..()

/datum/reagent/consumable/ethanol/green/on_mob_end_metabolize(mob/living/M)
	M.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, color)

/datum/reagent/consumable/ethanol/ale
	name = "Ale"
	description = "A dark alcoholic beverage made with malted barley and yeast."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 65
	taste_description = "hearty barley ale"
	glass_icon_state = "aleglass"
	glass_name = "glass of ale"
	glass_desc = ""


// BEERS - Imported for now, later the styles will be 'mockable', if and when I get to brewing.

// Humen Production - Underwhelming, but cheap.

/datum/reagent/consumable/ethanol/gin
	name = "Gin"
	boozepwr = 12
	taste_description = "fruity"
	color = "#809978"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/spottedhen
	name = "Spotted Hen"
	boozepwr = 15
	taste_description = "cheap pisswater"
	color = "#DBD77F"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/hagwoodbitter
	name = "Hagwood Bitter"
	boozepwr = 25
	taste_description = "dull crispness"
	color = "#BBB525"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/blackgoat
	name = "Black Gote Kriek"
	boozepwr = 25
	taste_description = "overwhelming sourness"
	color = "#401806"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/onion
	name = "Royal Onion Cognac"
	boozepwr = 10
	taste_description = "spicy sweet malty overtones"
	color = "#683e00"
	quality = DRINK_NICE

// Elf Production - LEAF-LOVERS MOTHERFUCKER

/datum/reagent/consumable/ethanol/aurorian
	name = "Aurorian"
	boozepwr = 5
	taste_description = "subtle herbacious undertones"
	color = "#5D8A8A"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/fireleaf // cabbbage
	name = "Fireleaf"
	boozepwr = 2
	taste_description = "bland liquor"
	color = "#475e45"
	quality = DRINK_NICE

// Dwarven Production - Best in the Realms

/datum/reagent/consumable/ethanol/butterhairs
	name = "Butterhairs"
	boozepwr = 30
	taste_description = "buttery richness"
	color = "#5D8A8A"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/stonebeards
	name = "Stonebeard Reserve"
	boozepwr = 40
	taste_description = "potent oatlike liquor"
	color = "#5D8A8A"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/voddena // Not vodka. Trust me.
	name = "Voddena"
	boozepwr = 55  // holy shit
	taste_description = "burning starchy wet dirt"
	color = "#a1a1a1"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/limoncello
	name = "Limoncello"
	boozepwr = 45  // holy shit
	taste_description = "burning and lemony"
	color = "#d2da63"
	quality = DRINK_GOOD

// WINE - Fancy.. And yes: all drinks are beer, technically. Cope. Seethe. I didnt code it like this.

// Humen Production - Grape Based

/datum/reagent/consumable/ethanol/sourwine // Peasant grade shit.
	name = "Sour Wine"
	boozepwr = 20
	taste_description = "sour wine"
	color = "#552b4b"

/datum/reagent/consumable/ethanol/whitewine
	name = "White Wine"
	boozepwr = 30
	taste_description = "sweet white wine"
	color = "#F3ED91"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/redwine
	name = "Red Wine"
	boozepwr = 30
	taste_description = "tannin-stricken wine"
	color = "#571111"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/jackberrywine
	name = "Jackberry Wine"
	boozepwr = 15
	taste_description = "sickly sweet young wine"
	color = "#3b2342"
	quality = DRINK_NICE
	age_path = /datum/reagent/consumable/ethanol/jackberrywine/aged
	age_time = 10 MINUTES

/datum/reagent/consumable/ethanol/jackberrywine/aged
	name = "Aged Jackberry Wine"
	boozepwr = 30
	taste_description = "sickly sweet aged wine"
	color = "#402249"
	quality = DRINK_GOOD
	age_path = /datum/reagent/consumable/ethanol/jackberrywine/delectable

/datum/reagent/consumable/ethanol/jackberrywine/delectable
	name = "Delectable Jackberry Wine"
	boozepwr = 30
	taste_description = "sickly sweet delectably aged wine"
	color = "#652679"
	quality = DRINK_VERYGOOD
	age_path = null

/datum/reagent/consumable/ethanol/plum_wine
	name = "Umeshu"
	boozepwr = 15
	taste_description = "sickly sweet young wine"
	color = "#c997d8"
	quality = DRINK_NICE
	age_path = /datum/reagent/consumable/ethanol/plum_wine/aged
	age_time = 10 MINUTES

/datum/reagent/consumable/ethanol/plum_wine/aged
	name = "Aged Umeshu"
	boozepwr = 30
	taste_description = "sickly sweet aged wine"
	color = "#c27cd8"
	quality = DRINK_GOOD
	age_path = /datum/reagent/consumable/ethanol/plum_wine/delectable

/datum/reagent/consumable/ethanol/plum_wine/delectable
	name = "Delectable Umeshu"
	boozepwr = 30
	taste_description = "sickly sweet delectably aged wine"
	color = "#a854c2"
	quality = DRINK_VERYGOOD
	age_path = null

/datum/reagent/consumable/ethanol/tangerine
	name = "Tangerine Wine"
	boozepwr = 15
	taste_description = "bitter sweet young wine"
	color = "#e7aa59"
	quality = DRINK_NICE
	age_path = /datum/reagent/consumable/ethanol/tangerine/aged

/datum/reagent/consumable/ethanol/tangerine/aged
	name = "Aged Tangerine Wine"
	boozepwr = 30
	taste_description = "bitter sweet aged wine"
	color = "#d68d2d"
	quality = DRINK_GOOD
	age_path = /datum/reagent/consumable/ethanol/tangerine/delectable

/datum/reagent/consumable/ethanol/tangerine/delectable
	name = "Delectable Tangerine Wine"
	boozepwr = 30
	taste_description = "bitter sweet delectably aged wine"
	color = "#eb9321"
	quality = DRINK_VERYGOOD
	age_path = null

/datum/reagent/consumable/ethanol/raspberry
	name = "Raspberry Wine"
	boozepwr = 15
	taste_description = "bitter sweet young wine"
	color = "#ee5ea6"
	quality = DRINK_NICE
	age_path = /datum/reagent/consumable/ethanol/raspberry/aged

/datum/reagent/consumable/ethanol/raspberry/aged
	name = "Aged Raspberry Wine"
	boozepwr = 30
	taste_description = "bitter sweet aged wine"
	color = "#d83788"
	quality = DRINK_GOOD
	age_path = /datum/reagent/consumable/ethanol/raspberry/delectable

/datum/reagent/consumable/ethanol/raspberry/delectable
	name = "Delectable Raspberry Wine"
	boozepwr = 30
	taste_description = "bitter sweet delectably aged wine"
	color = "#db0d74"
	quality = DRINK_VERYGOOD
	age_path = null

/datum/reagent/consumable/ethanol/blackberry
	name = "Blackberry Wine"
	boozepwr = 15
	taste_description = "bitter tart young wine"
	color = "#861491"
	quality = DRINK_NICE
	age_path = /datum/reagent/consumable/ethanol/blackberry/aged

/datum/reagent/consumable/ethanol/blackberry/aged
	name = "Aged Blackberry Wine"
	boozepwr = 30
	taste_description = "bitter tart aged wine"
	color = "#58065f"
	quality = DRINK_GOOD
	age_path = /datum/reagent/consumable/ethanol/blackberry/delectable

/datum/reagent/consumable/ethanol/blackberry/delectable
	name = "Delectable Blackberry Wine"
	boozepwr = 30
	taste_description = "bitter tart delectably aged wine"
	color = "#330038"
	quality = DRINK_VERYGOOD
	age_path = null

/datum/reagent/consumable/ethanol/tiefling
	name = "Tiefling Blood Wine"
	boozepwr = 15
	taste_description = "bitter young wine"
	color = "#b32525"
	quality = DRINK_NICE
	glows = TRUE
	age_path = /datum/reagent/consumable/ethanol/tiefling/aged

/datum/reagent/consumable/ethanol/tiefling/aged
	name = "Aged Tiefling Blood Wine"
	boozepwr = 30
	taste_description = "bitter aged wine"
	color = "#e21313"
	quality = DRINK_GOOD
	age_path = /datum/reagent/consumable/ethanol/tiefling/delectable

/datum/reagent/consumable/ethanol/tiefling/delectable
	name = "Delectable Tiefling Blood Wine"
	boozepwr = 30
	taste_description = "bitter delectably aged wine"
	color = "#ff0000"
	quality = DRINK_VERYGOOD
	age_path = null

// Elf Production - Berries & Herbal

/datum/reagent/consumable/ethanol/elfred
	name = "Elven Red"
	boozepwr = 15
	taste_description = "delectable fruity notes"
	color = "#6C0000"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/elfblue
	name = "Valmora Blue"
	boozepwr = 50
	taste_description = "saintly sweetness"
	color = "#2C9DAF"
	quality = DRINK_FANTASTIC

/datum/reagent/consumable/ethanol/jagdtrunk // JÄGERMEISTER!!!!
	name = "Jagdtrunk"
	boozepwr = 55  // gotta be stronk
	taste_description = "spicy herbal remedy"
	color = "#331f18"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/apfelweinheim
	name = "Appelheimer"
	boozepwr = 45
	taste_description = "tart crispness and mellow sweetness"
	color = "#e0cb55"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/rtoper
	name = "Rockhill Toper"
	boozepwr = 40
	taste_description = "overwhelming tartness"
	color = "#e0a400"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/nred
	name = "Norwardine Red"
	boozepwr = 30
	taste_description = "heavy caramel note and slight bitterness"
	color = "#543633"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/gronnmead
	name = "Ragnar's Brew"
	boozepwr = 35
	taste_description = "notes of honey and red berries" //I love red mead ok...
	color = "#772C48"
	quality = DRINK_GOOD

//Avar boozes

/datum/reagent/consumable/ethanol/avarmead
	name = "Zögiin bal"
	boozepwr = 30
	taste_description = "spicy honey"
	color = "#e0a400"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/avarrice
	name = "Makkolir"
	boozepwr = 30
	taste_description = "tangy sweetness"
	color = "#ddcbc9"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/saigamilk //No way, kumys from avar!!!
	name = "Bökhiin Arkhi"
	boozepwr = 15
	taste_description = "bubbly, sour salt"
	color = "#dddddd"

//Kazengun boozes

/datum/reagent/consumable/ethanol/kgunlager
	name = "Yamaguchi Pale"
	boozepwr = 10 //A PALE imitation actual beer...
	taste_description = "mellow bitterness and a hint of green tea"
	color = "#d7dbbc"

/datum/reagent/consumable/ethanol/kgunsake
	name = "Junmai-ginjo"
	boozepwr = 50
	taste_description = "dry sweetness"
	color = "#ccd7e0"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/kgunplum
	name = "Umeshu"
	boozepwr = 30
	taste_description = "a mix of sweet and sour"
	color = "#ddb99b"
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/mead
	name = "Mead"
	description = "A warriors drink, though a cheap one."
	color = "#664300" // rgb: 102, 67, 0
	nutriment_factor = 1 * REAGENTS_METABOLISM
	boozepwr = 30
	quality = DRINK_NICE
	taste_description = "sweet, sweet alcohol"
	glass_icon_state = "meadglass"
	glass_name = "Mead"
	glass_desc = ""

/datum/reagent/consumable/ethanol/mead/spider
	color = "#660061"
	glows = TRUE
