lib.locale()
local ox_inventory = exports.ox_inventory

lib.callback.register('neko_radio:server:verify_has_item', function(source, cb)
    if Config.requireItem then
        for key, item in pairs(Config.itemName) do
            local items = ox_inventory:Search(source, 'count', { item })
            if items and items > 0 then
                return true
            end
        end
        return false
    else
        return true
    end
end)

lib.callback.register('neko_radio:server:wet_radio', function(source, cb)
    if Config.requireItem and Config.shouldBrokenRadioOnWater then
        for key, itemName in pairs(Config.itemName) do
            local items = ox_inventory:Search(source, 'count', { itemName })
            if items and items > 0 then
                ox_inventory:RemoveItem(source, itemName, items)
                ox_inventory:AddItem(source, itemName..'_wet', items)
            end
        end
    end
end)


if Config.requireItem then
    for key, item in pairs(Config.itemName) do
        CreateItem(item)
    end
end
