# 📖 User Guide

## 🐺 THE LAND OF WOLVES - Custom Animations

Complete guide for players on how to use the TLW Custom Animations system.

---

## What Is This?

TLW Custom Animations is a player-to-player interactive animation system that allows you to request and perform synchronized animations with other players, including:

- 🔥 Intimate positions
- 💋 Romantic gestures
- 💃 Dancing and teasing
- 💥 Rejection responses (if declined)

---

## Basic Commands

| Command | What It Does |
|---------|--------------|
| `/tlwanim` or `/tlw` | Opens animation menu |
| `/tlwplay [key]` | Request specific animation |
| `/tlwaccept` or `/acceptanim` | Accept a pending request |
| `/tlwdecline` or `/declineanim` | Shows punishment menu to decline |
| `/tlwdecline [number]` | Decline with chosen punishment (0 = no punishment) |
| `/tlwstop` or `/stopanim` | Stop your current animation |

---

## How To Use

### Step 1: Find a Partner

- Get close to another player (within 3 meters)
- Make sure they're ready and willing

### Step 2: Request an Animation

**Option A: Use the menu**
```
/tlwanim
```
Browse available animations and select one.

**Option B: Use direct command**
```
/tlwplay cowgirl
```
Replace "cowgirl" with any animation key.

### Step 3: Wait for Response

The other player will see a notification:

```
🐺 You received an animation request from [Name]
Type /tlwaccept or /acceptanim to accept
Type /tlwdecline or /declineanim to decline
```

They have 30 seconds to respond.

### Step 4: Animation Plays

**If accepted:**
- Both players automatically start the synchronized animation
- Enjoy!

**If declined:**
- Request is denied
- Decliner chooses which punishment animation to apply (or none)

### Step 5: Stop When Done

Either player can stop:
```
/tlwstop
```

---

## Declining Requests

When you receive a request you don't want to accept, you can decline it with control over the punishment:

### Show Punishment Menu

Simply type:
```
/tlwdecline
```

You'll see a menu like this:
```
========================================
   Select Decline Punishment
========================================
0. Decline Without Punishment
1. Bottle Hit
2. Kick in Balls
3. Punch Face
4. Shove Away
5. Slap in Face
6. Spit on Face
========================================
```

### Choose Your Response

**Option 1: Decline without punishment**
```
/tlwdecline 0
```
Politely decline with no punishment animation.

**Option 2: Apply a specific punishment**
```
/tlwdecline 1    # Bottle Hit
/tlwdecline 2    # Kick in Balls
/tlwdecline 3    # Punch Face
/tlwdecline 4    # Shove Away
/tlwdecline 5    # Slap in Face
/tlwdecline 6    # Spit on Face
```

The punishment animation will play briefly (2-3 seconds) to show your displeasure!

**Why this feature?**
- **Player agency** - You control how you respond
- **RP flexibility** - Choose appropriate IC reactions
- **Funny moments** - Adds humor when deserved
- **No punishment option** - For friends or gentle declines

---

## Animation Categories

### Standing Animations

No special requirements, just stand close:

- `standart` - Standing Doggy
- `standing_behind` - Standing Behind
- `wallsex` - Against Wall
- And more...

### Bed Animations

Require a bed nearby:

- `cowgirl` - Cowgirl Position
- `missionary` - Missionary
- `spooning` - Spooning
- And more...

**How to use:**
1. Find a bed
2. Stand right next to it
3. Request the animation

### Chair Animations

Require a chair/bench/couch nearby:

- `lapdance` - Lap Dance
- `sitsex` - Sitting Sex
- `couplesit` - Couple Sitting
- And more...

**How to use:**
1. Find a chair
2. Stand right next to it
3. Request the animation

### Romantic Animations

Sweet and intimate:

- `kiss` - Simple Kiss
- `makeout` - Making Out
- `hug_romantic` - Romantic Hug
- And more...

---

## Tips & Tricks

### Getting the Best Experience

✅ **Stand on flat ground**
- Avoid slopes and stairs
- Level surfaces work best

✅ **Face your partner**
- Stand facing the direction you want
- Animations will auto-adjust

✅ **Be patient**
- Give your partner time to respond
- Don't spam requests

✅ **Communicate**
- Use voice chat or text
- Coordinate before requesting

### Finding Props

**For bed animations:**
- Hotels and homes
- Camps and hideouts
- Any building with beds

**For chair animations:**
- Saloons and bars
- Homes and offices
- Outdoor benches

---

## Common Questions

### Q: Can I decline without punishing someone?

**A:** Yes! Use `/tlwdecline 0` to decline without any punishment animation.

### Q: How do I choose which punishment to apply?

**A:** Type `/tlwdecline` to see the menu, then type `/tlwdecline [number]` with the number of your chosen punishment.

### Q: What if I want a random punishment like before?

**A:** The server can still be configured for random punishments if the Config.DeclineWithPunishment setting is enabled and you don't specify a punishment.

### Q: How close do I need to be?

**A:** Within 3 meters (about 10 feet) by default.

### Q: Can I use animations alone?

**A:** No, these are two-player animations only.

### Q: What if no one accepts my request?

**A:** The request expires after 30 seconds automatically.

### Q: Can I request from multiple people?

**A:** No, only one active request at a time.

### Q: What if we're already in an animation?

**A:** You must use `/tlwstop` or `/stopanim` first, then request a new one.

### Q: Do I need to be in a specific position?

**A:** Just stand near your partner. The system auto-positions you.

### Q: Why isn't the animation starting?

**A:** Check:
- You're close enough (3 meters)
- Required prop is nearby (for bed/chair animations)
- Both players accepted/aren't in another animation
- No console errors (press F8)

### Q: Can I create my own animations?

**A:** Players can't, but server admins can add custom animations. See [Adding Animations Guide](ADDING_ANIMATIONS.md).

### Q: Is this NSFW?

**A:** Yes, this is an adult 18+ system. Use responsibly and in appropriate contexts.

---

## Etiquette & Guidelines

### DO ✅

- **Ask permission** before sending requests
- **Respect "no"** - If someone declines, move on
- **Use appropriately** - Consider RP context
- **Be patient** - Give time to respond
- **Communicate** - Talk to your partner

### DON'T ❌

- **Don't spam** requests
- **Don't harass** players who decline
- **Don't use** in inappropriate public areas (unless your server allows)
- **Don't exploit** for griefing
- **Don't demand** acceptance

---

## Roleplay Tips

### For Serious RP

- **Build up** to intimate animations through RP
- **Use emotes** before and after animations
- **Stay in character** during animations
- **Respect boundaries** - Some characters may decline IC

### For Casual Fun

- **Have fun** with the system
- **Try different** animations
- **Laugh** at rejections (punishment animations)
- **Experiment** with positions

---

## Troubleshooting for Players

### Animation Menu Not Opening?

Try:
1. Check resource is loaded (F8 console)
2. Make sure you typed `/tlwanim` or `/tlw` correctly
3. Ask admin to restart the resource

### Partner Not Receiving Request?

- **Get closer** - Within 3 meters
- **Check they're online** - Verify in player list
- **Wait a moment** - Network may be slow
- **Try again** - Resend the request

### Animation Looks Weird?

- **Different props** - Try different bed/chair
- **Ground level** - Move to flatter area
- **Stop and retry** - `/tlwstop` or `/stopanim` then try again

---

## Advanced Usage

### Animation Keys Quick Reference

**Popular animations:**
```
/tlwplay cowgirl         # Cowgirl (needs bed)
/tlwplay missionary      # Missionary (needs bed)
/tlwplay kiss            # Simple kiss
/tlwplay lapdance        # Lap dance (needs chair)
/tlwplay spank           # Spanking
/tlwplay makeout         # Making out
```

**Full list:** See [Animation List](ANIMATIONS.md)

---

## Safety & Consent

### Important Reminders

⚠️ **This is an adult system**
- 18+ content
- Use responsibly
- Respect server rules

⚠️ **Always get consent**
- Ask before sending requests
- Respect "no" answers
- Don't pressure players

⚠️ **Server rules apply**
- Follow your server's guidelines
- Some servers may restrict usage
- Admins can stop animations

---

## Need Help?

**For issues:**
1. Check [Troubleshooting Guide](TROUBLESHOOTING.md)
2. Ask in-game admins
3. Check server Discord
4. Visit www.wolves.land

**For suggestions:**
- Share feedback with admins
- Suggest new animations
- Report bugs

---

<div align="center">

**🐺 THE LAND OF WOLVES 🐺**

*Have fun and be respectful!*

[www.wolves.land](https://www.wolves.land)

</div>
