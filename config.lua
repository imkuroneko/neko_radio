Config = {}

Config.requireItem    = true         -- utilizar item para el sistema de radio?
Config.itemName       = {            -- se necesita uno de estos itambulance para acceder a la radio
    'radio'
}

Config.bindRadioMenu = 'F10'
-- Config.bindRadioMenu = 'F10'      -- se podrá acceder al menú de la radio desde esta tecla
-- Config.bindRadioMenu = nil        -- al definir 'nil' see deshabilitará el bindeo


Config.defaultVolume = 50            -- volumen default para la radio

Config.minFrequency  = 1             -- número mínimo de frecuencia
Config.maxFrequency  = 1000          -- número máximo de frecuencia


-- estos canales, estarán disponibles únicamente para estas de facciones
Config.restrictedForJobs = {
    [1]  = { 'police' },
    [2]  = { 'police' },
    [3]  = { 'police' },
    [4]  = { 'police' },
    [5]  = { 'police' },
    [6]  = { 'police' },
    [7]  = { 'police' },
    [8]  = { 'police' },
    [9]  = { 'police' },
    [10] = { 'police' },

    [11] = { 'lssd' },
    [12] = { 'lssd' },
    [13] = { 'lssd' },
    [14] = { 'lssd' },
    [15] = { 'lssd' },
    [16] = { 'lssd' },
    [17] = { 'lssd' },
    [18] = { 'lssd' },
    [19] = { 'lssd' },
    [20] = { 'lssd' },

    [21] = { 'police', 'lssd' },
    [22] = { 'police', 'lssd' },
    [23] = { 'police', 'lssd' },
    [24] = { 'police', 'lssd' },
    [25] = { 'police', 'lssd' },

    [26] = { 'police', 'lssd', 'ambulance' },
    [27] = { 'police', 'lssd', 'ambulance' },
    [28] = { 'police', 'lssd', 'ambulance' },
    [29] = { 'police', 'lssd', 'ambulance' },
    [30] = { 'police', 'lssd', 'ambulance' },

    [31] = { 'ambulance' },
    [32] = { 'ambulance' },
    [33] = { 'ambulance' },
    [34] = { 'ambulance' },
    [35] = { 'ambulance' },
}