# ➕ Adding Custom Animations

## 🐺 THE LAND OF WOLVES - Custom Animations

Learn how to add your own custom animations to the system.

---

## Prerequisites

Before adding animations, you need:

1. **Animation dictionary name** - The RDR2 animation dict
2. **Animation name** - The specific animation within the dict
3. **Basic understanding** - Of positioning and rotation
4. **Testing ability** - To test your animations in-game

---

## Finding Animation Names

### Method 1: RDR2 Animation Database

Visit: https://www.rdr2mods.com/wiki/animations/

Search for animations related to your needs.

### Method 2: In-Game Testing

Use animation testing tools like:
- dpemotes
- Animation Menu scripts
- Animation explorers

### Method 3: Game Files

Extract and explore game files (advanced):
- YMT files contain animation data
- Animation dictionaries in game archives

---

## Basic Animation Structure

### Simple Standing Animation

```lua
["your_anim_key"] = {
    label = "Your Animation Name",
    player = {
        dict = "animation_dictionary",
        anim = "animation_name",
        flag = 1,
        posX = 0.0,
        posY = 0.0,
        posZ = 0.0,
        rotX = 0,
        rotY = 0,
        rotZ = 0,
    },
    target = {
        dict = "animation_dictionary",
        anim = "animation_name",
        flag = 1,
        posX = 0.0,
        posY = 0.30,  -- Slightly forward
        posZ = 0.0,
        rotX = 0,
        rotY = 0,
        rotZ = 180.0,  -- Facing player
    },
},
```

---

## Animation Flags

Choose appropriate flag for your animation:

| Flag | Purpose | Usage |
|------|---------|-------|
| `0` | Play once | Short actions (punch, slap) |
| `1` | Loop | Continuous animations (sex, dancing) |
| `2` | Hold last frame | Poses, frozen positions |
| `33` | Against props | Wall/furniture-based animations |

---

## Position Offsets Explained

### Understanding Coordinates

```
        +Y (Forward)
          |
          |
-X -------+------- +X
(Left)    |    (Right)
          |
        -Y (Back)

+Z = Up
-Z = Down
```

### Position Examples

**Place partner in front:**
```lua
posY = 0.30  -- 30cm forward
```

**Place partner to the right:**
```lua
posX = 0.20  -- 20cm right
```

**Raise partner up:**
```lua
posZ = 0.15  -- 15cm up
```

---

## Rotation Explained

### rotZ (Heading) - Most Important

```
         0° (North)
           |
   270° ---+--- 90°
           |
        180° (South)
```

**Common rotations:**
- `0` - Same direction as player
- `90` - Turn right
- `180` - Face player (opposite)
- `270` - Turn left

### rotX and rotY

Usually keep at `0` unless you need:
- `rotX` - Tilt forward/back
- `rotY` - Tilt left/right

---

## Adding Bed-Required Animation

```lua
["your_bed_anim"] = {
    label = "Your Bed Animation",
    nededBeds = {
        posX = 0.0,
        posY = 0.0,
        posZ = 0.15,  -- Slightly above bed surface
        rotX = 0,
        rotY = 0,
        rotZ = 0.0,
    },
    player = {
        dict = "your_animation_dict",
        anim = "your_anim_name",
        flag = 1,
        posX = 0,
        posY = 0,
        posZ = 0,
        rotX = 0,
        rotY = 0,
        rotZ = 0,
    },
    target = {
        dict = "your_animation_dict",
        anim = "your_anim_name",
        flag = 1,
        posX = 0.0,
        posY = 0.0,
        posZ = 0.15,
        rotX = 0,
        rotY = 0,
        rotZ = 180.0,
    },
},
```

---

## Adding Chair-Required Animation

```lua
["your_chair_anim"] = {
    label = "Your Chair Animation",
    nededChair = {
        posX = 0.0,
        posY = 0.0,
        posZ = 0.10,  -- Height of chair seat
        rotX = 0,
        rotY = 0,
        rotZ = 0.0,
    },
    player = {
        dict = "your_animation_dict",
        anim = "your_anim_name",
        flag = 1,
        posX = 0,
        posY = 0,
        posZ = 0,
        rotX = 0,
        rotY = 0,
        rotZ = 0,
    },
    target = {
        dict = "your_animation_dict",
        anim = "your_anim_name",
        flag = 1,
        posX = 0.0,
        posY = 0.25,
        posZ = 0.30,  -- Sitting on lap
        rotX = 0,
        rotY = 0,
        rotZ = 180.0,
    },
},
```

---

## Step-by-Step Tutorial

### Step 1: Choose Animation

Decide what animation you want to add:
- Standing positions
- Bed positions
- Chair positions
- Romantic gestures
- etc.

### Step 2: Find Animation Dicts

Research and find suitable animation dictionaries.

**Example sources:**
- `script_story@*` - Story mission animations
- `script_hideout@*` - Hideout animations
- `amb_*` - Ambient animations
- `cnv_*` - Conversation animations

### Step 3: Add to Config

Open `config.lua` and add your animation to `Config.Animations`:

```lua
Config.Animations = {
    -- ... existing animations ...
    
    ["my_new_anim"] = {
        label = "My Custom Animation",
        player = {
            dict = "script_story@example",
            anim = "example_anim",
            flag = 1,
            posX = 0.0,
            posY = 0.0,
            posZ = 0.0,
            rotX = 0,
            rotY = 0,
            rotZ = 0,
        },
        target = {
            dict = "script_story@example",
            anim = "example_anim_target",
            flag = 1,
            posX = 0.0,
            posY = 0.30,
            posZ = 0.0,
            rotX = 0,
            rotY = 0,
            rotZ = 180.0,
        },
    },
}
```

### Step 4: Save and Restart

```
restart tlw_custom_animations
```

### Step 5: Test In-Game

```
/playanim my_new_anim
```

Test with another player.

### Step 6: Adjust Positioning

If positioning is wrong:

1. Note what needs adjusting
2. Edit offsets in config.lua:
   - Too far apart? Reduce posY
   - Wrong height? Adjust posZ
   - Wrong direction? Change rotZ
3. Save and restart
4. Test again
5. Repeat until perfect

---

## Advanced: Punishment Animations

Add custom punishment animations to `Config.DeclineAnimations`:

```lua
Config.DeclineAnimations = {
    -- ... existing punishments ...
    
    ["my_punishment"] = {
        label = "My Punishment",
        attacker = {
            dict = "attack_animation_dict",
            anim = "attack_anim",
            flag = 0,
            duration = 2000,  -- 2 seconds
        },
        victim = {
            dict = "reaction_animation_dict",
            anim = "reaction_anim",
            flag = 1,
            duration = 2500,  -- 2.5 seconds
        },
        positioning = {
            distance = 0.5,
            rotation = 180.0,
        },
    },
}
```

---

## Testing Best Practices

### DO ✅

1. **Test with default settings first**
   - Start with posX/Y/Z at 0
   - Start with rotZ at 0 or 180
   - Adjust incrementally

2. **Test on flat ground**
   - Avoid slopes and stairs
   - Use level surfaces

3. **Test different props**
   - Not all beds are same height
   - Try multiple chairs

4. **Document your changes**
   - Keep notes on what works
   - Save backup of working config

### DON'T ❌

1. **Don't make big changes**
   - Adjust by small amounts (0.05-0.10)
   - Test after each change

2. **Don't use invalid dicts**
   - Verify animation exists
   - Check spelling carefully

3. **Don't forget flags**
   - Wrong flag = wrong behavior
   - Most need flag = 1

---

## Common Animation Dictionaries

### Intimate Animations
- `script_story@sal1@ig@sal1_18_lenny_on_lenny` - Very useful for couples
- `script_story@mud3@ig@ig_1_throw_whore` - Various positions
- `script_hideout@six_point_cabin@couple` - Couple animations

### Romantic Gestures
- `cnv_camp@rchso@cnv@ccsnk_par_cnv2` - Kissing, hugging
- `script_re@romance@generic` - Romantic interactions

### Aggressive Actions
- `script_re@duel@wheel_back` - Fighting, pushing
- `script_story@bea1@bea1_02_0_aftermath@aftermath_01_aint_right` - Reactions to hits

### Sitting/Relaxing
- `amb_rest@world_human_sit*` - Sitting positions
- `script_hideout@six_point_cabin@couple` - Sitting together

---

## Troubleshooting Custom Animations

### Animation not playing?

1. **Check dictionary name**
   - Verify spelling
   - Ensure it exists in game

2. **Check animation name**
   - Must match exactly
   - Case-sensitive

3. **Test dictionary alone**
   - Try just player animation first
   - Then add target

### Positioning wrong?

**Players too far apart:**
```lua
-- Reduce posY value
posY = 0.20  -- was 0.30
```

**Players too close:**
```lua
-- Increase posY value
posY = 0.40  -- was 0.30
```

**Wrong height:**
```lua
-- Adjust posZ
posZ = 0.10  -- up
posZ = -0.10 -- down
```

**Facing wrong way:**
```lua
-- Adjust rotZ
rotZ = 0    -- same direction
rotZ = 90   -- 90 degrees
rotZ = 180  -- opposite direction
rotZ = 270  -- 270 degrees
```

---

## Example: Creating a Hug Animation

Let's create a simple hug animation step-by-step:

### Step 1: Basic Structure
```lua
["friendly_hug"] = {
    label = "Friendly Hug",
    player = {},
    target = {},
},
```

### Step 2: Add Player Animation
```lua
player = {
    dict = "script_story@mud3@ig@ig_1_throw_whore",
    anim = "base_att",
    flag = 1,
    posX = 0.0,
    posY = 0.0,
    posZ = 0.0,
    rotX = 0,
    rotY = 0,
    rotZ = 0,
},
```

### Step 3: Add Target Animation
```lua
target = {
    dict = "script_story@mud3@ig@ig_1_throw_whore",
    anim = "base_vtm",
    flag = 1,
    posX = 0.0,
    posY = 0.25,  -- Close together
    posZ = 0.0,
    rotX = 0,
    rotY = 0,
    rotZ = 180.0,  -- Facing player
},
```

### Step 4: Test and Adjust

In-game: `/playanim friendly_hug`

If too far apart: Reduce `posY` to `0.20`
If too close: Increase `posY` to `0.30`

---

## Sharing Your Animations

Created something great? Share with the community!

1. **Document your animation**
   - Animation keys used
   - Positioning values
   - Any special requirements

2. **Share on Discord**
   - The Land of Wolves community
   - Help others with your creations

3. **Test thoroughly**
   - Ensure it works on different servers
   - Test with multiple players

---

<div align="center">

**🐺 THE LAND OF WOLVES 🐺**

*Create, Test, Share*

[www.wolves.land](https://www.wolves.land)

</div>
