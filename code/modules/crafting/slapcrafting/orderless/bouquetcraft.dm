/datum/orderless_slapcraft/bouquet
	abstract_type = /datum/orderless_slapcraft/bouquet
	starting_item = /obj/item/natural/fibers
	related_skill = /datum/skill/misc/sewing
	skill_xp_gained = 5
	action_time = 5 SECONDS

/datum/orderless_slapcraft/bouquet/rosa
	name = "Rosa Bouquet"
	requirements = list(
	/obj/item/alch/rosa = 2,
	/obj/item/natural/cloth = 1
	)
	output_item = /obj/item/bouquet/rosa

/datum/orderless_slapcraft/bouquet/salvia
	name = "Salvia Bouquet"
	requirements = list(
	/obj/item/alch/salvia = 2,
	/obj/item/natural/cloth = 1
	)
	output_item = /obj/item/bouquet/salvia

/datum/orderless_slapcraft/bouquet/matricaria
	name = "Matricaria Bouquet"
	requirements = list(
	/obj/item/alch/matricaria = 2,
	/obj/item/natural/cloth = 1
	)
	output_item = /obj/item/bouquet/matricaria

/datum/orderless_slapcraft/bouquet/calendula
	name = "Calendula Bouquet"
	requirements = list(
	/obj/item/alch/calendula = 2,
	/obj/item/natural/cloth = 1
	)
	output_item = /obj/item/bouquet/calendula

/datum/orderless_slapcraft/flowercrown
	abstract_type = /datum/orderless_slapcraft/flowercrown
	starting_item = /obj/item/natural/fibers
	related_skill = /datum/skill/misc/sewing
	skill_xp_gained = 5
	action_time = 5 SECONDS

/datum/orderless_slapcraft/flowercrown/rosa
	name = "Rosa Crown"
	requirements = list(
	/obj/item/alch/rosa = 2
	)
	output_item = /obj/item/clothing/head/flowercrown/rosa

/datum/orderless_slapcraft/flowercrown/salvia
	name = "Salvia Crown"
	requirements = list(
	/obj/item/alch/salvia = 2
	)
	output_item = /obj/item/clothing/head/flowercrown/salvia



