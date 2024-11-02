currentWeapon = nil
atasamente = {}


RegisterNetEvent("adaugam_atasament")
AddEventHandler("adaugam_atasament", function(arma, atasament)
    if atasamente[arma] == nil then
        atasamente[arma] = {atasament}
    else 
        local temp = atasamente[arma]
        temp[#temp + 1] = atasament
        atasamente[arma] = temp
        
    end
end)


bigweaponslist = {	
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_SMG",
	"WEAPON_SMG_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"weapon_tacticalrifle",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_COMBATPDW",
	"WEAPON_GUSENBERG",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"weapon_militaryrifle",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SWEEPERSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_MUSKET",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DBSHOTGUN",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_RPG",
	"WEAPON_MINIGUN",
	"WEAPON_FIREWORK",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_RAYPISTOL",
	"WEAPON_RAYCARBINE",
	"WEAPON_RAYMINIGUN",
	"WEAPON_DIGISCANNER"
}


function isWeaponBig(model)
	for _, bigWeapon in pairs(bigweaponslist) do
		if model == GetHashKey(bigWeapon) then
			return true
		end
	end

	return false
end

function vRPin.equipWeapon(weapon)
    local ped = PlayerPedId()
    local playerPed = PlayerPedId()
    local selectedWeapon = GetSelectedPedWeapon(ped)
    if currentWeapon == weapon and not (selectedWeapon == GetHashKey('WEAPON_UNARMED')) then
        vRP.playAnim({true,{{"reaction@intimidation@1h","outro",1}},false})
        Citizen.Wait(1600)
        ClearPedTasks(ped)
        local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon))
        RemoveWeaponFromPed(ped, GetHashKey(weapon))
        if currentAmmo > 0 then
            INserver.holstered({currentWeapon, currentAmmo})
        end

        currentWeapon = nil
        vRPin.notify({name = weapon, count = 1, label = Config.Items[weapon][1]}, "Dezechipata")
    else
        if isWeaponBig(GetHashKey(weapon)) and not bypass then
            if IsPedModel(playerPed,1885233650) and GetVehiclePedIsIn(playerPed, false) == 0 then -- male
                if (GetPedDrawableVariation(playerPed,5) == 40 or GetPedDrawableVariation(playerPed,5) == 41 or GetPedDrawableVariation(playerPed,5) == 44 or GetPedDrawableVariation(playerPed,5) == 45 or GetPedDrawableVariation(playerPed,5) == 81 or GetPedDrawableVariation(playerPed,5) == 82 or GetPedDrawableVariation(playerPed,5) == 85 or GetPedDrawableVariation(playerPed,5) == 86 or GetPedDrawableVariation(playerPed,5) == 112 or GetPedDrawableVariation(playerPed,5) == 113 or GetPedDrawableVariation(playerPed,5) == 114 or GetPedDrawableVariation(playerPed,5) == 115)  then
                    RemoveAllPedWeapons(ped, true)
                    currentWeapon = weapon
                    plmm = nil
                    vRP.playAnim({true,{{"reaction@intimidation@1h","intro",1}},false})
                    Citizen.Wait(1600)
                    ClearPedTasks(ped)

                    local magazineSize = GetMaxAmmoInClip(ped, GetHashKey(weapon))
                    local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(weapon))
                    local toReload = magazineSize
                    if currentAmmo > 0 then
                        toReload = magazineSize - currentAmmo
                    end
                    INserver.requestReload({weapon, toReload}, function(ok)
                        if ok then
                            GiveWeaponToPed(ped, GetHashKey(weapon), magazineSize, false, true)
                        else
                            GiveWeaponToPed(ped, GetHashKey(weapon), 0, false, true)
                        end
                    end)
                    plmm = weapon
                    INserver.daiatasamentepearma{atasamente[GetHashKey(weapon)]}
                    vRPin.notify({name = weapon, count = 1, label = Config.Items[weapon][1]}, "Echipata")
                end
            else
                if IsPedModel(playerPed,-1667301416) and GetVehiclePedIsIn(playerPed, false) == 0 then -- female
                    if (GetPedDrawableVariation(playerPed,5) == 40 or GetPedDrawableVariation(playerPed,5) == 41 or GetPedDrawableVariation(playerPed,5) == 44 or GetPedDrawableVariation(playerPed,5) == 45 or GetPedDrawableVariation(playerPed,5) == 81 or GetPedDrawableVariation(playerPed,5) == 82 or GetPedDrawableVariation(playerPed,5) == 85 or GetPedDrawableVariation(playerPed,5) == 86) then
                        RemoveAllPedWeapons(ped, true)
                        currentWeapon = weapon
                        plmm = nil
                        vRP.playAnim({true,{{"reaction@intimidation@1h","intro",1}},false})
                        Citizen.Wait(1600)
                        ClearPedTasks(ped)

                        local magazineSize = GetMaxAmmoInClip(ped, GetHashKey(weapon))
                        local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(weapon))
                        local toReload = magazineSize
                        if currentAmmo > 0 then
                            toReload = magazineSize - currentAmmo
                        end
                        INserver.requestReload({weapon, toReload}, function(ok)
                            if ok then
                                GiveWeaponToPed(ped, GetHashKey(weapon), magazineSize, false, true)
                            else
                                GiveWeaponToPed(ped, GetHashKey(weapon), 0, false, true)
                            end
                        end)
                        plmm = weapon
                        INserver.daiatasamentepearma{atasamente[GetHashKey(weapon)]}
                        vRPin.notify({name = weapon, count = 1, label = Config.Items[weapon][1]}, "Echipata")
                    end
                end
            end
        else
            RemoveAllPedWeapons(ped, true)
            currentWeapon = weapon
            plmm = nil
            vRP.playAnim({true,{{"reaction@intimidation@1h","intro",1}},false})
            Citizen.Wait(1600)
            ClearPedTasks(ped)

            local magazineSize = GetMaxAmmoInClip(ped, GetHashKey(weapon))
            local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(weapon))
            local toReload = magazineSize
            if currentAmmo > 0 then
                toReload = magazineSize - currentAmmo
            end
            INserver.requestReload({weapon, toReload}, function(ok)
                if ok then
                    GiveWeaponToPed(ped, GetHashKey(weapon), magazineSize, false, true)
                else
                    GiveWeaponToPed(ped, GetHashKey(weapon), 0, false, true)
                end
            end)
            plmm = weapon
            INserver.daiatasamentepearma{atasamente[GetHashKey(weapon)]}
            vRPin.notify({name = weapon, count = 1, label = Config.Items[weapon][1]}, "Echipata")
        end
    end
end


RegisterCommand('reload',function()
    if currentWeapon ~= nil then
        local ped = PlayerPedId()
        local magazineSize = GetMaxAmmoInClip(ped, GetHashKey(currentWeapon))
        local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon))
        local toReload = magazineSize

        if currentAmmo > 0 then
            toReload = magazineSize - currentAmmo
        end

        INserver.requestReload({currentWeapon, toReload}, function(ok)
            if ok then
                SetPedAmmo(ped, currentWeapon, magazineSize)
                MakePedReload(ped)
            end
        end)
    end
end)
RegisterKeyMapping('reload', 'Reload your weapon', 'keyboard', 'R')

AddEventHandler("CEventGunShot", function(_,eventEntity)
    if eventEntity == PlayerPedId() then
        if currentWeapon then
            local ped = PlayerPedId()
            local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon));
            
            if currentAmmo < 1 then
                Wait(50)
                GiveWeaponToPed(ped, GetHashKey(currentWeapon), 0, false, true)
                SetCurrentPedWeapon(ped, GetHashKey(currentWeapon), true);
                
                local magazineSize = GetMaxAmmoInClip(ped, GetHashKey(currentWeapon))
                local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon))
                local toReload = magazineSize

                if currentAmmo > 0 then
                    toReload = magazineSize - currentAmmo
                end
                
                INserver.requestReload({currentWeapon, toReload},function(ok)
                    if ok then
                        SetPedAmmo(ped, currentWeapon, magazineSize)
                        MakePedReload(ped);
                    end
                end)
            end
        end
    end
end)