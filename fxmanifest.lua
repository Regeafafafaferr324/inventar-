fx_version "bodacious"
games { 'gta5' }
lua54 'yes'
author 'Daffy Duck' 

ui_page 'html/ui.html'

client_scripts {
  "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
  'config.lua',
  'client/main.lua',
  'client/chest.lua',
  'client/shop.lua',
  'client/player.lua',
  'client/weapon.lua',
  'client/drops.lua',
  'client/clothing.lua'
}

server_scripts {
  "@vrp/lib/utils.lua",
  'config.lua',	
  'server/main.lua',
  'server/chest.lua',
  'server/shop.lua',
  'server/player.lua',
  'server/drops.lua'
}

files {
  'html/ui.html',
  'html/css/ui.css',
  'html/css/jquery-ui.css',
  'html/js/inventory.js',
  'html/js/config.js',
  -- ICONS
  'html/img/*.png',
  'html/cloth/*.png',
	'html/cloth/*.svg',
}
