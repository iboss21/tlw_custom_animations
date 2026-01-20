# 📦 Installation Guide

## 🐺 THE LAND OF WOLVES - Custom Animations

This guide will walk you through installing the TLW Custom Animations system on your RedM server.

---

## Prerequisites

Before installing, ensure you have:

- ✅ A working RedM server
- ✅ Either RSG-Core or LXR-Core framework installed
- ✅ Server access to add resources
- ✅ Basic understanding of server configuration

---

## Installation Steps

### Step 1: Download the Resource

**Option A: Git Clone (Recommended)**
```bash
cd path/to/your/server/resources/[local]
git clone https://github.com/iboss21/tlw_custom_animations.git
```

**Option B: Manual Download**
1. Download the ZIP from GitHub
2. Extract to your resources folder
3. Rename folder to `tlw_custom_animations` (if needed)

---

### Step 2: Verify File Structure

Your resource folder should look like this:

```
tlw_custom_animations/
├── client/
│   └── main.lua
├── server/
│   └── main.lua
├── shared/
│   └── functions.lua
├── docs/
│   └── (documentation files)
├── config.lua
├── fxmanifest.lua
├── LICENSE
└── README.md
```

---

### Step 3: Configure the Script

Open `config.lua` and configure your settings:

#### Framework Selection
```lua
Config.Framework = "RSG"  -- Options: "RSG" or "LXR"
```

Choose based on your server:
- `"RSG"` for RSG-Core servers
- `"LXR"` for LXR-Core servers

#### Language Setting
```lua
Config.Language = "en"  -- Default: English
```

#### Request Settings (Optional)
```lua
Config.RequestTimeout = 30000        -- Time before request expires (ms)
Config.MaxDistance = 3.0              -- Max distance to request (meters)
Config.DeclineWithPunishment = true   -- Enable punishment animations
Config.PunishmentChance = 75          -- Chance of punishment (0-100)
```

---

### Step 4: Add to server.cfg

Add the following line to your `server.cfg`:

```cfg
ensure tlw_custom_animations
```

**Recommended placement:** After your framework but before other gameplay scripts

Example:
```cfg
ensure rsg-core
ensure tlw_custom_animations
ensure other-gameplay-scripts
```

---

### Step 5: Set Permissions (Optional)

If you want admins to use special commands, add ace permissions to your `server.cfg`:

```cfg
# Admin permissions for TLW Animations
add_ace group.admin tlw_animations.admin allow
```

This allows admins to use `/stopallanims` command.

---

### Step 6: Restart Server

**Option A: Full Restart (Recommended)**
```bash
# Stop server
# Start server
```

**Option B: Resource Restart (if server is running)**
```
restart tlw_custom_animations
```

---

### Step 7: Verify Installation

Once your server is running:

1. **Join your server**
2. **Test the commands:**
   ```
   /anim          # Should show available animations
   /stopanim      # Should work (even if not in animation)
   ```

3. **Test with another player:**
   - Stand near another player (within 3 meters)
   - Use `/playanim standart`
   - Other player should receive notification
   - Other player types `/acceptanim`
   - Both should start animation

---

## Post-Installation

### Customization

After successful installation, you can:

1. **Add more animations** - See [Adding Animations Guide](ADDING_ANIMATIONS.md)
2. **Customize messages** - Edit locale in `config.lua`
3. **Adjust timing** - Modify timeout and distance settings
4. **Add languages** - Create new locale tables

### Performance Verification

Check your server's resmon to verify performance:

```
resmon
```

Look for `tlw_custom_animations` - it should show ~0.01ms usage.

---

## Troubleshooting Installation

### Resource not starting?

1. Check console for errors
2. Verify file structure matches above
3. Ensure `fxmanifest.lua` exists
4. Check resource name in `server.cfg` matches folder name

### Commands not working?

1. Verify framework is correctly set in `config.lua`
2. Check framework is loaded before this resource
3. Restart the resource: `restart tlw_custom_animations`

### Animations not playing?

1. Ensure two players are within max distance (default 3m)
2. Check both players have resource loaded
3. Verify animation dictionaries are valid
4. Check server console for errors

---

## Upgrading

To upgrade to a new version:

1. **Backup your config.lua** (save your settings)
2. **Delete old resource folder**
3. **Install new version** (follow steps above)
4. **Restore your config settings**
5. **Restart server**

---

## Need Help?

- 📚 Check [Troubleshooting Guide](TROUBLESHOOTING.md)
- 💬 Join our Discord
- 🌐 Visit www.wolves.land
- 📧 Contact iBoss

---

## Next Steps

- [Configuration Guide](CONFIGURATION.md) - Detailed config options
- [User Guide](USER_GUIDE.md) - How to use the system
- [Animation List](ANIMATIONS.md) - See all animations

---

<div align="center">

**🐺 THE LAND OF WOLVES 🐺**

[www.wolves.land](https://www.wolves.land)

</div>
