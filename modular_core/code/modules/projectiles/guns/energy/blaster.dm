//Blasters Go Here
//Blasters shoot bolts of energy as means of doing damage even if they have other nonlethal firemodes

/obj/item/gun/energy/blaster
	name = "blaster pistol"
	desc = "A tiny energy pistol converted to fire off energy bolts rather than lasers beams."
	icon = 'icons/obj/guns/blaster.dmi'
	icon_state = "blaster_pistol"
	item_state = "blaster_pistol"
	has_item_ratio = FALSE
	fire_sound = 'sound/weapons/laser1.ogg'
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	w_class = ITEMSIZE_SMALL
	force = 5
	origin_tech = list(TECH_COMBAT = 2, TECH_MAGNET = 2)
	matter = list(DEFAULT_WALL_MATERIAL = 2000)
	offhand_accuracy = 1
	projectile_type = /obj/item/projectile/energy/blaster
	max_shots = 6

	burst_delay = 2
	sel_mode = 1

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=null, burst_accuracy=null, dispersion=null),
		list(mode_name="2-round bursts", burst=2, fire_delay=null, move_delay=2,    burst_accuracy=list(1,0,0),       dispersion=list(0, 10, 15))
		)

/obj/item/gun/energy/blaster/mounted/mech
	name = "rapidfire blaster"
	desc = "An aged but reliable rapidfire blaster tuned to expel projectiles at high fire rates."
	fire_sound = 'sound/weapons/laserstrong.ogg'
	projectile_type = /obj/item/projectile/energy/blaster/heavy
	burst = 5
	burst_delay = 3
	max_shots = 30
	charge_cost = 100
	use_external_power = TRUE
	self_recharge = TRUE
	recharge_time = 1.5
	dispersion = list(3,6,9,12)
	firemodes = list()

/obj/item/gun/energy/blaster/revolver
	name = "blaster revolver"
	desc = "A robust eight-shot blaster.."
	icon_state = "blaster_revolver"
	item_state = "blaster_revolver"
	fire_sound = 'sound/weapons/laserstrong.ogg'
	projectile_type = /obj/item/projectile/energy/blaster
	max_shots = 8
	w_class = ITEMSIZE_NORMAL

/obj/item/gun/energy/blaster/revolver/verb/spin_cylinder()
	set name = "Spin cylinder"
	set desc = "Fun when you're bored out of your skull."
	set category = "Object"
	var/mob/living/carbon/human/user
	if(istype(usr,/mob/living/carbon/human))
		user = usr
	else
		return

	user.visible_message(SPAN_WARNING("\The [user] spins the cylinder of \the [src]!"), SPAN_WARNING("You spin the cylinder of \the [src]!"), SPAN_NOTICE("You hear something metallic spin and click."))
	playsound(src.loc, 'sound/weapons/revolver_spin.ogg', 100, 1)

/obj/item/gun/energy/blaster/revolver/pilot
	name = "pilot's sidearm"
	desc = "A robust, low in maintenance, eight-shot blaster. Perfect for self-defense purposes."

/obj/item/gun/energy/blaster/carbine
	name = "blaster carbine"
	desc = "A short-barreled blaster carbine meant for easy handling and comfort when in combat."
	icon_state = "blaster_carbine"
	item_state = "blaster_carbine"
	max_shots = 12
	origin_tech = list(TECH_COMBAT = 3, TECH_MAGNET = 2)
	offhand_accuracy = 0
	projectile_type = /obj/item/projectile/energy/blaster
	slot_flags = SLOT_BELT
	w_class = ITEMSIZE_NORMAL

/obj/item/gun/energy/blaster/rifle
	name = "bolt slinger"
	desc = "A blaster rifle which seems to work by accelerating particles and flinging them out in destructive bolts."
	icon_state = "blaster_rifle"
	item_state = "blaster_rifle"
	max_shots = 20
	origin_tech = list(TECH_COMBAT = 4, TECH_MAGNET = 3)
	offhand_accuracy = 0
	projectile_type = /obj/item/projectile/energy/blaster/heavy

	slot_flags = SLOT_BACK
	w_class = ITEMSIZE_LARGE

	fire_delay = 25
	w_class = ITEMSIZE_LARGE
	accuracy = -3
	scoped_accuracy = 4

	fire_delay_wielded = 10
	accuracy_wielded = 1

	is_wieldable = TRUE

/obj/item/gun/energy/blaster/rifle/verb/scope()
	set category = "Object"
	set name = "Use Scope"
	set popup_menu = 1

	if(wielded)
		toggle_scope(2.0, usr)
	else
		to_chat(usr, "<span class='warning'>You can't look through the scope without stabilizing the rifle!</span>")

//////"Diruptors" Togglable Blaster Pistols//////

/obj/item/gun/energy/disruptorpistol
	name = "disruptor pistol"
	desc = "A Nanotrasen designed blaster pistol with two settings: stun and lethal."
	desc_fluff = "Developed and produced by NanoTrasen for its internal security division, the NT DP-7 is a state of the art blaster pistol capable of firing reduced-power bolts which disrupt the central nervous system, inducing a stunning effect on the victim. It is also capable of firing full-power blaster bolts."
	icon = 'icons/obj/guns/blaster.dmi'
	icon_state = "disruptorpistol"
	item_state = "disruptorpistol"
	fire_sound = 'sound/weapons/gunshot/bolter.ogg'
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	w_class = ITEMSIZE_NORMAL
	force = 5
	origin_tech = list(TECH_COMBAT = 3, TECH_MAGNET = 2)
	matter = list(DEFAULT_WALL_MATERIAL = 2000)
	projectile_type = /obj/item/projectile/energy/disruptorstun
	secondary_projectile_type = /obj/item/projectile/energy/blaster
	max_shots = 12 //12 shots stun, 8 shots lethal.
	charge_cost = 150
	fire_delay = 8
	accuracy = 1
	has_item_ratio = FALSE
	modifystate = "disruptorpistolstun100"
	sel_mode = 1
	var/selectframecheck = FALSE
	firemodes = list(
		list(mode_name="stun", projectile_type=/obj/item/projectile/energy/disruptorstun, modifystate="disruptorpistolstun100", charge_cost = 150, fire_sound = 'sound/weapons/gunshot/bolter.ogg'),
		list(mode_name="lethal", projectile_type=/obj/item/projectile/energy/blaster, modifystate="disruptorpistolkill100", recoil = 1, charge_cost = 225, fire_sound = 'sound/weapons/gunshot/bolter.ogg')
		)

/obj/item/gun/energy/disruptorpistol/security
	pin = /obj/item/device/firing_pin/wireless

/obj/item/gun/energy/disruptorpistol/miniature
	name = "miniature disruptor pistol"
	desc = "A Nanotrasen designed blaster pistol with two settings: stun and lethal. This is the miniature version."
	icon_state = "disruptorpistolc"
	max_shots = 7
	force = 3
	slot_flags = SLOT_BELT|SLOT_HOLSTER|SLOT_POCKET
	w_class = ITEMSIZE_SMALL
	firemodes = list(
		list(mode_name="stun", projectile_type=/obj/item/projectile/energy/disruptorstun, modifystate="disruptorpistolcstun", charge_cost = 150, fire_sound = 'sound/weapons/gunshot/bolter.ogg'),
		list(mode_name="lethal", projectile_type=/obj/item/projectile/energy/blaster, modifystate="disruptorpistolckill", recoil = 1, charge_cost = 225, fire_sound = 'sound/weapons/gunshot/bolter.ogg')
		)

/obj/item/gun/energy/disruptorpistol/miniature/security
	pin = /obj/item/device/firing_pin/wireless

/obj/item/gun/energy/disruptorpistol/magnum
	name = "magnum disruptor pistol"
	desc = "A Nanotrasen designed blaster pistol with two settings: stun and lethal. This is the magnum version."
	icon_state = "disruptorpistolm"
	max_shots = 20
	force = 6
	w_class = ITEMSIZE_SMALL
	firemodes = list(
		list(mode_name="stun", projectile_type=/obj/item/projectile/energy/disruptorstun, modifystate="disruptorpistolmstun", charge_cost = 150, fire_sound = 'sound/weapons/gunshot/bolter.ogg'),
		list(mode_name="lethal", projectile_type=/obj/item/projectile/energy/blaster, modifystate="disruptorpistolmkill", recoil = 1, charge_cost = 225, fire_sound = 'sound/weapons/gunshot/bolter.ogg')
		)

/obj/item/gun/energy/disruptorpistol/magnum/security
	pin = /obj/item/device/firing_pin/wireless