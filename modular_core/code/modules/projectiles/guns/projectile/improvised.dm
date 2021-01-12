//ghetto shotgun, mostly based on the tg-version. Also this file can be used for more improvised guns in the future - Alberyk
//Improvished Firearms go here
//Projectile weapons that are either craftable or have a "homebuilt" feel

/obj/item/gun/projectile/shotgun/improvised //similar to the double barrel, but without the option to fire both barrels //Now a Single Barrel since there is only one pipe you knob
	name = "improvised shotgun"
	desc = "An improvised pipe assembly that can fire shotgun shells."
	icon = 'icons/obj/guns/improvised.dmi'
	icon_state = "ishotgun"
	item_state = "ishotgun"
	max_shells = 1
	w_class = ITEMSIZE_LARGE
	force = 5
	recoil = 2
	accuracy = -1
	slot_flags = SLOT_BACK
	caliber = "shotgun"
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	handle_casings = CYCLE_CASINGS
	load_method = SINGLE_CASING
	needspin = FALSE
	fire_sound = 'sound/weapons/gunshot/gunshot_shotgun2.ogg'
//	var/fail_chance = 35
	has_safety = FALSE //Why did pipe guns have safeties?
	jam_chance = 20
/*											//This is commented out until we can make a better system for it... Especially since pipe guns are  to be an improtant part of Blight
/obj/item/gun/projectile/shotgun/improvised/special_check(var/mob/living/carbon/human/M)
	if(prob(fail_chance))
		if(!loaded.len)
			M.visible_message("<span class='danger'>[M]'s weapon blows up, shattering into pieces!</span>","<span class='danger'>[src] blows up in your face!</span>", "You hear a loud bang!")
			M.take_organ_damage(0,30)
			M.drop_item()
			new /obj/item/material/shard/shrapnel(get_turf(src))
			qdel(src)
			return 0
		else
			return 0
	return ..()
*/
/obj/item/gun/projectile/shotgun/improvised/attackby(var/obj/item/A as obj, mob/user as mob)
	if(istype(A, /obj/item/surgery/circular_saw) || istype(A, /obj/item/melee/energy) || istype(A, /obj/item/gun/energy/plasmacutter) && w_class != 3)
		to_chat(user, "<span class='notice'>You begin to shorten the barrel of \the [src].</span>")
		if(loaded.len)
			for(var/i in 1 to max_shells)
				Fire(user, user)	//will this work? //it will. we call it twice, for twice the FUN
			user.visible_message("<span class='danger'>The shotgun goes off!</span>", "<span class='danger'>The shotgun goes off in your face!</span>")
			return
		if(do_after(user, 30))
			icon_state = "ishotgunsawn"
			item_state = "ishotgunsawn"
			w_class = ITEMSIZE_NORMAL
			force = 5
			slot_flags &= ~SLOT_BACK
			slot_flags |= (SLOT_BELT|SLOT_HOLSTER)
			name = "sawn-off improvised shotgun"
			to_chat(user, "<span class='warning'>You shorten the barrel of \the [src]!</span>")
	else
		..()

/obj/item/gun/projectile/shotgun/improvised/examine(mob/user)
	..(user)
	switch(jam_chance)
		if(1) to_chat(user, "All craftsmanship is of the highest quality.")
		if(2 to 25) to_chat(user, "All craftsmanship is of high quality.")
		if(26 to 50) to_chat(user, "All craftsmanship is of average quality.")
		if(51 to 75) to_chat(user, "All craftsmanship is of low quality.")
		if(100) to_chat(user, "All craftsmanship is of the lowest quality.")

/obj/item/gun/projectile/shotgun/improvised/sawn
	name = "sawn-off improvised shotgun"
	desc = "An improvised pipe assembly that can fire shotgun shells."
	icon_state = "ishotgunsawn"
	item_state = "ishotgunsawn"
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	w_class = ITEMSIZE_NORMAL
	force = 5

// shotgun construction

/obj/item/gun_parts
	name = "weapon parts"
	desc = "A part from some kind of weapon. Though this one appears rather useless."
	icon = 'icons/obj/improvised.dmi'

/obj/item/gun_parts/stock
	name = "rifle stock"
	desc = "A classic rifle stock that doubles as a grip, roughly carved out of wood."
	icon_state = "riflestock"
	var/buildstate = 0

/obj/item/gun_parts/receivergun
	name = "receiver"
	desc = "A receiver and trigger assembly for a firearm."
	icon_state = "receiver"
	var/buildstate = 0

/obj/item/gun_parts/barrel
	name = "rifle barrel"
	desc = "A long rifled barrel with proper iron sights screwed on to it."
	icon_state = "barrel"
	var/buildstate = 0

/obj/item/gun_parts/flintlock
	name = "flintlock mechanism"
	desc = "A self striking flint and steel of a powder pan that funnels a barrel."
	icon_state = "flintlock"
	var/buildstate = 0


/obj/item/gun_parts/receivergun/examine(mob/user)
	..(user)
	switch(buildstate)
		if(1) to_chat(user, "It has a pipe segment installed.")
		if(2) to_chat(user, "It has a stock installed.")
		if(3) to_chat(user, "Its pieces are held together by tape roll.")

/obj/item/gun_parts/receivergun/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/pipe))
		if(buildstate == 0)
			qdel(W)
			to_chat(user, "<span class='notice'>You place the pipe and the receiver together.</span>")
			buildstate++
			update_icon()
			return
	else if(istype(W,/obj/item/gun_parts/stock))
		if(buildstate == 1)
			qdel(W)
			to_chat(user, "<span class='notice'>You add the stock to the assembly.</span>")
			buildstate++
			update_icon()
			return
	else if(istype(W,/obj/item/tape_roll))
		if(buildstate == 2)
			qdel(W)
			to_chat(user, "<span class='notice'>You strap the pieces together with tape.</span>")
			buildstate++
			update_icon()
			return
	else if(W.iscoil())
		var/obj/item/stack/cable_coil/C = W
		if(buildstate == 3)
			if(C.use(10))
				to_chat(user, "<span class='notice'>You tie the lengths of cable to the shotgun, making a sling.</span>")
				var/obj/item/gun/projectile/shotgun/improvised/G = new(get_turf(src))
				G.jam_chance = rand(1,100)
				qdel(src)
			else
				to_chat(user, "<span class='notice'>You need at least ten lengths of cable if you want to make a sling!.</span>")
				return

//ghetto handgun, sprites by datberry

/obj/item/gun/projectile/improvised_handgun
	name = "improvised handgun"
	desc = "A common sight in an amateur's workshop, a simple yet effective assembly made to chamber and fire a single pistol round."
	max_shells = 1	//As cheap as this is giving it a magazine is stupid. Now presenting a true improvised handgun.
	recoil = 2
	accuracy = -1
	offhand_accuracy = 1
	fire_delay = 9
	icon = 'icons/obj/guns/improvised.dmi'
	icon_state = "ipistol"
	item_state = "ipistol"
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	fire_sound = 'sound/weapons/gunshot/gunshot_light.ogg'
	handle_casings = CYCLE_CASINGS
	load_method = SINGLE_CASING
	jam_chance = 20
	needspin = FALSE
	has_safety = FALSE //Why did pipe guns have safeties?

	var/global/list/ammo_types = list(
		/obj/item/ammo_casing/a357              = ".357",
		/obj/item/ammo_casing/c38				= ".38",
		/obj/item/ammo_casing/c38				= ".38",
		/obj/item/ammo_casing/c38/rubber		= ".38",
		/obj/item/ammo_casing/c38/emp			= ".38",
		/obj/item/ammo_casing/c9mm				= "9mm",
		/obj/item/ammo_casing/c9mm				= "9mm",
		/obj/item/ammo_casing/c9mm/flash		= "9mm",
		/obj/item/ammo_casing/c9mm/rubber		= "9mm",
		/obj/item/ammo_casing/c10mm				= "10mm",
		/obj/item/ammo_casing/c10mm				= "10mm",
		/obj/item/ammo_casing/c10mm				= "10mm",
		/obj/item/ammo_casing/c45				= ".45",
		/obj/item/ammo_casing/c45				= ".45",
		/obj/item/ammo_casing/c45/rubber		= ".45",
		/obj/item/ammo_casing/c45/flash			= ".45",
		/obj/item/ammo_casing/a12mm				= "12mm"
		)

/obj/item/gun/projectile/improvised_handgun/Initialize()
	ammo_type = pick(ammo_types)
	desc += " Uses [ammo_types[ammo_type]] rounds."

	var/obj/item/ammo_casing/ammo = ammo_type
	caliber = initial(ammo.caliber)
	. = ..()

/obj/item/gun/projectile/improvised_handgun/examine(mob/user)
	..(user)
	switch(jam_chance)
		if(1) to_chat(user, "All craftsmanship is of the highest quality.")
		if(2 to 25) to_chat(user, "All craftsmanship is of high quality.")
		if(26 to 50) to_chat(user, "All craftsmanship is of average quality.")
		if(51 to 75) to_chat(user, "All craftsmanship is of low quality.")
		if(100) to_chat(user, "All craftsmanship is of the lowest quality.")

/obj/item/gun_parts/stock/update_icon()
	icon_state = "ipistol[buildstate]"

/obj/item/gun_parts/stock/examine(mob/user)
	..(user)
	switch(buildstate)
		if(1) to_chat(user, "It is carved in the shape of a pistol handle.")
		if(2) to_chat(user, "It has a receiver installed.")
		if(3) to_chat(user, "It has a pipe installed.")

/obj/item/gun_parts/stock/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/material/hatchet))
		if(buildstate == 0)
			to_chat(user, "<span class='notice'>You carve the rifle stock.</span>")
			buildstate++
			update_icon()
			return
	else if(istype(W,/obj/item/gun_parts/receivergun))
		if(buildstate == 1)
			qdel(W)
			to_chat(user, "<span class='notice'>You add the receiver to the assembly.</span>")
			buildstate++
			update_icon()
			return
	else if(istype(W,/obj/item/pipe))
		if(buildstate == 2)
			qdel(W)
			to_chat(user, "<span class='notice'>You strap the pipe to the assembly.</span>")
			buildstate++
			update_icon()
			return
	else if(W.iswelder())
		if(buildstate == 3)
			var/obj/item/weldingtool/T = W
			if(T.remove_fuel(0,user))
				if(!src || !T.isOn()) return
				playsound(src.loc, 'sound/items/welder_pry.ogg', 100, 1)
				to_chat(user, "<span class='notice'>You shorten the barrel with the welding tool.</span>")
				var/obj/item/gun/projectile/improvised_handgun/G = new(get_turf(src))
				G.jam_chance = rand(1,100)
				qdel(src)
		..()

/obj/item/gun/projectile/automatic/improvised
	name = "improvised machine pistol"
	desc = "An improvised automatic handgun. Uses .45 rounds."
	icon = 'icons/obj/guns/improvised.dmi'
	icon_state = "ismg"
	item_state = "ismg"
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/c45uzi
	allowed_magazines = list(/obj/item/ammo_magazine/c45uzi)
	max_shells = 16
	caliber = ".45"
	sel_mode = 1
	accuracy = -1
	fire_delay = 5
	burst = 3
	burst_delay = 3
	move_delay = 3
	fire_delay = 2
	dispersion = list(5, 10, 15, 20)
	jam_chance = 20

	needspin = FALSE

	firemodes = list()

	has_safety = FALSE //Why did pipe guns have safeties?

/obj/item/gun/projectile/musket/improvised
	name = "improvised musket"
	desc = "An improvised flintlock rifle. How far has civilization fallen?"

	desc_fluff = "With the mass collapse of civilized society people were forced to take anything they could and when it became impossible to produce complex cartirdges even muskets made a comeback. \
	Weapons such as these show just how far 28th century society has regressed with parts scraped from advanced machines used to construct a weapon that would dated a miliennia ago."

	icon = 'icons/obj/guns/improvised.dmi'
	icon_state = "imusket"
	item_state = "ishotgun"

	fire_delay = 40 //Probably not as easy to stick those bullet in there when its not made properly
	accuracy = -1 //Smoothbore
	jam_chance = 20 //Improvised
	has_safety = FALSE //Why did pipe guns have safeties?


/obj/item/gun_parts/flintlock/update_icon()
	icon_state = "iflintlock[buildstate]"

/obj/item/gun_parts/flintlock/examine(mob/user)
	..(user)
	switch(buildstate)
		if(1) to_chat(user, "It has a pipe segment installed.")
		if(2) to_chat(user, "It has a stock installed.")
		if(3) to_chat(user, "Its pieces are held together by tape roll.")

/obj/item/gun/projectile/musket/improvised/attackby(var/obj/item/A as obj, mob/user as mob)
	if(istype(A, /obj/item/surgery/circular_saw) || istype(A, /obj/item/melee/energy) || istype(A, /obj/item/gun/energy/plasmacutter) && w_class != 3)
		to_chat(user, "<span class='notice'>You begin to shorten the barrel of \the [src].</span>")
		if(has_powder)	//This way it will only go off in your face when you actually have powder loaded
			Fire(user, user)	//will this work? //it will. we call it twice, for twice the FUN
			user.visible_message("<span class='danger'>The musket goes off!</span>", "<span class='danger'>The musket goes off in your face!</span>")
			return
		if(do_after(user, 30))
			icon_state = "iflintlock"
			item_state = "ipistol"
			w_class = ITEMSIZE_NORMAL
			force = 5
			slot_flags &= ~SLOT_BACK
			slot_flags |= (SLOT_BELT|SLOT_HOLSTER)
			name = "improvised flintlock"
			accuracy = -2 //Very Smoothbore
			to_chat(user, "<span class='warning'>You shorten the barrel of \the [src]!</span>")
	else
		..()

/obj/item/gun_parts/flintlock/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/pipe))
		if(buildstate == 0)
			qdel(W)
			to_chat(user, "<span class='notice'>You place the pipe and the flintlock together.</span>")
			buildstate++
			update_icon()
			return
	else if(istype(W,/obj/item/gun_parts/stock))
		if(buildstate == 1)
			qdel(W)
			to_chat(user, "<span class='notice'>You add the stock to the assembly.</span>")
			buildstate++
			update_icon()
			return
	else if(istype(W,/obj/item/tape_roll))
		if(buildstate == 2)
			qdel(W)
			to_chat(user, "<span class='notice'>You strap the pieces together with tape.</span>")
			buildstate++
			update_icon()
			return
	else if(W.iscoil())
		var/obj/item/stack/cable_coil/C = W
		if(buildstate == 3)
			if(C.use(10))
				to_chat(user, "<span class='notice'>You tie the lengths of cable to the musket, making a sling.</span>")
				var/obj/item/gun/projectile/musket/improvised/G = new(get_turf(src))
				G.jam_chance = rand(1,100)
				qdel(src)
			else
				to_chat(user, "<span class='notice'>You need at least ten lengths of cable if you want to make a sling!.</span>")
				return

/obj/item/gun/projectile/musket/improvised/sawn
	name = "improvised flintlock"
	desc = "A hastily cobbled together flintlock pistol. You better hope you only need one shot."
	icon_state = "iflintlock"
	item_state = "ipistol"
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	w_class = ITEMSIZE_NORMAL
	force = 5
	accuracy = -2 //Very Smoothbore

/obj/item/gun/projectile/pirate
	name = "zip gun"
	desc = "Little more than a barrel, handle, and firing mechanism, cheap makeshift firearms like this one are not uncommon in frontier systems."
	icon = 'icons/obj/guns/improvised.dmi'
	icon_state = "zipgun"
	item_state = "zipgun"
	handle_casings = CYCLE_CASINGS //player has to take the old casing out manually before reloading
	load_method = SINGLE_CASING
	max_shells = 1 //literally just a barrel
	has_safety = FALSE //Why did pipe guns have safeties?

	var/global/list/ammo_types = list(
		/obj/item/ammo_casing/a357              = ".357",
		/obj/item/ammo_casing/shotgun           = "12 gauge",
		/obj/item/ammo_casing/shotgun           = "12 gauge",
		/obj/item/ammo_casing/shotgun/pellet    = "12 gauge",
		/obj/item/ammo_casing/shotgun/pellet    = "12 gauge",
		/obj/item/ammo_casing/shotgun/beanbag   = "12 gauge",
		/obj/item/ammo_casing/shotgun/emp	    = "12 gauge",
		/obj/item/ammo_casing/a762              = "7.62mm",
		/obj/item/ammo_casing/a556              = "5.56mm"
		)

/obj/item/gun/projectile/pirate/Initialize()
	ammo_type = pick(ammo_types)
	desc += " Uses [ammo_types[ammo_type]] rounds."

	var/obj/item/ammo_casing/ammo = ammo_type
	caliber = initial(ammo.caliber)
	. = ..()

/obj/item/gun/projectile/shotgun/improvised/rifle
	name = "pipe rifle"
	desc = "A long rifled barrel strapped to a reciever and a stock. It even has crude iron sights though how useful they are is debatable."
	icon_state = "irifle"
	fire_sound = 'sound/weapons/gunshot/gunshot_rifle.ogg'
	accuracy = 0 //The Barrel is rifled even if the rest of the gun is imposvised

	var/global/list/ammo_types = list(
		/obj/item/ammo_casing/a762             	= "7.62mm",
		/obj/item/ammo_casing/a762             	= "7.62mm",
		/obj/item/ammo_casing/vintage			= "vintage",
		/obj/item/ammo_casing/vintage			= "vintage",
		/obj/item/ammo_casing/vintage			= "vintage",
		/obj/item/ammo_casing/a556				= "5.56mm",
		/obj/item/ammo_casing/a556				= "5.56mm",
		/obj/item/ammo_casing/a556				= "5.56mm",
		/obj/item/ammo_casing/a556/ap			= "5.56mm"
		)

/obj/item/gun/projectile/shotgun/improvised/rifle/Initialize()
	ammo_type = pick(ammo_types)
	desc += " Uses [ammo_types[ammo_type]] rounds."

	var/obj/item/ammo_casing/ammo = ammo_type
	caliber = initial(ammo.caliber)


/obj/item/gun_parts/barrel/examine(mob/user)
	..(user)
	switch(buildstate)
		if(1) to_chat(user, "It has a rifled barrel installed.")
		if(2) to_chat(user, "It has a stock installed.")
		if(3) to_chat(user, "Its pieces are held together by tape roll.")

/obj/item/gun_parts/barrel/update_icon()
	icon_state = "irifle[buildstate]"

/obj/item/gun_parts/barrel/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/gun_parts/receivergun))
		if(buildstate == 0)
			to_chat(user, "<span class='notice'>You screw the barrel onto the modular reciever.</span>")
			buildstate++
			update_icon()
			return
	else if(istype(W,/obj/item/gun_parts/stock))
		if(buildstate == 1)
			qdel(W)
			to_chat(user, "<span class='notice'>You add the stock to the assmebly.</span>")
			buildstate++
			update_icon()
			return
	else if(istype(W,/obj/item/tape_roll))
		if(buildstate == 2)
			qdel(W)
			to_chat(user, "<span class='notice'>You strap the pieces together with tape.</span>")
			buildstate++
			update_icon()
			return
	else if(W.iscoil())
		var/obj/item/stack/cable_coil/C = W
		if(buildstate == 3)
			if(C.use(10))
				to_chat(user, "<span class='notice'>You tie the lengths of cable to the rifle, making a sling.</span>")
				var/obj/item/gun/projectile/shotgun/improvised/rifle/G = new(get_turf(src))
				G.jam_chance = rand(1,100)		//Commented Out Shotgun self destruction replaced with jamming... It was very half assed anyway...
				qdel(src)
			else
				to_chat(user, "<span class='notice'>You need at least ten lengths of cable if you want to make a sling!.</span>")
				return

/obj/item/gun/projectile/shotgun/improvised/rifle/attackby(var/obj/item/A as obj, mob/user as mob)
	if(istype(A, /obj/item/surgery/circular_saw) || istype(A, /obj/item/melee/energy) || istype(A, /obj/item/gun/energy/plasmacutter) && w_class != 3)
		to_chat(user, "<span class='notice'>You begin to shorten the barrel of \the [src].</span>")
		if(loaded.len)
			for(var/i in 1 to max_shells)
				Fire(user, user)	//will this work? //it will. we call it twice, for twice the FUN
			user.visible_message("<span class='danger'>The rifle goes off!</span>", "<span class='danger'>The rifle goes off in your face!</span>")
			return
		if(do_after(user, 30))
			icon_state = "iobrez"
			item_state = "iobrez"
			w_class = ITEMSIZE_NORMAL
			force = 5
			slot_flags &= ~SLOT_BACK
			slot_flags |= (SLOT_BELT|SLOT_HOLSTER)
			accuracy = -2 //Its a pipe rifle that has been sawn off you ain't hitting shit
			recoil = 2
			name = "homemade obrez"
			can_bayonet = FALSE
			to_chat(user, "<span class='warning'>You shorten the barrel of \the [src]!</span>")
	else
		..()

/obj/item/gun/projectile/shotgun/improvised/rifle/obrez
	name = "pipe obrez"
	desc = "A shortened pipe rifle, probably equally as dangerous to the hands of the firer as the target."
	icon_state = "iobrez"
	item_state = "ipistol"
	w_class = ITEMSIZE_NORMAL
	force = 5
	recoil = 2
	accuracy = -2 //Its a pipe rifle that has been sawn off you ain't hitting shit
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	can_bayonet = FALSE

/obj/item/gun/projectile/musket/blunderbuss/improvised
	name = "improvised blunderbuss"
	desc = "A old fashioned boomstick made from scavenged scrap. Devstating up close but useless at any other distance."
	icon = 'icons/obj/guns/improvised.dmi'
	icon_state = "iblunderbuss"
	item_state = "ishotgun"
	accuracy = -1 //I mean do you expect to hit anything?