// "Nuclear" Energy Weapons go here
// These weapons have nuclear reactors in them... which are detailed below...

/obj/item/gun/energy/gun/nuclear
	name = "advanced energy gun"
	desc = "An energy gun with an experimental miniaturized reactor."
	desc_info = "This is an energy weapon.  To fire the weapon, ensure your intent is *not* set to 'help', have your gun mode set to 'fire', \
	then click where you want to fire.  Most energy weapons can fire through windows harmlessly.  To switch between stun and lethal, click the weapon \
	in your hand.  Unlike most weapons, this weapon recharges itself."
	icon = 'icons/obj/guns/nucgun.dmi'
	icon_state = "nucgun"
	item_state = "nucgun"
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 5, TECH_POWER = 3)
	slot_flags = SLOT_BELT
	force = 8 //looks heavier than a pistol
	self_recharge = 1
	modifystate = null
	reliability = 95
	turret_sprite_set = "nuclear"
	charge_failure_message = "'s charging socket was removed to make room for a minaturized reactor."

	firemodes = list(
		list(mode_name="stun", projectile_type=/obj/item/projectile/beam/stun, fire_sound='sound/weapons/Taser.ogg'),
		list(mode_name="lethal", projectile_type=/obj/item/projectile/beam, fire_sound='sound/weapons/laser1.ogg')
		)

	var/lightfail = 0

/obj/item/gun/energy/gun/nuclear/get_cell()
	return DEVICE_NO_CELL

/obj/item/gun/energy/gun/nuclear/small_fail(var/mob/user)
	for (var/mob/living/M in range(0,src)) //Only a minor failure, enjoy your radiation if you're in the same tile or carrying it
		if (M == user)
			to_chat(M, "<span class='warning'>Your gun feels pleasantly warm for a moment.</span>")
		else
			to_chat(M, "<span class='warning'>You feel a warm sensation.</span>")
		M.apply_effect(rand(3,120), IRRADIATE)
	return

/obj/item/gun/energy/gun/nuclear/medium_fail(var/mob/user)
	if(prob(50))
		critical_fail(user)
	else
		small_fail(user)
	return

/obj/item/gun/energy/gun/nuclear/critical_fail(var/mob/user)
	to_chat(user, "<span class='danger'>Your gun's reactor overloads!</span>")
	for (var/mob/living/M in range(rand(1,4),src))
		to_chat(M, "<span class='warning'>You feel a wave of heat wash over you.</span>")
		M.apply_effect(300, IRRADIATE)
	crit_fail = 1 //break the gun so it stops recharging
	self_recharge = FALSE
	update_icon()
	return

/obj/item/gun/energy/gun/nuclear/proc/update_charge()
	if (crit_fail)
		add_overlay("nucgun-whee")
		return
	var/ratio = power_supply.charge / power_supply.maxcharge
	ratio = round(ratio, 0.25) * 100
	add_overlay("nucgun-[ratio]")

/obj/item/gun/energy/gun/nuclear/proc/update_reactor()
	if(crit_fail)
		add_overlay("nucgun-crit")
		return
	if(lightfail)
		add_overlay("nucgun-medium")
	else if ((power_supply.charge/power_supply.maxcharge) <= 0.5)
		add_overlay("nucgun-light")
	else
		add_overlay("nucgun-clean")

/obj/item/gun/energy/gun/nuclear/proc/update_mode()
	var/datum/firemode/current_mode = firemodes[sel_mode]
	switch(current_mode.name)
		if("stun")
			add_overlay("nucgun-stun")
		if("lethal")
			add_overlay("nucgun-kill")

/obj/item/gun/energy/gun/nuclear/update_icon()
	cut_overlays()
	update_charge()
	update_reactor()
	update_mode()
