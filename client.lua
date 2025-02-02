local QBCore = exports['qb-core']:GetCoreObject()


postMessage = function(data)
    SendNUIMessage(data)
end


GetLifeStyle = function()
    local life1 = nil 
    QBCore.Functions.TriggerCallback('ricky-server:getLifeStyle', function(life) 
        life1 = life
    end)
    while life1 == nil do
        Wait(0)
    end
    return life1
end

exports('GetLifeStyle', GetLifeStyle)


OpenStyleMenu = function()
    SetNuiFocus(true, true)
    postMessage({
        type = "SET_CONFIG",
        config = Config
    })
    postMessage({
        type = "OPEN"
    })
end

RegisterNUICallback('play', function(data, cb)
    local id = data.id
    for k,v in pairs(Config.Stili) do
        if v.id == id then
            item = v.oggetti
        end
    end
    TriggerEvent('ricky-client:onChooseLifeStyle', id)
    TriggerServerEvent('ricky-server:lifeStyleChoose', id, item)
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
end)

RegisterNetEvent('ricky-client:openLifeStyle')
AddEventHandler('ricky-client:openLifeStyle', function()
    OpenStyleMenu()
end)
RegisterCommand('lifestyle', function()
	 TriggerEvent('ricky-client:openLifeStyle')
end)

