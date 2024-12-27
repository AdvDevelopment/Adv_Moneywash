fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'Adv_Moneywash'
description 'Money Wash by Lix'
version '1.0.0'


shared_scripts {
    '@es_extended/imports.lua', 
    'config.lua'
}


ui_page 'nui/index.html'


client_scripts {
    'client.lua',
}


server_scripts {
    'server.lua',
}


files {
    'nui/index.html',
}

