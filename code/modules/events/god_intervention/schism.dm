/// Tracks schism participants and their chosen sides
GLOBAL_LIST_EMPTY(tennite_schisms)

/datum/tennite_schism
    var/datum/weakref/challenger_god
    var/datum/weakref/astrata_god
    var/list/supporters_astrata = list()
    var/list/supporters_challenger = list()
    var/list/neutrals = list()
    var/start_time
    var/end_time
    var/announced = FALSE

/datum/tennite_schism/New(datum/patron/challenger)
    . = ..()
    src.challenger_god = WEAKREF(challenger)
    src.astrata_god = WEAKREF(GLOB.patronlist[/datum/patron/divine/astrata])
    start_time = world.time + 3 MINUTES
    end_time = start_time + 30 MINUTES
    GLOB.tennite_schisms += src

/datum/tennite_schism/Destroy()
    GLOB.tennite_schisms -= src
    return ..()

/datum/tennite_schism/proc/announce()
    if(announced)
        return

    announced = TRUE
    var/datum/patron/challenger = challenger_god.resolve()
    if(!challenger)
        return

    priority_announce("A schism has emerged within the Ten! [challenger.name] challenges Astrata's authority! All Tennites must choose their allegiance!", "Celestial Schism", 'sound/magic/marked.ogg')

    // Grant the choosing spell to all tennites
    for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
        if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
            continue

        if(!is_tennite(human_mob))
            continue

        human_mob.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/choose_schism_side)

/datum/tennite_schism/proc/process_winner()
    var/datum/patron/challenger = challenger_god.resolve()
    var/datum/patron/astrata = astrata_god.resolve()

    if(!challenger || !astrata)
        return

    var/astrata_count = length(supporters_astrata)
    var/challenger_count = length(supporters_challenger)

    if(astrata_count > challenger_count)
        // Astrata wins
        adjust_storyteller_influence("Astrata", 200)
        for(var/datum/weakref/supporter_ref in supporters_astrata)
            var/mob/living/supporter = supporter_ref.resolve()
            if(supporter)
                supporter.adjust_triumphs(1)
                to_chat(supporter, span_notice("Astrata's light prevails! Your faith is rewarded with a triumph."))

        priority_announce("The schism has ended! Astrata's light prevails over the challenge of [challenger.name]!", "Celestial Schism Concluded")
    else if(challenger_count > astrata_count)
        // Challenger wins
        adjust_storyteller_influence(challenger.name, 200)
        for(var/datum/weakref/supporter_ref in supporters_challenger)
            var/mob/living/supporter = supporter_ref.resolve()
            if(supporter)
                supporter.adjust_triumphs(1)
                to_chat(supporter, span_notice("[challenger.name]'s challenge succeeds! Your faith is rewarded with a triumph."))

        priority_announce("The schism has ended! [challenger.name]'s challenge succeeds against Astrata's light!", "Celestial Schism Concluded")
    else
        priority_announce("The schism has ended in a stalemate! Neither side could claim dominance.", "Celestial Schism Concluded")

    // Clean up spells
    for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
        if(!istype(human_mob) || !human_mob.mind)
            continue
        human_mob.mind.RemoveSpell(/obj/effect/proc_holder/spell/invoked/choose_schism_side)

    qdel(src)

/datum/tennite_schism/proc/change_side(mob/living/carbon/human/user, new_side)
    // Remove from previous side
    supporters_astrata -= WEAKREF(user)
    supporters_challenger -= WEAKREF(user)
    neutrals -= WEAKREF(user)

    // Add to new side
    switch(new_side)
        if("astrata")
            supporters_astrata += WEAKREF(user)
            to_chat(user, span_notice("You have declared your allegiance to Astrata!"))
        if("challenger")
            supporters_challenger += WEAKREF(user)
            var/datum/patron/challenger = challenger_god.resolve()
            if(challenger)
                to_chat(user, span_notice("You have declared your allegiance to [challenger.name]!"))
        if("neutral")
            neutrals += WEAKREF(user)
            to_chat(user, span_notice("You have declared neutrality in the schism."))

/obj/effect/proc_holder/spell/invoked/choose_schism_side
    name = "Choose Schism Side"
    desc = "Declare your allegiance in the schism within the Ten. You may change your mind once."
    invocation = "DECLARE ALLEGIANCE"
    invocation_type = "whisper"
    action_icon_state = "convert"
    cooldown_min = 3 MINUTES
    var/uses_remaining = 2 // Players get 2 total uses (initial choice + one change)

/obj/effect/proc_holder/spell/invoked/choose_schism_side/cast(list/targets, mob/living/carbon/human/user)
    if(!is_tennite(user))
        to_chat(user, span_warning("Only Tennites can participate in the schism."))
        return

    if(uses_remaining <= 0)
        to_chat(user, span_warning("You've already finalized your allegiance in the schism."))
        return

    var/datum/tennite_schism/current_schism
    for(var/datum/tennite_schism/schism in GLOB.tennite_schisms)
        current_schism = schism
        break

    if(!current_schism)
        to_chat(user, span_warning("There is no active schism to participate in."))
        return

    var/list/options = list()
    options["Astrata"] = "astrata"
    var/datum/patron/challenger = current_schism.challenger_god.resolve()
    if(challenger)
        options["[challenger.name]"] = "challenger"
    options["Neutral"] = "neutral"

    var/choice = input(user, "Choose your allegiance in the schism (Remaining changes: [uses_remaining-1]):", "Schism within the Ten") as null|anything in options
    if(!choice || !current_schism)
        return

    uses_remaining--
    current_schism.change_side(user, options[choice])

    if(uses_remaining <= 0)
        name = "[initial(name)] (Finalized)"
        if(action)
            action.UpdateButtonIcon() // Visual feedback
        to_chat(user, span_boldnotice("Your allegiance in the schism is now final."))

    current_schism.change_side(user, options[choice])

/datum/round_event_control/schism_within_ten
    name = "Schism within the Ten"
    typepath = /datum/round_event/schism_within_ten
    weight = 6
    max_occurrences = 1
    min_players = 50
    earliest_start = 40 MINUTES
    track = EVENT_TRACK_INTERVENTION
    tags = list(TAG_COMBAT)

/datum/round_event_control/schism_within_ten/canSpawnEvent(players_amt, gamemode, fake_check)
    . = ..()
    if(!.)
        return FALSE

    var/datum/patron/astrata = GLOB.patronlist[/datum/patron/divine/astrata]
    if(!astrata)
        return FALSE

    var/astrata_power = (GLOB.patron_follower_counts["Astrata"] * 10) + get_storyteller_influence("Astrata")

    for(var/type in subtypesof(/datum/patron/divine) - /datum/patron/divine/astrata)
        var/datum/patron/divine/god = GLOB.patronlist[type]
        if(!god)
            continue

        var/god_power = (GLOB.patron_follower_counts[god.name] * 10) + get_storyteller_influence(god.name)
        if(god_power > astrata_power * 1.25) // 25% stronger than Astrata
            return TRUE

    return FALSE

/datum/round_event/schism_within_ten/start()
    var/datum/patron/strongest_challenger = find_strongest_challenger()
    if(!strongest_challenger)
        return

    // Notify challenger god's patrons
    for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
        if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
            continue

        if(human_mob.patron == strongest_challenger)
            to_chat(human_mob, span_notice("You feel a divine calling - the time has come to challenge Astrata's authority! Prepare for the coming schism!"))
            SEND_SOUND(human_mob, 'sound/magic/marked.ogg')

    new /datum/tennite_schism(strongest_challenger)
    addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(announce_schism_start)), 3 MINUTES)
    addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(announce_schism_end)), 33 MINUTES)

/proc/announce_schism_start()
    for(var/datum/tennite_schism/schism in GLOB.tennite_schisms)
        schism.announce()

/proc/announce_schism_end()
    for(var/datum/tennite_schism/schism in GLOB.tennite_schisms)
        schism.process_winner()

/proc/adjust_storyteller_influence(god_name, amount)
    for(var/storyteller_type in SSgamemode.storytellers)
        var/datum/storyteller/S = SSgamemode.storytellers[storyteller_type]
        if(S.name == god_name)
            S.bonus_points += amount
            break

/proc/is_tennite(mob/living/carbon/human/human_mob)
    if(!human_mob.patron)
        return FALSE
    return istype(human_mob.patron, /datum/patron/divine)

/proc/get_storyteller_influence(god_name)
    for(var/storyteller_type in SSgamemode.storytellers)
        var/datum/storyteller/S = SSgamemode.storytellers[storyteller_type]
        if(S.name == god_name)
            return SSgamemode.calculate_storyteller_influence(S.type)
    return 0

/proc/find_strongest_challenger()
    var/datum/patron/astrata = GLOB.patronlist[/datum/patron/divine/astrata]
    if(!astrata)
        return null

    var/astrata_power = (GLOB.patron_follower_counts["Astrata"] * 10) + get_storyteller_influence("Astrata")
    var/datum/patron/strongest_challenger
    var/strongest_power = 0

    for(var/type in subtypesof(/datum/patron/divine) - /datum/patron/divine/astrata)
        var/datum/patron/divine/god = GLOB.patronlist[type]
        if(!god)
            continue

        var/god_power = (GLOB.patron_follower_counts[god.name] * 10) + get_storyteller_influence(god.name)
        if(god_power > strongest_power && god_power > astrata_power * 1.25)
            strongest_power = god_power
            strongest_challenger = god

    return strongest_challenger
