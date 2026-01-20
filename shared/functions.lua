--[[
    ████████╗██╗     ██╗    ██╗     █████╗ ███╗   ██╗██╗███╗   ███╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
    ╚══██╔══╝██║     ██║    ██║    ██╔══██╗████╗  ██║██║████╗ ████║██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
       ██║   ██║     ██║ █╗ ██║    ███████║██╔██╗ ██║██║██╔████╔██║███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
       ██║   ██║     ██║███╗██║    ██╔══██║██║╚██╗██║██║██║╚██╔╝██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
       ██║   ███████╗╚███╔███╔╝    ██║  ██║██║ ╚████║██║██║ ╚═╝ ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
       ╚═╝   ╚══════╝ ╚══╝╚══╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
                                                                                                                     
    🐺 The Land of Wolves - Custom Animations
    Shared Utilities - Multi-Framework Support Functions
    
    Version: 1.0.0
    Author: iBoss
    Website: www.wolves.land
    
    This module provides shared utilities used by both client and server:
    - Notify() - Universal notification system supporting multiple frameworks
    - Locale() - Translation function with placeholder support
    - Framework detection and compatibility layer
    - Configurable notification durations and types
    - Clean API for consistent behavior across frameworks
    
    Supported Frameworks:
    - RSG-Core (ox_lib notifications)
    - LXR-Core (redem_roleplay notifications)
    - VORP (vorp notifications)
    
    © 2026 iBoss | The Land of Wolves | www.wolves.land
]]

-- Shared utility functions

function Notify(data)
    local text = data.text or "No message" 
    local time = data.time or Config.NotificationSettings.defaultDuration
    local type = data.type or Config.NotificationSettings.defaultType
    local dict = data.dict
    local icon = data.icon
    local color = data.color or 0
    local src = data.source
  
    if IsDuplicityVersion() then
        if Config.Framework == "RSG" then
            text = string.gsub(text, "~.-~", "")
            TriggerClientEvent('ox_lib:notify', src, { title = text, type = type, duration = time })
        elseif Config.Framework == "LXR" then
            text = string.gsub(text, "~.-~", "")
            TriggerClientEvent("redem_roleplay:Tip", src, text, time)
        elseif Config.Framework == "VORP" then
            if icon then
                TriggerClientEvent('vorp:ShowAdvancedRightNotification', src, text, dict, icon, color, time)
            else
                TriggerClientEvent("vorp:TipBottom", src, text, time, type)
            end
        end
    else
        if Config.Framework == "RSG" then
            text = string.gsub(text, "~.-~", "")
            TriggerEvent('ox_lib:notify', { title = text, type = type, duration = time })
        elseif Config.Framework == "LXR" then
            text = string.gsub(text, "~.-~", "")
            TriggerEvent("redem_roleplay:Tip", text, time)
        elseif Config.Framework == "VORP" then
            if icon then
                TriggerEvent("vorp:ShowAdvancedRightNotification", text, dict, icon, color, time)
            else
                TriggerEvent("vorp:TipBottom", text, time, type)
            end
        end
    end
end

function Locale(key, subs)
    local translate = Config.Locale[Config.Language][key] and Config.Locale[Config.Language][key] or "Config.Locale["..Config.Language.."]["..key.."] doesn't exist"
    subs = subs and subs or {}
    for k, v in pairs(subs) do
        local templateToFind = '%${' .. k .. '}'
        translate = translate:gsub(templateToFind, tostring(v))
    end
    return tostring(translate)
end
