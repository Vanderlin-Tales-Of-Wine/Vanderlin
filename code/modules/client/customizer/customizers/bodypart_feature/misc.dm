/datum/customizer/bodypart_feature/accessory
	name = "Accessory"
	customizer_choices = list(/datum/customizer_choice/bodypart_feature/accessory)
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer_choice/bodypart_feature/accessory
	name = "Accessory"
	feature_type = /datum/bodypart_feature/accessory
	allows_accessory_color_customization = FALSE
	sprite_accessories = list(
		/datum/sprite_accessory/accessories/earrings,
		/datum/sprite_accessory/accessories/earrings/sil,
		/datum/sprite_accessory/accessories/earrings/em,
		/datum/sprite_accessory/accessories/eyepierce,
		/datum/sprite_accessory/accessories/eyepierce/alt,
		/datum/sprite_accessory/accessories/choker,
		/datum/sprite_accessory/accessories/chokere,
		)

/datum/customizer/organ/ears/demihuman
	customizer_choices = list(/datum/customizer_choice/organ/ears/demihuman)
	allows_disabling = TRUE

/datum/customizer_choice/organ/ears/demihuman
	name = "Half-Kinhuman Ears"
	organ_type = /obj/item/organ/ears
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/ears/cat,
		/datum/sprite_accessory/ears/axolotl,
		/datum/sprite_accessory/ears/bat,
		/datum/sprite_accessory/ears/bear,
		/datum/sprite_accessory/ears/bigwolf,
		/datum/sprite_accessory/ears/bigwolf_inner,
		/datum/sprite_accessory/ears/rabbit,
		/datum/sprite_accessory/ears/bunny,
		/datum/sprite_accessory/ears/bunny_perky,
		/datum/sprite_accessory/ears/big/rabbit_large,
		/datum/sprite_accessory/ears/cat_big,
		/datum/sprite_accessory/ears/cat_normal,
		/datum/sprite_accessory/ears/cow,
		/datum/sprite_accessory/ears/curled,
		/datum/sprite_accessory/ears/deer,
		/datum/sprite_accessory/ears/eevee,
		/datum/sprite_accessory/ears/elf,
		/datum/sprite_accessory/ears/elephant,
		/datum/sprite_accessory/ears/fennec,
		/datum/sprite_accessory/ears/fish,
		/datum/sprite_accessory/ears/fox,
		/datum/sprite_accessory/ears/vulp,
		/datum/sprite_accessory/ears/husky,
		/datum/sprite_accessory/ears/jellyfish,
		/datum/sprite_accessory/ears/kangaroo,
		/datum/sprite_accessory/ears/lab,
		/datum/sprite_accessory/ears/murid,
		/datum/sprite_accessory/ears/otie,
		/datum/sprite_accessory/ears/pede,
		/datum/sprite_accessory/ears/sergal,
		/datum/sprite_accessory/ears/shark,
		/datum/sprite_accessory/ears/skunk,
		/datum/sprite_accessory/ears/squirrel,
		/datum/sprite_accessory/ears/wolf,
		/datum/sprite_accessory/ears/perky,
		/datum/sprite_accessory/ears/miqote,
		/datum/sprite_accessory/ears/lunasune,
		/datum/sprite_accessory/ears/sabresune,
		/datum/sprite_accessory/ears/possum,
		/datum/sprite_accessory/ears/raccoon,
		/datum/sprite_accessory/ears/mouse,
		/datum/sprite_accessory/ears/big/acrador_long,
		/datum/sprite_accessory/ears/big/acrador_short,
		/datum/sprite_accessory/ears/big/sandfox_large,
		)

/datum/customizer_choice/organ/horns/demihuman
	name = "Horns"
	organ_type = /obj/item/organ/horns
	sprite_accessories = list(
		/datum/sprite_accessory/horns/simple,
		/datum/sprite_accessory/horns/short,
		/datum/sprite_accessory/horns/curled,
		/datum/sprite_accessory/horns/ram,
		/datum/sprite_accessory/horns/guilmon,
		/datum/sprite_accessory/horns/uni,
		/datum/sprite_accessory/horns/oni,
		/datum/sprite_accessory/horns/oni_large,
		/datum/sprite_accessory/horns/broken,
		/datum/sprite_accessory/horns/rbroken,
		/datum/sprite_accessory/horns/lbroken,
		/datum/sprite_accessory/horns/drake,
		/datum/sprite_accessory/horns/knight,
		/datum/sprite_accessory/horns/antlers,
		/datum/sprite_accessory/horns/ramalt,
		/datum/sprite_accessory/horns/smallantlers,
		/datum/sprite_accessory/horns/curledramhorns,
		/datum/sprite_accessory/horns/curledramhornsalt,
		/datum/sprite_accessory/horns/smallramhorns,
		/datum/sprite_accessory/horns/smallramhornsalt,
		/datum/sprite_accessory/horns/smallramhornsthree,
		/datum/sprite_accessory/horns/liftedhorns,
		/datum/sprite_accessory/horns/sideswept,
		/datum/sprite_accessory/horns/bigcurlyhorns,
		/datum/sprite_accessory/horns/billberry,
		/datum/sprite_accessory/horns/stabbers,
		/datum/sprite_accessory/horns/unihorn,
		/datum/sprite_accessory/horns/longhorns,
		/datum/sprite_accessory/horns/outstretched,
		/datum/sprite_accessory/horns/halo,
		/datum/sprite_accessory/horns/greathorns,
		/datum/sprite_accessory/horns/bunhorns,
		/datum/sprite_accessory/horns/marauder,
		/datum/sprite_accessory/horns/faceguard,
		/datum/sprite_accessory/horns/sheephorns,
		/datum/sprite_accessory/horns/doublehorns,
		/datum/sprite_accessory/horns/tiefling,
		/datum/sprite_accessory/horns/tieflingalt
		)

/datum/customizer_choice/organ/tail/demihuman
	name = "Half-Kinhuman Tail"
	organ_type = /obj/item/organ/tail
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/tail/cat,
		/datum/sprite_accessory/tail/monkey,
		/datum/sprite_accessory/tail/axolotl,
		/datum/sprite_accessory/tail/batl,
		/datum/sprite_accessory/tail/bats,
		/datum/sprite_accessory/tail/bee,
		/datum/sprite_accessory/tail/catbig,
		/datum/sprite_accessory/tail/twocat,
		/datum/sprite_accessory/tail/corvid,
		/datum/sprite_accessory/tail/cow,
		/datum/sprite_accessory/tail/data_shark,
		/datum/sprite_accessory/tail/eevee,
		/datum/sprite_accessory/tail/fennec,
		/datum/sprite_accessory/tail/fish,
		/datum/sprite_accessory/tail/fox,
		/datum/sprite_accessory/tail/fox2,
		/datum/sprite_accessory/tail/hawk,
		/datum/sprite_accessory/tail/horse,
		/datum/sprite_accessory/tail/husky,
		/datum/sprite_accessory/tail/insect,
		/datum/sprite_accessory/tail/kangaroo,
		/datum/sprite_accessory/tail/kitsune,
		/datum/sprite_accessory/tail/lab,
		/datum/sprite_accessory/tail/murid,
		/datum/sprite_accessory/tail/orca,
		/datum/sprite_accessory/tail/otie,
		/datum/sprite_accessory/tail/rabbit,
		/datum/sprite_accessory/tail/redpanda,
		/datum/sprite_accessory/tail/pede,
		/datum/sprite_accessory/tail/sergal,
		/datum/sprite_accessory/tail/shark,
		/datum/sprite_accessory/tail/shepherd,
		/datum/sprite_accessory/tail/australian_shepherd,
		/datum/sprite_accessory/tail/skunk,
		/datum/sprite_accessory/tail/stripe,
		/datum/sprite_accessory/tail/straighttail,
		/datum/sprite_accessory/tail/squirrel,
		/datum/sprite_accessory/tail/tamamo_kitsune,
		/datum/sprite_accessory/tail/tentacle,
		/datum/sprite_accessory/tail/tiger,
		/datum/sprite_accessory/tail/wolf,
		/datum/sprite_accessory/tail/guilmon,
		/datum/sprite_accessory/tail/sharknofin,
		/datum/sprite_accessory/tail/raptor,
		/datum/sprite_accessory/tail/spade,
		/datum/sprite_accessory/tail/leopard,
		/datum/sprite_accessory/tail/deer,
		/datum/sprite_accessory/tail/raccoon,
		/datum/sprite_accessory/tail/sabresune,
		/datum/sprite_accessory/tail/lizard/smooth,
		/datum/sprite_accessory/tail/lizard/dtiger,
		/datum/sprite_accessory/tail/lizard/ltiger,
		/datum/sprite_accessory/tail/lizard/spikes,
		/datum/sprite_accessory/tail/rattlesnake
		)
