if GetResourceState('es_extended') ~= 'started' then return end
local ESX = exports['es_extended']:getSharedObject()

function CreateItem(item)
    ESX.RegisterUsableItem(item, function(source)
        TriggerClientEvent('neko_radio:client:open_radio_menu', source)
    end)
end