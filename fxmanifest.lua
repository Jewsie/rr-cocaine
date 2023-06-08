resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
fx_version 'cerulean'
game 'gta5'

description 'Cocaine script for Replex Roleplay'

author 'Jack P'

escrow_ignore {
    'config.lua'
}

shared_script 'config.lua'
server_scripts {
    'server/sv_main.lua',
    'server/sv_plants.lua'
}
client_scripts {
    '@menuv/menuv.lua',
    'client/cl_main.lua'
}

lua54 'yes'