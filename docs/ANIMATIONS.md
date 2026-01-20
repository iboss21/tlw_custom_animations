# 🎭 Animation List

## 🐺 THE LAND OF WOLVES - Custom Animations

Complete list of all available animations in the TLW Custom Animations system.

---

## How to Use

Use the animation key with the command:
```
/playanim [animation_key]
```

Example: `/playanim cowgirl`

---

## 🔥 Standing Positions (No Props Required)

| Key | Label | Description |
|-----|-------|-------------|
| `standart` | Standing Doggy | Classic standing doggy style position |
| `standing_behind` | Standing Behind | Standing position from behind |
| `standing_close` | Standing Close | Close standing intimate position |
| `lifted_standing` | Lifted Standing | Lifted standing position |
| `standing_grind` | Standing Grind | Standing grinding motion |
| `wallsex` | Wall Sex | Against the wall position |
| `wall_grind` | Wall Grind | Grinding against wall |
| `against_wall_2` | Against Wall 2 | Alternative wall position |
| `table_sex` | Table Sex | Using a table surface |
| `counter_sex` | Counter Sex | Counter/bar surface position |

---

## 🛏️ Bed-Required Animations

**Note:** These animations require a bed nearby (within 2 meters)

| Key | Label | Description |
|-----|-------|-------------|
| `cowgirl` | Cowgirl | Classic cowgirl position |
| `cowgirl2` | Reverse Cowgirl | Reverse cowgirl variation |
| `missionary` | Missionary | Traditional missionary position |
| `facesitting` | Face Sitting | Face sitting position |
| `spooning` | Spooning | Spooning/side position |
| `side_sex` | Side Sex | Side-by-side position |
| `cuddling` | Cuddling in Bed | Intimate cuddling |
| `prone_bone` | Prone Bone | Prone position |
| `sixtynine` | 69 Position | Mutual oral position |
| `bedsex1` | Bed Sex 1 | Bed variation 1 |
| `bedsex2` | Bed Sex 2 | Bed variation 2 |
| `laying_oral` | Laying Oral | Laying oral position |
| `edge_bed_oral` | Edge Bed Oral | At the edge of bed |

### Recognized Bed Props
- `p_bedsleptinold04x`
- `p_cs_bedsleptinbed08x`
- `p_bedsleptin01x`
- `p_gen_bedsleptin01x_tc01`

---

## 💺 Chair-Required Animations

**Note:** These animations require a chair/bench/couch nearby (within 2 meters)

| Key | Label | Description |
|-----|-------|-------------|
| `couplesit` | Sit Couple | Sitting together intimately |
| `sitsex` | Sit Sex | Seated sexual position |
| `lapdance` | Lap Dance | Lap dance position |
| `handjob` | Handjob | Seated handjob position |
| `chair_ride` | Chair Ride | Riding on chair |
| `reverse_chair` | Reverse Chair | Reverse chair position |
| `sitting_bj` | Sitting BJ | Seated oral position |

### Recognized Chair Props
System recognizes 100+ chair models including:
- All `P_CHAIR*` variants
- All `P_BENCH*` variants  
- All `P_COUCH*` variants
- All `P_LOVESEAT*` variants
- Special furniture like `P_ROCKINGCHAIR*`, `P_SOFA*`, etc.

---

## 👄 Oral Animations

| Key | Label | Description |
|-----|-------|-------------|
| `blowjob` | BJ Standing | Standing oral position |
| `blowjob_kneel` | BJ Kneeling | Kneeling oral position |

---

## 💋 Romantic & Intimate

| Key | Label | Description |
|-----|-------|-------------|
| `kiss` | Kiss | Simple kiss |
| `makeout` | Make Out | Passionate makeout |
| `deep_kiss` | Deep Kiss | Deep kissing |
| `neck_kiss` | Neck Kiss | Neck kissing |
| `passionate_embrace` | Passionate Embrace | Tight embrace |
| `hug_romantic` | Romantic Hug | Romantic hug |

---

## 💃 Teasing & Dancing

| Key | Label | Description |
|-----|-------|-------------|
| `dance_grind` | Dance Grind | Grinding dance |
| `tease_dance` | Tease Dance | Teasing dance |
| `stripsex` | Strip Tease Sex | Strip tease position |

---

## 👋 Spanking

| Key | Label | Description |
|-----|-------|-------------|
| `spank` | Spank | Basic spanking |
| `spank_standing` | Spank Standing | Standing spank |
| `spank_bent` | Spank Bent Over | Bent over spanking |

---

## 💥 Rejection/Punishment Animations

**Note:** These trigger automatically when someone declines a request (75% chance by default)

| Key | Label | Description |
|-----|-------|-------------|
| `slap` | Slap in Face | Slapping the requester |
| `kick_balls` | Kick in Balls | Kick to the groin |
| `punch` | Punch Face | Punch to the face |
| `shove` | Shove Away | Shoving away |
| `bottle_hit` | Bottle Hit | Hit with bottle |
| `spit` | Spit on Face | Spitting on requester |

---

## Animation Flags

Animations use different flags for behavior:

| Flag | Behavior |
|------|----------|
| `0` | Normal animation, not looping |
| `1` | Looping animation (default for most) |
| `33` | Animation against props/walls |

---

## Position & Rotation Values

### Position Offsets (posX, posY, posZ)
- **posX:** Left/Right positioning (negative = left, positive = right)
- **posY:** Forward/Back positioning (negative = back, positive = forward)
- **posZ:** Up/Down positioning (negative = down, positive = up)

### Rotation Values (rotX, rotY, rotZ)
- **rotX:** Pitch (tilt up/down)
- **rotY:** Roll (barrel roll)
- **rotZ:** Yaw (heading/direction) - Most commonly used

---

## Tips for Using Animations

### For Standing Animations
1. Stand close to your partner (within 3 meters)
2. Face the general direction you want
3. Send the request
4. Both players should be on flat ground

### For Bed Animations
1. Find a bed (check list above)
2. Stand very close to the bed (within 2 meters)
3. Position yourself at the desired side
4. Send request
5. Animations will auto-align to bed

### For Chair Animations
1. Find a suitable chair/bench
2. Stand near the chair
3. The player sitting should be closest
4. Send request
5. Animations align to chair automatically

---

## Common Issues

### Animation not starting?
- ✅ Check you're within 3 meters of partner
- ✅ Verify required prop (bed/chair) is nearby
- ✅ Ensure animation dictionary name is correct
- ✅ Try stopping any current animation first (`/stopanim`)

### Animation looks weird?
- Different beds/chairs may have different heights
- Positioning offsets may need adjustment
- Some animations work better on specific furniture

### Partner not receiving request?
- Check they're in range (3 meters default)
- Verify both have the script loaded
- Check server console for errors

---

## Adding Custom Animations

See [Adding Animations Guide](ADDING_ANIMATIONS.md) for instructions on creating your own animations.

---

## Animation Sources

All animations use native RDR2 animation dictionaries from the game files. Common sources:

- `script_story@sal1@ig@sal1_18_lenny_on_lenny` - Intimate scenes
- `script_story@mud3@ig@ig_1_throw_whore` - Various positions
- `script_hideout@six_point_cabin@couple` - Couple animations
- `cnv_camp@rchso@cnv@ccsnk_par_cnv2` - Romantic interactions
- `script_re@peep_tom@spanking_cowboy` - Spanking animations

---

<div align="center">

**🐺 THE LAND OF WOLVES 🐺**

Total Animations: **40+ Interactive + 6 Punishment**

[www.wolves.land](https://www.wolves.land)

</div>
