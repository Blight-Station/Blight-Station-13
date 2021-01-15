//Alien pinning weapon.
/obj/item/gun/launcher/spikethrower
	name = "spike thrower"
	desc = "A vicious alien projectile weapon. Parts of it quiver gelatinously, as though the thing is insectile and alive."
	var/last_regen = 0
	var/spike_gen_time = 100
	var/max_spikes = 3
	var/spikes = 3
	release_force = 30
	slot_flags = SLOT_BELT|SLOT_BACK
	icon_state = "spikethrower3"
	item_state = "spikethrower"
	fire_sound_text = "a strange noise"
	fire_sound = 'sound/weapons/bladeslice.ogg'
	needspin = FALSE

/obj/item/gun/launcher/spikethrower/Initialize()
	. = ..()
	last_regen = world.time

/obj/item/gun/launcher/spikethrower/Destroy()
	return ..()

/obj/item/gun/launcher/spikethrower/process()
	if(spikes < max_spikes && world.time > last_regen + spike_gen_time)
		spikes++
		last_regen = world.time
		update_icon()

/obj/item/gun/launcher/spikethrower/proc/regen_spike()
	spikes++
	update_icon()
	if (spikes < max_spikes)
		addtimer(CALLBACK(src, .proc/regen_spike), spike_gen_time, TIMER_UNIQUE)

/obj/item/gun/launcher/spikethrower/examine(mob/user)
	..(user)
	if(get_dist(src, user) > 1)
		return
	to_chat(user, "It has [spikes] spike\s remaining.")

/obj/item/gun/launcher/spikethrower/update_icon()
	icon_state = "spikethrower[spikes]"

/obj/item/gun/launcher/spikethrower/special_check(user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.species && H.species.name != SPECIES_VAURCA_WARRIOR)
			to_chat(user, "<span class='warning'>\The [src] does not respond to you!</span>")
			return FALSE
	return ..()

/obj/item/gun/launcher/spikethrower/update_release_force()
	return

/obj/item/gun/launcher/spikethrower/consume_next_projectile()
	if(spikes < 1) return null
	spikes--
	addtimer(CALLBACK(src, .proc/regen_spike), spike_gen_time, TIMER_UNIQUE)
	return new /obj/item/spike(src)