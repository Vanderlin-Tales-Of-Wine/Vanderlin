/datum/chemical_reaction/reagent_explosion
	name = "Generic explosive"
	id = "reagent_explosion"
	var/strengthdiv = 10
	var/modifier = 0

/datum/chemical_reaction/reagent_explosion/proc/do_explosion(datum/reagents/holder, created_volume)
	var/turf/T = get_turf(holder.my_atom)
	var/lastkey = holder.my_atom.fingerprintslast
	log_game("Reagent explosion reaction occurred at [AREACOORD(T)]. Last Fingerprint: [lastkey ? lastkey : "N/A"]." )
	var/datum/effect_system/reagents_explosion/e = new()
	e.set_up(modifier + round(created_volume/strengthdiv, 1), T, 0, 0)
	e.start()
	holder.clear_reagents()

/datum/chemical_reaction/reagent_explosion/on_reaction(datum/reagents/holder, created_volume)
	do_explosion()

