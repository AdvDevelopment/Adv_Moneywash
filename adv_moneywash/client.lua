local isNuiVisible = false

RegisterNetEvent('opennui', function()
    if not isNuiVisible then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'open'
        })
        nuiOpen = true
        isNuiVisible = true
    end
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'close'
    })
    nuiOpen = false
    isNuiVisible = false
    cb('ok')
end)


RegisterNUICallback('cleanmoney', function(data, cb)
    for k, v in pairs(Config.Position) do
        TriggerServerEvent("adv:clearmoney", data, v.percentage)

    end
    cb('ok')
end)


Citizen.CreateThread(function()
    Wait(250)
    for k, v in pairs(Config.Position) do
        TriggerEvent('gridsystem:registerMarker', {
            name = 'rapina' .. k,
            pos = v.pos,
            scale = vector3(1.5, 1.5, 1.5),
            msg = 'Press ~INPUT_CONTEXT~ To Clear Money',
            control = 'E',
            type = -1,
            texture = 'logo',
            permission = v.job,
            color = { r = 130, g = 120, b = 110 },
            action = function()
                if not isNuiVisible then
                    TriggerEvent('opennui')
                end
            end
        })
    end
end)

