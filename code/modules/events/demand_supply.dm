/var/global/running_demand_events = list()

/hook/sell_shuttle/proc/demand_supply_sell_shuttle(var/area/area_shuttle)
	for(var/datum/event/demand_supply/evt)
		evt.handle_sold_shuttle(area_shuttle)
	return 1 // All hooks must return one to show success.

/datum/demand_supply_meta
	var/type_path	// Type path of the item required
	var/qty			// How many we need right now
	var/name		// Name of the item

/datum/event/demand_supply
	var/my_department = "CentCom Supply Division"
	var/list/required_items = list()
	var/end_time
	announceWhen = 1
	startWhen = 2
	endWhen = 1800 // Aproximately 1 hour in master controller ticks, refined by end_time


/datum/event/demand_supply/setup()
	end_time = world.time + 36000 // Exactly 1 hour in deciseconds.
	running_demand_events += src
	// TODO - Decide what items are requried!
	for(var/i = rand(1,3), i > 0, i--)
		required_items += choose_required_item()

/datum/event/demand_supply/announce()
	var/message = "Blah blah, accounting wants stuff.  You'd better have this here stuff by [worldtime2text(end_time)]<br>"
	message += "The requested items are as follows<hr>"

	for (var/datum/demand_supply_meta/req in required_items)
		message += "[req.name] - (Qty: [req.qty])<br>"
	message += "<hr>"
	message += "Deliver these items to CentCom via the supply shuttle.  Make sure to package them into crates!<br>"

	send_console_message(message);

	// Also announce over main comms so people know to look
	command_announcement.Announce("An order for the station to deliver supplies to CentCom has been delivered to all Request Consoles", my_department)

/datum/event/demand_supply/tick()
	if(required_items.len == 0)
		endWhen = activeFor  // End early becuase we're done already!

/datum/event/demand_supply/end()
	running_demand_events -= src

	// Check if the crew succeeded or failed!
	if(required_items.len == 0)
		// Success!
		supply_controller.points += 200
		command_announcement.Announce("Congrats! You delivered everything!", my_department)
	else
		// Fail!
		supply_controller.points = supply_controller.points / 2
		command_announcement.Announce("Booo! You failed to deliver some stuff!", my_department)

/datum/event/demand_supply/proc/choose_required_item()
	var/datum/demand_supply_meta/meta = new()
	meta.type_path = pick(
		/obj/item/weapon/reagent_containers/food/snacks/cookie,
		/obj/item/weapon/reagent_containers/food/snacks/candy_corn,
		/obj/item/weapon/reagent_containers/food/snacks/muffin,
		/obj/item/weapon/reagent_containers/food/snacks/cheeseburger,
		/mob/living/simple_animal/corgi/puppy,
		/obj/item/weapon/gun/energy/sizegun,
		/obj/item/mecha_parts/mecha_equipment/tool/syringe_gun,
		/obj/machinery/singularity,
		/obj/mecha/working/ripley)
	meta.qty = rand(1,3)

	var/atom/temp = new meta.type_path()
	meta.name = temp.name
	del(temp)

	return meta

/**
 * Event Handler for responding to the supply shuttle arriving at centcom.
 */
/datum/event/demand_supply/proc/handle_sold_shuttle(var/area/area_shuttle)
	var/match_found = 0;

	for(var/atom/movable/MA in area_shuttle)
		if(MA.anchored)	continue // Ignore anchored stuff

		// If its a crate, search inside of it for matching items.
		if(istype(MA, /obj/structure/closet/crate))
			for(var/atom/item_in_crate in MA)
				match_found |= match_item(item_in_crate)
		else
			// Otherwise check it against our list
			match_found |= match_item(MA)

	if(match_found && required_items.len > 1)
		// Okay we delivered SOME.  Lets give an update, but only if not finished.
		var/message = "Shipment Received.  As a reminder, the following items are still requried:<br>"
		for (var/datum/demand_supply_meta/req in required_items)
			message += "[req.name] - (Qty: [req.qty])<br>"
		message += "<hr>"
		message += "Deliver these items to CentCom via the supply shuttle.  Make sure to package them into crates!<br>"
		send_console_message(message, "Cargo Bay")

/**
 * Helper method to check an item against the list of required_items.
 */
/datum/event/demand_supply/proc/match_item(var/atom/I)
	for(var/datum/demand_supply_meta/meta in required_items)
		if(istype(I, meta.type_path))
			// Hey, we found it!  How we handle it depends on some details tho.
			if(istype(I, /obj/item/stack))
				var/obj/item/stack/S = I
				var amount_to_take = min(S.get_amount(), meta.qty)
				S.use(amount_to_take)
				meta.qty -= amount_to_take
				// TODO - Do I need to delete the stack if empty?
			else
				meta.qty -= 1
				del(I)
			if(meta.qty <= 0)
				required_items -= meta
			return 1
	return 0 // Nothing found if we get here

/**
 * Utility method to send message to request consoles.
 * @param message - Message to send
 * @param to_department - Name of department to deliver to, or null to send to all departments.
 * @return 1 if successful, 0 if couldn't send.
 */
/datum/event/demand_supply/proc/send_console_message(var/message, var/to_department)
	var/pass = 0
	for(var/obj/machinery/message_server/MS in world)
		if(!MS.active) continue
		MS.send_rc_message(to_department ? to_department : "All Departments", my_department, message, "", "", 2)
		pass = 1
	if(pass)
		for (var/obj/machinery/requests_console/Console in allConsoles)
			if (to_department && ckey(Console.department) != ckey(to_department)) continue;
			Console.deliver_message(2, my_department, message)
	return pass;
