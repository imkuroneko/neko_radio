if GetResourceState('qb-core') ~= 'started' then return end
local QBCore = exports['qb-core']:GetCoreObject()

function CreateItem(item)
    QBCore.Functions.CreateUseableItem(item, function(source)
        TriggerClientEvent('neko_radio:client:open_radio_menu', source)
    end)
end