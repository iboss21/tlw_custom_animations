# 🔧 Troubleshooting Guide

## 🐺 THE LAND OF WOLVES - Custom Animations

Solutions to common issues and problems.

---

## Commands Not Working

### Issue: `/anim` or `/playanim` doesn't work

**Solutions:**

1. **Check resource is started**
   ```
   ensure tlw_custom_animations
   ```
   In server console, verify: `Resource tlw_custom_animations started`

2. **Restart the resource**
   ```
   restart tlw_custom_animations
   ```

3. **Check for console errors**
   - Look in both server and client F8 console
   - Fix any errors shown

4. **Verify framework setting**
   - Open `config.lua`
   - Ensure `Config.Framework` matches your server ("RSG" or "LXR")

---

## Animations Not Playing

### Issue: Request accepted but animation doesn't start

**Solutions:**

1. **Check distance**
   - Both players must be within 3 meters (default)
   - Try standing closer

2. **Check for required props**
   - Bed animations need a bed nearby
   - Chair animations need a chair nearby
   - Use `/stopanim` and try again

3. **Verify animation dictionary**
   - Some animations may use invalid dictionaries
   - Try a different animation to test

4. **Clear current animations**
   ```
   /stopanim
   ```
   Both players should run this, then try again

5. **Check server console**
   - Look for Lua errors
   - Fix any missing files or syntax errors

---

## Request Not Received

### Issue: Player B doesn't get notification from Player A

**Solutions:**

1. **Check distance**
   - Must be within `Config.MaxDistance` (default 3 meters)
   - Get closer and try again

2. **Verify both have resource**
   - Both players must have script loaded
   - Check F8 console for errors on both clients

3. **Check server events**
   - Ensure server is forwarding events
   - Restart resource: `restart tlw_custom_animations`

4. **Network issues**
   - Check for high ping/lag
   - Verify server is stable

---

## Prop Not Detected

### Issue: "This animation requires a bed/chair nearby" error

**Solutions:**

1. **Get closer to prop**
   - Default detection range is 2 meters
   - Stand very close to the bed/chair

2. **Check prop is in list**
   - Open `config.lua`
   - Verify prop model is in `Config.Beds` or `Config.ChairList`
   - Add prop if missing:
     ```lua
     Config.Beds = {
         "your_bed_prop_name",
         -- ... existing props
     }
     ```

3. **Verify prop name**
   - Use a prop menu/tool to find exact prop model name
   - Names are case-sensitive

4. **Prop may be non-solid**
   - Some decorative props don't work
   - Try a different bed/chair

---

## Performance Issues

### Issue: High resmon usage or lag

**Solutions:**

1. **Check for conflicts**
   - Disable other animation scripts
   - Look for competing resources

2. **Verify installation**
   - Re-download clean copy
   - Don't modify optimization code

3. **Monitor server health**
   ```
   resmon
   ```
   - Check overall server performance
   - Other resources may be causing issues

4. **Check modifications**
   - If you edited the code, revert to original
   - Our optimizations are carefully balanced

---

## Punishment Animations

### Issue: Punishment not triggering on decline

**Solutions:**

1. **Check config**
   ```lua
   Config.DeclineWithPunishment = true  -- Must be true
   Config.PunishmentChance = 75         -- Percentage chance
   ```

2. **Randomness**
   - Punishment is chance-based (75% default)
   - Not guaranteed every time

3. **Test with 100% chance**
   ```lua
   Config.PunishmentChance = 100
   ```
   If this works, randomness is normal

---

## Framework Integration Issues

### Issue: Notify not showing or framework errors

**Solutions:**

1. **RSG-Core:**
   - Ensure `ox_lib` is installed
   - Verify RSG-Core is loaded first

2. **LXR-Core:**
   - Ensure LXR-Core is running
   - Check framework exports are available

3. **Check Config.Framework**
   ```lua
   Config.Framework = "RSG"  -- or "LXR"
   ```

4. **Test notifications**
   - Use `/anim` and check for any notification
   - If none appear, framework integration failed

---

## Animation Looks Wrong

### Issue: Players positioned incorrectly

**Solutions:**

1. **Different props have different heights**
   - Try the animation on a different bed/chair
   - Some work better than others

2. **Adjust offsets**
   - Edit animation in `config.lua`
   - Modify `posX`, `posY`, `posZ` values
   - Test incrementally (±0.05 at a time)

3. **Check rotation**
   - Verify `rotZ` values
   - Try adjusting ±10 degrees

4. **Ground level matters**
   - Ensure both players on level ground
   - Stairs/slopes may cause issues

---

## Server Console Errors

### Common Errors and Fixes

**Error:** `attempt to index a nil value (field 'Animations')`

**Fix:** Config.lua not loaded properly
```lua
-- Check fxmanifest.lua includes:
shared_scripts {
    'config.lua',
}
```

---

**Error:** `Animation dictionary not found`

**Fix:** Invalid animation dictionary name
- Check spelling in config.lua
- Verify dictionary exists in RDR2
- Use a known-working animation as template

---

**Error:** `Player not found`

**Fix:** Target player out of range or disconnected
- Ensure both players online
- Check distance (within 3 meters)
- Have target player rejoin

---

**Error:** `attempt to call a nil value (function 'Notify')`

**Fix:** Shared functions not loaded
```lua
-- Check fxmanifest.lua includes:
shared_scripts {
    'config.lua',
    'shared/*.lua'
}
```

---

## Permission Issues

### Issue: Admin commands not working

**Solution:** Add ace permissions to server.cfg

```cfg
# For all admins
add_ace group.admin tlw_animations.admin allow

# For specific player
add_ace identifier.steam:110000XXXXXXXX tlw_animations.admin allow
```

Restart server after adding.

---

## Database/Persistent Issues

### Issue: Settings not saving

**Note:** This script doesn't use database. All settings are in config.lua

**To change settings:**
1. Edit `config.lua`
2. Save file
3. Restart resource: `restart tlw_custom_animations`

---

## Client-Side Issues

### Issue: F8 console errors on client

**Common fixes:**

1. **Clear cache**
   - Delete FiveM/RedM cache folder
   - Rejoin server

2. **Verify install**
   - Re-download resource
   - Ensure all files present

3. **Check for conflicts**
   - Disable other animation mods
   - Test one at a time

---

## Testing Checklist

If nothing works, test systematically:

- [ ] Resource shows as started in server console
- [ ] No errors in server console  
- [ ] No errors in client F8 console
- [ ] `/anim` command responds
- [ ] Can detect nearby player
- [ ] Can send request
- [ ] Other player receives notification
- [ ] `/acceptanim` works
- [ ] Animation starts for both players
- [ ] `/stopanim` stops animation

**Where it fails = where to focus troubleshooting**

---

## Getting Additional Help

If you've tried everything:

1. **Gather information:**
   - Server console errors
   - Client F8 console errors
   - Exact steps to reproduce
   - What you've already tried

2. **Check documentation:**
   - [Installation Guide](INSTALLATION.md)
   - [Configuration Guide](CONFIGURATION.md)
   - [Performance Guide](PERFORMANCE.md)

3. **Contact support:**
   - Discord: The Land of Wolves community
   - Website: www.wolves.land
   - Include all gathered information

---

## Debug Mode

To enable verbose logging (for advanced troubleshooting):

Add to client/main.lua:
```lua
local DEBUG = true

local function DebugPrint(msg)
    if DEBUG then
        print("^3[TLW Debug]^7 " .. msg)
    end
end

-- Add DebugPrint calls throughout code to trace execution
```

---

## Common Mistakes

### ❌ Don't

1. Don't modify optimization code
2. Don't run multiple animation scripts
3. Don't use invalid animation dictionaries
4. Don't ignore console errors
5. Don't skip checking distance

### ✅ Do

1. Read error messages carefully
2. Test with default settings first
3. Make small changes at a time
4. Check both client and server consoles
5. Ask for help with specific details

---

<div align="center">

**🐺 THE LAND OF WOLVES 🐺**

Still need help? Visit [www.wolves.land](https://www.wolves.land)

</div>
