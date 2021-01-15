//Laser Guns go here
//Weapons that use Energy Beams as the means of doing damage even if they have other nonlethal firemods.

///////////////Guns with lethal/stun toggability///////////////
/obj/item/gun/energy/gun
	name = "energy carbine"
	desc = "A Nanotrasen designed energy-based carbine with two settings: Stun and kill."
	desc_info = "This is an energy weapon.  To fire the weapon, ensure your intent is *not* set to 'help', have your gun mode set to 'fire', \
	then click where you want to fire.  Most energy weapons can fire through windows harmlessly.  To switch between stun and lethal, click the weapon \
	in your hand.  To recharge this weapon, use a weapon recharger."
	desc_fluff = "The NT EC-4 is an energy carbine developed and produced by Nanotrasen. Compact, light and durable, used by security forces and law enforcement for its ability to fire stun or lethal beams, depending on selection. It is widely sold and distributed across the galaxy."
	icon = 'icons/obj/guns/laser.dmi'
	icon_state = "energystun100"
	item_state = "energystun100"
	fire_sound = 'sound/weapons/Taser.ogg'
	slot_flags = SLOT_BELT
	accuracy = 1
	max_shots = 10
	can_turret = 1
	secondary_projectile_type = /obj/item/projectile/beam
	secondary_fire_sound = 'sound/weapons/laser1.ogg'
	can_switch_modes = 1
	turret_is_lethal = 0

	projectile_type = /obj/item/projectile/beam/stun
	origin_tech = list(TECH_COMBAT = 3, TECH_MAGNET = 2)
	modifystate = "energystun"

	firemodes = list(
		list(mode_name="stun", projectile_type=/obj/item/projectile/beam/stun, modifystate="energystun", fire_sound='sound/weapons/Taser.ogg'),
		list(mode_name="lethal", projectile_type=/obj/item/projectile/beam, modifystate="energykill", fire_sound='sound/weapons/laser1.ogg')
		)

	var/crit_fail = 0 //Added crit_fail as a local variable

/obj/item/gun/energy/gun/mounted
	name = "mounted energy gun"
	self_recharge = 1
	use_external_power = 1
	can_turret = 0

/obj/item/gun/energy/pistol
	name = "energy pistol"
	desc = "A Nanotrasen energy-based pistol gun with two settings: Stun and kill."
	desc_fluff = "The NT EP-3 is an energy sidearm developed and produced by Nanotrasen. Compact, light and durable, used by security forces and law enforcement for its ability to fire stun or lethal beams, depending on selection. It is widely sold and distributed across the galaxy."
	icon = 'icons/obj/guns/laser.dmi'
	icon_state = "epistolstun100"
	item_state = "epistolstun100"
	fire_sound = 'sound/weapons/Taser.ogg'
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	max_shots = 7
	fire_delay = 4
	can_turret = 1
	secondary_projectile_type = /obj/item/projectile/beam/pistol
	secondary_fire_sound = 'sound/weapons/laser1.ogg'
	can_switch_modes = 1
	turret_sprite_set = "carbine"
	turret_is_lethal = 0

	projectile_type = /obj/item/projectile/beam/stun
	origin_tech = list(TECH_COMBAT = 3, TECH_MAGNET = 2)
	modifystate = "epistolstun"

	firemodes = list(
		list(mode_name="stun", projectile_type=/obj/item/projectile/beam/stun, modifystate="epistolstun", fire_sound='sound/weapons/Taser.ogg'),
		list(mode_name="lethal", projectile_type=/obj/item/projectile/beam/pistol, modifystate="epistolkill", fire_sound='sound/weapons/laser1.ogg')
		)

/obj/item/gun/energy/pistol/hegemony
	name = "hegemony energy pistol"
	desc = "An upgraded variant of the standard energy pistol with two settings: Incapacitate and Smite."
	desc_fluff = "This is the Zkrehk-Guild Beamgun, an energy-based sidearm designed and manufactured on Moghes. A special crystal used in its design allows it to penetrate armor with pinpoint accuracy."
	icon_state = "hegemony_pistol"
	item_state = "hegemony_pistol"
	has_item_ratio = FALSE
	fire_sound = 'sound/weapons/Taser.ogg'
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	max_shots = 10
	fire_delay = 3
	can_turret = FALSE
	secondary_projectile_type = /obj/item/projectile/beam/pistol/hegemony
	secondary_fire_sound = 'sound/weapons/laser1.ogg'
	can_switch_modes = TRUE

	projectile_type = /obj/item/projectile/beam/stun
	origin_tech = list(TECH_COMBAT = 4, TECH_MAGNET = 3)
	modifystate = "hegemony_pistol"

	firemodes = list(
		list(mode_name="incapacitate", projectile_type=/obj/item/projectile/beam/stun, modifystate="hegemony_pistol", fire_sound='sound/weapons/Taser.ogg'),
		list(mode_name="smite", projectile_type=/obj/item/projectile/beam/pistol/hegemony, modifystate="hegemony_pistol", fire_sound='sound/weapons/laser1.ogg')
		)

/obj/item/gun/energy/laser
	name = "laser carbine"
	desc = "An Hephaestus Industries G40E carbine, designed to kill with concentrated energy blasts."
	icon = 'icons/obj/guns/laser.dmi'
	icon_state = "laserrifle100"
	item_state = "laserrifle100"
	has_item_ratio = FALSE // the back and suit slots have ratio sprites but the in-hands dont
	fire_sound = 'sound/weapons/laser1.ogg'
	slot_flags = SLOT_BELT|SLOT_BACK
	accuracy = 1
	w_class = ITEMSIZE_NORMAL
	force = 10
	origin_tech = list(TECH_COMBAT = 3, TECH_MAGNET = 2)
	matter = list(DEFAULT_WALL_MATERIAL = 2000)
	projectile_type = /obj/item/projectile/beam/midlaser
	can_turret = 1
	turret_is_lethal = 1
	turret_sprite_set = "laser"

	modifystate = "laserrifle"

/obj/item/gun/energy/laser/mounted
	name = "mounted laser carbine"
	has_safety = FALSE
	self_recharge = TRUE
	use_external_power = TRUE
	can_turret = FALSE

/obj/item/gun/energy/laser/mounted/cyborg/overclocked
	max_shots = 15
	recharge_time = 1

/obj/item/gun/energy/laser/practice
	name = "practice laser carbine"
	desc = "A modified version of the HI G40E, this one fires less concentrated energy bolts designed for target practice."
	projectile_type = /obj/item/projectile/beam/practice

/obj/item/gun/energy/laser/shotgun
	name = "laser shotgun"
	desc = "A Nanotrasen designed laser weapon, designed to split a single amplified beam four times."
	desc_fluff = "The NT QB-2 is a laser weapon developed and produced by Nanotrasen. Designed to fill in the niche that ballistic shotguns do, but in the form of laser weaponry. It is equipped with a special crystal lens that splits a single laser beam into four."
	icon_state = "lasershotgun"
	item_state = "lasershotgun"
	modifystate = null
	has_item_ratio = FALSE
	fire_sound = 'sound/weapons/laser1.ogg'
	slot_flags = SLOT_BELT|SLOT_BACK
	w_class = ITEMSIZE_LARGE
	accuracy = 0
	force = 10
	matter = list(DEFAULT_WALL_MATERIAL = 2000)
	origin_tech = list(TECH_COMBAT = 4, TECH_MAGNET = 2)
	projectile_type = /obj/item/projectile/beam/shotgun
	max_shots = 20
	sel_mode = 1
	is_wieldable = TRUE
	burst = 4
	burst_delay = 0
	move_delay = 0
	fire_delay = 2
	dispersion = list(10)
	can_turret = TRUE
	turret_is_lethal = TRUE
	turret_sprite_set = "laser"

/obj/item/gun/energy/laser/shotgun/research
	name = "expedition shotgun"
	desc = "A Nanotrasen designed laser weapon, designed to split a single amplified beam four times. This one is marked for expeditionary use."
	pin = /obj/item/device/firing_pin/away_site


obj/item/gun/energy/retro
	name = "retro laser"
	icon = 'icons/obj/guns/laser.dmi'
	icon_state = "retro"
	item_state = "retro"
	has_item_ratio = FALSE
	desc = "An older model of the basic lasergun. Nevertheless, it is still quite deadly and easy to maintain, making it a favorite amongst pirates and other outlaws."
	fire_sound = 'sound/weapons/laser1.ogg'
	slot_flags = SLOT_BELT
	w_class = ITEMSIZE_NORMAL
	offhand_accuracy = 1
	projectile_type = /obj/item/projectile/beam
	fire_delay = 10 //old technology
	can_turret = 1
	turret_is_lethal = 1
	turret_sprite_set = "retro"

	modifystate = "retro"

/obj/item/gun/energy/captain
	name = "antique laser gun"
	icon = 'icons/obj/guns/laser.dmi'
	desc = "This is an antique laser gun. All craftsmanship is of the highest quality. The object menaces with spikes of energy."
	desc_info = "This is an energy weapon.  To fire the weapon, ensure your intent is *not* set to 'help', have your gun mode set to 'fire', \
	then click where you want to fire.  Most energy weapons can fire through windows harmlessly. Unlike most weapons, this weapon recharges itself."
	icon_state = "caplaser"
	item_state = "caplaser"
	has_item_ratio = FALSE
	force = 5
	fire_sound = 'sound/weapons/laser1.ogg'
	slot_flags = SLOT_BELT
	w_class = ITEMSIZE_NORMAL
	offhand_accuracy = 2
	projectile_type = /obj/item/projectile/beam
	origin_tech = null
	max_shots = 5 //to compensate a bit for self-recharging
	self_recharge = 1
	can_turret = 1
	turret_is_lethal = 1
	turret_sprite_set = "captain"

/obj/item/gun/energy/lasercannon
	name = "laser cannon"
	desc = "A nanotrasen designed laser cannon capable of acting as a powerful support weapon."
	desc_fluff = "The NT LC-4 is a laser cannon developed and produced by Nanotrasen. Produced and sold to organizations both in need of a highly powerful support weapon and can afford its high unit cost. In spite of the low capacity, it is a highly capable tool, cutting down fortifications and armored targets with ease."
	icon = 'icons/obj/guns/laser.dmi'
	icon_state = "lasercannon100"
	item_state = "lasercannon100"
	fire_sound = 'sound/weapons/lasercannonfire.ogg'
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3, TECH_POWER = 3)
	slot_flags = SLOT_BELT|SLOT_BACK
	projectile_type = /obj/item/projectile/beam/heavylaser
	charge_cost = 400
	max_shots = 5
	fire_delay = 20
	can_turret = 1
	turret_is_lethal = 1
	turret_sprite_set = "cannon"

	modifystate = "lasercannon"

/obj/item/gun/energy/lasercannon/mounted
	name = "mounted laser cannon"
	self_recharge = 1
	use_external_power = 1
	recharge_time = 10
	can_turret = 0

/obj/item/gun/energy/lasercannon/mounted/cyborg/overclocked
	recharge_time = 1
	max_shots = 15

/obj/item/gun/energy/sniperrifle
	name = "marksman energy rifle"
	desc = "The HI L.W.A.P. is an older design of Hephaestus Industries. A designated marksman rifle capable of shooting powerful ionized beams, this is a weapon to kill from a distance."
	desc_info = "This is an energy weapon.  To fire the weapon, ensure your intent is *not* set to 'help', have your gun mode set to 'fire', \
	then click where you want to fire.  Most energy weapons can fire through windows harmlessly.  To recharge this weapon, use a weapon recharger. \
	To use the scope, use the appropriate verb in the object tab."
	icon = 'icons/obj/guns/laser.dmi'
	icon_state = "sniper"
	item_state = "sniper"
	has_item_ratio = FALSE // same as the laserrifle
	fire_sound = 'sound/weapons/marauder.ogg'
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 5, TECH_POWER = 4)
	projectile_type = /obj/item/projectile/beam/sniper
	slot_flags = SLOT_BACK
	charge_cost = 400
	max_shots = 4
	fire_delay = 45
	force = 10
	w_class = ITEMSIZE_LARGE
	accuracy = -3 //shooting at the hip
	scoped_accuracy = 4
	can_turret = 1
	turret_sprite_set = "sniper"
	turret_is_lethal = 1

	is_wieldable = TRUE

	fire_delay_wielded = 35
	accuracy_wielded = 0

/obj/item/gun/energy/sniperrifle/verb/scope()
	set category = "Object"
	set name = "Use Scope"
	set popup_menu = 1

	if(wielded)
		toggle_scope(2.0, usr)
	else
		to_chat(usr, "<span class='warning'>You can't look through the scope without stabilizing the rifle!</span>")

/////////Two Handed Lasers///////////
/obj/item/gun/energy/rifle
	name = "energy rifle"
	desc = "A Nanotrasen designed energy-based rifle with two settings: Stun and Kill."
	desc_fluff = "The NT ER-2 is an energy rifle developed and produced by Nanotrasen. Widely produced and sold across the galaxy. Designed to both stun and kill with concentrated energy blasts of varying strengths based on the fire mode, focused through a crystal lens. Considered to be a dual-purpose rifle with prolonged combat capability."
	icon = 'icons/obj/guns/laser.dmi'
	icon_state = "eriflestun"
	item_state = "eriflestun"
	fire_sound = 'sound/weapons/Taser.ogg'
	slot_flags = SLOT_BACK
	w_class = ITEMSIZE_LARGE
	force = 10
	max_shots = 20
	fire_delay = 6
	accuracy = -1
	can_turret = 1
	secondary_projectile_type = /obj/item/projectile/beam
	secondary_fire_sound = 'sound/weapons/laser1.ogg'
	can_switch_modes = 1
	turret_sprite_set = "carbine"
	turret_is_lethal = 0

	fire_delay_wielded = 1
	accuracy_wielded = 2
	sel_mode = 1

	projectile_type = /obj/item/projectile/beam/stun
	matter = list(DEFAULT_WALL_MATERIAL = 2000)
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 2, TECH_MAGNET = 3)
	modifystate = "eriflestun"

	is_wieldable = TRUE

	firemodes = list(
		list(mode_name="stun", projectile_type=/obj/item/projectile/beam/stun, modifystate="eriflestun", fire_sound='sound/weapons/Taser.ogg'),
		list(mode_name="lethal", projectile_type=/obj/item/projectile/beam, modifystate="eriflekill", fire_sound='sound/weapons/laser1.ogg')
		)

/obj/item/gun/energy/rifle/laser
	name = "laser rifle"
	desc = "A Nanotrasen designed laser weapon, designed to kill with concentrated energy blasts."
	desc_fluff = "The NT LR-6 is a laser rifle developed and produced by Nanotrasen. Designed to kill with concentrated energy blasts focused through a crystal lens. It is considered to be the template of other standard laser weaponry."
	icon = 'icons/obj/guns/laser.dmi'
	icon_state = "laserrifle"
	item_state = "laserrifle"
	has_item_ratio = FALSE // the back and suit slots have ratio sprites but the in-hands dont
	fire_sound = 'sound/weapons/laser1.ogg'
	max_shots = 15
	fire_delay = 5
	burst_delay = 5
	origin_tech = list(TECH_COMBAT = 3, TECH_MAGNET = 2)
	projectile_type = /obj/item/projectile/beam
	secondary_projectile_type = null
	secondary_fire_sound = null
	can_switch_modes = 0
	turret_sprite_set = "laser"
	turret_is_lethal = 1

	firemodes = list()
	modifystate = null

/obj/item/gun/energy/rifle/laser/heavy
	name = "laser cannon"
	desc = "A nanotrasen designed laser cannon capable of acting as a powerful support weapon."
	desc_fluff = "The NT LC-4 is a laser cannon developed and produced by Nanotrasen. Produced and sold to organizations both in need of a highly powerful support weapon and can afford its high unit cost. In spite of the low capacity, it is a highly capable tool, cutting down fortifications and armored targets with ease."
	icon = 'icons/obj/guns/laser.dmi'
	icon_state = "lasercannon100"
	item_state = "lasercannon100"
	has_item_ratio = TRUE
	fire_sound = 'sound/weapons/lasercannonfire.ogg'
	projectile_type = /obj/item/projectile/beam/heavylaser
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3, TECH_POWER = 3)
	charge_cost = 400
	max_shots = 5
	fire_delay = 40
	accuracy = -2
	secondary_projectile_type = null
	secondary_fire_sound = null
	can_switch_modes = 0
	turret_sprite_set = "cannon"
	turret_is_lethal = 1

	modifystate = "lasercannon"

	accuracy_wielded = 2
	fire_delay_wielded = 20



////////Laser Tag////////////////////

/obj/item/gun/energy/lasertag
	name = "laser tag gun"
	icon = 'icons/obj/guns/laser.dmi'
	item_state = "laser"
	has_item_ratio = FALSE
	desc = "Standard issue weapon of the Imperial Guard"
	origin_tech = list(TECH_COMBAT = 1, TECH_MAGNET = 2)
	self_recharge = 1
	matter = list(DEFAULT_WALL_MATERIAL = 2000)
	fire_sound = 'sound/weapons/laser1.ogg'
	projectile_type = /obj/item/projectile/beam/lastertag/blue
	var/required_vest

/obj/item/gun/energy/lasertag/special_check(var/mob/living/carbon/human/M)
	if(ishuman(M))
		if(!istype(M.wear_suit, required_vest))
			to_chat(M, "<span class='warning'>You need to be wearing your laser tag vest!</span>")
			return 0
	return ..()

/obj/item/gun/energy/lasertag/blue
	icon_state = "bluetag"
	item_state = "bluetag"
	projectile_type = /obj/item/projectile/beam/lastertag/blue
	required_vest = /obj/item/clothing/suit/bluetag
	pin = /obj/item/device/firing_pin/tag/blue
	can_turret = 1
	turret_is_lethal = 0
	turret_sprite_set = "blue"

/obj/item/gun/energy/lasertag/red
	icon_state = "redtag"
	item_state = "redtag"
	projectile_type = /obj/item/projectile/beam/lastertag/red
	required_vest = /obj/item/clothing/suit/redtag
	pin = /obj/item/device/firing_pin/tag/red
	can_turret = 1
	turret_is_lethal = 0
	turret_sprite_set = "red"
