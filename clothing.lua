local PlayerPedPreview
function CreatePedScreen(first)
    CreateThread(function()
        SetFrontendActive(true)
        ActivateFrontendMenu(`FE_MENU_VERSION_JOINING_SCREEN`, true, -1)
        Wait(100)
        SetMouseCursorVisibleInMenus(false)
        PlayerPedPreview = ClonePed(PlayerPedId(), false, true, false)
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedPreview))
        TaskSetBlockingOfNonTemporaryEvents(PlayerPedPreview, true)
        SetEntityCoords(PlayerPedPreview, x, y, z - 10)
        FreezeEntityPosition(PlayerPedPreview, true)
        SetEntityVisible(PlayerPedPreview, false, false)
        NetworkSetEntityInvisibleToNetwork(PlayerPedPreview, false)
        Wait(200)
        GivePedToPauseMenu(PlayerPedPreview, 2)

        if first then
            SetPauseMenuPedSleepState(false)
            Wait(1000)
            SetPauseMenuPedSleepState(true)
        else
            SetPauseMenuPedSleepState(true)
        end

        SetPauseMenuPedLighting(true)
    end)
end
function DeletePedScreen()
    DeleteEntity(PlayerPedPreview)
    SetFrontendActive(false)
end

function RefreshPedScreen()
    if DoesEntityExist(PlayerPedPreview) then
        DeletePedScreen()
        Wait(500)
        if checkInventory() then 
            CreatePedScreen(false)
        end
    end
end

RegisterNUICallback("togglecloth", function(data, cb)
    ExecuteCommand(data.component)
    Wait(1000)
    RefreshPedScreen()
end)