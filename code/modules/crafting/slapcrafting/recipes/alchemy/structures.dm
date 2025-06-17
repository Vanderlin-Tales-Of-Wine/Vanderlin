/datum/slapcraft_recipe/alchemy/structure/infuser
	name = "Essence Infuser"
	steps = list(
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/use_item/masonry/hammer,
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/use_item/masonry/hammer/second,
		)
	result_type = /obj/machinery/essence/infuser

/datum/slapcraft_recipe/alchemy/structure/splitter
	name = "Essence Splitter"
	steps = list(
		/datum/slapcraft_step/item/thaumic,
		/datum/slapcraft_step/item/glass,
		/datum/slapcraft_step/use_item/masonry/hammer,
		/datum/slapcraft_step/item/thaumic/second,
		/datum/slapcraft_step/use_item/masonry/hammer/second,
		)
	result_type = /obj/machinery/essence/splitter

/datum/slapcraft_recipe/alchemy/structure/resevoir
	name = "Essence Resevoir"
	steps = list(
		/datum/slapcraft_step/item/thaumic,
		/datum/slapcraft_step/item/glass,
		/datum/slapcraft_step/item/glass/second,
		/datum/slapcraft_step/item/glass/third,
		/datum/slapcraft_step/use_item/masonry/hammer,
		)
	result_type = /obj/machinery/essence/reservoir

/datum/slapcraft_recipe/alchemy/structure/combiner
	name = "Essence Combiner"
	steps = list(
		/datum/slapcraft_step/item/thaumic,
		/datum/slapcraft_step/item/thaumic/second,
		/datum/slapcraft_step/item/glass,
		/datum/slapcraft_step/item/glass/second,
		/datum/slapcraft_step/use_item/masonry/hammer,
		)
	result_type = /obj/machinery/essence/combiner

/datum/slapcraft_recipe/alchemy/structure/research
	name = "Research Matrix"
	steps = list(
		/datum/slapcraft_step/item/thaumic,
		/datum/slapcraft_step/item/thaumic/second,
		/datum/slapcraft_step/use_item/masonry/hammer,
		/datum/slapcraft_step/item/mana_crystal,
		)
	result_type = /obj/machinery/essence/research_matrix

/datum/slapcraft_recipe/alchemy/structure/enchanter
	name = "Enchantment Altar"
	steps = list(
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/use_item/masonry/hammer,
		/datum/slapcraft_step/item/thaumic,
		/datum/slapcraft_step/item/thaumic/second,
		/datum/slapcraft_step/use_item/masonry/hammer/second,
		/datum/slapcraft_step/item/mana_crystal,
		)
	result_type = /obj/machinery/essence/enchantment_altar

/datum/slapcraft_recipe/alchemy/structure/harvester
	name = "Essence Harvester"
	steps = list(
		/datum/slapcraft_step/item/thaumic,
		/datum/slapcraft_step/item/thaumic/second,
		/datum/slapcraft_step/use_item/masonry/hammer,
		/datum/slapcraft_step/item/mana_crystal,
		/datum/slapcraft_step/item/glass,
		/datum/slapcraft_step/use_item/masonry/hammer/second,
		)
	result_type = /obj/machinery/essence/harvester
