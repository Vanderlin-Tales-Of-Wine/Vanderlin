/obj/effect/mapping_helpers/access/keyset
	name = "keyid access helper"
	icon_state = "access_helper"
	var/list/accesses

/obj/effect/mapping_helpers/access/keyset/payload(obj/payload)
	if(!length(accesses))
		log_mapping("[src] at [AREACOORD(src)] tried to set lockids, but had nothing to assign!")
		return
	if(payload.lockids != null)
		log_mapping("[src] at [AREACOORD(src)] tried to set lockids, but lockid was already set!")
		return
	payload.lockids += accesses

// Town locks
/obj/effect/mapping_helpers/access/keyset/town
	color = "#58431e"

/obj/effect/mapping_helpers/access/keyset/town/tailor
	accesses = list(ACCESS_TAILOR)

/obj/effect/mapping_helpers/access/keyset/town/smith
	accesses = list(ACCESS_SMITH)

/obj/effect/mapping_helpers/access/keyset/town/inn
	accesses = list(ACCESS_INN)

/obj/effect/mapping_helpers/access/keyset/town/artificer
	acesses = list(ACCESS_ARTIFICER)

/obj/effect/mapping_helpers/access/keyset/town/clinic
	accesses = list(ACCESS_CLINIC)

/obj/effect/mapping_helpers/access/keyset/town/merchant
	accesses = list(ACCESS_MERCHANT)

/obj/effect/mapping_helpers/access/keyset/town/soilson
	accesses = list(ACCESS_FARM)

/obj/effect/mapping_helpers/access/keyset/town/butcher
	accesses = list(ACCESS_BUTCHER)

/obj/effect/mapping_helpers/access/keyset/town/apothecary
	accesses = list(ACCESS_APOTHECARY)

/obj/effect/mapping_helpers/access/keyset/town/doctor
	accesses = list(ACCESS_FELDSHER)

/obj/effect/mapping_helpers/access/keyset/town/matron
	accesses = list(ACCESS_MATRON)

/obj/effect/mapping_helpers/access/keyset/town/mercenary
	accesses = list(ACCESS_MERC)

/obj/effect/mapping_helpers/access/keyset/town/elder
	acesses = list(ACCESS_ELDER)

/obj/effect/mapping_helpers/access/keyset/town/veteran
	acesses = list(ACCESS_VETERAN)

/obj/effect/mapping_helpers/access/keyset/town/tower
	accesses = list(ACCESS_TOWER)

/obj/effect/mapping_helpers/access/keyset/town/warehouse
	accesses = list(ACCESS_WAREHOUSE)

/obj/effect/mapping_helpers/access/keyset/town/bathhouse
	acesses = list(ACCESS_BATHHOUSE)

// Town Garrison
/obj/effect/mapping_helpers/access/keyset/garrison
	color = "#b02323"

/obj/effect/mapping_helpers/access/keyset/garrison/general
	accesses = list(ACCESS_GARRISON)

/obj/effect/mapping_helpers/access/keyset/garrison/captain
	accesses = list(ACCESS_CAPTAIN)

/obj/effect/mapping_helpers/access/keyset/garrison/forest
	accesses = list(ACCESS_FOREST)

/obj/effect/mapping_helpers/access/keyset/garrison/gate
	accesses = list(ACCESS_GATE)

// Church locks
/obj/effect/mapping_helpers/access/keyset/church
	color = "#eaed3e"

/obj/effect/mapping_helpers/access/keyset/church/general
	accesses = list(ACCESS_CHURCH)

/obj/effect/mapping_helpers/access/keyset/church/priest
	accesses = list(ACCESS_PRIEST)

/obj/effect/mapping_helpers/access/keyset/church/inquisition
	accesses = list(ACCESS_RITTER)

/obj/effect/mapping_helpers/access/keyset/church/grave
	accesses = list(ACCESS_GRAVE)

// Manor locks
/obj/effect/mapping_helpers/access/keyset/manor
	color = "#a926ad"

/obj/effect/mapping_helpers/access/keyset/manor/general
	accesses = list(ACCESS_MANOR)

/obj/effect/mapping_helpers/access/keyset/manor/gate
	accesses = list(ACCESS_MANOR_GATE)

/obj/effect/mapping_helpers/access/keyset/manor/steward
	accesses = list(ACCESS_STEWARD)

/obj/effect/mapping_helpers/access/keyset/manor/dungeon
	accesses = list(ACCESS_DUNGEON)

/obj/effect/mapping_helpers/access/keyset/manor/hand
	accesses = list(ACCESS_HAND)

/obj/effect/mapping_helpers/access/keyset/manor/lord
	accesses = list(ACCESS_LORD)

/obj/effect/mapping_helpers/access/keyset/manor/vault
	accesses = list(ACCESS_VAULT)

/obj/effect/mapping_helpers/access/keyset/manor/mage
	acesses = list(ACCESS_MAGE)

/obj/effect/mapping_helpers/access/keyset/manor/archive
	acesses = list(ACCESS_ARCHIVE)

/obj/effect/mapping_helpers/access/keyset/manor/atarms
	acesses = list(ACCESS_AT_ARMS)

/obj/effect/mapping_helpers/access/keyset/manor/guest
	acesses = list(ACCESS_GUEST)
