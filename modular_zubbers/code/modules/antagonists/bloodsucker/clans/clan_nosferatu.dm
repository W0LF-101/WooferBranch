/datum/bloodsucker_clan/nosferatu
	name = CLAN_NOSFERATU
	description = "The Nosferatu Clan is unable to blend in with the crew, with no abilities such as Masquerade and Veil. \n\
		Additionally, has a permanent bad back and looks like a Bloodsucker upon a simple examine, and is entirely unidentifiable, \n\
		they can fit in the vents regardless of their form and equipment. \n\
		The Favorite Vassal is also permanently disfigured, and can also ventcrawl, but only while entirely nude. \n\
		They also have night vision, know what each wire does, and have silent footsteps."
	clan_objective = /datum/objective/bloodsucker/kindred
	join_icon_state = "nosferatu"
	join_description = "You are permanetly disfigured, look like a Bloodsucker to all who examine you, \
		lose your Masquerade ability, but gain the ability to Ventcrawl even while clothed."
	blood_drink_type = BLOODSUCKER_DRINK_INHUMANELY

/datum/bloodsucker_clan/nosferatu/New(datum/antagonist/bloodsucker/owner_datum)
	. = ..()
	for(var/datum/action/cooldown/bloodsucker/power as anything in bloodsuckerdatum.powers)
		if(istype(power, /datum/action/cooldown/bloodsucker/masquerade) || istype(power, /datum/action/cooldown/bloodsucker/veil))
			bloodsuckerdatum.RemovePower(power)
	if(!bloodsuckerdatum.owner.current.has_quirk(/datum/quirk/badback))
		bloodsuckerdatum.owner.current.add_quirk(/datum/quirk/badback)
	bloodsuckerdatum.owner.current.add_traits(list(TRAIT_VENTCRAWLER_ALWAYS, TRAIT_DISFIGURED), BLOODSUCKER_TRAIT)

/datum/bloodsucker_clan/nosferatu/Destroy(force)
	for(var/datum/action/cooldown/bloodsucker/power in bloodsuckerdatum.powers)
		bloodsuckerdatum.RemovePower(power)
	bloodsuckerdatum.give_starting_powers()
	bloodsuckerdatum.owner.current.remove_quirk(/datum/quirk/badback)
	bloodsuckerdatum.owner.current.remove_traits(list(TRAIT_VENTCRAWLER_ALWAYS, TRAIT_DISFIGURED), BLOODSUCKER_TRAIT)
	return ..()

/datum/bloodsucker_clan/nosferatu/handle_clan_life(datum/antagonist/bloodsucker/source)
	. = ..()
	if(!HAS_TRAIT(bloodsuckerdatum.owner.current, TRAIT_NOBLOOD))
		bloodsuckerdatum.owner.current.blood_volume = BLOOD_VOLUME_SURVIVE

/datum/bloodsucker_clan/nosferatu/on_favorite_vassal(datum/antagonist/bloodsucker/source, datum/antagonist/vassal/vassaldatum)
	vassaldatum.owner.current.add_traits(list(TRAIT_VENTCRAWLER_NUDE, TRAIT_DISFIGURED, TRAIT_TRUE_NIGHT_VISION, TRAIT_KNOW_ENGI_WIRES, TRAIT_SILENT_FOOTSTEPS), BLOODSUCKER_TRAIT)
	to_chat(vassaldatum.owner.current, span_notice("Additionally, you can now ventcrawl while naked, and are permanently disfigured. You also have night vision, know how which wires to cut, and have silent footsteps."))
