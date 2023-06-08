local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()

local isProcessingCoke = false
local isBaggingCoke = false
local isPackingCoke = false
local pickingCoke = false
local plantObjects = {}

function CreateBlip(location, blipName)
    local blip = AddBlipForCoord(location.x, location.y, location.z)
    SetBlipSprite(blip, 501)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 0)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(blipName)
    EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
    if CONFIG.ShowBlip then
        for _, location in ipairs(CONFIG.PickingLocations) do
            CreateBlip(location, "Pick Coke")
        end
        
        CreateBlip(CONFIG.PrepCoke, "Prepare Coke")
        CreateBlip(CONFIG.BagCoke, "Bag Coke")
        CreateBlip(CONFIG.PackageCoke, "Package Coke")
    end
end)


Citizen.CreateThread(function()
    local markerLocation = CONFIG.PrepCoke
    local markerRadius = 1.5 -- Adjust the marker radius as per your preference

    while true do
        Citizen.Wait(0)

        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(playerCoords, markerLocation, true)

        if distance <= markerRadius then
            DrawMarker(2, markerLocation.x, markerLocation.y, markerLocation.z - 0.5, 0, 0, 0, 0, 0, 0, markerRadius - 2, markerRadius - 2, 0.8, 255, 0, 0, 200, true, false, 2, true, nil, nil, false)
            if distance <= markerRadius * 0.5 then
                if isProcessingCoke == true then
                    TriggerEvent('qb-core:client:HideText')
                else
                    TriggerEvent('qb-core:client:DrawText', 'Press ~E~ to prepare coke', 'right')
                end
                    if IsControlJustPressed(0, 38) then
                    PrepCoke()
                    TriggerEvent('qb-core:client:HideText')
                end
            else
                TriggerEvent('qb-core:client:HideText')
            end
        end
    end
end)

Citizen.CreateThread(function()
    local markerLocation = CONFIG.BagCoke
    local markerRadius = 1.5 -- Adjust the marker radius as per your preference

    while true do
        Citizen.Wait(0)

        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(playerCoords, markerLocation, true)

        if distance <= markerRadius then
            DrawMarker(2, markerLocation.x, markerLocation.y, markerLocation.z - 0.5, 0, 0, 0, 0, 0, 0, markerRadius - 2, markerRadius - 2, 0.8, 255, 0, 0, 200, true, false, 2, true, nil, nil, false)
            if distance <= markerRadius * 0.5 then
                if isBaggingCoke == true then
                    TriggerEvent('qb-core:client:HideText')
                else
                    TriggerEvent('qb-core:client:DrawText', 'Press ~E~ to bag coke', 'right')
                end
                    if IsControlJustPressed(0, 38) then
                    BagCoke()
                    TriggerEvent('qb-core:client:HideText')
                end
            else
                TriggerEvent('qb-core:client:HideText')
            end
        end
    end
end)

Citizen.CreateThread(function()
    local markerLocation = CONFIG.PackageCoke
    local markerRadius = 1.5 -- Adjust the marker radius as per your preference

    while true do
        Citizen.Wait(0)

        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(playerCoords, markerLocation, true)

        if distance <= markerRadius then
            DrawMarker(2, markerLocation.x, markerLocation.y, markerLocation.z - 0.5, 0, 0, 0, 0, 0, 0, markerRadius - 2, markerRadius - 2, 0.8, 255, 0, 0, 200, true, false, 2, true, nil, nil, false)
            if distance <= markerRadius * 0.5 then
                if isPackingCoke == true then
                    TriggerEvent('qb-core:client:HideText')
                else
                    TriggerEvent('qb-core:client:DrawText', 'Press ~E~ to pack coke', 'right')
                end
                    if IsControlJustPressed(0, 38) then
                    PackCoke()
                    TriggerEvent('qb-core:client:HideText')
                end
            else
                TriggerEvent('qb-core:client:HideText')
            end
        end
    end
end)

Citizen.CreateThread(function()
    local markerLocation = vector3(1076.78, -3198.47, 5.9)
    local markerRadius = 3 -- Adjust the marker radius as per your preference

    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        
        for _, markerLocation in ipairs(CONFIG.PickingLocations) do
            local distance = GetDistanceBetweenCoords(playerCoords, markerLocation, true)
    
            if distance <= markerRadius then
                DrawMarker(2, markerLocation.x, markerLocation.y, markerLocation.z - 0.5, 0, 0, 0, 0, 0, 0, markerRadius - 2, markerRadius - 2, 0.8, 255, 0, 0, 200, true, false, 2, true, nil, nil, false)
                
                if distance <= markerRadius * 0.5 then
                    if pickingCoke then
                        TriggerEvent('qb-core:client:HideText')
                    else
                        TriggerEvent('qb-core:client:DrawText', 'Press ~E~ to pick coke', 'right')
                    end
                    if IsControlJustPressed(0, 38) then
                        PickupCoke()
                        TriggerEvent('qb-core:client:HideText')
                        pickingCoke = true
                        SetTimeout(60000, function()
                            pickingCoke = false
                        end)
                    end
                else
                    TriggerEvent('qb-core:client:HideText')
                end
            end
        end
    end    
end)

function PrepCoke()
    local hasItem = QBCore.Functions.HasItem(CONFIG.CokeLeafItem)
    isProcessingCoke = true
    QBCore.Functions.Progressbar("coke_processing", "Preparing coke...", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        -- Finished processing coke
        if hasItem then
            QBCore.Functions.Notify("Coke Processed!", "success")
            QBCore.Functions.Notify("Coke Bagged!", "success")
            TriggerServerEvent('rr-cocaine:server:prepcoke')
        else
            QBCore.Functions.Notify('You don\'t have enough coke leafs!', 'error', 5000)
        end
        Wait(5500)
        isProcessingCoke = false
        ClearPedTasks(PlayerPedId()) -- Stop the animation when progress bar is done
    end, function()
        -- Cancelled processing coke
        isProcessingCoke = false
        QBCore.Functions.Notify("Cancelled coke preparation.", "error")
        ClearPedTasks(PlayerPedId()) -- Stop the animation when progress bar is cancelled
    end)

    -- Play animation while processing
    if IsEntityPlayingAnim(PlayerPedId(), "timetable@ron@ig_4_smoking_meth", "chefiscookingup", 3) then
        ClearPedTasks(PlayerPedId())
    else
        RequestAnimDict("timetable@ron@ig_4_smoking_meth")
        while not HasAnimDictLoaded("timetable@ron@ig_4_smoking_meth") do
            Citizen.Wait(10)
        end
        TaskPlayAnim(PlayerPedId(), "timetable@ron@ig_4_smoking_meth", "chefiscookingup", 8.0, -8.0, -1, 1, 0, false, false, false)
    end
end

function BagCoke()
    local hasItem = QBCore.Functions.HasItem(CONFIG.ProcessedCokeItem)
    isBaggingCoke = true
    QBCore.Functions.Progressbar("coke_processing", "Bagging coke...", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        -- Finished processing coke
        QBCore.Functions.Notify("Coke Bagged!", "success")
        if hasItem then
            TriggerServerEvent('rr-cocaine:server:bagcoke')
        else
            QBCore.Functions.Notify('You don\'t have enough coke leafs!', 'success', 5000)
        end
        wait(1000)
        isBaggingCoke = false
        ClearPedTasks(PlayerPedId()) -- Stop the animation when progress bar is done
    end, function()
        -- Cancelled processing coke
        isBaggingCoke = false
        QBCore.Functions.Notify("Cancelled coke bagging.", "error")
        ClearPedTasks(PlayerPedId()) -- Stop the animation when progress bar is cancelled
    end)

    -- Play animation while bagging
    if IsEntityPlayingAnim(PlayerPedId(), "timetable@ron@ig_4_smoking_meth", "chefiscookingup", 3) then
        ClearPedTasks(PlayerPedId())
    else
        RequestAnimDict("timetable@ron@ig_4_smoking_meth")
        while not HasAnimDictLoaded("timetable@ron@ig_4_smoking_meth") do
            Citizen.Wait(10)
        end
        TaskPlayAnim(PlayerPedId(), "timetable@ron@ig_4_smoking_meth", "chefiscookingup", 8.0, -8.0, -1, 1, 0, false, false, false)
    end
end

function PackCoke()
    isPackingCoke = true
    QBCore.Functions.Progressbar("coke_processing", "Packing coke...", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        -- Finished processing coke
        isPackingCoke = false
        QBCore.Functions.Notify("Coke Packed!", "success")
        TriggerServerEvent('rr-cocaine:server:packcoke')
        ClearPedTasks(PlayerPedId()) -- Stop the animation when progress bar is done
    end, function()
        -- Cancelled processing coke
        isPackingCoke = false
        QBCore.Functions.Notify("Cancelled coke packing.", "error")
        ClearPedTasks(PlayerPedId()) -- Stop the animation when progress bar is cancelled
    end)

    -- Play animation while packing
    if IsEntityPlayingAnim(PlayerPedId(), "timetable@ron@ig_4_smoking_meth", "chefiscookingup", 3) then
        ClearPedTasks(PlayerPedId())
    else
        RequestAnimDict("timetable@ron@ig_4_smoking_meth")
        while not HasAnimDictLoaded("timetable@ron@ig_4_smoking_meth") do
            Citizen.Wait(10)
        end
        TaskPlayAnim(PlayerPedId(), "timetable@ron@ig_4_smoking_meth", "chefiscookingup", 8.0, -8.0, -1, 1, 0, false, false, false)
    end
end

RegisterNetEvent('rr-cocaine:client:nocokeleaf')
AddEventHandler('rr-cocaine:client:nocokeleaf', function()
    QBCore.Functions.Notify('You need atleast' .. CONFIG.CokeLeafsNeeded .. ' ' .. CONFIG.CokeLeafItem, 'error', 5000)
end)

RegisterNetEvent('rr-cocaine:client:noprocessedcoke')
AddEventHandler('rr-cocaine:client:nocokeleaf', function()
    QBCore.Functions.Notify('You need atleast' .. CONFIG.ProcessedCokeNeeded .. ' ' .. CONFIG.ProcessedCokeItem, 'error', 5000)
end)

RegisterNetEvent('rr-cocaine:client:nopackagedcoke')
AddEventHandler('rr-cocaine:client:nocokeleaf', function()
    QBCore.Functions.Notify('You need atleast' .. CONFIG.CokeBagsNeeded .. ' ' .. CONFIG.BaggedCokeItem, 'error', 5000)
end)

function PickupCoke()
    local playerPed = PlayerPedId()

    QBCore.Functions.Progressbar("coke_processing", "Preparing coke...", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        -- Finished processing coke
        if plantObject ~= nil and DoesEntityExist(plantObject) then
            DeleteEntity(plantObject)
        end
        TriggerServerEvent('rr-cocaine:server:pickupcoke')
        Wait(5500)
        pickingCoke = false
        ClearPedTasks(playerPed) -- Stop the animation when progress bar is done
    end, function()
        -- Cancelled processing coke
        pickingCoke = false
        QBCore.Functions.Notify("Cancelled coke picking.", "error")
        ClearPedTasks(playerPed) -- Stop the animation when progress bar is cancelled
    end)

    -- Play animation while processing
    if IsEntityPlayingAnim(playerPed, "anim@gangops@facility@servers@bodysearch@", "player_search", 3) then
        ClearPedTasks(playerPed)
    else
        RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
        while not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@") do
            Citizen.Wait(10)
        end
        TaskPlayAnim(playerPed, "anim@gangops@facility@servers@bodysearch@", "player_search", 8.0, -8.0, -1, 1, 0, false, false, false)
    end
end

Citizen.CreateThread(function()
    for _, location in ipairs(CONFIG.PickingLocations) do
        local plantObject = CreateObject(GetHashKey(CONFIG.CokePlant), location.x, location.y, location.z, false, false, false)
        SetEntityAsMissionEntity(plantObject, true, true)
        SetEntityHeading(plantObject, 0.0)
        PlaceObjectOnGroundProperly(plantObject)
        FreezeEntityPosition(plantObject, true)
        table.insert(plantObjects, plantObject)
    end

    while true do
        Citizen.Wait(60000) -- Wait for 60 seconds
        for _, plantObject in ipairs(plantObjects) do
            DeleteEntity(plantObject)
        end
        plantObjects = {}
        for _, location in ipairs(CONFIG.PickingLocations) do
            local plantObject = CreateObject(GetHashKey(CONFIG.CokePlant), location.x, location.y, location.z, false, false, false)
            SetEntityAsMissionEntity(plantObject, true, true)
            SetEntityHeading(plantObject, 0.0)
            PlaceObjectOnGroundProperly(plantObject)
            FreezeEntityPosition(plantObject, true)
            table.insert(plantObjects, plantObject)
        end
    end
end)