--[[
    ████████╗██╗     ██╗    ██╗     █████╗ ███╗   ██╗██╗███╗   ███╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
    ╚══██╔══╝██║     ██║    ██║    ██╔══██╗████╗  ██║██║████╗ ████║██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
       ██║   ██║     ██║ █╗ ██║    ███████║██╔██╗ ██║██║██╔████╔██║███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
       ██║   ██║     ██║███╗██║    ██╔══██║██║╚██╗██║██║██║╚██╔╝██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
       ██║   ███████╗╚███╔███╔╝    ██║  ██║██║ ╚████║██║██║ ╚═╝ ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
       ╚═╝   ╚══════╝ ╚══╝╚══╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
                                                                                                                     
    🐺 The Land of Wolves - Custom Animations
    Server-Side Coordinator - Request Management & Framework Integration
    
    Version: 1.0.0
    Author: iBoss
    Website: www.wolves.land
    
    This module handles all server-side coordination:
    - Animation request routing between players
    - Accept/decline logic with randomization
    - Punishment animation selection and triggering
    - Framework integration (RSG-Core, LXR-Core, VORP)
    - Active animation state tracking
    - Player disconnect cleanup
    - Admin commands for server management
    - Permission-based access control
    
    © 2026 iBoss | The Land of Wolves | www.wolves.land
]]
local activeAnimations = {}
local pendingRequests = {}

-- Framework detection and initialization
local Framework = nil

Citizen.CreateThread(function()
    if Config.Framework == "RSG" then
        Framework = exports['rsg-core']:GetCoreObject()
    elseif Config.Framework == "LXR" then
        Framework = exports['lxr-core']:GetCoreObject()
    end
end)

-- Function to get player name
function GetPlayerName(source)
    if Config.Framework == "RSG" then
        local Player = Framework.Functions.GetPlayer(source)
        if Player then
            return Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
        end
    elseif Config.Framework == "LXR" then
        local Player = Framework.Functions.GetPlayer(source)
        if Player then
            return Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
        end
    end
    return GetPlayerName(source) or "Unknown"
end

-- Function to check if player is in animation
function IsPlayerInAnimation(source)
    return activeAnimations[source] ~= nil
end

-- Event: Player requests animation from another player
RegisterNetEvent('tlw_animations:requestAnimation', function(targetId, animationKey)
    local source = source
    
    -- Validate animation exists
    if not Config.Animations[animationKey] then
        return
    end
    
    -- Check if players are valid
    if not targetId or targetId == source then
        Notify({text = Locale("invalid_player"), type = "error", source = source})
        return
    end
    
    -- Check if either player is already in animation
    if IsPlayerInAnimation(source) or IsPlayerInAnimation(targetId) then
        Notify({text = Locale("already_in_animation"), type = "error", source = source})
        return
    end
    
    -- Store pending request
    local requestId = source .. "_" .. targetId .. "_" .. os.time()
    pendingRequests[targetId] = {
        from = source,
        animation = animationKey,
        requestId = requestId,
        timestamp = os.time()
    }
    
    -- Send request to target player
    local playerName = GetPlayerName(source)
    TriggerClientEvent('tlw_animations:receiveRequest', targetId, source, animationKey, playerName)
    
    -- Auto-cleanup after timeout
    Citizen.SetTimeout(Config.RequestTimeout, function()
        if pendingRequests[targetId] and pendingRequests[targetId].requestId == requestId then
            pendingRequests[targetId] = nil
        end
    end)
end)

-- Event: Target player accepts the animation request
RegisterNetEvent('tlw_animations:acceptRequest', function(fromPlayerId, animationKey)
    local source = source
    
    -- Validate request exists
    if not pendingRequests[source] or pendingRequests[source].from ~= fromPlayerId then
        Notify({text = Locale("no_request"), type = "error", source = source})
        return
    end
    
    -- Validate animation
    if not Config.Animations[animationKey] then
        return
    end
    
    -- Check if either player is already in animation
    if IsPlayerInAnimation(source) or IsPlayerInAnimation(fromPlayerId) then
        Notify({text = Locale("already_in_animation"), type = "error", source = source})
        return
    end
    
    -- Clear pending request
    pendingRequests[source] = nil
    
    -- Mark players as in animation
    activeAnimations[fromPlayerId] = {
        partner = source,
        animation = animationKey,
        isInitiator = true
    }
    
    activeAnimations[source] = {
        partner = fromPlayerId,
        animation = animationKey,
        isInitiator = false
    }
    
    -- Notify both players to start animation
    TriggerClientEvent('tlw_animations:startAnimation', fromPlayerId, animationKey, true, source)
    TriggerClientEvent('tlw_animations:startAnimation', source, animationKey, false, fromPlayerId)
    
    -- Send acceptance notification to initiator
    Notify({text = Locale("request_accepted"), type = "success", source = fromPlayerId})
end)

-- Event: Target player declines the animation request
RegisterNetEvent('tlw_animations:declineRequest', function(fromPlayerId, selectedPunishment)
    local source = source
    
    -- Validate request exists
    if not pendingRequests[source] or pendingRequests[source].from ~= fromPlayerId then
        return
    end
    
    -- Clear pending request
    pendingRequests[source] = nil
    
    -- Check if player selected a punishment
    if selectedPunishment and Config.DeclineAnimations[selectedPunishment] then
        -- Apply selected punishment
        TriggerClientEvent('tlw_animations:startPunishment', source, selectedPunishment, fromPlayerId)
        TriggerClientEvent('tlw_animations:receivePunishment', fromPlayerId, selectedPunishment, source)
        
        -- Notify both players
        Notify({text = Locale("taught_lesson"), type = "success", source = source})
        Notify({text = Locale("got_punished"), type = "error", source = fromPlayerId})
        return
    end
    
    -- Check if random punishment should be applied (legacy behavior)
    local shouldApplyRandomPunishment = selectedPunishment == nil 
        and Config.DeclineWithPunishment 
        and math.random(100) <= Config.PunishmentChance
    
    if shouldApplyRandomPunishment then
        -- Select random punishment animation
        local punishments = {}
        for key, _ in pairs(Config.DeclineAnimations) do
            table.insert(punishments, key)
        end
        
        if #punishments > 0 then
            local randomPunishment = punishments[math.random(#punishments)]
            
            -- Trigger punishment animation
            TriggerClientEvent('tlw_animations:startPunishment', source, randomPunishment, fromPlayerId)
            TriggerClientEvent('tlw_animations:receivePunishment', fromPlayerId, randomPunishment, source)
            
            -- Notify both players
            Notify({text = Locale("taught_lesson"), type = "success", source = source})
            Notify({text = Locale("got_punished"), type = "error", source = fromPlayerId})
            return
        end
    end
    
    -- No punishment, just notify
    TriggerClientEvent('tlw_animations:requestDeclined', fromPlayerId)
    Notify({text = Locale("request_declined"), type = "info", source = fromPlayerId})
end)

-- Event: Player stops animation
RegisterNetEvent('tlw_animations:stopAnimation', function()
    local source = source
    
    if activeAnimations[source] then
        local partnerId = activeAnimations[source].partner
        
        -- Remove from active animations
        activeAnimations[source] = nil
        
        -- Notify partner and stop their animation too
        if partnerId and activeAnimations[partnerId] then
            activeAnimations[partnerId] = nil
            TriggerClientEvent('tlw_animations:partnerStopped', partnerId)
        end
    end
end)

-- Cleanup on player disconnect
AddEventHandler('playerDropped', function()
    local source = source
    
    -- Clean up pending requests
    if pendingRequests[source] then
        pendingRequests[source] = nil
    end
    
    -- Clean up active animations
    if activeAnimations[source] then
        local partnerId = activeAnimations[source].partner
        activeAnimations[source] = nil
        
        -- Notify partner
        if partnerId and activeAnimations[partnerId] then
            activeAnimations[partnerId] = nil
            TriggerClientEvent('tlw_animations:partnerStopped', partnerId)
        end
    end
    
    -- Check if this player was mentioned in any pending request
    for targetId, request in pairs(pendingRequests) do
        if request.from == source then
            pendingRequests[targetId] = nil
        end
    end
end)

-- Admin command to force stop all animations (config-based)
RegisterCommand(Config.Commands.stopAllAnimations.name, function(source, args)
    -- Add permission check here if needed
    if source == 0 or IsPlayerAceAllowed(source, Config.Commands.stopAllAnimations.permission) then
        local count = 0
        for playerId, _ in pairs(activeAnimations) do
            TriggerClientEvent('tlw_animations:partnerStopped', playerId)
            count = count + 1
        end
        activeAnimations = {}
        print("^2[TLW Animations]^7 Stopped " .. count .. " active animations")
    else
        print("^3[TLW Animations]^7 Insufficient permissions for this command")
    end
end, true)

-- Periodic cleanup of old pending requests (every 5 minutes)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000) -- 5 minutes
        
        local currentTime = os.time()
        for targetId, request in pairs(pendingRequests) do
            if currentTime - request.timestamp > 60 then -- Remove requests older than 1 minute
                pendingRequests[targetId] = nil
            end
        end
    end
end)

print("^2[TLW Custom Animations]^7 Server initialized successfully!")
