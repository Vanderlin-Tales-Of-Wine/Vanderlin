/datum/team/vampire
	name = "\improper Vampires"
	member_name = "child of Kain"

	var/lord_level = 0
	var/datum/mind/lord

/datum/team/vampire/New(starting_members)
	. = ..()

/datum/team/add_member(datum/mind/new_member)
	. = ..()
