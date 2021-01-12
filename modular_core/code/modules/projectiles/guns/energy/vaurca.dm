/* Vaurca Weapons */
//I understand these are suppose to be "Artifact Weapons" of the sorts so I decided to give them their own file
//May use this as a general artifact gun folder later but safe to say these weapons should not be in circulation...

/obj/item/gun/energy/vaurca
	name = "Alien Firearm"
	desc = "Vaurcae weapons tend to be specialized and highly lethal. This one doesn't do much"
	icon = 'icons/obj/guns/vaurca.dmi'
	var/is_charging = 0 //special var for sanity checks in the three guns that currently use charging as a special_check

/obj/item/gun/energy/vaurca/bfg
	name = "BFG 9000"
	desc = "'Bio-Force Gun'. Yeah, right."
	icon_state = "bfg"
	item_state = "bfg"
	has_item_ratio = FALSE
	charge_meter = 0
	w_class = ITEMSIZE_LARGE
	fire_sound = 'sound/magic/LightningShock.ogg'
	force = 30
	projectile_type = /obj/item/projectile/energy/bfg
	slot_flags = SLOT_BACK
	max_shots = 3
	sel_mode = 1
	fire_delay = 10
	accuracy = 20
	muzzle_flash = 10

#define GATLINGLASER_DISPERSION_CONCENTRATED list(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
#define GATLINGLASER_DISPERSION_SPRAY list(0, 5, 5, 10, 10, 15, 15, 20, 20, 25, 25, 30, 30, 35, 40, 45)

/obj/item/gun/energy/vaurca/gatlinglaser
	name = "gatling laser"
	desc = "A highly sophisticated rapid fire laser weapon."
	icon_state = "gatling"
	item_state = "gatling"
	has_item_ratio = FALSE
	fire_sound = 'sound/weapons/laser1.ogg'
	origin_tech = list(TECH_COMBAT = 6, TECH_PHORON = 5, TECH_MATERIAL = 6)
	charge_meter = 0
	slot_flags = SLOT_BACK
	w_class = ITEMSIZE_LARGE
	force = 10
	projectile_type = /obj/item/projectile/beam/gatlinglaser
	max_shots = 80
	sel_mode = 1
	burst = 10
	burst_delay = 1
	fire_delay = 10
	dispersion = GATLINGLASER_DISPERSION_CONCENTRATED

	is_wieldable = TRUE

	firemodes = list(
		list(mode_name="concentrated burst", burst=10, burst_delay = 1, fire_delay = 10, dispersion = GATLINGLASER_DISPERSION_CONCENTRATED),
		list(mode_name="spray", burst=20, burst_delay = 1, move_delay = 5, fire_delay = 30, dispersion = GATLINGLASER_DISPERSION_SPRAY)
		)

	charge_cost = 50

/obj/item/gun/energy/vaurca/gatlinglaser/special_check(var/mob/user)
	if(is_charging)
		to_chat(user, "<span class='danger'>\The [src] is already spinning!</span>")
		return 0
	if(!wielded)
		to_chat(user, "<span class='danger'>You cannot fire this weapon with just one hand!</span>")
		return 0
	playsound(src, 'sound/weapons/saw/chainsawstart.ogg', 90, 1)
	user.visible_message(
					"<span class='danger'>\The [user] begins spinning [src]'s barrels!</span>",
					"<span class='danger'>You begin spinning [src]'s barrels!</span>",
					"<span class='danger'>You hear the spin of a rotary gun!</span>"
					)
	is_charging = 1
	if(!do_after(user, 30))
		is_charging = 0
		return 0
	is_charging = 0
	if(!istype(user.get_active_hand(), src))
		return
	msg_admin_attack("[key_name_admin(user)] shot with \a [src.type] [key_name_admin(src)]'s target (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[src.x];Y=[src.y];Z=[src.z]'>JMP</a>)",ckey=key_name(user),ckey_target=key_name(src))

	return ..()

/obj/item/gun/energy/vaurca/blaster
	name = "\improper Zo'ra Blaster"
	desc = "An elegant weapon for a more civilized time."
	icon_state = "blaster"
	item_state = "blaster"
	has_item_ratio = FALSE
	origin_tech = list(TECH_COMBAT = 2, TECH_PHORON = 4)
	fire_sound = 'sound/weapons/laser1.ogg'
	slot_flags = SLOT_BACK | SLOT_HOLSTER | SLOT_BELT
	w_class = ITEMSIZE_NORMAL
	accuracy = 1
	force = 10
	projectile_type = /obj/item/projectile/energy/blaster/incendiary
	max_shots = 6
	sel_mode = 1
	burst = 1
	burst_delay = 1
	fire_delay = 0
	can_turret = 1
	turret_sprite_set = "laser"
	firemodes = list(
		list(mode_name="single shot", burst=1, burst_delay = 1, fire_delay = 0),
		list(mode_name="concentrated burst", burst=3, burst_delay = 1, fire_delay = 5)
		)

/obj/item/gun/energy/vaurca/typec
	name = "thermal lance"
	desc = "A powerful piece of Zo'rane energy artillery, converted to be portable...if you weigh a metric tonne, that is."
	icon_state = "megaglaive0"
	item_state = "megaglaive"
	item_icons = list(//DEPRECATED. USE CONTAINED SPRITES IN FUTURE //Moved to special Vaurca.dmi until we find a better place for it
		slot_l_hand_str = 'icons/mob/species/breeder/held_l.dmi', //Keep Seperate since they are 64X64 sprites
		slot_r_hand_str = 'icons/mob/species/breeder/held_r.dmi'
		)
	origin_tech = list(TECH_COMBAT = 6, TECH_PHORON = 8)
	fire_sound = 'sound/magic/lightningbolt.ogg'
	attack_verb = list("sundered", "annihilated", "sliced", "cleaved", "slashed", "pulverized")
	slot_flags = SLOT_BACK
	w_class = ITEMSIZE_HUGE
	accuracy = 3 // It's a massive beam, okay.
	force = 60
	projectile_type = /obj/item/projectile/beam/megaglaive
	max_shots = 36
	sel_mode = 1
	burst = 10
	burst_delay = 1
	fire_delay = 30
	sharp = 1
	edge = 1
	anchored = 0
	armor_penetration = 40
	flags = NOBLOODY
	can_embed = 0
	self_recharge = 1
	recharge_time = 2
	needspin = FALSE

	is_wieldable = TRUE

	action_button_name = "Wield thermal lance"

/obj/item/gun/energy/vaurca/typec/attack(mob/living/carbon/human/M as mob, mob/living/carbon/user as mob)
	user.setClickCooldown(16)
	..()

/obj/item/gun/energy/vaurca/typec/pre_attack(var/mob/living/target, var/mob/living/user)
	if(istype(target))
		cleave(user, target)
	..()

/obj/item/gun/energy/vaurca/typec/special_check(var/mob/user)
	if(is_charging)
		to_chat(user, "<span class='danger'>\The [src] is already charging!</span>")
		return 0
	if(!wielded)
		to_chat(user, "<span class='danger'>You could never fire this weapon with merely one hand!</span>")
		return 0
	user.visible_message(
					"<span class='danger'>\The [user] begins charging the [src]!</span>",
					"<span class='danger'>You begin charging the [src]!</span>",
					"<span class='danger'>You hear a low pulsing roar!</span>"
					)
	is_charging = 1
	if(!do_after(user, 20))
		is_charging = 0
		return 0
	is_charging = 0
	if(!istype(user.get_active_hand(), src))
		return
	msg_admin_attack("[key_name_admin(user)] shot with \a [src.type] [key_name_admin(src)]'s target (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[src.x];Y=[src.y];Z=[src.z]'>JMP</a>)",ckey=key_name(user),ckey_target=key_name(src))

	return ..()

/obj/item/gun/energy/vaurca/typec/attack_hand(mob/user as mob)
	if(loc != user)
		var/mob/living/carbon/human/H = user
		if(H.mob_size >= 30)
			playsound(user, 'sound/weapons/saberon.ogg', 50, 1)
			anchored = 1
			to_chat(user, "<span class='notice'>\The [src] is now energised.</span>")
			icon_state = "megaglaive1"
			..()
			return
		to_chat(user, "<span class='warning'>\The [src] is far too large for you to pick up.</span>")
		return

/obj/item/gun/energy/vaurca/typec/dropped(var/mob/user)
	..()
	if(!istype(loc,/mob))
		playsound(user, 'sound/weapons/saberoff.ogg', 50, 1)
		icon_state = "megaglaive0"
		anchored = 0

/obj/item/gun/energy/vaurca/typec/update_icon()
	return

/obj/item/gun/energy/vaurca/thermaldrill
	name = "thermal drill"
	desc = "Pierce the heavens? Son, there won't <i>be</i> any heavens when you're through with it."
	icon_state = "thermaldrill"
	item_state = "thermaldrill"
	has_item_ratio = FALSE
	origin_tech = list(TECH_COMBAT = 6, TECH_PHORON = 8)
	fire_sound = 'sound/magic/lightningbolt.ogg'
	slot_flags = SLOT_BACK
	w_class = ITEMSIZE_LARGE
	accuracy = 0 // Overwrite just in case.
	force = 15
	projectile_type = /obj/item/projectile/beam/thermaldrill
	max_shots = 90
	sel_mode = 1
	burst = 10
	burst_delay = 1
	fire_delay = 20
	self_recharge = 1
	recharge_time = 1
	charge_meter = 1
	charge_cost = 50
	can_turret = 1
	turret_sprite_set = "thermaldrill"

	is_wieldable = TRUE

	firemodes = list(
		list(mode_name="2 second burst", burst=10, burst_delay = 1, fire_delay = 20),
		list(mode_name="4 second burst", burst=20, burst_delay = 1, fire_delay = 40),
		list(mode_name="6 second burst", burst=30, burst_delay = 1, fire_delay = 60),
		list(mode_name="point-burst auto", can_autofire = TRUE, burst = 1, fire_delay = 1, burst_accuracy = list(0,-1,-1,-2,-2,-2,-3,-3), dispersion = list(1.0, 1.0, 1.0, 1.0, 1.2))
		)

	action_button_name = "Wield thermal drill"

	needspin = FALSE

/obj/item/gun/energy/vaurca/thermaldrill/special_check(var/mob/user)
	if(can_autofire)
		return ..()
	if(is_charging)
		to_chat(user, "<span class='danger'>\The [src] is already charging!</span>")
		return 0
	if(!wielded)
		to_chat(user, "<span class='danger'>You cannot fire this weapon with just one hand!</span>")
		return 0
	user.visible_message(
					"<span class='danger'>\The [user] begins charging the [src]!</span>",
					"<span class='danger'>You begin charging the [src]!</span>",
					"<span class='danger'>You hear a low pulsing roar!</span>"
					)
	is_charging = 1
	if(!do_after(user, 40))
		is_charging = FALSE
		return 0
	is_charging = 0
	if(!istype(user.get_active_hand(), src))
		return
	msg_admin_attack("[key_name_admin(user)] shot with \a [src.type] [key_name_admin(src)]'s target (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[src.x];Y=[src.y];Z=[src.z]'>JMP</a>)")

	return ..()

/obj/item/gun/energy/vaurca/mountedthermaldrill
	name = "mounted thermal drill"
	desc = "Pierce the heavens? Son, there won't <i>be</i> any heavens when you're through with it."
	icon_state = "thermaldrill"
	item_state = "thermaldrill"
	has_item_ratio = FALSE
	origin_tech = list(TECH_COMBAT = 6, TECH_PHORON = 8)
	fire_sound = 'sound/magic/lightningbolt.ogg'
	slot_flags = SLOT_BACK
	w_class = ITEMSIZE_LARGE
	force = 15
	projectile_type = /obj/item/projectile/beam/thermaldrill
	max_shots = 90
	sel_mode = 1
	burst = 30
	burst_delay = 1
	fire_delay = 20
	self_recharge = 1
	recharge_time = 1
	charge_meter = 1
	use_external_power = 1
	charge_cost = 25

/obj/item/gun/energy/vaurca/mountedthermaldrill/special_check(var/mob/user)
	if(is_charging)
		to_chat(user, "<span class='danger'>\The [src] is already charging!</span>")
		return 0
	user.visible_message(
					"<span class='danger'>\The [user] begins charging the [src]!</span>",
					"<span class='danger'>You begin charging the [src]!</span>",
					"<span class='danger'>You hear a low pulsing roar!</span>"
					)
	is_charging = 1
	if(!do_after(user, 20))
		is_charging = 0
		return 0
	is_charging = 0
	msg_admin_attack("[key_name_admin(user)] shot with \a [src.type] [key_name_admin(src)]'s target (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[src.x];Y=[src.y];Z=[src.z]'>JMP</a>)",ckey=key_name(user),ckey_target=key_name(src))

	return ..()

/obj/item/gun/energy/vaurca/tachyon
	name = "tachyon carbine"
	desc = "A Vaurcan carbine that fires a beam of concentrated faster than light particles, capable of passing through most forms of matter."
	icon_state = "tachyoncarbine"
	item_state = "tachyoncarbine"
	has_item_ratio = FALSE
	fire_sound = 'sound/weapons/laser3.ogg'
	projectile_type = /obj/item/projectile/beam/tachyon
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 3, TECH_MAGNET = 2, TECH_ILLEGAL = 2)
	max_shots = 10
	accuracy = 1
	fire_delay = 1
	can_turret = 0

/obj/item/gun/energy/rifle/laser/tachyon
	name = "tachyon rifle"
	desc = "A Vaurcan rifle that fires a beam of concentrated faster than light particles, capable of passing through most forms of matter."
	icon_state = "tachyonrifle"
	item_state = "tachyonrifle"
	has_item_ratio = FALSE
	fire_sound = 'sound/weapons/laser3.ogg'
	projectile_type = /obj/item/projectile/beam/tachyon
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 3, TECH_MAGNET = 2, TECH_ILLEGAL = 2)
	secondary_projectile_type = null
	secondary_fire_sound = null
	can_switch_modes = 0
	can_turret = 0
	zoomdevicename = "rifle scope"
	var/obj/screen/overlay = null

/obj/item/gun/energy/rifle/laser/tachyon/verb/scope()
	set category = "Object"
	set name = "Use Rifle Scope"
	set popup_menu = 1

	if(wielded)
		toggle_scope(2.0, usr)
	else
		to_chat(usr, "<span class='warning'>You can't look through the scope without stabilizing the rifle!</span>")

/obj/item/gun/launcher/crossbow/vaurca
	name = "gauss rifle"
	desc = "An unwieldy, heavy weapon that propels metal projectiles with magnetic coils that run its length."
	contained_sprite = 1
	icon = 'icons/obj/guns/vaurca.dmi'
	icon_state = "gaussrifle"
	item_state = "gaussrifle"
	fire_sound = /decl/sound_category/gauss_fire_sound
	fire_sound_text = "a subdued boom"
	fire_delay = 12
	slot_flags = SLOT_BACK
	needspin = TRUE
	recoil = 6

	is_wieldable = TRUE

	release_speed = 5
	var/list/belt = new/list()
	var/belt_size = 12 //holds this + one in the chamber
	recoil_wielded = 2
	accuracy_wielded = -1
	fire_delay_wielded = 1

/obj/item/gun/launcher/crossbow/vaurca/consume_next_projectile(mob/user=null)
	return bolt

/obj/item/gun/launcher/crossbow/vaurca/handle_post_fire(mob/user, atom/target)
	bolt = null
	tension = 1
	..()

/obj/item/gun/launcher/crossbow/vaurca/attack_self(mob/living/user as mob)
	pump(user)

/obj/item/gun/launcher/crossbow/vaurca/proc/pump(mob/M as mob)
	playsound(M, 'sound/weapons/shotgun_pump.ogg', 60, 1)

	if(bolt)
		if(tension < max_tension)
			if(do_after(M, 5 * tension))
				to_chat(M, "<span class='warning'>You pump [src], charging the magnetic coils.</span>")
				tension++
		else
			to_chat(M, "<span class='notice'>\The [src]'s magnetic coils are at maximum charge.</span>")
		return
	var/obj/item/next
	if(belt.len)
		next = belt[1]
	if(do_after(M, 10))
		if(next)
			belt -= next //Remove grenade from loaded list.
			bolt = next
			to_chat(M, "<span class='warning'>You pump [src], loading \a [next] into the chamber.</span>")
		else
			to_chat(M, "<span class='warning'>You pump [src], but the magazine is empty.</span>")

/obj/item/gun/launcher/crossbow/vaurca/proc/load(obj/item/W, mob/user)
	if(belt.len >= belt_size)
		to_chat(user, "<span class='warning'>[src] is full.</span>")
		return
	user.remove_from_mob(W)
	W.forceMove(src)
	belt.Insert(1, W) //add to the head of the list, so that it is loaded on the next pump
	user.visible_message("[user] inserts \a [W] into [src].", "<span class='notice'>You insert \a [W] into [src].</span>")

/obj/item/gun/launcher/crossbow/vaurca/proc/unload(mob/user)
	if(belt.len)
		var/obj/item/arrow/rod/R = belt[belt.len]
		belt.len--
		user.put_in_hands(R)
		user.visible_message("[user] removes \a [R] from [src].", "<span class='notice'>You remove \a [R] from [src].</span>")
	else
		to_chat(user, "<span class='warning'>[src] is empty.</span>")

/obj/item/gun/launcher/crossbow/vaurca/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/arrow))
		load(I, user)
	if(istype(I, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = I
		if (R.use(1))
			var/obj/item/arrow/rod/ROD = new /obj/item/arrow/rod(src)
			load(ROD, user)
	else
		..()

/obj/item/gun/launcher/crossbow/vaurca/attack_hand(mob/user)
	if(user.get_inactive_hand() == src)
		unload(user)
	else
		..()

/obj/item/gun/launcher/crossbow/vaurca/superheat_rod(mob/user)
	if(!user || !bolt) return
	if(bolt.throwforce >= 25) return
	if(!istype(bolt,/obj/item/arrow/rod)) return

	bolt.throwforce = 25
	bolt.icon_state = "metal-rod-superheated"

/obj/item/gun/launcher/crossbow/vaurca/update_icon()
	return

//This gun only functions for vaurca warriors. The on-sprite is too huge to render properly on other sprites.
//File Bloat is the enemy of progress... This is not here with all other Vaurca weapons..
//Also the above is only half true... In reality the sprite was gone with only the Vaurca in mind so it would just look dumb on other races
/obj/item/gun/energy/noisecannon
	name = "alien heavy cannon"
	desc = "It's some kind of enormous alien weapon, as long as a man is tall."

	icon = 'icons/obj/guns/vaurca.dmi'
	icon_state = "noisecannon"
	item_state = "noisecannon"
	recoil = 1

	force = 10
	projectile_type = /obj/item/projectile/energy/sonic
	cell_type = /obj/item/cell/super
	fire_delay = 40
	fire_sound = 'sound/effects/basscannon.ogg'
	needspin = FALSE

	var/mode = 1

/obj/item/gun/energy/noisecannon/attack_hand(mob/user as mob)
	if(loc != user)
		var/mob/living/carbon/human/H = user
		if(istype(H))
			if(H.species.name == SPECIES_VAURCA_WARRIOR)
				..()
				return
		to_chat(user, "<span class='warning'>\The [src] is far too large for you to pick up.</span>")
		return

/obj/item/gun/energy/noisecannon/update_icon()
	return

//Projectile.
/obj/item/projectile/energy/sonic
	name = "distortion"
	icon = 'icons/obj/machines/particle_accelerator2.dmi'
	icon_state = "particle"
	damage = 60
	damage_type = BRUTE
	check_armor = "bullet"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE

	embed = 0
	weaken = 5
	stun = 5
