fx_version 'cerulean'

game 'gta5'

author 'scarfoxed'

description 'cerberus roleplay humane heist'

version '1.0'

client_scripts {
	'client/humane.lua'
}

server_scripts {
	'server/main.lua'
}

shared_scripts{
    'config.lua',
	'@ox_lib/init.lua',
}

lua54 'yes'