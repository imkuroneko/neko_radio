lib.locale()
local QBCore = exports['qb-core']:GetCoreObject()

RadioProp      = nil
CurrentChannel = 0
RadioVolume    = Config.defaultVolume

-- ===== Bind
if Config.bindRadioMenu ~= nil and Config.bindRadioMenu ~= '' then
    local keybind = lib.addKeybind({
        name        = 'NekoRadioMenú',
        description = locale('bind_description'),
        defaultKey  = Config.bindRadioMenu,
        onPressed   = function(self) TriggerEvent('neko_radio:client:open_radio_menu') end,
    })
    keybind:disable(false)
end

-- ===== Events
RegisterNetEvent('neko_radio:client:open_radio_menu')
AddEventHandler('neko_radio:client:open_radio_menu', function()
    ToggleRadio()
end)

RegisterNetEvent('neko_radio:client:disconnect')
AddEventHandler('neko_radio:client:disconnect', function()
    SetRadioChannel(0, false)
    ToggleRadioAnimation(false)
    CurrentChannel = 0
end)

RegisterNetEvent('neko_radio:client:set_frequency')
AddEventHandler('neko_radio:client:set_frequency', function()
    local input = lib.inputDialog(locale('radio_label'), {
        {
            type     = 'number',
            icon     = { 'fas', 'radio' },
            required = true,
            label    = locale('set_frequency_label'),
            min      = Config.minFrequency,
            max      = Config.maxFrequency,
        }
    })

    if not input then return end

    local frequency = input[1]

    if frequency > Config.maxFrequency or frequency < Config.minFrequency then
        return lib.notify({ description = locale('error_frequency_not_available'), type = 'error' })
    else
        local player = QBCore.Functions.GetPlayerData()

        if Config.restrictedForJobs[frequency] ~= nil then
            HasRequiredJob = false

            for key, type in pairs(Config.restrictedForJobs[frequency]) do
                if player.job.type and player.job.type == type then HasRequiredJob = true end
            end

            if HasRequiredJob then
                if not player.job.onduty then
                    return lib.notify({ description = locale('error_player_not_on_duty'), type = 'error' })
                end

                SetRadioChannel(frequency, true)
                CurrentChannel = frequency
                ToggleRadioAnimation(false)
                return lib.notify({ description = locale('frequency_updated', frequency), type = 'success' })
            else
                return lib.notify({ description = locale('error_reserved_frequency'), type = 'info' })
            end
        else
            SetRadioChannel(frequency, true)
            CurrentChannel = frequency
            ToggleRadioAnimation(false)
            return lib.notify({ description = locale('frequency_updated', frequency), type = 'success' })
        end
    end
end)

RegisterNetEvent('neko_radio:client:change_volume')
AddEventHandler('neko_radio:client:change_volume', function()
    if CurrentChannel == 0 then
        local input = lib.inputDialog(locale('radio_label'), {
            {
                type     = 'number',
                icon     = { 'fas', 'volume-high' },
                required = true,
                label    = locale('set_volume_label'),
                min      = 1,
                max      = 100,
                default  = RadioVolume,
            }
        })

        if not input then return end

        local volume = input[0]
        RadioVolume = volume

        ToggleRadio()
        exports['pma-voice']:setRadioVolume(RadioVolume)

        return lib.notify({ description = locale('volume_updated'), type = 'success' })
    else
        return lib.notify({ description = locale('info_radio_off_volume'), type = 'info' })
    end
end)

RegisterNetEvent('neko_radio:client:build_menu')
AddEventHandler('neko_radio:client:build_menu', function()
    local channDescription = ''
    local titleCloseMenu = ''
    local disableVolume = false
    if CurrentChannel == 0 then
        channDescription = locale('channel_description_off')
        titleCloseMenu = locale('mainmenu_save')
        disableVolume = true
    else
        titleCloseMenu = locale('mainmenu_turn_off')
        channDescription = locale('channel_description_on', CurrentChannel)
    end

    lib.registerContext({
        id = 'radio_menu',
        title = locale('radio_label'),
        onExit = function() ToggleRadioAnimation(false) end,
        options = {
            {
                title = locale('mainmenu_frequency'),
                description = channDescription,
                icon  = 'fa-solid fa-walkie-talkie',
                arrow = true,
                event = 'neko_radio:client:set_frequency',
            },
            {
                title = locale('mainmenu_volume'),
                description = locale('volume_description', RadioVolume..'%'),
                icon  = 'fa-solid fa-volume-high',
                arrow = true,
                event = 'neko_radio:client:change_volume',
                disabled = disableVolume,
            },
            {
                title = titleCloseMenu,
                icon  = 'fa-solid fa-right-from-bracket',
                arrow = false,
                event = 'neko_radio:client:disconnect',
            }
        }
    })
    lib.showContext('radio_menu')
end)

-- ===== Functions
function ToggleRadioAnimation(state)
    lib.requestAnimDict('cellphone@')
    if state then
        TriggerEvent("attachItemRadio","radio01")
        TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
        RadioProp = CreateObject(`prop_cs_hand_radio`, 1.0, 1.0, 1.0, 1, 1, 0)
        AttachEntityToEntity(RadioProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0.01, -0.02, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)
    else
        StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 1.0)
        ClearPedTasks(PlayerPedId())
        DeleteObject(RadioProp)
        RadioProp = 0
    end
end

function ToggleRadio()
    local hasItem = lib.callback.await('neko_radio:server:verify_has_item', false)

    if not hasItem then
        return lib.notify({ description = locale('radio_needs_item'), type = 'error' })
    else
        ToggleRadioAnimation(false)
        ToggleRadioAnimation(true)

        TriggerEvent('neko_radio:client:build_menu')
    end
end

function SetRadioChannel(channel, events)
    if channel == nil then channel = 0 end
    if channel == 0 then
        exports["pma-voice"]:removePlayerFromRadio()
    end
    exports['pma-voice']:setVoiceProperty('radioEnabled', events)
    exports['pma-voice']:setVoiceProperty('micClicks', events)
    exports["pma-voice"]:SetRadioChannel(channel)
end