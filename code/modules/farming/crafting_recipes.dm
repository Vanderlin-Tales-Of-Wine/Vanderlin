/datum/crafting_recipe/structure/composter
	name = "composter"
	result = /obj/structure/composter
	reqs = list(/obj/item/grown/log/tree/small = 1)
	craftdiff = 0
	time = 2 SECONDS

/datum/crafting_recipe/structure/plough
	name = "plough"
	result = /obj/structure/plough
	reqs = list(/obj/item/grown/log/tree/small = 2, /obj/item/ingot/iron = 1)
	skillcraft = /datum/skill/craft/carpentry
	time = 4 SECONDS

/datum/crafting_recipe/woodthresher
	name = "thresher"
	result = list(/obj/item/weapon/thresher)
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/rope = 1)

/datum/crafting_recipe/militarythresher
	name = "military flail"
	result = list(/obj/item/weapon/thresher/military)
	reqs = list(/obj/item/weapon/thresher = 1,
				/obj/item/ingot/iron = 1)
