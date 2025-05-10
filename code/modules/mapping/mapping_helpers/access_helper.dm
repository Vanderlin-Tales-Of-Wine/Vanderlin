/obj/effect/mapping_helpers/door/access
	name = "door access helper"
	icon_state = "access_helper"
	var/access_string = null

/obj/effect/mapping_helpers/door/access/payload(obj/structure/door/door)
	if(door.lockid != null)
		log_mapping("[src] at [AREACOORD(src)] tried to set lockid, but lockid was already set!")
		return
	if(access_string == null)
		log_mapping("[src] at [AREACOORD(src)] tried to set lockid, but had nothing to assign!")
		return
	door.lockid = access_string

// Town locks
/obj/effect/mapping_helpers/door/access/town
	color = "#5a5454"

/obj/effect/mapping_helpers/door/access/town/tailor
	access_string = ACCESS_TAILOR

/obj/effect/mapping_helpers/door/access/town/smith
	access_string = ACCESS_SMITH

/obj/effect/mapping_helpers/door/access/town/artificer
	access_string = ACCESS_ARTIFICER

/obj/effect/mapping_helpers/door/access/town/miner
	access_string = ACCESS_MINER

/obj/effect/mapping_helpers/door/access/town/inn
	access_string = ACCESS_INN

/obj/effect/mapping_helpers/door/access/town/clinic
	access_string = ACCESS_CLINIC

/obj/effect/mapping_helpers/door/access/town/merchant
	access_string = ACCESS_MERCHANT

/obj/effect/mapping_helpers/door/access/town/soilson
	access_string = ACCESS_FARM

/obj/effect/mapping_helpers/door/access/town/butcher
	access_string = ACCESS_BUTCHER

/obj/effect/mapping_helpers/door/access/town/apothecary
	access_string = ACCESS_APOTHECARY

/obj/effect/mapping_helpers/door/access/town/doctor
	access_string = ACCESS_FELDSHER

/obj/effect/mapping_helpers/door/access/town/matron
	access_string = ACCESS_MATRON

/obj/effect/mapping_helpers/door/access/town/elder
	access_string = ACCESS_ELDER
/obj/effect/mapping_helpers/door/access/town/veteran
	access_string = ACCESS_VETERAN

/obj/effect/mapping_helpers/door/access/town/mercenary
	access_string = ACCESS_MERC

/obj/effect/mapping_helpers/door/access/town/gaffer
	access_string = ACCESS_GAFFER

/obj/effect/mapping_helpers/door/access/town/tower
	access_string = ACCESS_TOWER

/obj/effect/mapping_helpers/door/access/town/warehouse
	access_string = ACCESS_WAREHOUSE

/obj/effect/mapping_helpers/door/access/town/bathhouse
	access_string = ACCESS_BATHHOUSE

// Town Garrison
/obj/effect/mapping_helpers/door/access/garrison
	color = "#b02323"

/obj/effect/mapping_helpers/door/access/garrison/garrison
	access_string = ACCESS_GARRISON

/obj/effect/mapping_helpers/door/access/garrison/captain
	access_string = ACCESS_CAPTAIN

/obj/effect/mapping_helpers/door/access/garrison/forest
	access_string = ACCESS_FOREST

/obj/effect/mapping_helpers/door/access/garrison/gate
	access_string = ACCESS_GATE

// Church locks
/obj/effect/mapping_helpers/door/access/church
	color = "#eaed3e"

/obj/effect/mapping_helpers/door/access/church/church
	access_string = ACCESS_CHURCH

/obj/effect/mapping_helpers/door/access/church/priest
	access_string = ACCESS_PRIEST

/obj/effect/mapping_helpers/door/access/church/inquisition
	access_string = ACCESS_RITTER

/obj/effect/mapping_helpers/door/access/church/grave
	access_string = ACCESS_GRAVE

// Manor locks
/obj/effect/mapping_helpers/door/access/manor
	color = "#a926ad"

/obj/effect/mapping_helpers/door/access/manor/manor
	access_string = ACCESS_MANOR

/obj/effect/mapping_helpers/door/access/manor/gate
	access_string = ACCESS_MANOR_GATE

/obj/effect/mapping_helpers/door/access/manor/steward
	access_string = ACCESS_STEWARD

/obj/effect/mapping_helpers/door/access/manor/dungeon
	access_string = ACCESS_DUNGEON

/obj/effect/mapping_helpers/door/access/manor/hand
	access_string = ACCESS_HAND

/obj/effect/mapping_helpers/door/access/manor/lord
	access_string = ACCESS_LORD

/obj/effect/mapping_helpers/door/access/manor/vault
	access_string = ACCESS_VAULT

/obj/effect/mapping_helpers/door/access/manor/mage
	access_string = ACCESS_MAGE

/obj/effect/mapping_helpers/door/access/manor/archive
	access_string = ACCESS_ARCHIVE

/obj/effect/mapping_helpers/door/access/manor/atarms
	access_string = ACCESS_AT_ARMS

/obj/effect/mapping_helpers/door/access/manor/guest
	access_string = ACCESS_GUEST

/obj/effect/mapping_helpers/door/access/manor/physician
	access_string = ACCESS_PHYSICIAN
