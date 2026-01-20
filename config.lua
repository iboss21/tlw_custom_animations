--[[
    ████████╗██╗     ██╗    ██╗     █████╗ ███╗   ██╗██╗███╗   ███╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
    ╚══██╔══╝██║     ██║    ██║    ██╔══██╗████╗  ██║██║████╗ ████║██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
       ██║   ██║     ██║ █╗ ██║    ███████║██╔██╗ ██║██║██╔████╔██║███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
       ██║   ██║     ██║███╗██║    ██╔══██║██║╚██╗██║██║██║╚██╔╝██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
       ██║   ███████╗╚███╔███╔╝    ██║  ██║██║ ╚████║██║██║ ╚═╝ ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
       ╚═╝   ╚══════╝ ╚══╝╚══╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
                                                                                                                     
    🐺 The Land of Wolves - Advanced Custom Animations
    "Intimate Encounters" - Player-to-Player Interactive Animation System
    
    Version: 1.0.0
    Author: iBoss
    Website: www.wolves.land
    Server: The Land of Wolves
    
    A comprehensive player-to-player animation system featuring:
    - 40+ adult 18+ synchronized animations (standing, bed, chair, romantic)
    - Interactive request/accept/decline mechanics with 30-second timeout
    - 6 punishment animations for rejected requests (slap, kick, punch, etc.)
    - Smart prop detection (beds & 100+ chair models)
    - Multi-framework support (RSG-Core, LXR-Core, VORP)
    - Supreme performance optimization (~0.01ms resmon)
    - Extensive configuration system - everything configurable from config.lua
    - Beautiful localization support with emojis
    - Comprehensive documentation with 7+ guides
    
    © 2026 iBoss | The Land of Wolves | www.wolves.land
    License: All Rights Reserved
]]

Config = {}

--[[
    ┌──────────────────────────────────────────────────────────────────────────────┐
    │                          FRAMEWORK SETTINGS                                   │
    │  Configure which framework you're using and language preferences              │
    └──────────────────────────────────────────────────────────────────────────────┘
]]
Config.Framework = "RSG" -- Options: "RSG" (RSG-Core) or "LXR" (LXR-Core)
Config.Language = "en"   -- Language code for localization (default: "en")

--[[
    ┌──────────────────────────────────────────────────────────────────────────────┐
    │                      ANIMATION REQUEST SETTINGS                               │
    │  Control timing, distance, and behavior of animation requests                 │
    └──────────────────────────────────────────────────────────────────────────────┘
]]
Config.RequestTimeout = 30000        -- Time in milliseconds before request expires (default: 30000 = 30 seconds)
Config.MaxDistance = 3.0              -- Maximum distance in meters to request animation from another player
Config.DeclineWithPunishment = true   -- Enable punishment animations when someone declines
Config.PunishmentChance = 75          -- Percentage chance (0-100) that declining will trigger punishment animation

--[[
    ┌──────────────────────────────────────────────────────────────────────────────┐
    │                        PERFORMANCE SETTINGS                                    │
    │  Optimization and cache settings for supreme performance                       │
    └──────────────────────────────────────────────────────────────────────────────┘
]]
Config.PlayerPedUpdateInterval = 5000 -- How often to update cached player ped (milliseconds, default: 5000)
Config.PropDetectionRadius = 2.0      -- Detection radius for beds/chairs (meters, default: 2.0)
Config.EnableDebugMode = false        -- Enable debug prints (set to true for troubleshooting)

--[[
    ┌──────────────────────────────────────────────────────────────────────────────┐
    │                           COMMAND SETTINGS                                     │
    │  Customize all command names - change these to avoid conflicts                │
    └──────────────────────────────────────────────────────────────────────────────┘
]]
Config.Commands = {
    openMenu = {
        name = "tlwanim",           -- Main command to open animation menu
        aliases = {"tlw"},           -- Alternative shorter commands (table)
        description = "Open TLW animation menu"
    },
    playAnimation = {
        name = "tlwplay",            -- Command to play specific animation
        aliases = {},                -- No aliases by default
        description = "Request animation from nearby player"
    },
    acceptRequest = {
        name = "tlwaccept",          -- Command to accept animation request
        aliases = {"acceptanim"},    -- Alternative command
        description = "Accept pending animation request"
    },
    declineRequest = {
        name = "tlwdecline",         -- Command to decline animation request
        aliases = {"declineanim"},   -- Alternative command
        description = "Decline pending animation request"
    },
    stopAnimation = {
        name = "tlwstop",            -- Command to stop current animation
        aliases = {"stopanim"},      -- Alternative command
        description = "Stop current animation"
    },
    -- Admin Commands
    stopAllAnimations = {
        name = "tlwstopallanims",    -- Admin command to stop all animations
        permission = "tlw_animations.admin",
        description = "Force stop all active animations (admin only)"
    }
}

--[[
    ┌──────────────────────────────────────────────────────────────────────────────┐
    │                        NOTIFICATION SETTINGS                                   │
    │  Customize notification behavior and appearance                                │
    └──────────────────────────────────────────────────────────────────────────────┘
]]
Config.NotificationSettings = {
    defaultDuration = 5000,          -- Default notification duration (milliseconds)
    requestDuration = 8000,          -- Duration for animation requests (milliseconds)
    useEmojis = true,                -- Use emojis in notifications (🐺, ✅, ❌, etc.)
    defaultType = "info",            -- Default notification type
}

--[[
    ┌──────────────────────────────────────────────────────────────────────────────┐
    │                      ADULT 18+ ANIMATIONS                                     │
    │                                                                                │
    │  All adult animations with synchronized player and target positions.          │
    │  Each animation contains:                                                      │
    │    - label: Display name for the animation                                    │
    │    - player: Animation data for the requesting player                         │
    │    - target: Animation data for the accepting player                          │
    │    - nededBeds/nededChair: Optional prop requirements with offsets            │
    │                                                                                │
    │  Position Offsets (posX, posY, posZ):                                         │
    │    - posX: Right/Left positioning                                             │
    │    - posY: Forward/Back positioning                                           │
    │    - posZ: Up/Down positioning                                                │
    │                                                                                │
    │  Rotation Values (rotX, rotY, rotZ):                                          │
    │    - rotX: Pitch rotation                                                     │
    │    - rotY: Roll rotation                                                      │
    │    - rotZ: Yaw rotation (heading)                                             │
    │                                                                                │
    └──────────────────────────────────────────────────────────────────────────────┘
]]
Config.Animations = {
    ["standart"] = {
        label = "Standing Doggy",
        player = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_att",
            flag = 1,
            posX = 0.0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = -15.0,
        },
        target = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_vtm",
            flag = 1,
            posX = 0,
            posY = 0.22,
            posZ = 0.1,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
    },
    ["cowgirl"] = {
        label = "Cowgirl",
        nededBeds = {
            posX = -0.06, --- RIGHT LEFT
            posY = 0.05, --- FORWARD BACK 
            posZ = 0.10,
            rotX = 0,
            rotY = 0,
            rotZ = 170.0,
        },
        player = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_female",
            flag = 1,
            posX = 0.06, --- RIGHT LEFT
            posY = -0.05, --- FORWARD BACK 
            posZ = 0.10,
            rotX = 0,
            rotY = 0,
            rotZ = 170.0,
        },
    },
    ["cowgirl2"] = {
        label = "Reverse Cowgirl",
        nededBeds = {
            posX = 0.10,
            posY = -0.25,
            posZ = 0.10,
            rotX = 0,
            rotY = 0,
            rotZ = -10.0,
        },
        player = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_female",
            flag = 1,
            posX = -0.10,
            posY = 0.25,
            posZ = 0.10,
            rotX = 0,
            rotY = 0,
            rotZ = -10.0,
        },
    },
    ["facesitting"] = {
        label = "Face Sitting",
        nededBeds = {
            posX = 0.23, ---- RIGHT LEFT
            posY = 0.38, --- FORWARD BACK
            posZ = 0.18,
            rotX = 0,
            rotY = 0,
            rotZ = -10.0,
        },
        player = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_female",
            flag = 1,
            posX = -0.23, ---- RIGHT LEFT
            posY = -0.38, --- FORWARD BACK
            posZ = 0.18,
            rotX = 0,
            rotY = 0,
            rotZ = -10.0,
        },
    },
    ["kiss"] = {
        label = "Kiss",
        player = {
            dict = "cnv_camp@rchso@cnv@ccsnk_par_cnv2",
            anim = "sean_base_outro",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "cnv_camp@rchso@cnv@ccsnk_par_cnv2",
            anim = "karen_base_outro",
            flag = 1,
            posX = 0.05, ---- RIGHT LEFT
            posY = 0.40, --- FORWARD BACK
            posZ = 0.0,
            rotX = 0,
            rotY = 0,
            rotZ = 140.0,
        },
    },
    ["couplesit"] = {
        label = "Sit Couple",
        nededChair = {
            posX = 0.13, ----RIGHT LEFT
            posY = -0.30, --- FORWARD BACK
            posZ = 0.10,
            rotX = 0,
            rotY = 0,
            rotZ = -90.0,
        },
        player = {
            dict = "script_hideout@six_point_cabin@couple",
            anim = "base_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_hideout@six_point_cabin@couple",
            anim = "base_female",
            flag = 1,
            posX = -0.13, ---- RIGHT LEFT
            posY = 0.30, --- FORWARD BACK
            posZ = 0.10,
            rotX = 0,
            rotY = 0,
            rotZ = -90.0,
        },
    },
    ["sitsex"] = {
        label = "Sit Sex",
        nededChair = {
            posX = -0.07, --- RIGHT LEFT
            posY = -0.35, --- FORWARD BACK
            posZ = 0.50,
            rotX = 20.0,
            rotY = 0,
            rotZ = 180.0,
        },
        player = {
            dict = "script_hideout@six_point_cabin@couple",
            anim = "base_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_female",
            flag = 1,
            posX = 0.07, --- RIGHT LEFT
            posY = 0.35, --- FORWARD BACK 
            posZ = 0.50,
            rotX = 20.0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    ["spank"] = {
        label = "Spank",
        player = {
            dict = "script_re@peep_tom@spanking_cowboy",
            anim = "spanking_idle_female",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_re@peep_tom@spanking_cowboy",
            anim = "spanking_idle_cowboy",
            flag = 1,
            posX = -0.43, --- RIGHT LEFT
            posY = 0.60, --- FORWARD BACK 
            posZ = 0.09,
            rotX = 0.0,
            rotY = 0,
            rotZ = 90.0,
        },
    },
    ["missionary"] = {
        label = "Missionary",
        nededBeds = {
            posX = 0.0,
            posY = 0.0,
            posZ = 0.15,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        player = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_female",
            flag = 1,
            posX = 0.0,
            posY = 0.0,
            posZ = 0.15,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    ["blowjob"] = {
        label = "BJ Standing",
        player = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_att",
            flag = 1,
            posX = 0.0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        target = {
            dict = "script_re@poker@pickup_card",
            anim = "pickup_card_player",
            flag = 1,
            posX = 0,
            posY = 0.45,
            posZ = -0.5,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    ["blowjob_kneel"] = {
        label = "BJ Kneeling",
        player = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_att",
            flag = 1,
            posX = 0.0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        target = {
            dict = "amb_camp@world_camp_interact_fireplace@kneel@male_a@idle_a",
            anim = "idle_a",
            flag = 1,
            posX = 0,
            posY = 0.5,
            posZ = 0.0,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    ["sixtynine"] = {
        label = "69 Position",
        nededBeds = {
            posX = 0.0,
            posY = 0.0,
            posZ = 0.15,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        player = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_female",
            flag = 1,
            posX = 0.0,
            posY = 0.0,
            posZ = 0.20,
            rotX = 180,
            rotY = 0,
            rotZ = 0.0,
        },
    },
    ["handjob"] = {
        label = "Handjob",
        nededChair = {
            posX = 0.0,
            posY = 0.0,
            posZ = 0.10,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        player = {
            dict = "script_hideout@six_point_cabin@couple",
            anim = "base_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_hideout@six_point_cabin@couple",
            anim = "base_female",
            flag = 1,
            posX = -0.15,
            posY = 0.25,
            posZ = 0.10,
            rotX = 0,
            rotY = 0,
            rotZ = -90.0,
        },
    },
    ["dance_grind"] = {
        label = "Dance Grind",
        player = {
            dict = "script_re@duel@wheel_back",
            anim = "wheel_back_01",
            flag = 1,
            posX = 0.0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        target = {
            dict = "script_re@duel@wheel_back",
            anim = "wheel_back_01",
            flag = 1,
            posX = 0,
            posY = 0.3,
            posZ = 0.0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
    },
    ["lapdance"] = {
        label = "Lap Dance",
        nededChair = {
            posX = 0.0,
            posY = 0.0,
            posZ = 0.10,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        player = {
            dict = "script_hideout@six_point_cabin@couple",
            anim = "base_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_female",
            flag = 1,
            posX = 0.0,
            posY = 0.25,
            posZ = 0.30,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    ["wallsex"] = {
        label = "Wall Sex",
        player = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_att",
            flag = 1,
            posX = 0.0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        target = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_vtm",
            flag = 33,
            posX = 0,
            posY = 0.25,
            posZ = 0.0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
    },
    ["makeout"] = {
        label = "Make Out",
        player = {
            dict = "cnv_camp@rchso@cnv@ccsnk_par_cnv2",
            anim = "sean_base_outro",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "cnv_camp@rchso@cnv@ccsnk_par_cnv2",
            anim = "karen_base_outro",
            flag = 1,
            posX = 0.05,
            posY = 0.40,
            posZ = 0.0,
            rotX = 0,
            rotY = 0,
            rotZ = 140.0,
        },
    },
    ["hug_romantic"] = {
        label = "Romantic Hug",
        player = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_att",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_vtm",
            flag = 1,
            posX = 0,
            posY = 0.30,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    ["bedsex1"] = {
        label = "Bed Sex 1",
        nededBeds = {
            posX = 0.05,
            posY = 0.0,
            posZ = 0.20,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        player = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_female",
            flag = 1,
            posX = -0.05,
            posY = 0.0,
            posZ = 0.20,
            rotX = 0,
            rotY = 0,
            rotZ = 90.0,
        },
    },
    ["bedsex2"] = {
        label = "Bed Sex 2",
        nededBeds = {
            posX = 0.0,
            posY = 0.15,
            posZ = 0.20,
            rotX = 0,
            rotY = 0,
            rotZ = -90.0,
        },
        player = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_female",
            flag = 1,
            posX = 0.0,
            posY = -0.15,
            posZ = 0.20,
            rotX = 0,
            rotY = 0,
            rotZ = -90.0,
        },
    },
    ["stripsex"] = {
        label = "Strip Tease Sex",
        player = {
            dict = "script_hideout@six_point_cabin@couple",
            anim = "base_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_vtm",
            flag = 1,
            posX = 0.0,
            posY = 0.35,
            posZ = 0.0,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    -- Additional Bed-Based Animations
    ["spooning"] = {
        label = "Spooning",
        nededBeds = {
            posX = 0.0,
            posY = 0.0,
            posZ = 0.15,
            rotX = 0,
            rotY = 0,
            rotZ = 90.0,
        },
        player = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_female",
            flag = 1,
            posX = 0.0,
            posY = 0.25,
            posZ = 0.15,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
    },
    ["side_sex"] = {
        label = "Side Sex",
        nededBeds = {
            posX = 0.0,
            posY = 0.0,
            posZ = 0.15,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        player = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 90,
        },
        target = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_female",
            flag = 1,
            posX = 0.20,
            posY = 0.0,
            posZ = 0.15,
            rotX = 0,
            rotY = 0,
            rotZ = -90.0,
        },
    },
    ["cuddling"] = {
        label = "Cuddling in Bed",
        nededBeds = {
            posX = 0.0,
            posY = 0.0,
            posZ = 0.18,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        player = {
            dict = "script_hideout@six_point_cabin@couple",
            anim = "base_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_hideout@six_point_cabin@couple",
            anim = "base_female",
            flag = 1,
            posX = 0.15,
            posY = 0.0,
            posZ = 0.18,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    ["prone_bone"] = {
        label = "Prone Bone",
        nededBeds = {
            posX = 0.0,
            posY = 0.0,
            posZ = 0.20,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        player = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_female",
            flag = 1,
            posX = 0.0,
            posY = 0.0,
            posZ = 0.10,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
    },
    -- Standing Position Variations
    ["standing_behind"] = {
        label = "Standing Behind",
        player = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_att",
            flag = 1,
            posX = 0.0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        target = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_vtm",
            flag = 1,
            posX = 0,
            posY = 0.30,
            posZ = 0.0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
    },
    ["standing_close"] = {
        label = "Standing Close",
        player = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_att",
            flag = 1,
            posX = 0.0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        target = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_vtm",
            flag = 1,
            posX = 0,
            posY = 0.20,
            posZ = 0.0,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    ["lifted_standing"] = {
        label = "Lifted Standing",
        player = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_att",
            flag = 1,
            posX = 0.0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        target = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_vtm",
            flag = 1,
            posX = 0,
            posY = 0.25,
            posZ = 0.3,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    -- Chair/Sitting Variations
    ["chair_ride"] = {
        label = "Chair Ride",
        nededChair = {
            posX = 0.0,
            posY = 0.0,
            posZ = 0.15,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        player = {
            dict = "script_hideout@six_point_cabin@couple",
            anim = "base_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_female",
            flag = 1,
            posX = 0.0,
            posY = 0.20,
            posZ = 0.35,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    ["reverse_chair"] = {
        label = "Reverse Chair",
        nededChair = {
            posX = 0.0,
            posY = 0.0,
            posZ = 0.15,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
        player = {
            dict = "script_hideout@six_point_cabin@couple",
            anim = "base_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_female",
            flag = 1,
            posX = 0.0,
            posY = -0.20,
            posZ = 0.35,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
    },
    ["sitting_bj"] = {
        label = "Sitting BJ",
        nededChair = {
            posX = 0.0,
            posY = 0.0,
            posZ = 0.10,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        player = {
            dict = "script_hideout@six_point_cabin@couple",
            anim = "base_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "amb_camp@world_camp_interact_fireplace@kneel@male_a@idle_a",
            anim = "idle_a",
            flag = 1,
            posX = 0.0,
            posY = 0.45,
            posZ = -0.20,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    -- Oral Variations
    ["laying_oral"] = {
        label = "Laying Oral",
        nededBeds = {
            posX = 0.0,
            posY = 0.0,
            posZ = 0.15,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        player = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_female",
            flag = 1,
            posX = 0.0,
            posY = -0.35,
            posZ = 0.15,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    ["edge_bed_oral"] = {
        label = "Edge Bed Oral",
        nededBeds = {
            posX = 0.0,
            posY = 0.35,
            posZ = 0.15,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        player = {
            dict = "script_story@sal1@ig@sal1_18_lenny_on_lenny",
            anim = "loop_male",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "amb_camp@world_camp_interact_fireplace@kneel@male_a@idle_a",
            anim = "idle_a",
            flag = 1,
            posX = 0.0,
            posY = -0.35,
            posZ = -0.15,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    -- Kissing and Romantic Variations
    ["deep_kiss"] = {
        label = "Deep Kiss",
        player = {
            dict = "cnv_camp@rchso@cnv@ccsnk_par_cnv2",
            anim = "sean_base_outro",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "cnv_camp@rchso@cnv@ccsnk_par_cnv2",
            anim = "karen_base_outro",
            flag = 1,
            posX = 0.03,
            posY = 0.35,
            posZ = 0.0,
            rotX = 0,
            rotY = 0,
            rotZ = 140.0,
        },
    },
    ["neck_kiss"] = {
        label = "Neck Kiss",
        player = {
            dict = "cnv_camp@rchso@cnv@ccsnk_par_cnv2",
            anim = "sean_base_outro",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "cnv_camp@rchso@cnv@ccsnk_par_cnv2",
            anim = "karen_base_outro",
            flag = 1,
            posX = 0.0,
            posY = 0.30,
            posZ = 0.0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
    },
    ["passionate_embrace"] = {
        label = "Passionate Embrace",
        player = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_att",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_vtm",
            flag = 1,
            posX = 0,
            posY = 0.25,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    -- Grinding and Teasing
    ["standing_grind"] = {
        label = "Standing Grind",
        player = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_att",
            flag = 1,
            posX = 0.0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        target = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_vtm",
            flag = 1,
            posX = 0,
            posY = 0.28,
            posZ = 0.0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
    },
    ["wall_grind"] = {
        label = "Wall Grind",
        player = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_att",
            flag = 1,
            posX = 0.0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        target = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_vtm",
            flag = 33,
            posX = 0,
            posY = 0.22,
            posZ = 0.0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
    },
    ["tease_dance"] = {
        label = "Tease Dance",
        player = {
            dict = "script_re@duel@wheel_back",
            anim = "wheel_back_01",
            flag = 1,
            posX = 0.0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        target = {
            dict = "script_re@duel@wheel_back",
            anim = "wheel_back_01",
            flag = 1,
            posX = 0,
            posY = 0.35,
            posZ = 0.0,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    -- Spanking Variations
    ["spank_standing"] = {
        label = "Spank Standing",
        player = {
            dict = "script_re@peep_tom@spanking_cowboy",
            anim = "spanking_idle_female",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_re@peep_tom@spanking_cowboy",
            anim = "spanking_idle_cowboy",
            flag = 1,
            posX = -0.40,
            posY = 0.55,
            posZ = 0.05,
            rotX = 0.0,
            rotY = 0,
            rotZ = 90.0,
        },
    },
    ["spank_bent"] = {
        label = "Spank Bent Over",
        player = {
            dict = "script_re@peep_tom@spanking_cowboy",
            anim = "spanking_idle_female",
            flag = 1,
            posX = 0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_re@peep_tom@spanking_cowboy",
            anim = "spanking_idle_cowboy",
            flag = 1,
            posX = -0.45,
            posY = 0.65,
            posZ = 0.10,
            rotX = 0.0,
            rotY = 0,
            rotZ = 85.0,
        },
    },
    -- Additional Creative Positions
    ["table_sex"] = {
        label = "Table Sex",
        player = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_att",
            flag = 1,
            posX = 0.0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        target = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_vtm",
            flag = 1,
            posX = 0,
            posY = 0.25,
            posZ = 0.5,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
    ["counter_sex"] = {
        label = "Counter Sex",
        player = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_att",
            flag = 1,
            posX = 0.0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        target = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_vtm",
            flag = 1,
            posX = 0,
            posY = 0.20,
            posZ = 0.45,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
    },
    ["against_wall_2"] = {
        label = "Against Wall 2",
        player = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_att",
            flag = 1,
            posX = 0.0,
            posY = 0,
            posZ = 0,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
        target = {
            dict = "script_story@mud3@ig@ig_1_throw_whore",
            anim = "base_vtm",
            flag = 33,
            posX = 0,
            posY = 0.28,
            posZ = 0.05,
            rotX = 0,
            rotY = 0,
            rotZ = 0.0,
        },
    },
}


-- Decline/Rejection Punishment Animations
-- These play when someone declines a request, punishing the requester
Config.DeclineAnimations = {
    ["slap"] = {
        label = "Slap in Face",
        attacker = {
            dict = "script_re@duel@wheel_back",
            anim = "wheel_back_01",
            flag = 0,
            duration = 2000,
        },
        victim = {
            dict = "script_story@bea1@bea1_02_0_aftermath@aftermath_01_aint_right",
            anim = "bill_impact_01",
            flag = 1,
            duration = 2500,
        },
        positioning = {
            distance = 0.5, -- How close the attacker gets to victim
            rotation = 180.0, -- Attacker faces victim
        },
    },
    ["kick_balls"] = {
        label = "Kick in Balls",
        attacker = {
            dict = "script_re@duel@wheel_back",
            anim = "wheel_back_01",
            flag = 0,
            duration = 2000,
        },
        victim = {
            dict = "script_story@mud1@ig@ig_3_find_whore",
            anim = "dutch_kick_ground_reaction",
            flag = 1,
            duration = 3500,
        },
        positioning = {
            distance = 0.6,
            rotation = 180.0,
        },
    },
    ["punch"] = {
        label = "Punch Face",
        attacker = {
            dict = "script_re@duel@wheel_back",
            anim = "wheel_back_01",
            flag = 0,
            duration = 1800,
        },
        victim = {
            dict = "script_story@bea1@bea1_02_0_aftermath@aftermath_01_aint_right",
            anim = "bill_impact_01",
            flag = 1,
            duration = 2500,
        },
        positioning = {
            distance = 0.5,
            rotation = 180.0,
        },
    },
    ["shove"] = {
        label = "Shove Away",
        attacker = {
            dict = "script_re@duel@wheel_back",
            anim = "wheel_back_01",
            flag = 0,
            duration = 1500,
        },
        victim = {
            dict = "script_story@bea1@bea1_02_0_aftermath@aftermath_01_aint_right",
            anim = "bill_impact_01",
            flag = 1,
            duration = 2000,
        },
        positioning = {
            distance = 0.4,
            rotation = 180.0,
        },
    },
    ["bottle_hit"] = {
        label = "Bottle Hit",
        attacker = {
            dict = "script_re@duel@wheel_back",
            anim = "wheel_back_01",
            flag = 0,
            duration = 2000,
        },
        victim = {
            dict = "script_story@mud1@ig@ig_3_find_whore",
            anim = "dutch_kick_ground_reaction",
            flag = 1,
            duration = 3000,
        },
        positioning = {
            distance = 0.5,
            rotation = 180.0,
        },
    },
    ["spit"] = {
        label = "Spit on Face",
        attacker = {
            dict = "script_re@duel@wheel_back",
            anim = "wheel_back_01",
            flag = 0,
            duration = 2000,
        },
        victim = {
            dict = "script_story@bea1@bea1_02_0_aftermath@aftermath_01_aint_right",
            anim = "bill_impact_01",
            flag = 1,
            duration = 2000,
        },
        positioning = {
            distance = 0.8,
            rotation = 180.0,
        },
    },
}

--[[
    ┌──────────────────────────────────────────────────────────────────────────────┐
    │                          BED PROPS LIST                                       │
    │  All recognized bed props that can be used for bed-required animations        │
    └──────────────────────────────────────────────────────────────────────────────┘
]]
Config.Beds = {
    "p_bedsleptinold04x",
    "p_cs_bedsleptinbed08x",
    "p_bedsleptin01x",
    "p_gen_bedsleptin01x_tc01",
}

--[[
    ┌──────────────────────────────────────────────────────────────────────────────┐
    │                        CHAIR PROPS LIST                                       │
    │  All recognized chair/bench/couch props for sitting animations                │
    └──────────────────────────────────────────────────────────────────────────────┘
]]
Config.ChairList = {
    "P_CHAIRCOMFY04X",
    "P_CHAIR14X",
    "P_SIT_CHAIRWICKER01B",
    "P_SIT_CHAIRWICKER01A",
    "S_CRATESEAT03X",
    "P_CHAIRWICKER01X",
    "P_CHAIRROCKING06X",
    "P_WINDSORCHAIR03X",
    "P_CHAIR13X",
    "P_CHAIR12X",
    "p_bistrochair01x",
    "p_bistrochair02x",
    "P_CHAIRFOLDING02X",
    "P_CHAIR06X",
    "P_CHAIR22X",
    "P_WOODENCHAIR01X",
    "P_DININGCHAIRS01X",
    "P_WINDSORCHAIR02X",
    "P_LOVESEAT01X",
    "P_BENCH06X",
    "P_BENCH17X",
    "P_COUCH05X",
    "P_COUCH08X",
    "P_BENCH_LOG07X",
    "P_WINDSORBENCH01X",
    "P_BENCH15X",
    "p_seatbench01x",
    "p_chairdesk01x",
    "p_chairdesk02x",
    "p_couch02x",
    "p_woodendeskchair01x",
    "p_chair05x",
    "p_chairrusticsav01x",
    "p_chaircomfy11x",
    "p_medwheelchair01x",
    "p_chairdoctor01x",
    "p_ambchair01x",
    "mp005_s_posse_trad_chair01x",
    "p_chairoffice02x",
    "p_chair_barrel04b",
    "p_chairrustic05x",
    "p_chairrocking03x",
    "p_chaircomfy17x",
    "p_chair07x",
    "p_chaircomfy23x",
    "p_chair37x",
    "p_chaircomfy12x",
    "p_chestchair01x",
    "p_chairdining01x",
    "p_chaircomfy09x",
    "p_chairrustic03x",
    "mp005_s_posse_foldingchair_01x",
    "p_theaterchair01b01x",
    "p_chair04x",
    "p_cs_electricchair01x",
    "s_bfchair04x",
    "p_chair_crate15x",
    "p_chaircomfycombo01x",
    "p_rockingchair01x",
    "p_chairwicker03x",
    "p_chaircomfy01x",
    "p_chair20x",
    "p_chairdining03x",
    "p_chairrustic02x",
    "p_chaircomfy07x",
    "s_chair04x",
    "p_chairrocking02x",
    "p_chaircomfy02",
    "p_chair_privatedining01x",
    "p_chairtall01x",
    "p_chair30x",
    "p_chairpokerfancy01x",
    "p_chaircomfy14x",
    "p_privatelounge_chair01x",
    "p_gen_chair07x",
    "p_oldarmchair01x",
    "p_chaircomfy22x",
    "p_chairrocking04x",
    "p_chair15x",
    "p_ambchair02x",
    "p_chairsalon01x",
    "p_chair_10x",
    "p_chairmed01x",
    "p_chair12bx",
    "p_chaircomfy06x",
    "p_chair18x",
    "p_chair02x",
    "p_chaircomfy03x",
    "p_chair21x",
    "p_rockingchair02x",
    "p_armchair01x",
    "p_chair38x",
    "p_chairmed02x",
    "p_chair27x",
    "p_chair23x",
    "s_electricchair01x",
    "p_chair11x",
    "p_couch10x",
    "p_chairdining02x",
    "p_chairporch01x",
    "p_rockingchair03x",
    "p_chair31x",
    "p_chair16x",
    "p_chairdeck01x",
    "p_chaireagle01x",
    "p_loveseat02x",
    "p_seatsnorpass01_x",
    "p_seatsnorpass02_x",
    "p_bench03x",
    "p_benchbear01x",
    "p_bench_log05x",
    "p_benchch01x",
    "p_bench_log06x",
    "p_bench09x",
    "p_benchnbx02x",
    "p_woodbench02x",
    "p_bench20x",
    "p_bench18x",
    "p_bench_log04x",
    "p_benchironnbx01x",
    "p_couch06x",
    "p_bench_log02x",
    "p_chairwhite01x",
    "p_sofa02x",
    "p_chair09x",    
    "p_chaircomfy05x",    
    "p_sofa01x",    
    "p_settee01x",    
    "p_benchlong05x",
}

--[[
    ┌──────────────────────────────────────────────────────────────────────────────┐
    │                          LOCALIZATION                                         │
    │  Multi-language support for all in-game messages and notifications            │
    │  Add new languages by creating a new table with the language code             │
    └──────────────────────────────────────────────────────────────────────────────┘
]]

-- Locales
Config.Locale = {
    ["en"] = {
        -- Request/Response Messages
        ["request_sent"] = "🐺 Animation request sent to player",
        ["request_received"] = "🐺 You received an animation request from ${name}. Type /tlwaccept or /acceptanim to accept, /tlwdecline or /declineanim to decline",
        ["request_accepted"] = "✅ Animation request accepted!",
        ["request_declined"] = "❌ Animation request declined",
        ["request_expired"] = "⏰ Animation request expired",
        ["no_request"] = "❌ You don't have any pending animation requests",
        
        -- Distance/Player Messages
        ["player_too_far"] = "❌ Player is too far away",
        ["no_player_nearby"] = "❌ No player nearby",
        ["invalid_player"] = "❌ Invalid player",
        
        -- Animation Status Messages
        ["animation_stopped"] = "🛑 Animation stopped",
        ["animation_started"] = "▶️ Animation started",
        ["already_in_animation"] = "❌ You or the other player is already in an animation",
        
        -- Requirement Messages
        ["need_bed"] = "🛏️ This animation requires a bed nearby",
        ["need_chair"] = "💺 This animation requires a chair nearby",
        
        -- Menu Options
        ["select_animation"] = "Select Animation",
        ["close_menu"] = "Close Menu",
        
        -- Punishment Messages
        ["got_punished"] = "💥 You got what you deserved!",
        ["taught_lesson"] = "💪 Taught them a lesson!",
    }
}
