/var/global/running_demand_events = list()

/hook/sell_crate/proc/demand_supply_sell_crate(var/obj/structure/closet/crate/sold_crate, var/area/shuttle)
	for(var/datum/event/demand_supply/evt)
		evt.handle_sold_crate(sold_crate, shuttle)
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
	message += "Deliver these items to CentCom via the supply shuttle.  Make sure to package them into crates!"

	var/pass = 0
	for(var/obj/machinery/message_server/MS in world)
		if(!MS.active) continue
		MS.send_rc_message("All Departments", my_department, message, "", "", 2)
		pass = 1
	if(pass)
		for (var/obj/machinery/requests_console/Console in allConsoles)
			Console.deliver_message(2, my_department, message)

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
		/obj/item/weapon/reagent_containers/food/snacks/muffin)
	meta.qty = rand(2,10)

	var/atom/temp = new meta.type_path()
	meta.name = temp.name
	del(temp)

	return meta

/datum/event/demand_supply/proc/handle_sold_crate(var/obj/structure/closet/crate/sold_crate, var/area/shuttle)
	for(var/datum/demand_supply_meta/meta in required_items)
		for(var/atom/I in sold_crate)
			if(istype(I, meta.type_path))
				// Hey we found it!
				meta.qty -= 1
				if(meta.qty <= 0)
					required_items -= meta
					break
