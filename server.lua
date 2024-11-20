ESX = nil

-- Wait for ESX to be available
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Example of handling a notification when someone raises their hands
RegisterNetEvent('esx_handsup:notify')
AddEventHandler('esx_handsup:notify', function(playerId)
    TriggerClientEvent('esx:showNotification', playerId, "Someone raised their hands!")
end)
