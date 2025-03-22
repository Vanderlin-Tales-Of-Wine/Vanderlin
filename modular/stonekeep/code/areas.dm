// ==============================================================
// ==============================================================
/*	..................   Areas   ................... */

/area/rogue/indoors/town/hamlet
	name = "indoors"
	alpha = 150
	droning_sound = 'sound/music/area/indoor.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/deliverer.ogg'
	converted_type = /area/rogue/outdoors/exposed/townhamlet

/area/rogue/outdoors/exposed/townhamlet
	name = "stone hamlet"
	icon_state = "town"
	alpha = 150
	droning_sound = 'sound/music/area/StreetsofWhiterun.ogg'
	droning_sound_dusk = null
	droning_sound_night = 'sound/music/area/towngen.ogg'

/area/rogue/indoors/town/tavern/saiga
	droning_sound = list('sound/music/area/Folia1490.ogg', 'sound/music/area/TheBanneredMare.ogg')
	droning_sound_night = list('sound/music/area/LeTourdion.ogg', 'sound/music/area/JaimSansPenserLaidure.ogg')
	converted_type = /area/rogue/outdoors/exposed/tavern/saiga

/area/rogue/outdoors/exposed/tavern/saiga
	droning_sound = list('sound/music/area/Folia1490.ogg', 'sound/music/area/TheBanneredMare.ogg')
	droning_sound_night = list('sound/music/area/LeTourdion.ogg', 'sound/music/area/JaimSansPenserLaidure.ogg')

/area/rogue/indoors/town/manor/stone
	name = "stonehill manor"
	alpha = 50
	droning_sound = list('sound/music/area/manor.ogg', 'sound/music/area/manor2.ogg')
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/manorgarri
	first_time_text = "Stonehill manor"

/area/rogue/indoors/town/garrison
	name = "garrison"
	alpha = 100
	droning_sound = list('sound/music/area/manorgarri.ogg', 'sound/music/area/Wanyada.ogg')
	droning_sound_dusk = null
	droning_sound_night = null
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/rogue/outdoors/exposed/manorgarri


/area/rogue/indoors/town/church
	name = "temple"
	icon_state = "church"
	droning_sound = list('modular/stonekeep/kaizoku/sound/ambience/Syzygy.ogg', 'sound/music/area/Temple.ogg')
	droning_sound_dusk = null
	droning_sound_night = 'sound/music/area/churchnight.ogg'
	converted_type = /area/rogue/outdoors/exposed/church

/area/rogue/outdoors/exposed/church
	icon_state = "church"
	droning_sound = list('modular/stonekeep/kaizoku/sound/ambience/Syzygy.ogg', 'sound/music/area/Temple.ogg')
	droning_sound_dusk = null
	droning_sound_night = 'sound/music/area/churchnight.ogg'

/area/rogue/indoors/town/bath/redhouse
	name = "baths"
	droning_sound = 'sound/music/area/Fulminate.ogg'




/area/rogue/outdoors/rtfield/plague_district
	ambush_mobs = list(/mob/living/carbon/human/species/human/northern/bum/skilled/madman = 40, /mob/living/carbon/human/species/zizombie/npc/peasant = 40)
	first_time_text = "PLAGUE DISTRICT"
	color = "#d4da75"
	name = "danger (plague district)"
	droning_sound = 'sound/music/area/underworlddrone.ogg'
	ambientsounds = 'sound/ambience/creepywind.ogg'
	ambientnight = 'sound/ambience/creepywind.ogg'
	spookysounds = SPOOKY_MYSTICAL
	spookynight = SPOOKY_MYSTICAL

/area/rogue/outdoors/rtfield/outlaw
	ambush_mobs = list(/mob/living/carbon/human/species/human/northern/bum/skilled/outlaw = 50)
	name = "danger (outlaws)"
	first_time_text = ""
	color = "#e9baa3"
	ambush_times = list("day","dawn","night","dusk")
	droning_sound = 'sound/music/area/forest.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/forestnight.ogg'
	ambientsounds = AMB_FORESTDAY
	ambientnight = AMB_FORESTNIGHT
	spookysounds = SPOOKY_CROWS
	spookynight = SPOOKY_FOREST


/area/rogue/outdoors/rtfield/hamlet
	name = "hamlet surroundings"
	ambush_times = list("night","dusk")
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/wolf = 60,
				/mob/living/carbon/human/species/goblin/skilled/ambush = 5,
				/mob/living/simple_animal/pet/cat/cabbit = 10)
	first_time_text = "Stonehill Valley"
	ambush_types = list(
				/turf/open/floor/dirt)

/area/rogue/under/cave/sumpgrotto
	name = "sump grotto"
	first_time_text = "Sump Grotto"
	ambush_types = list(
				/turf/open/floor/dirt/muddie, /turf/open/floor/naturalstone/rough)
	ambush_times = list("day","dawn","night","dusk")
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/mole = 50,
				/mob/living/carbon/human/species/goblin/skilled/ambush/cave = 50)

/area/rogue/under/lavamonastery
	name = "danger(monastery)"
	icon_state = "cavelava"
	ambientsounds = AMB_CAVELAVA
	ambientnight = AMB_CAVELAVA
	spookysounds = SPOOKY_CAVE
	spookynight = SPOOKY_CAVE
	droning_sound = 'modular/stonekeep/kaizoku/sound/ambience/Syzygy.ogg'
	converted_type = /area/rogue/outdoors/exposed/decap

/area/rogue/under/cavelava
	first_time_text = ""

/area/rogue/outdoors/rtfield/spooky		// haunts ambush and dug down hidden treasure
	ambush_mobs = list(/mob/living/simple_animal/hostile/haunt = 50)
	name = "spooky place"
	color = "#9294d3"

/area/rogue/outdoors/mountains/deception
	name = "deception"
	icon_state = "deception"
	first_time_text = "THE CANYON OF DECEPTION"
	ambush_types = list(
				/turf/open/floor/dirt)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/troll = 20,
				/mob/living/carbon/human/species/skeleton/skilled/fighter = 15,
				/mob/living/carbon/human/species/goblin/skilled/ambush/hell = 50)

/area/rogue/outdoors/mountains/decap
	name = "mt decapitation"
	icon_state = "decap"
	ambush_types = list(
				/turf/open/floor/snow)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/troll = 15,
				/mob/living/carbon/human/species/skeleton/skilled/unarmed = 25,
				/mob/living/carbon/human/species/skeleton/skilled/fighter = 25)
	droning_sound = 'sound/music/area/decap.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "MOUNT DECAPITATION"
	ambush_times = list("night","dawn","dusk","day")
	converted_type = /area/rogue/indoors/shelter/mountains/decap

// modifications to bog area
/area/rogue/outdoors/bog/wetlands
	ambush_types = list(
				/turf/open/floor/dirt,
				/turf/open/water/swamp)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/bigrat = 20,
				/mob/living/simple_animal/hostile/retaliate/spider = 20,
				/mob/living/carbon/human/species/goblin/npc/ambush/sea = 20,
				/mob/living/simple_animal/hostile/retaliate/trollbog = 3)
	first_time_text = "TREACHEROUS WETLANDS"

/area/rogue/outdoors/bog/wetlands/gator
	ambush_types = list(
				/turf/open/floor/dirt/muddie,
				/turf/open/water/swamp)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/gator = 10)


/area/rogue/outdoors/woods/stone
	ambush_types = list(
				/turf/open/floor/grass, /turf/open/floor/dirt)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/wolf = 40,
				/mob/living/simple_animal/hostile/retaliate/spider/hairy = 10)
	first_time_text = "MURDER WOODS"
	converted_type = /area/rogue/indoors/shelter/woods


/area/rogue/outdoors/beach
	name = "beach"
	droning_sound = 'modular/stonekeep/kaizoku/sound/ambience/Oceansanct.ogg'
	droning_sound_dusk = 'modular/stonekeep/kaizoku/sound/ambience/Town_in_Rogue.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Defenestration.ogg'

/area/rogue/under/cave/abandoned_mine
	name = "abandoned mine"
	first_time_text = "Abandoned Mine"
	ambush_types = list(
				/turf/open/floor/dirt)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/bigrat = 30,
				/mob/living/carbon/human/species/goblin/skilled/ambush/cave = 5,
				/mob/living/simple_animal/hostile/retaliate/mole = 10)


/area/rogue/indoors/cave/volf
	name = "volf cave"
	icon_state = "cave"

/area/rogue/indoors/cave/spider
	name = "spider cave"
	icon_state = "cave"

/area/rogue/outdoors/town/amphitheatre
	name = "town (amphitheatre)"

/area/rogue/under/catacombs
	name = "catacombs"
	icon_state = "cavewet"
	first_time_text = "The Catacombs"
	ambientsounds = AMB_CAVEWATER
	ambientnight = AMB_CAVEWATER
	spookysounds = SPOOKY_CAVE
	spookynight = SPOOKY_CAVE
	droning_sound = 'sound/music/area/caves.ogg'
	droning_sound_dusk = 'modular/stonekeep/kaizoku/sound/ambience/Bucolic.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Nebula.ogg'
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/water/swamp)
	ambush_mobs = list(
				/mob/living/carbon/human/species/skeleton/skilled/unarmed = 30,
				/mob/living/simple_animal/hostile/retaliate/bigrat = 10)
	converted_type = /area/rogue/outdoors/caves

/area/rogue/under/catacombs/dwarfoutpost
	name = "underrock outpost"
	first_time_text = "Underrock Outpost"
	ambush_types = list(
				/turf/open/water/swamp)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/lamia = 30,
				/mob/living/simple_animal/hostile/retaliate/headless = 20)

/area/rogue/under/catacombs/dwarfoutpost/orcy
	ambush_types = list(
				/turf/open/floor/blocks/newstone/alt)
	ambush_mobs = list(
				/mob/living/carbon/human/species/orc/skilled/savage = 50)

/area/rogue/under/town/caverogue/saltmine
	name = "salt mine"
	first_time_text = "Salt Mine"

/area/rogue/under/necropolis
	name = "necropolis"
	icon_state = "cave"
	first_time_text = "Necropolis"
	ambientsounds = AMB_CAVEWATER
	ambientnight = AMB_CAVEWATER
	spookysounds = SPOOKY_CAVE
	spookynight = SPOOKY_CAVE
	droning_sound = 'sound/music/area/caves.ogg'
	droning_sound_dusk = 'modular/stonekeep/kaizoku/sound/ambience/Bucolic.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Nebula.ogg'
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/water/swamp)
	ambush_mobs = list(
				/mob/living/carbon/human/species/skeleton/skilled/unarmed = 30,
				/mob/living/simple_animal/hostile/retaliate/bigrat = 10)

