# ⚙️ Configuration Guide

## 🐺 THE LAND OF WOLVES - Custom Animations

Complete guide to configuring TLW Custom Animations system.

---

## Configuration File Location

All configuration is done in: `config.lua`

---

## Framework Settings

### Config.Framework
```lua
Config.Framework = "RSG"  -- Options: "RSG" or "LXR"
```

**Options:**
- `"RSG"` - For RSG-Core framework
- `"LXR"` - For LXR-Core framework

**When to change:** Set this based on which framework your server uses.

---

### Config.Language
```lua
Config.Language = "en"  -- Default: English
```

**Available Languages:**
- `"en"` - English (default)

**Adding new languages:** See [Localization](#localization) section below.

---

## Animation Request Settings

### Config.RequestTimeout
```lua
Config.RequestTimeout = 30000  -- Time in milliseconds
```

**What it does:** How long a request stays active before expiring

**Recommendations:**
- `30000` (30 seconds) - Default, works well
- `20000` (20 seconds) - For faster-paced servers
- `60000` (60 seconds) - For RP-heavy servers

---

### Config.MaxDistance
```lua
Config.MaxDistance = 3.0  -- Distance in meters
```

**What it does:** Maximum distance between players to send/accept requests

**Recommendations:**
- `3.0` - Default, good balance
- `2.0` - More intimate, requires closeness
- `5.0` - More relaxed, easier to use

---

### Config.DeclineWithPunishment
```lua
Config.DeclineWithPunishment = true  -- Enable/disable punishment
```

**What it does:** When true, declining a request may trigger punishment animation

**Options:**
- `true` - Punishment animations enabled (recommended for fun/humor)
- `false` - Punishment disabled (simple decline only)

---

### Config.PunishmentChance
```lua
Config.PunishmentChance = 75  -- Percentage (0-100)
```

**What it does:** Chance that declining triggers a punishment animation

**Recommendations:**
- `75` - Default, most declines result in punishment
- `50` - Half the time
- `100` - Always punish (harsh!)
- `0` - Never punish (even if enabled)

---

## Animations Configuration

Animations are defined in `Config.Animations` table. Each animation has:

### Basic Structure
```lua
["animation_key"] = {
    label = "Display Name",
    player = { 
        -- Player (requester) animation data
    },
    target = {
        -- Target (accepter) animation data
    },
}
```

### Animation Data Fields

#### Required Fields
```lua
dict = "animation_dictionary_name"  -- RDR2 animation dict
anim = "animation_name"              -- Specific animation
flag = 1                             -- Animation flag (1 = default, 33 = against prop)
```

#### Position Offsets
```lua
posX = 0.0  -- Right/Left offset
posY = 0.0  -- Forward/Back offset  
posZ = 0.0  -- Up/Down offset
```

#### Rotation Values
```lua
rotX = 0    -- Pitch (tilt up/down)
rotY = 0    -- Roll (barrel roll)
rotZ = 0    -- Yaw (heading/direction)
```

### Optional: Prop Requirements

#### Bed Requirement
```lua
nededBeds = {
    posX = 0.0,
    posY = 0.0,
    posZ = 0.15,
    rotX = 0,
    rotY = 0,
    rotZ = 0.0,
}
```

#### Chair Requirement
```lua
nededChair = {
    posX = 0.0,
    posY = 0.0,
    posZ = 0.10,
    rotX = 0,
    rotY = 0,
    rotZ = 0.0,
}
```

---

## Prop Lists

### Config.Beds
List of prop models recognized as beds:

```lua
Config.Beds = {
    "p_bedsleptinold04x",
    "p_cs_bedsleptinbed08x",
    "p_bedsleptin01x",
    "p_gen_bedsleptin01x_tc01",
}
```

**To add more beds:** Add prop model names to this list.

---

### Config.ChairList
List of prop models recognized as chairs/seats:

```lua
Config.ChairList = {
    "P_CHAIRCOMFY04X",
    "P_CHAIR14X",
    -- ... 100+ chairs included
}
```

**To add more chairs:** Add prop model names to this list.

---

## Decline/Punishment Animations

Configured in `Config.DeclineAnimations`:

### Structure
```lua
["punishment_key"] = {
    label = "Punishment Name",
    attacker = {
        dict = "anim_dict",
        anim = "anim_name",
        flag = 0,
        duration = 2000,  -- How long animation plays (ms)
    },
    victim = {
        dict = "anim_dict",
        anim = "anim_name",
        flag = 1,
        duration = 2500,
    },
    positioning = {
        distance = 0.5,    -- Distance between players
        rotation = 180.0,  -- Attacker faces victim
    },
}
```

---

## Localization

### Adding New Language

1. **Add new locale table in config.lua:**

```lua
Config.Locale["es"] = {
    ["request_sent"] = "🐺 Solicitud enviada",
    ["request_received"] = "🐺 ${name} te envió una solicitud",
    ["request_accepted"] = "✅ Solicitud aceptada",
    -- ... add all translations
}
```

2. **Set language:**
```lua
Config.Language = "es"
```

### Available Locale Keys

```lua
-- Request/Response
["request_sent"]
["request_received"]  -- Uses ${name} placeholder
["request_accepted"]
["request_declined"]
["request_expired"]
["no_request"]

-- Distance/Player
["player_too_far"]
["no_player_nearby"]
["invalid_player"]

-- Animation Status
["animation_stopped"]
["animation_started"]
["already_in_animation"]

-- Requirements
["need_bed"]
["need_chair"]

-- Menu
["select_animation"]
["close_menu"]

-- Punishment
["got_punished"]
["taught_lesson"]
```

---

## Performance Tuning

### For Maximum Performance

Already optimized, but you can:

1. **Reduce animation count** - Remove unused animations
2. **Reduce prop lists** - Only include props on your server
3. **Increase timeout** - Less frequent request handling

### Current Optimizations

- ✅ Cached animation dictionaries
- ✅ Cached prop hashes
- ✅ Optimized distance calculations
- ✅ Event-driven (no loops)
- ✅ Smart ped caching (5-second intervals)

---

## Example Configurations

### Serious RP Server
```lua
Config.RequestTimeout = 60000
Config.MaxDistance = 2.0
Config.DeclineWithPunishment = false
Config.PunishmentChance = 0
```

### Fun/Casual Server
```lua
Config.RequestTimeout = 20000
Config.MaxDistance = 5.0
Config.DeclineWithPunishment = true
Config.PunishmentChance = 100
```

### Balanced (Default)
```lua
Config.RequestTimeout = 30000
Config.MaxDistance = 3.0
Config.DeclineWithPunishment = true
Config.PunishmentChance = 75
```

---

## Need Help?

- 📚 [Troubleshooting Guide](TROUBLESHOOTING.md)
- 📖 [Adding Animations Guide](ADDING_ANIMATIONS.md)
- 🌐 www.wolves.land

---

<div align="center">

**🐺 THE LAND OF WOLVES 🐺**

[www.wolves.land](https://www.wolves.land)

</div>
