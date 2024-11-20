ESX = nil

-- Wait for ESX to be available
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local isHandsUp = false

-- Define the key for raising hands (F10)
local handsUpKey = 56 -- You can change this to any key you like

-- Function to handle the animation of raising hands
function RaiseHands()
    local playerPed = PlayerPedId()

    if isHandsUp then
        -- If player already has hands up, lower them
        ClearPedSecondaryTask(playerPed)
        isHandsUp = false
    else
        -- If player does not have hands up, raise them
        TaskHandsUp(playerPed)
        isHandsUp = true
    end
end

-- Task to trigger hands up animation
function TaskHandsUp(ped)
    -- Make sure the ped is standing still
    ClearPedTasksImmediately(ped)
    RequestAnimDict('random@arrests')
    while not HasAnimDictLoaded('random@arrests') do
        Citizen.Wait(100)
    end

    TaskPlayAnim(ped, 'random@arrests', 'idle_2_hands_up', 8.0, -8.0, -1, 50, 0, false, false, false)
end

-- Listen for the key press to trigger hands up
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        -- Check if the player presses the defined key
        if IsControlJustPressed(0, handsUpKey) then
            RaiseHands()
        end
    end
end)
