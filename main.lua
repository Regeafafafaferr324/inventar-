local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPin = {}
Tunnel.bindInterface("vrp_inventoryhud",vRPin)
Proxy.addInterface("vrp_inventoryhud",vRPin)
INclient = Tunnel.getInterface("vrp_inventoryhud","vrp_inventoryhud")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_inventoryhud")

GlobalState['disabledInventory'] = false;

openInventories = {}
Hotbars = {}
vTypes = {}
local buzunare = {
	['id_doc'] = true,
	['permis_masina'] = true,
}

function vRPin.requestItemGive(idname, amount)
	local _source = source
	local user_id = vRP.getUserId({_source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
		if isItemInHotbar(user_id, idname) then return vRPclient.notify(player, {"Nu poti face acest lucru cu un item din hotbar!"}) end;
	  	-- get nearest player
	  	vRPclient.getNearestPlayer(player,{10},function(nplayer)
			local nuser_id = vRP.getUserId({nplayer})
			if nuser_id ~= nil then
				local new_weight = vRP.getInventoryWeight({nuser_id})+vRP.getItemWeight({idname})*amount
				if new_weight <= vRP.getInventoryMaxWeight({nuser_id}) then
					if vRP.tryGetInventoryItem({user_id,idname,amount,true}) then
						vRP.giveInventoryItem({nuser_id,idname,amount,true})
		
						local embed = {
                            {
                                  ["color"] = 0xcf0000,
                                  ["title"] = "".."OFERA-ITEM".."",
                                  ["description"] = "Jucatorul cu **ID: "..user_id.."** i-a oferit jucatorului cu **ID: "..nuser_id.."** item-ul `"..idname.." (x"..amount..")`",
                                  ["thumbnail"] = {
                                  },
                                  ["footer"] = {
                                  ["text"] = "SERVER",
                                  },
                            }
                        }
                        PerformHttpRequest('https://discord.com/api/webhooks/1225204843354787930/nhEOufvkelCRSeHUx3TvTC5N0aLeAIOUQ11QF9xkIysqMS8WQabmTVSgzM3CP8h_pdFM', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })

						vRPclient.playAnim(player,{true,{{"mp_common","givetake2_a",1}},false})
						vRPclient.playAnim(nplayer,{true,{{"mp_common","givetake2_a",1}},false})
					end
				else
					vRPclient.notify(player,{"Inventory is full."})
				end
			else
				vRPclient.notify(player,{"No players near you."})
			end
	  	end)
	end
  
	INclient.loadPlayerInventory(player)
end

function vRPin.requestItemUse(idname)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local choice = vRP.getItemChoices({idname})

	if string.find(idname, "WEAPON_") then
		INclient.equipWeapon(player, {idname})
	else
		if not type(choice) == 'table' then return end;
		
		for key, value in pairs(choice) do 
			if key ~= "Give" and key ~= "Trash" then
				local cb = value[1]
				cb(player,key)
				INclient.loadPlayerInventory(player)
				INclient.notify(player, {{name = idname, label = vRP.getItemName({idname}), count = 1}, "Used"})
			end
		end

		local embed = {
			{
				  ["color"] = 0xcf0000,
				  ["title"] = "".."FOLOSESTE-ITEM".."",
				  ["description"] = "Jucatorul cu **ID: "..user_id.."** a folosit item-ul `"..idname.."`",
				  ["thumbnail"] = {
				  },
				  ["footer"] = {
				  ["text"] = "SERVER",
				  },
			}
		}
		PerformHttpRequest('https://discord.com/api/webhooks/1225204782122139718/T8cbg67w9ZbZ2NZn9p5dKqbA3Y-m8EjqLtwBfB2co_15rLfmB_s92NPF1JHoXrnS00E4', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
	end
end


function vRPin.requestAmmoForItem(weapon)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
		local ammoItem = Config.Items[weapon][5]
		local maxAmmo = vRP.getInventoryItemAmount({user_id, ammoItem})
		return maxAmmo or 0
	end
end

function vRPin.requestReload(weapon, ammo)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		local ammoItem = Config.Items[weapon][5]

		if ammoItem ~= nil then
			local maxAmmo = vRP.getInventoryItemAmount({user_id, ammoItem})
			if ammo > maxAmmo then 
				ammo = maxAmmo
			end

			if vRP.tryGetInventoryItem({user_id, ammoItem, ammo, true}) then
				return true,maxAmmo
			else
				INclient.notify(source, {{name = ammoItem, label = vRP.getItemName({ammoItem}), count = ammo}, "Missing"})
			end
		end
	end
end

function vRPin.holstered(weapon, ammo, source)
    local user_id = vRP.getUserId({source})
    if user_id then
        local ammoItem = Config.Items[weapon][5]
        vRP.giveInventoryItem({user_id, ammoItem, ammo, true})
    end
end


function vRPin.requestPutHotbar(idname, amount, slot, from)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
		if from ~= nil then
			Hotbars[user_id][from] = nil
		end

		Hotbars[user_id][slot] = idname

		INclient.loadPlayerInventory(player)
	end
end

function isItemInHotbar(user_id, idname)
	if not (user_id and idname) then return end;
	if Hotbars[user_id] then
		local found = false;
		for i=1,5 do
			if Hotbars[user_id][i] == idname then
				found = true;
				break;
			end
		end
		return found;
	end
end


function vRPin.requestRemoveHotbar(slot)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
		Hotbars[user_id][slot] = nil
		INclient.loadPlayerInventory(player)

	end
end

function vRPin.useHotbarItem(slot)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil and Hotbars[user_id] ~= nil then
		local idname = Hotbars[user_id][slot]
		if idname ~= nil then
			vRPin.requestItemUse(idname)
			local amount = vRP.getInventoryItemAmount({user_id,idname})
			if amount < 1 then
				Hotbars[user_id][slot] = nil
			end
		end
	end
end

function vRPin.getHotbarItems(player)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		local hotbarItems = {}
		if Hotbars[user_id] ~= nil then
			for slot, idname in pairs(Hotbars[user_id]) do
				local item_name, description = vRP.getItemDefinition({idname})
				local amount = vRP.getInventoryItemAmount({user_id,idname})
				if amount > 0 then
					hotbarItems[#hotbarItems+1] = {
						label = item_name,
						count = amount,
						description = description,
						name = idname,
						slot = slot
					}
				end
			end
		end

		return hotbarItems
	end
end

function vRPin.getBuzunarData()
	local player = source
	local user_id = vRP.getUserId({player})
	if user_id then
		local data = vRP.getUserDataTable({user_id})
		local dataTable = {}
		if data and data.inventory then
			for k,v in pairs(data.inventory) do
				if buzunare[k] then
					local item_name, description, weight = vRP.getItemDefinition({k})
					dataTable[#dataTable+1] = {
						label = item_name,
						count = v.amount,
						description = description,
						name = k,
					}
				end
			end

			return dataTable
		end
	end
end

function vRPin.closeInventory(type)
	local user_id = vRP.getUserId({source})

	if type == "trunk" or type == "glovebox" then
		vRPclient.stopAnim(source, {false})
		if vTypes[user_id] ~= nil then
			vRPclient.vc_closeDoor(vTypes[user_id][1], {vTypes[user_id][2],5})
			vTypes[user_id] = nil
		end
	end
	
	openInventories[user_id] = nil
end

function vRPin.inventoryOpened(player)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		vRPclient.getNearestOwnedVehicle(player,{3.5},function(ok,vtype,name)
			if ok then
				INclient.isIsideACar(player, {}, function(inside)
					if inside then
						openGlovebox(player, user_id, user_id, name)
						return
					else
						openTrunk(player, user_id, user_id, name, vtype)
						return
					end
				end)
			else
				vRPin.openDrop(player, user_id)
			end
		end)
		--vRPin.openDrop(player, user_id)
		-- INclient.openInventory(player, {'normal'})
	end
end

--[[
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
	  vRPclient.getNearestPlayer(player,{10},function(nplayer)
		if nplayer ~= nil then
		  local nuser_id = vRP.getUserId(nplayer)
		  if nuser_id ~= nil then
			vRP.prompt(player,lang.money.give.prompt(),"",function(player,amount)
			  local amount = parseInt(amount)
			  if amount > 0 and vRP.tryPayment(user_id,amount) then
				vRP.giveMoney(nuser_id,amount)
				vRPclient.notify(player,{lang.money.given({amount})})
				vRPclient.notify(nplayer,{lang.money.received({amount})})
				local embed = {
					{
						  ["color"] = 0xcf0000,
						  ["title"] = "".."Ofera-Bani".."",
						  ["description"] = "Jucatorul cu **ID: "..user_id.."** i-a oferit jucatorului cu **ID: "..nuser_id.."** suma de `$"..amount.."`" ,
						  ["thumbnail"] = {
						  },
						  ["footer"] = {
						  ["text"] = "SERVER",
						  },
					}
				}
				PerformHttpRequest('https://discord.com/api/webhooks/1097979280903909406/jI61G0dW-Fs6y0YVIx72UrhGDo4DT3tUI2ZzDyDrHvwUbPDTYq-62eAAWypikPax0e_d', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })	
			  else
				vRPclient.notify(player,{lang.money.not_enough()})
			  end
			end)
		  else
			vRPclient.notify(player,{lang.common.no_player_near()})
		  end
		else
		  vRPclient.notify(player,{lang.common.no_player_near()})
		end
	  end)
	end
]]

RegisterServerEvent('sxint$oferaBani',function()
	local player = source
	local user_id = vRP.getUserId({player})
	if user_id then
	  vRPclient.getNearestPlayer(player,{10},function(nplayer)
		if nplayer ~= nil then
		  local nuser_id = vRP.getUserId({nplayer})
		  if nuser_id ~= nil then
			vRP.prompt({player,"Ofera bani","",function(player,amount)
			  local amount = parseInt(amount)
			  if amount > 50000 then return vRPclient.notify(player, {"Nu poti oferi mai mult de $50000 cash!"}) end;
			  if amount > 0 and vRP.tryPayment({user_id,amount}) then
				vRP.giveMoney({nuser_id,amount})
				vRPclient.notify(player,{"Ai oferit $"..vRP.formatMoney{amount}})
				vRPclient.notify(nplayer,{"Ai primit: $"..vRP.formatMoney{amount}});
				local embed = {
					{
						  ["color"] = 0xcf0000,
						  ["title"] = "".."Ofera-Bani".."",
						  ["description"] = "Jucatorul cu **ID: "..user_id.."** i-a oferit jucatorului cu **ID: "..nuser_id.."** suma de `$"..amount.."`" ,
						  ["thumbnail"] = {
						  },
						  ["footer"] = {
						  ["text"] = "SERVER",
						  },
					}
				}
				PerformHttpRequest('https://discord.com/api/webhooks/1225204675150872577/tyj9BLZGpkWDeF8xnmsjisr5n5od24wW0ngaZcQ13sQGy8bo0atxL0riVuaHqiwj-Frg', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })	
			  else
				vRPclient.notify(player,{"Nu ai bani suficienti!"})
			  end
			end})
		  else
			vRPclient.notify(player,{"Nici un jucator prin jurul tau!"})
		  end
		else
		  vRPclient.notify(player,{"Nici un jucator prin jurul tau!"})
		end
	  end)
	end
end)

function vRPin.getInventoryItems(player)
	local user_id = vRP.getUserId({player})
	local data = vRP.getUserDataTable({user_id})
	local weight = vRP.getInventoryWeight({user_id})
	local max_weight = vRP.getInventoryMaxWeight({user_id})
	local items = {}
	local hotbarItems = {}

	if Hotbars[user_id] == nil then
		Hotbars[user_id] = {}
	end

	for k,v in pairs(data.inventory) do 
		if buzunare[k] then goto skip end;
		local item_name, description, weight = vRP.getItemDefinition({k})
		local found = false

		if item_name ~= nil then
			for slot, idname in pairs(Hotbars[user_id]) do
				if idname == k then
					found = true
					hotbarItems[#hotbarItems+1] = {
						label = item_name,
						count = v.amount,
						description = description,
						name = idname,
						weight = weight,
						slot = slot
					}
				end
			end

			if not found then
				items[#items+1] = {
					label = item_name,
					count = v.amount,
					description = description,
					weight = weight,
					name = k
				}
			end
        end

		::skip::
    end

	return items, hotbarItems, weight, max_weight
end

function vRPin.getAllInventoryItems(player)
	local player = player
	local user_id = vRP.getUserId{player}
	if not user_id then return end
	
	local data = vRP.getUserDataTable({user_id})
	local weight = vRP.getInventoryWeight({user_id})
	local max_weight = vRP.getInventoryMaxWeight({user_id})
	local items = {}

	for k,v in pairs(data.inventory) do 
		local item_name, description, weight = vRP.getItemDefinition({k})
		if item_name then
			items[#items+1] = {
				label = item_name,
				count = v.amount,
				description = description,
				weight = weight,
				name = k
			}
		end
    end

	return items, weight, max_weight
end

-- Define items
CreateThread(function()
	for k,v in pairs(Config.Items) do
		vRP.defInventoryItem({k,v[1],v[2],v[3],v[4]})
	end
end)






function vRPin.daiatasamentepearma(tabel, arma)
    local user_id = vRP.getUserId({ source })
    if not tabel then 
        return
    end
    for k,v in pairs(tabel) do 
        if v == "supressor" then
            TriggerClientEvent('trf:supp:doarechipeaza', source)
        elseif v == "grip" then
            TriggerClientEvent('trf:grip:doarechipeaza', source)
        elseif v == "flash" then
            TriggerClientEvent('trf:flashlight:doarechipeaza', source)
        elseif v == "scope" then
            TriggerClientEvent('trf:scope:doarechipeaza', source)
		elseif v == "magazine1" then
            TriggerClientEvent('trf:magazine1:doarechipeaza', source)
		elseif v == "yusuf" then 
			TriggerClientEvent('trf:yusuf:doarechipeaza', source)
        end
    end
end


function vRPin.dajosatas(tabel, arma)
    local user_id = vRP.getUserId({ source })
    if not tabel then 
      return
    end
    
    for k,v in pairs(tabel) do 
        vRP.giveInventoryItem({ user_id, v, 1, false })
        vRPclient.notify(user_id, {"Ai primit " .. v})
    end
end


-- function removeSubstring(str, substr)
--     return string.gsub(str, substr, "")
-- end

-- function vRPin.armaplm(player,slot)
--     local user_id = vRP.getUserId({player})
--     if user_id ~= nil then
--         return removeSubstring(Hotbars[user_id][slot],"WEAPON_")
--     end
-- end