//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/*
CONTAINS:
RPD
*/
#define PIPE_BINARY		0
#define PIPE_BENDABLE	1
#define PIPE_TRINARY	2
#define PIPE_TRIN_M		3
#define PIPE_UNARY		4
#define PIPE_QUAD		5

#define PAINT_MODE "paint"
#define EATING_MODE "eating"
#define ATMOS_MODE "atmos"
#define METER_MODE "meter"
#define DISPOSALS_MODE "disposals"

#define CATEGORY_ATMOS 0
#define CATEGORY_DISPOSALS 1

// Disposal pipe types
#define DISP_PIPE_STRAIGHT	0
#define DISP_PIPE_BENT		1
#define DISP_JUNCTION		2
#define DISP_YJUNCTION		3
#define DISP_END_TRUNK		4
#define DISP_END_BIN		5
#define DISP_END_OUTLET		6
#define DISP_END_CHUTE		7

//
// Datum to store meta-data about the types of pipes which exist, so that the RPD knows what it can dispense.
//

var/global/list/RPD_recipes=list(
	"Regular Pipes" = list(
	list("name" = "Pipe", "type" = PIPE_SIMPLE_STRAIGHT, "dir" = 1),
		list("name" = "Bent Pipe", "type" = PIPE_SIMPLE_BENT, "dir" = 5),
		list("name" = "Manifold", "type" = PIPE_MANIFOLD, "dir" = 1),
		list("name" = "Manual Valve", "type" = PIPE_MVALVE, "dir" = 1),
		list("name" = "Pipe Cap", "type" = PIPE_CAP, "dir" = 1),
		list("name" = "4-Way Manifold", "type" = PIPE_MANIFOLD4W, "dir" = 1),
		list("name" = "Manual T-Valve", "type" = PIPE_MTVALVE, "dir" = 1),
		list("name" = "Manual T-Valve - Mirrored", "type" = PIPE_MTVALVEM, "dir" = 1),
//		list("name" = "Upward Pipe", "type" = PIPE_UP, "dir" = 1),
//		list("name" = "Downward Pipe", "type" = PIPE_DOWN, "dir" = 1),
	),
	"Supply Pipes" = list(
		list("name" = "Pipe", "type" = PIPE_SUPPLY_STRAIGHT, "dir" = 1),
		list("name" = "Bent Pipe", "type" = PIPE_SUPPLY_BENT, "dir" = 5),
		list("name" = "Manifold", "type" = PIPE_SUPPLY_MANIFOLD, "dir" = 1),
		list("name" = "Pipe Cap", "type" = PIPE_SUPPLY_CAP, "dir" = 1),
		list("name" = "4-Way Manifold", "type" = PIPE_SUPPLY_MANIFOLD4W, "dir" = 1),
//		list("name" = "Upward Pipe", "type" = PIPE_SUPPLY_UP, "dir" = 1),
//		list("name" = "Downward Pipe", "type" = PIPE_SUPPLY_DOWN, "dir" = 1),
	),
	"Scrubbers Pipes" = list(
		list("name" = "Pipe", "type" = PIPE_SCRUBBERS_STRAIGHT, "dir" = 1),
		list("name" = "Bent Pipe", "type" = PIPE_SCRUBBERS_BENT, "dir" = 5),
		list("name" = "Manifold", "type" = PIPE_SCRUBBERS_MANIFOLD, "dir" = 1),
		list("name" = "Pipe Cap", "type" = PIPE_SCRUBBERS_CAP, "dir" = 1),
		list("name" = "4-Way Manifold", "type" = PIPE_SCRUBBERS_MANIFOLD4W, "dir" = 1),
//		list("name" = "Upward Pipe", "type" = PIPE_SCRUBBERS_UP, "dir" = 1),
//		list("name" = "Downward Pipe", "type" = PIPE_SCRUBBERS_DOWN, "dir" = 1),
	),
	"Devices" = list(
		list("name" = "Universal pipe adapter", "type" = PIPE_UNIVERSAL, "dir" = 1),
		list("name" = "Connector", "type" = PIPE_CONNECTOR, "dir" = 1),
		list("name" = "Unary Vent", "type" = PIPE_UVENT, "dir" = 1),
		list("name" = "Gas Pump", "type" = PIPE_PUMP, "dir" = 1),
		list("name" = "Pressure Regulator", "type" = PIPE_PASSIVE_GATE, "dir" = 1),
		list("name" = "High Power Gas Pump", "type" = PIPE_VOLUME_PUMP, "dir" = 1),
		list("name" = "Scrubber", "type" = PIPE_SCRUBBER, "dir" = 1),
		list("name" = "Gas Filter", "type" = PIPE_GAS_FILTER, "dir" = 1),
		list("name" = "Gas Filter - Mirrored", "type" = PIPE_GAS_FILTER_M, "dir" = 1),
		list("name" = "Gas Mixer", "type" = PIPE_GAS_MIXER, "dir" = 1),
		list("name" = "Gas Mixer - Mirrored", "type" = PIPE_GAS_MIXER_M, "dir" = 1),
		list("name" = "Gas Mixer - T", "type" = PIPE_GAS_MIXER_T, "dir" = 1),
		list("name" = "Omni Gas Mixer", "type" = PIPE_OMNI_MIXER, "dir" = 1),
		list("name" = "Omni Gas Filter", "type" = PIPE_OMNI_FILTER, "dir" = 1),
	)
	"Heat Exchange" = list(
		list("name" = "Pipe", "type" = PIPE_HE_STRAIGHT, "dir" = 1),
		list("name" = "Bent Pipe", "type" = PIPE_HE_BENT, "dir" = 5),
		list("name" = "Junction", "type" = PIPE_JUNCTION, "dir" = 1),
		list("name" = "Heat Exchanger", "type" = PIPE_HEAT_EXCHANGE, "dir" = 1),
	),
	"Insulated Pipes" = list(
		list("name" = "Pipe", "type" = PIPE_INSULATED_STRAIGHT, "dir" = 1),
		list("name" = "Bent Pipe", "type" = PIPE_INSULATED_BENT, "dir" = 5),
	),
	"Disposal Pipes" = list(
		list("name" = "Pipe"      , "type" = DISP_PIPE_STRAIGHT),
		list("name" = "Bent Pipe" , "type" = DISP_PIPE_BENT),
		list("name" = "Junction"  , "type" = DISP_JUNCTION),
		list("name" = "Y-Junction", "type" = DISP_YJUNCTION),
		list("name" = "Trunk"     , "type" = DISP_END_TRUNK),
		list("name" = "Bin"       , "type" = DISP_END_BIN),
		list("name" = "Outlet"    , "type" = DISP_END_OUTLET),
		list("name" = "Chute"     , "type" = DISP_END_CHUTE),
	)
)

/obj/item/weapon/pipe_dispenser
	name = "Rapid Piping Device (RPD)"
	desc = "A device used to rapidly pipe things."
	icon = 'icons/obj/items.dmi'
	icon_state = "rpd"
	opacity = 0
	density = 0
	anchored = 0
	flags = CONDUCT
	force = 10
	throwforce = 10
	throw_speed = 1
	throw_range = 5
	w_class = 3
	materials = list(MAT_METAL=75000, MAT_GLASS=37500)
	origin_tech = "engineering=4;materials=2"


	var/p_mode = ATMOS_MODE
	var/p_selected_category = null

	var/datum/effect/effect/system/spark_spread/spark_system
	var/working = 0
	var/p_type = 0
	var/p_conntype = 0
	var/p_dir = 1
	var/p_flipped = 0
	var/p_mode = ATMOS_MODE
	var/p_disposal = 0
	var/list/paint_colors = list(
		"grey"		= rgb(255,255,255),
		"red"		= rgb(255,0,0),
		"blue"		= rgb(0,0,255),
		"cyan"		= rgb(0,256,249),
		"green"		= rgb(30,255,0),
		"yellow"	= rgb(255,198,0),
		"purple"	= rgb(130,43,255)
	)
	var/paint_color="grey"
	var/screen = CATEGORY_ATMOS //Starts on the atmos tab.

/obj/item/weapon/pipe_dispenser/New()
	. = ..()
	spark_system = new /datum/effect/effect/system/spark_spread
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)

/obj/item/weapon/pipe_dispenser/Destroy()
	del(spark_system)
	spark_system = null
	return ..()

/obj/item/weapon/pipe_dispenser/attack_self(mob/user)
	ui_interact(user)

/obj/item/weapon/pipe_dispenser/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] points the end of the RPD down \his throat and presses a button! It looks like \he's trying to commit suicide...</span>")
	playsound(get_turf(user), 'sound/machines/click.ogg', 50, 1)
	playsound(get_turf(user), 'sound/items/Deconstruct.ogg', 50, 1)
	return(BRUTELOSS)

/obj/item/weapon/pipe_dispenser/proc/activate()
	playsound(get_turf(src), 'sound/items/Deconstruct.ogg', 50, 1)






/obj/item/weapon/pipe_dispenser/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
		var/data[0]

		// we'll add some simple data here as an example
		data["mode"] = p_mode
		var/working = 0
		var/p_type = 0
		var/p_conntype = 0
		var/p_dir = 1
		var/p_flipped = 0
		var/p_mode = ATMOS_MODE
		var/p_disposal = 0

		var/pipe_categories = list()
		for(var/category in RPD_recipes)
			pipe_categories += list("name" => categorycategory

		data["pipe_categories"] = pipe_categories
		for(var/category in RPD_recipes)

		data["recipies"] = list()
		for(var/category in RPD_recipes)
			var/cat_recipies = RPD_recipes[category]




		// Standard NanoUI boilerplate
		// update the ui with data if it exists, returns null if no ui is passed/found or if force_open is 1/true
		ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
		if (!ui)
			// the ui does not exist, so we'll create a new() one
			// for a list of parameters and their descriptions see the code docs in \code\modules\nano\nanoui.dm
			ui = new(user, src, ui_key, "rpd.tmpl", "Rapid Pipe Dispenser UI", 520, 610)
			// when the ui is first opened this is the data it will use
			ui.set_initial_data(data)
			// open the new ui window
			ui.open()











/obj/item/weapon/pipe_dispenser/Topic(href, href_list)
	if(!usr.canUseTopic(src))
		usr << browse(null, "window=pipedispenser")
		return

	usr.set_machine(src)
	src.add_fingerprint(usr)

	if(href_list["screen"])
		screen = text2num(href_list["screen"])
		return 1

	if(href_list["setdir"])
		p_dir = text2num(href_list["setdir"])
		p_flipped = text2num(href_list["flipped"])
		return 1

	if(href_list["eatpipes"])
		p_mode = EATING_MODE
		p_conntype=-1
		p_dir=1
		src.spark_system.start()
		playsound(get_turf(src), 'sound/effects/pop.ogg', 50, 0)
		return 1

	if(href_list["paintpipes"])
		p_mode = PAINT_MODE
		p_conntype = -1
		p_dir = 1
		src.spark_system.start()
		playsound(get_turf(src), 'sound/effects/pop.ogg', 50, 0)
		return 1

	if(href_list["set_color"])
		paint_color = href_list["set_color"]
		src.spark_system.start()
		playsound(get_turf(src), 'sound/effects/pop.ogg', 50, 0)
		return 1

	if(href_list["makepipes"])
		p_type = text2path(href_list["makepipes"])
		p_dir = text2num(href_list["dir"])
		p_conntype = text2num(href_list["type"])
		p_class = ATMOS_MODE
		src.spark_system.start()
		playsound(get_turf(src), 'sound/effects/pop.ogg', 50, 0)
		return 1

	if(href_list["makedisposals"])
		p_type = text2num(href_list["makedisposals"])
		p_conntype = text2num(href_list["type"])
		p_dir = 1
		p_class = DISPOSALS_MODE
		src.spark_system.start()
		playsound(get_turf(src), 'sound/effects/pop.ogg', 50, 0)
		return 1





/obj/item/weapon/pipe_dispenser/afterattack(atom/A, mob/user)
	if(!in_range(A,user) || loc != user)
		return 0

	if(!user.IsAdvancedToolUser())
		user << "<span class='warning'>You don't have the dexterity to do this!</span>"
		return 0

	if(istype(A,/area/shuttle)||istype(A,/turf/space/transit))
		return 0

	//So that changing the menu settings doesn't affect the pipes already being built.
	var/queued_p_type = p_type
	var/queued_p_dir = p_dir
	var/queued_p_flipped = p_flipped

	switch(p_class)
		if(PAINT_MODE) // Paint pipes
			if(!istype(A,/obj/machinery/atmospherics/pipe))
				// Avoid spewing errors about invalid mode -2 when clicking on stuff that aren't pipes.
				user << "<span class='warning'>\The [src]'s error light flickers!  Perhaps you need to only use it on pipes and pipe meters?</span>"
				return 0
			var/obj/machinery/atmospherics/pipe/P = A
			playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)
			P.color = paint_colors[paint_color]
			P.pipe_color = paint_colors[paint_color]
			P.stored.color = paint_colors[paint_color]
			user.visible_message("<span class='notice'>[user] paints \the [P] [paint_color].</span>","<span class='notice'>You paint \the [P] [paint_color].</span>")
			//P.update_icon()
			P.update_node_icon()
			return 1
		if(EATING_MODE) // Eating pipes
			// Must click on an actual pipe or meter.
			if(istype(A,/obj/item/pipe) || istype(A,/obj/item/pipe_meter) || istype(A,/obj/structure/disposalconstruct))
				user << "<span class='notice'>You start destroying pipe...</span>"
				playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)
				if(do_after(user, 2, target = A))
					activate()
					qdel(A)
					return 1
				return 0

			// Avoid spewing errors about invalid mode -1 when clicking on stuff that aren't pipes.
			user << "<span class='warning'>The [src]'s error light flickers!  Perhaps you need to only use it on pipes and pipe meters?</span>"
			return 0
		if(ATMOS_MODE)
			if(!(istype(A, /turf)))
				user << "<span class='warning'>The [src]'s error light flickers!</span>"
				return 0
			user << "<span class='notice'>You start building pipes...</span>"
			playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)
			if(do_after(user, 2, target = A))
				activate()
				var/obj/item/pipe/P = new (A, pipe_type=queued_p_type, dir=queued_p_dir)
				P.flipped = queued_p_flipped
				P.update()
				P.add_fingerprint(usr)
				return 1
			return 0

		if(METER_MODE)
			if(!(istype(A, /turf)))
				user << "<span class='warning'>The [src]'s error light flickers!</span>"
				return 0
			user << "<span class='notice'>You start building meter...</span>"
			playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)
			if(do_after(user, 2, target = A))
				activate()
				new /obj/item/pipe_meter(A)
				return 1
			return 0

		if(DISPOSALS_MODE)
			if(!(istype(A, /turf)))
				user << "<span class='warning'>The [src]'s error light flickers!</span>"
				return 0
			user << "<span class='notice'>You start building pipes...</span>"
			playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)
			if(do_after(user, 20, target = A))
				var/obj/structure/disposalconstruct/C = new (A, queued_p_type ,queued_p_dir)

				if(!C.can_place())
					user << "<span class='warning'>There's not enough room to build that here!</span>"
					qdel(C)
					return 0

				activate()

				C.add_fingerprint(usr)
				C.update()
				return 1
			return 0
		else
			..()
			return 0



#undef PIPE_BINARY
#undef PIPE_BENT
#undef PIPE_TRINARY
#undef PIPE_TRIN_M
#undef PIPE_UNARY
#undef PIPE_QUAD
#undef PAINT_MODE
#undef EATING_MODE
#undef ATMOS_MODE
#undef METER_MODE
#undef DISPOSALS_MODE
#undef CATEGORY_ATMOS
#undef CATEGORY_DISPOSALS
