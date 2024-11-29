/obj/item/reagent_containers/food/snacks/meat
	var/subjectname = ""
	var/subjectjob = null

/obj/item/reagent_containers/food/snacks/meat/slab
	name = "meat"
	desc = ""
	bitesize = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = 3) //Meat has fats that a food processor can process into cooking oil
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/plain
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain
	slices_num = 3
	filling_color = "#FF0000"
	tastes = list("meat" = 1)
	foodtype = MEAT | RAW

/obj/item/reagent_containers/food/snacks/meat/slab/initialize_slice(obj/item/reagent_containers/food/snacks/meat/rawcutlet/slice, reagents_per_slice)
	..()
	var/mutable_appearance/filling = mutable_appearance(icon, "rawcutlet_coloration")
	filling.color = filling_color
	slice.add_overlay(filling)
	slice.filling_color = filling_color
	slice.name = "[name] cutlet"
/obj/item/reagent_containers/food/snacks/meat/slab/initialize_cooked_food(obj/item/reagent_containers/food/snacks/S, cooking_efficiency)
	..()
	S.name = "[name] steak"

///////////////////////////////////// HUMAN MEATS //////////////////////////////////////////////////////


/obj/item/reagent_containers/food/snacks/meat/slab/human
	name = "meat"
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/plain/human
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain/human
	tastes = list("tender meat" = 1)
	foodtype = MEAT | RAW | GROSS

/obj/item/reagent_containers/food/snacks/meat/slab/human/initialize_slice(obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain/human/slice, reagents_per_slice)
	..()
	slice.subjectname = subjectname
	slice.subjectjob = subjectjob
	if(subjectname)
		slice.name = "raw [subjectname] cutlet"
	else if(subjectjob)
		slice.name = "raw [subjectjob] cutlet"

/obj/item/reagent_containers/food/snacks/meat/slab/human/initialize_cooked_food(obj/item/reagent_containers/food/snacks/meat/S, cooking_efficiency)
	..()
	S.subjectname = subjectname
	S.subjectjob = subjectjob
	if(subjectname)
		S.name = "[subjectname] meatsteak"
	else if(subjectjob)
		S.name = "[subjectjob] meatsteak"

/obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/lizard
	icon_state = "lizardmeat"
	desc = ""
	filling_color = "#6B8E23"
	tastes = list("meat" = 4, "scales" = 1)
	foodtype = MEAT | RAW


/obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/shadow
	icon_state = "shadowmeat"
	desc = ""
	filling_color = "#202020"
	tastes = list("darkness" = 1, "meat" = 1)
	foodtype = MEAT | RAW

/obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/skeleton
	name = "bone"
	icon_state = "skeletonmeat"
	desc = ""
	filling_color = "#F0F0F0"
	tastes = list("bone" = 1)
	slice_path = null  //can't slice a bone into cutlets
	foodtype = GROSS

/obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/zombie
	name = " meat (rotten)"
	icon_state = "rottenmeat"
	desc = ""
	filling_color = "#6B8E23"
	tastes = list("brains" = 1, "meat" = 1)
	foodtype = RAW | MEAT | TOXIC

/obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/ethereal
	icon_state = "etherealmeat"
	desc = ""
	filling_color = "#97ee63"
	list_reagents = list(/datum/reagent/consumable/liquidelectricity = 3)
	tastes = list("pure electricity" = 2, "meat" = 1)
	foodtype = RAW | MEAT | TOXIC

////////////////////////////////////// OTHER MEATS ////////////////////////////////////////////////////////


/obj/item/reagent_containers/food/snacks/meat/slab/synthmeat
	name = "synthmeat"
	desc = ""
	foodtype = RAW | MEAT //hurr durr chemicals we're harmed in the production of this meat thus its non-vegan.

/obj/item/reagent_containers/food/snacks/meat/slab/meatproduct
	name = "meat product"
	desc = ""
	foodtype = RAW | MEAT

/obj/item/reagent_containers/food/snacks/meat/slab/monkey
	name = "monkey meat"
	foodtype = RAW | MEAT

/obj/item/reagent_containers/food/snacks/meat/slab/mouse
	name = "mouse meat"
	desc = ""
	foodtype = RAW | MEAT | GROSS

/obj/item/reagent_containers/food/snacks/meat/slab/corgi
	name = "corgi meat"
	desc = ""
	tastes = list("meat" = 4, "a fondness for wearing hats" = 1)
	foodtype = RAW | MEAT | GROSS

/obj/item/reagent_containers/food/snacks/meat/slab/pug
	name = "pug meat"
	desc = ""
	foodtype = RAW | MEAT | GROSS


////////////////////////////////////// MEAT STEAKS ///////////////////////////////////////////////////////////


/obj/item/reagent_containers/food/snacks/meat/steak
	name = "steak"
	desc = ""
	icon_state = "meatsteak"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 1)
	trash = /obj/item/trash/plate
	filling_color = "#B22222"
	foodtype = MEAT
	tastes = list("meat" = 1)

/obj/item/reagent_containers/food/snacks/meat/steak/plain
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/meat/steak/plain/human
	tastes = list("tender meat" = 1)
	foodtype = MEAT | GROSS

/obj/item/reagent_containers/food/snacks/meat/steak/killertomato
	name = "killer tomato steak"
	tastes = list("tomato" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/meat/steak/bear
	name = "bear steak"
	tastes = list("meat" = 1, "salmon" = 1)

/obj/item/reagent_containers/food/snacks/meat/steak/xeno
	name = "xeno steak"
	tastes = list("meat" = 1, "acid" = 1)

/obj/item/reagent_containers/food/snacks/meat/steak/goliath
	name = "goliath steak"
	desc = ""
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	icon_state = "goliathsteak"
	trash = null
	tastes = list("meat" = 1, "rock" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/meat/steak/gondola
	name = "gondola steak"
	tastes = list("meat" = 1, "tranquility" = 1)

/obj/item/reagent_containers/food/snacks/meat/steak/penguin
	name = "penguin steak"
	tastes = list("beef" = 1, "cod fish" = 1)

//////////////////////////////// MEAT CUTLETS ///////////////////////////////////////////////////////

//Raw cutlets

/obj/item/reagent_containers/food/snacks/meat/rawcutlet
	name = "raw cutlet"
	desc = ""
	icon_state = "rawcutlet"
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/cutlet/plain
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	filling_color = "#B22222"
	tastes = list("meat" = 1)
//	var/meat_type = "meat"
	foodtype = MEAT | RAW

/obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain/human
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/cutlet/plain/human
	tastes = list("tender meat" = 1)
	foodtype = MEAT | RAW | GROSS

/obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain/human/initialize_cooked_food(obj/item/reagent_containers/food/snacks/S, cooking_efficiency)
	..()
	if(subjectname)
		S.name = "[subjectname] [initial(S.name)]"
	else if(subjectjob)
		S.name = "[subjectjob] [initial(S.name)]"
//Cooked cutlets

/obj/item/reagent_containers/food/snacks/meat/cutlet
	name = "cutlet"
	desc = ""
	icon_state = "cutlet"
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#B22222"
	tastes = list("meat" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/meat/cutlet/plain

/obj/item/reagent_containers/food/snacks/meat/cutlet/plain/human
	tastes = list("tender meat" = 1)
	foodtype = MEAT | GROSS
