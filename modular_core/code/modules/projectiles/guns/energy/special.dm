//"Special" Energy Weapons go here
// Specifically Energy Weapons with 'Unique' effects or specialized roles

/obj/item/gun/energy/rifle/ionrifle
	name = "ion rifle"
	desc = "The NT Mk70 EW Halicon is a man portable anti-armor weapon designed to disable mechanical threats, produced by Nanotrasen."
	icon = 'icons/obj/guns/special.dmi'
	icon_state = "ionriflestun100"
	item_state = "ionriflestun100" // so the human update icon uses the icon_state instead.
	modifystate = "ionriflestun"
	projectile_type = /obj/item/projectile/ion/stun
	fire_sound = 'sound/weapons/laser1.ogg'
	origin_tech = list(TECH_COMBAT = 2, TECH_MAGNET = 4)
	w_class = ITEMSIZE_LARGE
	accuracy = 1
	force = 10
	flags = CONDUCT
	slot_flags = SLOT_BACK
	charge_cost = 300
	max_shots = 4
	can_turret = 1
	turret_sprite_set = "ion"
	firemodes = list()

/obj/item/gun/energy/rifle/ionrifle/emp_act(severity)
	..(max(severity, 2)) //so it doesn't EMP itself, I guess

/obj/item/gun/energy/rifle/ionrifle/update_icon()
	if(charge_meter && power_supply && power_supply.maxcharge)
		var/ratio = power_supply.charge / power_supply.maxcharge

		//make sure that rounding down will not give us the empty state even if we have charge for a shot left.
		if(power_supply.charge < charge_cost)
			ratio = 0
		else
			ratio = max(round(ratio, 0.25) * 100, 25)

		icon_state = "[modifystate][ratio]"
		item_state = "[modifystate][ratio]"
	update_held_icon()

/obj/item/gun/energy/rifle/ionrifle/mounted
	name = "mounted ion rifle"
	self_recharge = 1
	use_external_power = 1
	recharge_time = 10
	can_turret = 0

/obj/item/gun/energy/xray
	name = "xray laser gun"
	desc = "A Nanotrasen designed high-power laser sidearm capable of expelling concentrated xray blasts."
	desc_fluff = "The NT XG-1 is a laser sidearm developed and produced by Nanotrasen. A recent invention, used for specialist operations, it is presently being produced and sold in limited capacity over the galaxy. Designed for precision strikes, releasing concentrated xray blasts that are capable of hitting targets behind cover. It is compact with relatively high capacity to other sidearms."
	icon = 'icons/obj/guns/special.dmi'
	icon_state = "xray"
	item_state = "xray"
	has_item_ratio = FALSE
	fire_sound = 'sound/weapons/laser3.ogg'
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 3, TECH_MAGNET = 2, TECH_ILLEGAL = 2)
	projectile_type = /obj/item/projectile/beam/xray
	charge_cost = 100
	max_shots = 20
	fire_delay = 1
	can_turret = 1
	turret_is_lethal = 1
	turret_sprite_set = "xray"

/obj/item/gun/energy/xray/mounted
	name = "mounted xray laser gun"
	charge_cost = 200
	self_recharge = 1
	use_external_power = 1
	recharge_time = 5
	can_turret = 0

/obj/item/gun/energy/rifle/laser/xray
	name = "xray laser rifle"
	desc = "A Nanotrasen designed high-power laser rifle capable of expelling concentrated xray blasts."
	desc_fluff = "The NT XR-1 is a laser firearm developed and produced by Nanotrasen. A recent innovation, used for specialist operations, it is presently being produced and sold in limited capacity over the galaxy. Designed for precision strikes, releasing concentrated xray blasts that are capable of hitting targets behind cover, all the while having a large ammo capacity."
	icon = 'icons/obj/guns/special.dmi'
	icon_state = "xrifle"
	item_state = "xrifle"
	fire_sound = 'sound/weapons/laser3.ogg'
	projectile_type = /obj/item/projectile/beam/xray
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 3, TECH_MAGNET = 2, TECH_ILLEGAL = 2)
	max_shots = 40
	secondary_projectile_type = null
	secondary_fire_sound = null
	can_switch_modes = 0
	turret_sprite_set = "xray"
	turret_is_lethal = 1

/obj/item/gun/energy/decloner
	name = "biological demolecularisor"
	desc = "A gun that discharges high amounts of controlled radiation to slowly break a target into component elements."
	icon = 'icons/obj/guns/special.dmi'
	icon_state = "decloner"
	item_state = "decloner"
	has_item_ratio = FALSE
	fire_sound = 'sound/weapons/pulse3.ogg'
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 4, TECH_POWER = 3)
	max_shots = 10
	projectile_type = /obj/item/projectile/energy/declone

/obj/item/gun/energy/floragun
	name = "floral somatoray"
	desc = "A tool that discharges controlled radiation which induces mutation in plant cells."
	icon = 'icons/obj/guns/special.dmi'
	icon_state = "floramut100"
	item_state = "floramut"
	has_item_ratio = FALSE
	fire_sound = 'sound/effects/stealthoff.ogg'
	charge_cost = 100
	max_shots = 10
	projectile_type = /obj/item/projectile/energy/floramut
	origin_tech = list(TECH_MATERIAL = 2, TECH_BIO = 3, TECH_POWER = 3)
	modifystate = "floramut"
	self_recharge = 1

	firemodes = list(
		list(mode_name="induce mutations", projectile_type=/obj/item/projectile/energy/floramut, modifystate="floramut"),
		list(mode_name="increase yield", projectile_type=/obj/item/projectile/energy/florayield, modifystate="florayield")
		)

	needspin = FALSE

/obj/item/gun/energy/floragun/afterattack(obj/target, mob/user, adjacent_flag)
	//allow shooting into adjacent hydrotrays regardless of intent
	if(adjacent_flag && istype(target,/obj/machinery/portable_atmospherics/hydroponics))
		user.visible_message("<span class='danger'>\The [user] fires \the [src] into \the [target]!</span>")
		Fire(target,user)
		return
	..()

/obj/item/gun/energy/meteorgun
	name = "meteor gun"
	desc = "For the love of god, make sure you're aiming this the right way!"
	icon = 'icons/obj/guns/special.dmi'
	icon_state = "meteor_gun"
	item_state = "meteor_gun"
	has_item_ratio = FALSE
	slot_flags = SLOT_BELT|SLOT_BACK
	w_class = ITEMSIZE_LARGE
	max_shots = 10
	projectile_type = /obj/item/projectile/meteor
	self_recharge = 1
	recharge_time = 5 //Time it takes for shots to recharge (in ticks)
	charge_meter = 0
	can_turret = 1
	turret_sprite_set = "meteor"

/obj/item/gun/energy/meteorgun/pen
	name = "meteor pen"
	desc = "The pen is mightier than the sword."
	icon = 'icons/obj/bureaucracy.dmi'
	contained_sprite = FALSE
	icon_state = "pen"
	item_state = "pen"
	w_class = ITEMSIZE_TINY
	slot_flags = SLOT_BELT
	can_turret = 0


/obj/item/gun/energy/mindflayer
	name = "mind flayer"
	desc = "A custom-built weapon of some kind."
	icon = 'icons/obj/guns/special.dmi'
	icon_state = "xray"
	item_state = "xray"
	has_item_ratio = FALSE
	projectile_type = /obj/item/projectile/beam/mindflayer
	fire_sound = 'sound/weapons/laser1.ogg'
	can_turret = 1
	turret_sprite_set = "xray"

/obj/item/gun/energy/toxgun
	name = "phoron pistol"
	desc = "A specialized firearm designed to fire lethal bolts of phoron."
	icon = 'icons/obj/guns/special.dmi'
	icon_state = "toxgun"
	item_state = "toxgun"
	has_item_ratio = FALSE
	fire_sound = 'sound/effects/stealthoff.ogg'
	w_class = ITEMSIZE_NORMAL
	origin_tech = list(TECH_COMBAT = 5, TECH_PHORON = 4)
	projectile_type = /obj/item/projectile/energy/phoron
	can_turret = 1
	turret_is_lethal = 0
	turret_sprite_set = "net"

/obj/item/gun/energy/beegun
	name = "\improper NanoTrasen Portable Apiary"
	desc = "An experimental firearm that converts energy into bees, for purely botanical purposes."
	icon = 'icons/obj/guns/special.dmi'
	icon_state = "gyrorifle"
	item_state = "gyrorifle"
	has_item_ratio = FALSE
	charge_meter = 0
	w_class = ITEMSIZE_LARGE
	fire_sound = 'sound/effects/Buzz2.ogg'
	force = 5
	projectile_type = /obj/item/projectile/energy/bee
	slot_flags = SLOT_BACK
	max_shots = 9
	sel_mode = 1
	burst = 3
	burst_delay = 1
	move_delay = 3
	fire_delay = 0
	dispersion = list(0, 8)

/obj/item/gun/energy/mousegun
	name = "pest gun"
	desc = "The NT \"Arodentia\" Pesti-Shock is a highly sophisticated and probably safe beamgun designed for rapid pest-control."
	desc_antag = "This gun can be emagged to make it fire damaging beams and get more max shots. It doesn't do a lot of damage, but it is concealable."
	icon = 'icons/obj/guns/special.dmi'
	icon_state = "pestishock"
	item_state = "pestishock"
	has_item_ratio = FALSE
	w_class = ITEMSIZE_NORMAL
	fire_sound = 'sound/weapons/taser2.ogg'
	force = 5
	projectile_type = /obj/item/projectile/beam/mousegun
	slot_flags = SLOT_HOLSTER | SLOT_BELT
	max_shots = 6
	sel_mode = 1
	var/emagged = FALSE
	needspin = FALSE

/obj/item/gun/energy/mousegun/handle_post_fire(mob/user, atom/target, var/pointblank=0, var/reflex=0, var/playemote = 1)
	var/T = get_turf(user)
	spark(T, 3, alldirs)
	..()

/obj/item/gun/energy/mousegun/emag_act(var/remaining_charges, var/mob/user)
	if(!emagged)
		to_chat(user, SPAN_WARNING("You overload \the [src]'s shock modulator."))
		max_shots = initial(max_shots) + 4
		projectile_type = /obj/item/projectile/beam/mousegun/emag
		emagged = TRUE
		QDEL_NULL(power_supply)
		power_supply = new /obj/item/cell/device/variable(src, max_shots * charge_cost)
		return TRUE

/obj/item/gun/energy/mousegun/xenofauna
	name = "xenofauna gun"
	desc = "The NT \"Xenovermino\" Zap-Blast is a highly sophisticated and probably safe beamgun designed to deal with hostile xenofauna."
	projectile_type = /obj/item/projectile/beam/mousegun/xenofauna
	max_shots = 12

/obj/item/gun/energy/net
	name = "net gun"
	desc = "A gun designed to deploy energy nets to capture animals or unruly crew members."
	icon = 'icons/obj/guns/special.dmi'
	icon_state = "netgun"
	item_state = "netgun"
	has_item_ratio = FALSE
	projectile_type = /obj/item/projectile/beam/energy_net
	fire_sound = 'sound/weapons/plasma_cutter.ogg'
	slot_flags = SLOT_HOLSTER | SLOT_BELT
	w_class = ITEMSIZE_NORMAL
	max_shots = 4
	fire_delay = 25
	can_turret = 1
	turret_is_lethal = 0
	turret_sprite_set = "net"

/obj/item/gun/energy/net/mounted
	max_shots = 1
	self_recharge = TRUE
	use_external_power = TRUE
	has_safety = FALSE
	recharge_time = 40
	can_turret = FALSE

/obj/item/gun/energy/tesla
	name = "tesla gun"
	desc = "A gun that shoots a projectile that bounces from living thing to living thing. Keep your distance from whatever you are shooting at."
	icon = 'icons/obj/guns/special.dmi'
	icon_state = "tesla"
	item_state = "tesla"
	has_item_ratio = FALSE
	charge_meter = 0
	w_class = ITEMSIZE_LARGE
	fire_sound = 'sound/magic/LightningShock.ogg'
	force = 30
	projectile_type = /obj/item/projectile/beam/tesla
	slot_flags = SLOT_BACK
	max_shots = 3
	sel_mode = 1
	fire_delay = 10
	accuracy = 80
	muzzle_flash = 15

/obj/item/gun/energy/tesla/mounted
	name = "mounted tesla carbine"
	self_recharge = 1
	use_external_power = 1
	recharge_time = 10
	can_turret = 0

/obj/item/gun/energy/gravity_gun
	name = "gravity gun"
	desc = "This nifty gun disables the gravity in the area you shoot at. Use with caution."
	icon = 'icons/obj/guns/special.dmi'
	icon_state = "gravity_gun"
	item_state = "gravity_gun"
	has_item_ratio = FALSE
	charge_meter = 0
	w_class = ITEMSIZE_LARGE
	fire_sound = 'sound/magic/Repulse.ogg'
	force = 30
	projectile_type = /obj/item/projectile/energy/gravitydisabler
	slot_flags = SLOT_BACK
	max_shots = 2
	sel_mode = 1
	fire_delay = 20
	accuracy = 40
	muzzle_flash = 10

/obj/item/gun/energy/temperature
	name = "freeze ray"
	icon = 'icons/obj/guns/special.dmi'
	icon_state = "freezegun"
	item_state = "freezegun"
	has_item_ratio = FALSE
	fire_sound = 'sound/weapons/pulse3.ogg'
	desc = "A gun that changes temperatures. It has a small label on the side, 'More extreme temperatures will cost more charge!'"
	var/temperature = T20C
	var/current_temperature = T20C
	charge_cost = 100
	accuracy = 1
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 4, TECH_POWER = 3, TECH_MAGNET = 2)
	slot_flags = SLOT_BELT|SLOT_BACK

	projectile_type = /obj/item/projectile/temp
	can_turret = 1
	turret_sprite_set = "temperature"

	cell_type = /obj/item/cell/crap //WAS High, but brought down to match energy use

	needspin = FALSE

/obj/item/gun/energy/temperature/Topic(href, href_list)
	if (..())
		return 1
	usr.set_machine(src)
	src.add_fingerprint(usr)
