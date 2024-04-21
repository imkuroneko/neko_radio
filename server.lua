lib.locale()
local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports.ox_inventory

if Config.requireItem then
    for key, item in pairs(Config.itemName) do
        QBCore.Functions.CreateUseableItem(item, function(source)
            TriggerClientEvent('neko_radio:client:open_radio_menu', source)
        end)
    end
end

lib.callback.register('neko_radio:server:verify_has_item', function(source, cb)
    if Config.requireItem then
        local hasItem = false
        for key, item in pairs(Config.itemName) do
            local items = ox_inventory:Search(source, 'count', { item })
            if items and items > 0 then
                hasItem = true
            end
        end
        return hasItem
    else
        return true
    end
end)