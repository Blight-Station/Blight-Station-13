/obj/item/gun/projectile/musket
	name = "adhomian musket"
	desc = "A rustic firearm, used by Tajaran soldiers during the adhomian gunpowder age. Loads using musket balls."

	desc_fluff = "The Gunpowder Age was marked by the slow replacement of traditional Adhomian battle tactics and weapons, that included melee weapons and crossbows, in favor of \
	cannons and primitive firing lines. The Kingdoms of Amohda, Nal'tor and Das'nrra were the first countries to make use of this new technology."

	icon = 'icons/obj/guns/musket.dmi'
	icon_state = "musket"
	item_state = "musket"
	contained_sprite = TRUE

	load_method = SINGLE_CASING
	handle_casings = DELETE_CASINGS

	max_shells = 1

	caliber = "musket"

	slot_flags = SLOT_BACK

	is_wieldable = TRUE

	needspin = FALSE

	w_class = ITEMSIZE_LARGE

	has_safety = FALSE //Technically some muskets have half cock hammers but I don't think we need them for these weapons.

	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 2)

	fire_delay = 35
	fire_sound = 'sound/weapons/gunshot/musket.ogg'
	recoil = 4

	ammo_type = /obj/item/ammo_casing/musket

	var/has_powder = FALSE

/obj/item/gun/projectile/musket/special_check(mob/user)
	if(!has_powder)
		to_chat(user, SPAN_WARNING("\The [src] is not loaded with gunpowder!"))
		return FALSE

	if(!wielded)
		to_chat(user, SPAN_WARNING("You can't fire without stabilizing \the [src]!"))
		return FALSE

	var/datum/effect/effect/system/smoke_spread/smoke = new /datum/effect/effect/system/smoke_spread()
	smoke.set_up(3, 0, user.loc)
	smoke.start()
	has_powder = FALSE
	return ..()

/obj/item/gun/projectile/musket/attackby(obj/item/W, mob/user)
	..()
	if (istype(W, /obj/item/reagent_containers))
		if(has_powder)
			to_chat(user, SPAN_WARNING("\The [src] is already full of gunpowder."))
			return
		var/obj/item/reagent_containers/C = W
		if(C.reagents.has_reagent(/datum/reagent/gunpowder, 5))
			if(do_after(user, 15))
				if(has_powder)
					return
				C.reagents.remove_reagent(/datum/reagent/gunpowder, 5)
				has_powder = TRUE
				to_chat(user, SPAN_NOTICE("You fill \the [src] with gunpowder."))

/obj/item/reagent_containers/powder_horn
	name = "powder horn"
	desc = "An ivory container for gunpowder."
	icon = 'icons/obj/guns/musket.dmi'
	icon_state = "powderhorn"
	w_class = ITEMSIZE_NORMAL
	slot_flags = SLOT_BELT
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list(5)
	volume = 30
	reagents_to_add = list(/datum/reagent/gunpowder = 30)

/obj/item/gun/projectile/musket/blunderbuss
	name = "blunderbuss"
	desc = "The black powder ancestor of the shotgun and original boomstick, capable of firing a spray of metal shot. Loads using grapeshot."

	desc_fluff = "The blunderbuss was the premerie self defense weapon of the gunpowder age, being capable of delivering a devstating shot of shrapnel across in wide cone. \
	They are far too short ranged to see much military application however at extremely close ranges they remain devstating especially in these trying times."

	icon_state = "blunderbuss"
	item_state = "blunderbuss"
	caliber = "blunderbuss"

	recoil = 6 ///BOOOM Stick...

	ammo_type = /obj/item/ammo_casing/blunderbuss
