local QBCore = exports['qb-core']:GetCoreObject()
local InRoom = false
local InZone = false

CreateThread(function()
    if FastMotels.Blips then
        fastmotels = AddBlipForCoord(FastMotels.MotelCoords.x, FastMotels.MotelCoords.y, FastMotels.MotelCoords.z)
        SetBlipSprite(fastmotels, FastMotels.BlipSprite)
        SetBlipDisplay(fastmotels, 4)
        SetBlipScale(fastmotels, FastMotels.BlipScale)
        SetBlipColour(fastmotels, FastMotels.BlipColour)
        SetBlipAsShortRange(fastmotels, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Motel")
        EndTextCommandSetBlipName(fastmotels)
    end
end)

CreateThread(function()
    while true do
        local sleep = 2000
        local distance = #(FastMotels.MotelCoords - GetEntityCoords(PlayerPedId()))
        if distance <= 7 then
            InZone = true
            sleep = 1
            DrawMarker(2, FastMotels.MotelCoords.x, FastMotels.MotelCoords.y, FastMotels.MotelCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.70, 0.70, 0.70, 255, 0, 0, 50, false, true, 2, nil, nil, false)
            if distance <= 2 then
                QBCore.Functions.DrawText3D(FastMotels.MotelCoords.x, FastMotels.MotelCoords.y, FastMotels.MotelCoords.z, "[E] - Motel Menu")
                if IsControlJustPressed(0, 38) then
                    TriggerEvent("f4st-motels:openMotelMenu")
                end
            end
        end
        Wait(sleep)
    end
end)



RegisterNetEvent("f4st-motels:openMotelMenu")
AddEventHandler("f4st-motels:openMotelMenu", function()
    if InZone then
        exports['qb-menu']:openMenu({
            {
                header = 'Motel Menu',
                icon = 'fas fa-hotel',
                isMenuHeader = true,
            },

            {
                header = 'Enter Room',
                txt = 'Enters your owned motel room',
                icon = 'fas fa-key',
                params = {
                    event = 'f4st-motels:enterRoom'
                }
            },
            {
                header = 'Buy Motel Room',
                txt = 'Allows you to buy a new motel room',
                icon = 'fas fa-sack-dollar',
                params = {
                    event = 'f4st-motels:buyRoomMenu'
                }
            },
            {
                header = 'Close Menu',
                txt = 'Closes the motel menu',
                icon = 'fas fa-right-to-bracket',
                params = {
                    event = ''
                }
            },

        })
    end
end)

RegisterNetEvent("f4st-motels:buyRoomMenu")
AddEventHandler("f4st-motels:buyRoomMenu", function()
    if InZone then
        exports['qb-menu']:openMenu({
            {
                header = 'Room Purchase Menu',
                icon = 'fas fa-hotel',
                isMenuHeader = true,
            },
            {
                header = 'Basic Motel Room',
                txt = 'Price: '.. tostring(FastMotels.BasicRoomPrice) .. " $",
                icon = 'fas fa-sack-dollar',
                params = {
                    event = 'f4st-motels:buyBasicRoom'
