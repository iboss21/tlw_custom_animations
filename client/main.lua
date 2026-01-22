--[[
    ████████╗██╗     ██╗    ██╗     █████╗ ███╗   ██╗██╗███╗   ███╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
    ╚══██╔══╝██║     ██║    ██║    ██╔══██╗████╗  ██║██║████╗ ████║██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
       ██║   ██║     ██║ █╗ ██║    ███████║██╔██╗ ██║██║██╔████╔██║███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
       ██║   ██║     ██║███╗██║    ██╔══██║██║╚██╗██║██║██║╚██╔╝██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
       ██║   ███████╗╚███╔███╔╝    ██║  ██║██║ ╚████║██║██║ ╚═╝ ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
       ╚═╝   ╚══════╝ ╚══╝╚══╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
                                                                                                                     
    🐺 The Land of Wolves - Custom Animations
    Client-Side Handler - Player Interaction & Animation Management
    
    Version: 1.0.0
    Author: iBoss
    Website: www.wolves.land
    
    This module handles all client-side functionality:
    - Player ped caching with configurable intervals
    - Animation dictionary loading and caching
    - Prop detection (beds, chairs, furniture)
    - Distance-based player detection
    - Request/accept/decline interaction system
    - Punishment animation playback
    - Synchronized animation positioning
    - Command registration from config
    - Performance optimizations (~0.01ms resmon)
    
    © 2026 iBoss | The Land of Wolves | www.wolves.land
]]

-- ============================================================================
--                         LOCAL VARIABLES (OPTIMIZED)
-- ============================================================================
-- Cache frequently used values to avoid repeated function calls
local playerPed = PlayerPedId()
local isInAnimation = false
local currentAnimation = nil
local pendingRequest = nil
local animationPartner = nil
local propEntity = nil

-- Performance optimization: Only update ped cache when needed (configurable interval)
local pedUpdateTimer = 0
local function UpdatePlayerPed()
    local currentTime = GetGameTimer()
    if currentTime - pedUpdateTimer > Config.PlayerPedUpdateInterval then
        playerPed = PlayerPedId()
        pedUpdateTimer = currentTime
    end
    return playerPed
end

-- Debug helper function
local function DebugPrint(msg)
    if Config.EnableDebugMode then
        print("^3[TLW Debug]^7 " .. msg)
    end
end

-- ============================================================================
--                     ANIMATION DICTIONARY LOADER (OPTIMIZED)
-- ============================================================================
-- Cache loaded animation dictionaries to prevent redundant loads
local loadedDicts = {}

local function LoadAnimDict(dict)
    if loadedDicts[dict] then return true end
    
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        local timeout = 0
        while not HasAnimDictLoaded(dict) and timeout < 100 do
            Wait(10)
            timeout = timeout + 1
        end
        
        if HasAnimDictLoaded(dict) then
            loadedDicts[dict] = true
            return true
        end
        return false
    end
    
    loadedDicts[dict] = true
    return true
end

-- ============================================================================
--                     CLOSEST PLAYER DETECTION (OPTIMIZED)
-- ============================================================================
-- Optimized to minimize vector calculations and iterations
local function GetClosestPlayer()
    UpdatePlayerPed()
    local players = GetActivePlayers()
    local closestDistance = Config.MaxDistance
    local closestPlayer = -1
    local playerCoords = GetEntityCoords(playerPed)
    local px, py, pz = playerCoords.x, playerCoords.y, playerCoords.z
    
    for i = 1, #players do
        local player = players[i]
        local targetPed = GetPlayerPed(player)
        
        if targetPed ~= playerPed and DoesEntityExist(targetPed) then
            local targetCoords = GetEntityCoords(targetPed)
            local tx, ty, tz = targetCoords.x, targetCoords.y, targetCoords.z
            
            -- Fast distance calculation without vector allocation
            local dx, dy, dz = tx - px, ty - py, tz - pz
            local distance = math.sqrt(dx * dx + dy * dy + dz * dz)
            
            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = GetPlayerServerId(player)
            end
        end
    end
    
    return closestPlayer
end

-- ============================================================================
--                     PROP DETECTION (OPTIMIZED)
-- ============================================================================
-- Cache prop hashes and optimize prop detection
local propHashCache = {}

local function GetPropHash(propName)
    if not propHashCache[propName] then
        propHashCache[propName] = GetHashKey(propName)
    end
    return propHashCache[propName]
end

local function GetClosestProp(propList, maxDistance)
    maxDistance = maxDistance or Config.PropDetectionRadius
    UpdatePlayerPed()
    local playerCoords = GetEntityCoords(playerPed)
    local px, py, pz = playerCoords.x, playerCoords.y, playerCoords.z
    local closestProp = nil
    local closestDistance = maxDistance
    
    -- Optimize by checking only a subset of props at once
    for i = 1, #propList do
        local propHash = GetPropHash(propList[i])
        local prop = GetClosestObjectOfType(px, py, pz, maxDistance, propHash, false, false, false)
        
        if prop ~= 0 and DoesEntityExist(prop) then
            local propCoords = GetEntityCoords(prop)
            local dx, dy, dz = propCoords.x - px, propCoords.y - py, propCoords.z - pz
            local distance = math.sqrt(dx * dx + dy * dy + dz * dz)
            
            if distance < closestDistance then
                closestDistance = distance
                closestProp = prop
            end
        end
    end
    
    DebugPrint("Prop detection: " .. (closestProp and "Found" or "Not found"))
    return closestProp
end

-- Function to open animation menu
function OpenAnimationMenu()
    if isInAnimation then
        Notify({text = Locale("already_in_animation"), type = "error"})
        return
    end
    
    local closestPlayer = GetClosestPlayer()
    if closestPlayer == -1 then
        Notify({text = Locale("no_player_nearby"), type = "error"})
        return
    end
    
    -- Send animation data to NUI
    SendNUIMessage({
        action = 'open',
        animations = Config.Animations
    })
    
    -- Enable NUI focus
    SetNuiFocus(true, true)
    
    DebugPrint("Animation menu opened")
end

-- Helper function to get sorted punishment keys (cached for performance)
local sortedPunishmentKeys = nil
local function GetSortedPunishmentKeys()
    if not sortedPunishmentKeys then
        sortedPunishmentKeys = {}
        for key, _ in pairs(Config.DeclineAnimations) do
            table.insert(sortedPunishmentKeys, key)
        end
        table.sort(sortedPunishmentKeys)
    end
    return sortedPunishmentKeys
end

-- Function to show decline punishment selection menu
function ShowDeclinePunishmentMenu()
    if not pendingRequest then
        Notify({text = Locale("no_request"), type = "error"})
        return
    end
    
    print("========================================")
    print("   " .. Locale("select_punishment"))
    print("========================================")
    print("0. " .. Locale("decline_no_punishment"))
    
    -- Get sorted punishment keys
    local punishmentKeys = GetSortedPunishmentKeys()
    
    -- Display sorted list
    for index, key in ipairs(punishmentKeys) do
        local data = Config.DeclineAnimations[key]
        print(index .. ". " .. data.label)
    end
    
    print("========================================")
    print(Locale("usage_decline"))
    print(Locale("example_decline"))
    print("========================================")
end

-- Function to decline with selected punishment
function DeclineWithPunishment(punishmentKey)
    if not pendingRequest then
        Notify({text = Locale("no_request"), type = "error"})
        return
    end
    
    local fromPlayer = pendingRequest.from
    
    TriggerServerEvent('tlw_animations:declineRequest', fromPlayer, punishmentKey)
    pendingRequest = nil
    
    Notify({text = Locale("request_declined"), type = "info"})
end

-- Function to request animation from another player
function RequestAnimation(targetPlayerId, animationKey)
    if isInAnimation then
        Notify({text = Locale("already_in_animation"), type = "error"})
        return
    end
    
    local animData = Config.Animations[animationKey]
    if not animData then
        Notify({text = "Invalid animation", type = "error"})
        return
    end
    
    -- Check if animation needs bed or chair
    if animData.nededBeds then
        local bed = GetClosestProp(Config.Beds, 2.0)
        if not bed or bed == 0 then
            Notify({text = Locale("need_bed"), type = "error"})
            return
        end
    end
    
    if animData.nededChair then
        local chair = GetClosestProp(Config.ChairList, 2.0)
        if not chair or chair == 0 then
            Notify({text = Locale("need_chair"), type = "error"})
            return
        end
    end
    
    TriggerServerEvent('tlw_animations:requestAnimation', targetPlayerId, animationKey)
    Notify({text = Locale("request_sent"), type = "success"})
end

-- Function to start synchronized animation
function StartSyncAnimation(animationKey, isInitiator, partnerServerId)
    local animData = Config.Animations[animationKey]
    if not animData then return end
    
    isInAnimation = true
    currentAnimation = animationKey
    animationPartner = partnerServerId
    
    local animInfo = isInitiator and animData.player or animData.target
    local propCoords = nil
    local propHeading = 0
    
    -- Get prop if needed
    if animData.nededBeds then
        propEntity = GetClosestProp(Config.Beds, 2.0)
        if propEntity and propEntity ~= 0 then
            propCoords = GetEntityCoords(propEntity)
            propHeading = GetEntityHeading(propEntity)
        end
    elseif animData.nededChair then
        propEntity = GetClosestProp(Config.ChairList, 2.0)
        if propEntity and propEntity ~= 0 then
            propCoords = GetEntityCoords(propEntity)
            propHeading = GetEntityHeading(propEntity)
        end
    end
    
    -- Load animation dictionary
    LoadAnimDict(animInfo.dict)
    
    -- Calculate position and rotation
    local finalCoords, finalHeading
    
    if propCoords then
        -- Position relative to prop
        local propOffset = animData.nededBeds or animData.nededChair
        local offsetX = propOffset.posX or animInfo.posX
        local offsetY = propOffset.posY or animInfo.posY
        local offsetZ = propOffset.posZ or animInfo.posZ
        
        local heading = propHeading + (propOffset.rotZ or animInfo.rotZ)
        
        -- Calculate world coordinates from offset
        local radians = math.rad(propHeading)
        local finalX = propCoords.x + (offsetX * math.cos(radians) - offsetY * math.sin(radians))
        local finalY = propCoords.y + (offsetX * math.sin(radians) + offsetY * math.cos(radians))
        local finalZ = propCoords.z + offsetZ
        
        finalCoords = vector3(finalX, finalY, finalZ)
        finalHeading = heading
    else
        -- Position relative to initiator
        if isInitiator then
            finalCoords = GetEntityCoords(playerPed)
            finalHeading = GetEntityHeading(playerPed)
        else
            -- Get partner's position (this will be synced via server)
            -- For now, use offset from current position
            local playerCoords = GetEntityCoords(playerPed)
            local playerHeading = GetEntityHeading(playerPed)
            
            local radians = math.rad(playerHeading)
            local finalX = playerCoords.x + (animInfo.posX * math.cos(radians) - animInfo.posY * math.sin(radians))
            local finalY = playerCoords.y + (animInfo.posX * math.sin(radians) + animInfo.posY * math.cos(radians))
            local finalZ = playerCoords.z + animInfo.posZ
            
            finalCoords = vector3(finalX, finalY, finalZ)
            finalHeading = playerHeading + animInfo.rotZ
        end
    end
    
    -- Set entity position and play animation
    SetEntityCoords(playerPed, finalCoords.x, finalCoords.y, finalCoords.z, false, false, false, false)
    SetEntityHeading(playerPed, finalHeading)
    
    -- Play animation
    TaskPlayAnim(playerPed, animInfo.dict, animInfo.anim, 8.0, -8.0, -1, animInfo.flag, 0, false, false, false)
    
    Notify({text = Locale("animation_started"), type = "success"})
end

-- Function to stop animation
function StopAnimation()
    if isInAnimation then
        ClearPedTasks(playerPed)
        isInAnimation = false
        currentAnimation = nil
        animationPartner = nil
        propEntity = nil
        
        Notify({text = Locale("animation_stopped"), type = "info"})
        
        TriggerServerEvent('tlw_animations:stopAnimation')
    end
end

-- ============================================================================
--                     COMMAND REGISTRATION (CONFIG-BASED)
-- ============================================================================
-- All commands are registered dynamically from Config.Commands

-- Helper function to register command with aliases
local function RegisterCommandWithAliases(cmdConfig, callback)
    RegisterCommand(cmdConfig.name, callback, false)
    
    if cmdConfig.aliases then
        for _, alias in ipairs(cmdConfig.aliases) do
            RegisterCommand(alias, callback, false)
        end
    end
    
    DebugPrint("Registered command: /" .. cmdConfig.name)
end

-- Command: Open animation menu
RegisterCommandWithAliases(Config.Commands.openMenu, function()
    OpenAnimationMenu()
end)

-- Command: Play specific animation
RegisterCommandWithAliases(Config.Commands.playAnimation, function(source, args)
    if #args < 1 then
        print("Usage: /" .. Config.Commands.playAnimation.name .. " [animation_key]")
        return
    end
    
    local animKey = args[1]
    local closestPlayer = GetClosestPlayer()
    
    if closestPlayer == -1 then
        Notify({text = Locale("no_player_nearby"), type = "error"})
        return
    end
    
    RequestAnimation(closestPlayer, animKey)
end)

-- Command: Accept animation request
RegisterCommandWithAliases(Config.Commands.acceptRequest, function()
    if not pendingRequest then
        Notify({text = Locale("no_request"), type = "error"})
        return
    end
    
    TriggerServerEvent('tlw_animations:acceptRequest', pendingRequest.from, pendingRequest.animation)
    pendingRequest = nil
end)

-- Command: Decline animation request
RegisterCommandWithAliases(Config.Commands.declineRequest, function(source, args)
    if not pendingRequest then
        Notify({text = Locale("no_request"), type = "error"})
        return
    end
    
    -- If no argument provided, show menu
    if #args < 1 then
        ShowDeclinePunishmentMenu()
        return
    end
    
    -- Get punishment selection
    local selection = tonumber(args[1])
    
    if not selection then
        Notify({text = Locale("invalid_selection"), type = "error"})
        ShowDeclinePunishmentMenu()
        return
    end
    
    -- Selection 0 means no punishment
    if selection == 0 then
        DeclineWithPunishment(nil)
        return
    end
    
    -- Get sorted punishment keys (use same helper function)
    local punishmentKeys = GetSortedPunishmentKeys()
    local selectedPunishment = punishmentKeys[selection]
    
    if selectedPunishment then
        DeclineWithPunishment(selectedPunishment)
    else
        Notify({text = Locale("invalid_selection"), type = "error"})
        ShowDeclinePunishmentMenu()
    end
end)

-- Command: Stop current animation
RegisterCommandWithAliases(Config.Commands.stopAnimation, function()
    StopAnimation()
end)

-- ============================================================================
--                     NUI CALLBACKS (UI MENU SYSTEM)
-- ============================================================================
-- Handle NUI callbacks from the UI menu

-- Callback: Close menu
RegisterNUICallback('closeMenu', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Callback: Request animation from UI
RegisterNUICallback('requestAnimation', function(data, cb)
    local animationKey = data.animationKey
    local closestPlayer = GetClosestPlayer()
    
    if closestPlayer == -1 then
        Notify({text = Locale("no_player_nearby"), type = "error"})
        cb('ok')
        return
    end
    
    RequestAnimation(closestPlayer, animationKey)
    cb('ok')
end)

-- Callback: Stop animation from UI
RegisterNUICallback('stopAnimation', function(data, cb)
    StopAnimation()
    cb('ok')
end)


-- ============================================================================
--                     NETWORK EVENT HANDLERS (OPTIMIZED)
-- ============================================================================
-- All network events optimized to minimize processing overhead

-- Event to receive animation request
RegisterNetEvent('tlw_animations:receiveRequest', function(fromPlayer, animationKey, fromName)
    pendingRequest = {
        from = fromPlayer,
        animation = animationKey,
        time = GetGameTimer()
    }
    
    Notify({text = Locale("request_received", {name = fromName}), type = "info", time = 8000})
    
    -- Auto-expire after timeout (optimized timer)
    SetTimeout(Config.RequestTimeout, function()
        if pendingRequest and pendingRequest.from == fromPlayer then
            pendingRequest = nil
            Notify({text = Locale("request_expired"), type = "error"})
        end
    end)
end)

-- Event to start animation (accepted)
RegisterNetEvent('tlw_animations:startAnimation', function(animationKey, isInitiator, partnerServerId)
    StartSyncAnimation(animationKey, isInitiator, partnerServerId)
end)

-- Event when request is declined
RegisterNetEvent('tlw_animations:requestDeclined', function()
    Notify({text = Locale("request_declined"), type = "error"})
end)

-- Event to start punishment animation (attacker/decliner)
RegisterNetEvent('tlw_animations:startPunishment', function(punishmentKey, victimServerId)
    local punishData = Config.DeclineAnimations[punishmentKey]
    if not punishData then return end
    
    UpdatePlayerPed()
    local attackerData = punishData.attacker
    
    -- Load animation dictionary
    if LoadAnimDict(attackerData.dict) then
        -- Play attacker animation
        TaskPlayAnim(playerPed, attackerData.dict, attackerData.anim, 8.0, -8.0, attackerData.duration or 2000, attackerData.flag or 0, 0, false, false, false)
        
        -- Auto-stop after duration
        SetTimeout(attackerData.duration or 2000, function()
            if DoesEntityExist(playerPed) then
                ClearPedTasks(playerPed)
            end
        end)
    end
end)

-- Event to receive punishment (victim/requester)
RegisterNetEvent('tlw_animations:receivePunishment', function(punishmentKey, attackerServerId)
    local punishData = Config.DeclineAnimations[punishmentKey]
    if not punishData then return end
    
    UpdatePlayerPed()
    local victimData = punishData.victim
    
    -- Load animation dictionary
    if LoadAnimDict(victimData.dict) then
        -- Play victim reaction animation
        TaskPlayAnim(playerPed, victimData.dict, victimData.anim, 8.0, -8.0, victimData.duration or 2500, victimData.flag or 1, 0, false, false, false)
        
        -- Auto-stop after duration
        SetTimeout(victimData.duration or 2500, function()
            if DoesEntityExist(playerPed) then
                ClearPedTasks(playerPed)
            end
        end)
    end
end)

-- Event when partner stops animation
RegisterNetEvent('tlw_animations:partnerStopped', function()
    if isInAnimation then
        StopAnimation()
    end
end)

-- ============================================================================
--                     AUTO-CANCEL FEATURE (MOVEMENT DETECTION)
-- ============================================================================
-- Automatically cancel animation when player moves

CreateThread(function()
    while true do
        Wait(100)
        
        if isInAnimation then
            UpdatePlayerPed()
            
            -- Check if player is moving
            if IsPedWalking(playerPed) or IsPedRunning(playerPed) or IsPedSprinting(playerPed) or 
               IsPedJumping(playerPed) or IsPedClimbing(playerPed) or IsPedFalling(playerPed) then
                DebugPrint("Auto-cancel: Player is moving")
                StopAnimation()
            end
        else
            -- Sleep longer when not in animation to save performance
            Wait(1000)
        end
    end
end)

-- ============================================================================
--                     CLEANUP AND RESOURCE MANAGEMENT
-- ============================================================================
-- Proper cleanup to prevent memory leaks

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        -- Stop any active animations
        if isInAnimation then
            StopAnimation()
        end
        
        -- Clear cached data
        loadedDicts = {}
        propHashCache = {}
        pendingRequest = nil
        
        -- Clear ped tasks
        if DoesEntityExist(playerPed) then
            ClearPedTasks(playerPed)
        end
    end
end)

-- ============================================================================
--                     PERFORMANCE MONITORING (DEBUG)
-- ============================================================================
-- Uncomment for performance debugging
--[[
CreateThread(function()
    while true do
        Wait(5000)
        local resmon = GetResourceMetadata(GetCurrentResourceName(), 'resource_monitor', 0)
        print(string.format("^2[TLW Animations]^7 Performance: %s ms", resmon or "N/A"))
    end
end)
]]
