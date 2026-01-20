--[[
    ╔════════════════════════════════════════════════════════════════════════════════╗
    ║                                                                                ║
    ║                        🐺 THE LAND OF WOLVES 🐺                               ║
    ║                          Advanced Custom Animations                            ║
    ║                                                                                ║
    ║                          www.wolves.land                                       ║
    ║                          Created by: iBoss                                     ║
    ║                                                                                ║
    ║  Description: Player-to-Player interactive adult animations with accept/      ║
    ║               decline mechanics and punishment animations for rejection        ║
    ║                                                                                ║
    ║  Version: 1.0.0                                                                ║
    ║  License: All Rights Reserved - The Land of Wolves                            ║
    ║                                                                                ║
    ╚════════════════════════════════════════════════════════════════════════════════╝
]]

fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'iBoss - The Land of Wolves'
description 'Advanced Custom Animations for RedM - Player to Player Interactive Animations with Accept/Decline System'
version '1.0.0'

shared_scripts {
    'config.lua',
    'shared/*.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

lua54 'yes'
