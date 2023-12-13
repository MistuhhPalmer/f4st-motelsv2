fx_version 'cerulean'
game 'gta5'
author 'f4st3r'
description 'f4st-motelsv2'

client_scripts {
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

shared_scripts {
    'config.lua'.
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua'
}

-- by f4st3r
