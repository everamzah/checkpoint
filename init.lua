local players = {}

minetest.register_node("checkpoint:checkpoint", {
	description = "Checkpoint",
	--[[
	tiles =	{"default_dirt.png^checkpoint_teleporter.png",
		"default_wood.png^checkpoint_teleporter.png",
		"default_steel_block.png^checkpoint_teleporter.png",
		"default_gold_block.png^checkpoint_teleporter.png",
		"default_mese_block.png^checkpoint_teleporter.png",
		"default_diamond_block.png^checkpoint_teleporter.png"},
	--]]
	tiles = {"checkpoint_teleporter.png"},
	drawtype = "plantlike",
	sunlight_propagates = true,
	light_source = 8,
	paramtype = "light",
	--paramtype2 = "facedir",
	groups = {cracky=1, choppy=1, crumbly=1, snappy=1},
	on_rightclick = function(pos, node, clicker)
		local name = clicker:get_player_name()
		players[name] = clicker:getpos()

		minetest.chat_send_player(name, "Checkpoint saved")
	end
})

minetest.register_craftitem("checkpoint:teleporter", {
	description = "Checkpoint Teleporter",
	inventory_image = "checkpoint_teleporter.png",
	on_use = function(itemstack, user, pointed_thing)
		local name = user:get_player_name()
		local pos = players[name]
		if pos then
			user:setpos(pos)
		else
			minetest.chat_send_player(name, "No checkpoint saved")
		end
	end
})

minetest.register_chatcommand("checkpoint", {
	func = function(name, param)
		local pos = players[name]
		if pos then
			local player = minetest.get_player_by_name(name)
			player:setpos(pos)
		else
			minetest.chat_send_player(name, "No checkpoint saved")
			--return "No checkpoint saved"
		end

		--print(dump(players))
	end
})
