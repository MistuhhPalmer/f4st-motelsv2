exports['qb-menu']:openMenu({
    { header = 'Room Purchase Menu', icon = 'fas fa-hotel', isMenuHeader = true },
    { header = 'Simple Motel Room', txt = 'Price: '.. tostring(FastMotels.BasicRoomPrice) .. " $", icon = 'fas fa-sack-dollar', params = { event = 'f4st-motels:buyBasicRoom' } },
    { header = 'Medium Motel Room', txt = 'Price: '.. tostring(FastMotels.Room1Price) .. " $", icon = 'fas fa-sack-dollar', params = { event = 'f4st-motels:buyRoom1' } },
    { header = 'Large Motel Room', txt = 'Price: '.. tostring(FastMotels.Room2Price) .. " $", icon = 'fas fa-sack-dollar', params = { event = 'f4st-motels:buyRoom2' } },
    { header = 'Go back', txt = 'Return to motel menu', icon = 'fas fa-right-to-bracket', params = { event = "f4st-motels:openMotelMenu" } },
})

RegisterNetEvent("f4st-motels:buyBasicRoom")
AddEventHandler("f4st-motels:buyBasicRoom", function()
    TriggerServerEvent("f4st-motels:buyRoom", "basic")
end)

RegisterNetEvent("f4st-motels:buyRoom1")
AddEventHandler("f4st-motels:buyRoom1", function()
    TriggerServerEvent("f4st-motels:buyRoom", "room1")
end)

RegisterNetEvent("f4st-motels:buyRoom2")
AddEventHandler("f4st-motels:buyRoom2", function()
    TriggerServerEvent("f4st-motels:buyRoom", "room2")
end)

function OpenMotelStash()
    local PlayerData = QBCore.Functions.GetPlayerData()
    TriggerEvent("inventory:client:SetCurrentStash", "Motel_"..PlayerData.citizenid)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Motel_"..PlayerData.citizenid)
end

function OpenOutfitMenu()
    TriggerEvent("qb-clothing:client:openOutfitMenu")
end

function ExitRoom()
    InRoom = false
    FreezeEntityPosition(PlayerPedId(), true)
    DoScreenFadeOut(1000)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), FastMotels.MotelCoords.x, FastMotels.MotelCoords.y, FastMotels.MotelCoords.z, false)
    SetEntityHeading(PlayerPedId(), 140.69)
    FreezeEntityPosition(PlayerPedId(), false)
    Wait(1000)
    DoScreenFadeIn(1000)
    TriggerServerEvent("f4st-motels:ExitRoom")
end

function BasicRoom()
    InRoom = true
    FreezeEntityPosition(PlayerPedId(), true)
    DoScreenFadeOut(1000)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), FastMotels.BasicRoomCoords.x, FastMotels.BasicRoomCoords.y, FastMotels.BasicRoomCoords.z, false)
    SetEntityHeading(PlayerPedId(), 171.61)
    Wait(100)
    FreezeEntityPosition(PlayerPedId(), false)
    Wait(1000)
    DoScreenFadeIn(1000)
end

function Room1()
    InRoom = true
    FreezeEntityPosition(PlayerPedId(), true)
    DoScreenFadeOut(1000)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), FastMotels.Room1Coords.x, FastMotels.Room1Coords.y, FastMotels.Room1Coords.z, false)
    SetEntityHeading(PlayerPedId(), 0.19)
    Wait(100)
    FreezeEntityPosition(PlayerPedId(), false)
    Wait(1000)
    DoScreenFadeIn(1000)
end

function Room2()
    InRoom = true
    FreezeEntityPosition(PlayerPedId(), true)
    DoScreenFadeOut(1000)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), FastMotels.Room2Coords.x, FastMotels.Room2Coords.y, FastMotels.Room2Coords.z, false)
    SetEntityHeading(PlayerPedId(), 353.9)
    Wait(100)
    FreezeEntityPosition(PlayerPedId(), false)
    Wait(1000)
    DoScreenFadeIn(1000)
end

RegisterNetEvent("f4st-motels:enterRoom")
AddEventHandler("f4st-motels:enterRoom", function()
    TriggerServerEvent("f4st-motels:datacheck")
end)

RegisterNetEvent("f4st-motels:teleportRoom")
AddEventHandler("f4st-motels:teleportRoom", function(motel_type_data)
    local motel_type = motel_type_data
    --print(motel_type)
    if motel_type == "basic" then
        BasicRoom()
    elseif motel_type == "room1" then
        Room1()
    elseif motel_type == "room2" then
        Room2()
    else
        print("[DEBUG]: Data not found")
        QBCore.Functions.Notify("Your motel data was not found, contact the server owner", "error", 5000)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        local distance = #(FastMotels.BasicRoomStash - GetEntityCoords(PlayerPedId()))
        if InRoom then
            if distance <= 2 then
                sleep = 1
                QBCore.Functions.DrawText3D(FastMotels.BasicRoomStash.x, FastMotels.BasicRoomStash.y, FastMotels.BasicRoomStash.z, "[E] - Stash")
                if IsControlJustPressed(0, 38) then
                    OpenMotelStash()
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        local distance = #(FastMotels.BasicRoomOutfit - GetEntityCoords(PlayerPedId()))
        if InRoom then
            if distance <= 2 then
                sleep = 1
                QBCore.Functions.DrawText3D(FastMotels.BasicRoomOutfit.x, FastMotels.BasicRoomOutfit.y, FastMotels.BasicRoomOutfit.z, "[E] - Wardrobe")
                if IsControlJustPressed(0, 38) then
                    OpenOutfitMenu()
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        local distance = #(FastMotels.BasicRoomDoor - GetEntityCoords(PlayerPedId()))
        if InRoom then
            if distance <= 2 then
                sleep = 1
                QBCore.Functions.DrawText3D(FastMotels.BasicRoomDoor.x, FastMotels.BasicRoomDoor.y, FastMotels.BasicRoomDoor.z, "[E] - Exit Room")
                if IsControlJustPressed(0, 38) then
                    ExitRoom()
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        local distance = #(FastMotels.Room1DoorCoords - GetEntityCoords(PlayerPedId()))
        if InRoom then
            if distance <= 2 then
                sleep = 1
                QBCore.Functions.DrawText3D(FastMotels.Room1DoorCoords.x, FastMotels.Room1DoorCoords.y, FastMotels.Room1DoorCoords.z, "[E] - Exit Room")
                if IsControlJustPressed(0, 38) then
                    ExitRoom()
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        local distance = #(FastMotels.Room1Stash - GetEntityCoords(PlayerPedId()))
        if InRoom then
            if distance <= 2 then
                sleep = 1
                QBCore.Functions.DrawText3D(FastMotels.Room1Stash.x, FastMotels.Room1Stash.y, FastMotels.Room1Stash.z, "[E] - Stash")
                if IsControlJustPressed(0, 38) then
                    OpenMotelStash()
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        local distance = #(FastMotels.Room1Outfit - GetEntityCoords(PlayerPedId()))
        if InRoom then
            if
