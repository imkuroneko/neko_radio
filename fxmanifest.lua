fx_version  'cerulean'
game        'gta5'
lua54       'yes'
-- ===========================================================
description 'Sistemas de radio'
author      'KuroNeko'
-- ===========================================================
version     '1.0.0'

-- ===========================================================
shared_scripts { '@ox_lib/init.lua', 'config.lua' }
server_scripts { 'server.lua' }
client_scripts { 'client.lua' }
dependency     { 'ox_lib', 'ox_inventory', 'pma-voice' }

files          { 'locales/*.json' }