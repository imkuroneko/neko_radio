Config = {}

Config.requireItem    = true         -- utilizar item para el sistema de radio?
Config.itemName       = {            -- se necesita uno de estos items para acceder a la radio
    'radio'
}

Config.bindRadioMenu = 'F10'
-- Config.bindRadioMenu = 'F10'      -- se podrá acceder al menú de la radio desde esta tecla
-- Config.bindRadioMenu = nil        -- al definir 'nil' see deshabilitará el bindeo


Config.defaultVolume = 50            -- volumen default para la radio

Config.minFrequency  = 1             -- número mínimo de frecuencia
Config.maxFrequency  = 1000          -- número máximo de frecuencia


-- estos canales, estarán disponibles únicamente para estos tipos de facciones
-- los jobs deberán contar con el parámetro type para este control
Config.restrictedForJobs = {
    [1]  = { 'leo' },
    [2]  = { 'leo' },
    [3]  = { 'leo' },
    [4]  = { 'leo' },
    [5]  = { 'leo' },
    [6]  = { 'leo' },
    [7]  = { 'leo' },
    [8]  = { 'leo' },
    [9]  = { 'leo' },
    [10] = { 'leo' },
    [11] = { 'ems' },
    [12] = { 'ems' },
    [13] = { 'ems' },
    [14] = { 'ems' },
    [15] = { 'ems' },
    [16] = { 'ems' },
    [17] = { 'ems' },
    [18] = { 'ems' },
    [19] = { 'ems' },
    [20] = { 'ems' },
    [21] = { 'leo', 'ems' },
    [22] = { 'leo', 'ems' },
    [23] = { 'leo', 'ems' },
    [24] = { 'leo', 'ems' },
    [25] = { 'leo', 'ems' },
}