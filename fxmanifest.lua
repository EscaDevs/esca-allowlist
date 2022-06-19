fx_version 'adamant'
game 'gta5'
version '1.1'
description 'VANESCA Whitelist'

ui_page 'html/ui.html'

client_scripts {
    'client/cl_main.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/sv_main.lua'
}

files {
    'html/ui.html',
    'html/style.css',
    'html/main.js',
}

