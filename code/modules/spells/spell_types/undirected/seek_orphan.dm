/datum/action/cooldown/spell/undirected/seek_orphan
	name = "Brat Detector"
	desc = "Find the distance between me and one of my brats."

	charge_required = FALSE
	cooldown_time = 20 SECONDS

	var/datum/weakref/targeted_orphan

/datum/action/cooldown/spell/undirected/seek_orphan/Destroy()
	targeted_orphan = null
	return ..()

/datum/action/cooldown/spell/undirected/seek_orphan/before_cast(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return
	var/list/orphans = list()
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(!H.mind)
			continue
		if(!HAS_TRAIT(H, TRAIT_ORPHAN))
			continue
		orphans += H

	if(!length(orphans))
		to_chat(owner, span_red("There aren't any..."))
		return . | SPELL_CANCEL_CAST

	var/mob/orphan = browser_input_list(owner, "Which One?", "Seek Orphan", orphans)
	if(QDELETED(src) || QDELETED(cast_on) || QDELETED(targeted_orphan) || !can_cast_spell())
		return . | SPELL_CANCEL_CAST
	if(!orphan)
		reset_cooldown()
		return . | SPELL_CANCEL_CAST

	targeted_orphan = WEAKREF(orphan)
	return TRUE

/datum/action/cooldown/spell/undirected/seek_orphan/cast(atom/cast_on)
	. = ..()
	var/mob/orphan = targeted_orphan.resolve()
	if(QDELETED(orphan))
		return
	to_chat(owner, span_notice("That brat is [where_orphan(owner, orphan)]."))

/datum/action/cooldown/spell/undirected/seek_orphan/proc/where_orphan(mob/living/carbon/human/tracked_orphan)
	var/turf/our_turf = get_turf(owner)
	var/turf/their_turf = get_turf(tracked_orphan)
	var/our_z = our_turf?.z
	var/their_z = their_turf?.z
	var/dist = get_dist(our_turf, their_turf)
	var/dir = get_dir(our_turf, their_turf)
	var/dir_text = dir2text(dir)
	var/distance_text

	switch(dist)
		if(0 to 7)
			distance_text = "very close"
		if(8 to 15)
			distance_text = "close"
		if(16 to 35)
			distance_text = "near"
		if(36 to 49)
			distance_text = "somewhat near"
		if(50 to 70)
			distance_text = "slightly far"
		if(71 to 98)
			distance_text = "somewhat far"
		if(99 to 127)
			distance_text = "far"
		else
			distance_text = "very far"

	var/z_text = null
	if(our_z != their_z)
		z_text = ", [our_z > their_z ? "below me" : "above me"]"

	return "[distance_text]... and to the [dir_text][z_text]."
