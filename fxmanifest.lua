-- {{FX Infomration}}
fx_version 'cerulean'
game 'gta5'

-- {{Resouce Information}}
author 'Respect Development (Forked by Jv$st)'
description 'Discord RPC'
version '1.5.0'

-- {{Manifest}} --
lua54 'yes'

shared_scripts {
    'Config.lua'
}

client_scripts {
    'Client/Client.lua'
}

server_scripts {
    'Server/Server.lua'
}

files {
    "Bridge/*.lua"
}