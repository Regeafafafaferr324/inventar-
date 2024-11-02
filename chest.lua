local Chests = {}

local function getChestMaxWeight(id)
    local s = splitString(id, ":")
    local type = s[1]

    local maxWeight = Config.DefaultChestMaxWeight

    if type == "trunk" then
        local vehicle = s[3]
        local thisWeight = Config.Trunks[vehicle]

        maxWeight = Config.DefaultTrunkWeight

        if thisWeight ~= nil then
            maxWeight = thisWeight
        end
    elseif type == "glovebox" then
        local vehicle = s[3]
        local thisWeight = Config.Gloveboxes[vehicle]
        
        maxWeight = Config.DefaultGloveboxWeight

        if thisWeight ~= nil then
            maxWeight = thisWeight
        end
    elseif type == "chest" then
        local chestId = s[2]
        if Config.Chests[chestId] ~= nil then
		    local thisWeight = Config.Chests[chestId].maxWeight
        
            if thisWeight ~= nil then
                maxWeight = thisWeight
            end
	    end
    elseif type == 'deposit' then
        maxWeight = 5000
    end

    return maxWeight
end

function vRPin.putIntoChest(idname, amount)
    local user_id = vRP.getUserId({source})
    local chestname = openInventories[user_id]
    local player = vRP.getUserSource({user_id})
    if chestname ~= nil then
        local items = Chests[chestname] or {}
        local new_weight = vRP.computeItemsWeight({items})+vRP.getItemWeight({idname})*amount
        if new_weight <= getChestMaxWeight(chestname) then
            if amount >= 0 and vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                local citem = items[idname]

                if citem ~= nil then
                    citem.amount = citem.amount+amount
                else
                    items[idname] = {amount=amount}
                end

                Chests[chestname] = items
            end
        else
            vRPclient.notify(player,{"Chest is full"})
        end

        Wait(20)
        vRPin.getChestItems(chestname, player)
        INclient.loadPlayerInventory(player)
    end
end

function vRPin.takeFromChest(idname, amount)
    local user_id = vRP.getUserId({source})
    local chestname = openInventories[user_id]
    local player = vRP.getUserSource({user_id})
    if chestname ~= nil then
        local items = Chests[chestname] or {}
        local citem = items[idname]
        if amount >= 0 and amount <= citem.amount then
            local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({idname})*amount
            if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
                vRP.giveInventoryItem({user_id, idname, amount, true})
                citem.amount = citem.amount-amount

                if citem.amount <= 0 then
                    items[idname] = nil -- remove item entry
                end

                Chests[chestname] = items
            else
                vRPclient.notify(player,{"Inventory is full"})
            end
        end

        Wait(20)
        vRPin.getChestItems(chestname, player)
        INclient.loadPlayerInventory(player)
    end
end

function vRPin.getChestItems(chestname, player, label)
    if Chests[chestname] then
        local weight = vRP.computeItemsWeight({Chests[chestname]})
        local max_weight = getChestMaxWeight(chestname)
        local items = {}
        for k,v in pairs(Chests[chestname]) do
            local item_name,description,weight = vRP.getItemDefinition({k})
            items[#items+1] = {
                label = item_name,
				count = v.amount,
				description = description,
				name = k,
                weight = weight
            }
        end
        INclient.setSecondInventoryItems(player, {items, weight, max_weight, label})
    else
        vRP.getSData({chestname, function(cdata)
            local rawItems = json.decode(cdata) or {}
            local items = {}
            local weight = vRP.computeItemsWeight({rawItems})
            local max_weight = getChestMaxWeight(chestname)
            for k,v in pairs(rawItems) do
                local item_name,description,weight = vRP.getItemDefinition({k})
                items[#items+1] = {
                    label = item_name,
                    count = v.amount,
                    description = description,
                    name = k,
                    weight = weight
                }
            end

            INclient.setSecondInventoryItems(player, {items, weight, max_weight, label})
            Chests[chestname] = rawItems
        end})
    end
end

function openTrunk(player, user_id, owner_id, vname, vtype)    
    local id = "trunk:user-" .. owner_id .. ":" .. string.lower(vname)
    if isChestFree(id) then
        openInventories[user_id] = id
        INclient.openInventory(player, {"trunk"})
        vRPin.getChestItems(id, player)

        local ownerSource = vRP.getUserSource({owner_id})
        vRPclient.vc_openDoor(ownerSource, {vtype,5})
        vTypes[user_id] = {ownerSource,vtype}
        vRPclient.playAnim(player,{true,{{"mini@repair","fixing_a_player",1}},true})
    else
        vRPclient.notify(player,{"Trunk is busy."})
    end
end

function openGlovebox(player, user_id, owner_id, vname)    
    local id = "glovebox:user-" .. owner_id .. ":" .. string.lower(vname)
    if isChestFree(id) then
        openInventories[user_id] = id
        INclient.openInventory(player, {"glovebox"})
        vRPin.getChestItems(id, player)
        vRPclient.playAnim(player,{true,{{"mini@repair","fixing_a_player",1}},true})
    else
        vRPclient.notify(player,{"Glovebox is busy."})
    end
end

function isChestFree(id)
    for user_id, chestId in pairs(openInventories) do
        if chestId == id then
            return false
        end
    end

    return true
end

function openChest(user_id, player, id, label)
    if isChestFree(id) then
        openInventories[user_id] = id
        INclient.openInventory(player, {"chest"})
        vRPin.getChestItems(id, player, label)
    else
        vRPclient.notify(player,{"Chest is busy."})
    end
end
exports("openChest", openChest)

function vRPin.openDeposit(name, pos)
    if not (name and pos) then return end
    local player = source
    local user_id = vRP.getUserId{player}
    if not user_id then return end;
    if vRP.tryPayment({user_id,Config.Depozite[name].accesPrice}) then
        local label = 'deposit:'..name..':user-'..user_id;
        openChest(user_id, player, label, name)
    else
        vRPclient.notify(player, {"Nu ai suficienti bani pentru a face acest lucru!"})
    end
end

function vRPin.openChest(name, pos)
    local user_id = vRP.getUserId({source})
    if user_id then
        if Config.Chests[name] then
            local id = "chest:".. name
            if vRP.hasPermission({user_id, Config.Chests[name].permission}) then
                openChest(user_id, source, id, name)
            else
                TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "You don't have permission to open this chest.")
            end
        else
            TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "The specified chest doesn't exist.")
        end
    else
        TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "You are not authenticated to perform this action.")
    end
end


RegisterServerEvent('server$saveChests',function()
    for k,v in pairs(Chests) do
        vRP.setSData({k,json.encode(v)});
    end
end)

exports("getChests",function()
    return Chests;
end)

function task_save_chests()
    for k,v in pairs(Chests) do
        vRP.setSData({k,json.encode(v)})
    end
    
    print("~g~[BHZ-Sync]^0 Toate chest-urile au fost salvate!");
    
    CreateThread(function()
        Wait(5*60*1000)
        task_save_chests();
    end)
end

CreateThread(function()
    Wait(5*60*1000)
    task_save_chests();
end)