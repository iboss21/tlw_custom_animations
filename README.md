<!--
    ╔════════════════════════════════════════════════════════════════════════════════╗
    ║                                                                                ║
    ║                        🐺 THE LAND OF WOLVES 🐺                               ║
    ║                     Advanced Custom Animations System                          ║
    ║                                                                                ║
    ║                          www.wolves.land                                       ║
    ║                          Created by: iBoss                                     ║
    ║                                                                                ║
    ╚════════════════════════════════════════════════════════════════════════════════╝
-->

# 🐺 TLW Custom Animations

**Advanced Player-to-Player Interactive Animation System for RedM**

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/iboss21/tlw_custom_animations)
[![License](https://img.shields.io/badge/license-All%20Rights%20Reserved-red.svg)](LICENSE)
[![Performance](https://img.shields.io/badge/resmon-0.01ms-green.svg)](https://github.com/iboss21/tlw_custom_animations)

---

## 📖 Quick Links

- [Installation Guide](docs/INSTALLATION.md)
- [Configuration Guide](docs/CONFIGURATION.md)
- [Animation List](docs/ANIMATIONS.md)
- [Performance Guide](docs/PERFORMANCE.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)

---

## ✨ Features

🎭 **40+ Adult Animations** - Extensive synchronized two-player animations  
🤝 **Request/Accept System** - Interactive player invitations  
💥 **Rejection Punishment** - Funny consequences for declined requests  
🛏️ **Smart Prop Detection** - Auto-detect beds, chairs, and furniture  
🎮 **Multi-Framework** - RSG-Core and LXR-Core support  
⚡ **Supreme Performance** - Optimized to ~0.01ms resmon  
🌐 **Multilingual Ready** - Easy localization system  
🔒 **Secure** - Built-in validation and anti-abuse

---

## 🚀 Quick Start

```bash
# 1. Clone or download
git clone https://github.com/iboss21/tlw_custom_animations.git

# 2. Place in resources folder
mv tlw_custom_animations server-data/resources/[local]/

# 3. Configure (edit config.lua)
Config.Framework = "RSG"  # or "LXR"

# 4. Add to server.cfg
ensure tlw_custom_animations

# 5. Restart server
```

---

## 🎮 Basic Usage

```
/anim                    # Open animation menu
/playanim [key]         # Request animation
/acceptanim             # Accept request
/declineanim            # Decline (triggers punishment)
/stopanim               # Stop animation
```

---

## 🎭 Animation Categories

| Category | Count | Requires Prop |
|----------|-------|---------------|
| Standing Positions | 10+ | ❌ |
| Bed Animations | 13+ | 🛏️ Yes |
| Chair Animations | 7+ | 💺 Yes |
| Oral Positions | 2+ | ❌ |
| Romantic | 6+ | ❌ |
| Spanking | 3+ | ❌ |
| Punishment (Auto) | 6+ | ❌ |

---

## ⚙️ Configuration

```lua
-- Framework
Config.Framework = "RSG"              -- RSG-Core or LXR-Core

-- Request Settings
Config.RequestTimeout = 30000         -- 30 seconds
Config.MaxDistance = 3.0              -- 3 meters
Config.DeclineWithPunishment = true   -- Enable punishment
Config.PunishmentChance = 75          -- 75% chance
```

---

## 📊 Performance Metrics

| Metric | Value |
|--------|-------|
| **Resmon Usage** | ~0.01ms |
| **Memory** | <2MB |
| **Network** | Minimal |
| **Server Impact** | Near-zero |

### Optimization Features
✅ Cached animation dictionaries  
✅ Cached prop hashes  
✅ Optimized distance calculations  
✅ Event-driven architecture  
✅ Smart player ped caching  
✅ No continuous loops

---

## 📚 Documentation

### For Users
- [Installation Guide](docs/INSTALLATION.md) - Step-by-step setup
- [User Guide](docs/USER_GUIDE.md) - How to use the system
- [Animation List](docs/ANIMATIONS.md) - All available animations
- [Troubleshooting](docs/TROUBLESHOOTING.md) - Common issues

### For Developers
- [Configuration](docs/CONFIGURATION.md) - All config options
- [Adding Animations](docs/ADDING_ANIMATIONS.md) - Create custom animations
- [Performance](docs/PERFORMANCE.md) - Optimization details
- [API Reference](docs/API.md) - Events and exports

---

## 🛠️ Requirements

- **RedM Server**
- **Framework:** RSG-Core or LXR-Core
- **No dependencies**

---

## 🐛 Support

Having issues? Check our documentation:

1. [Troubleshooting Guide](docs/TROUBLESHOOTING.md)
2. [FAQ](docs/FAQ.md)
3. Join our Discord: **The Land of Wolves**
4. Visit: **www.wolves.land**

---

## 📝 License

**All Rights Reserved - The Land of Wolves**

This script is proprietary software owned by The Land of Wolves (www.wolves.land) and iBoss.  
Unauthorized copying, distribution, or modification is prohibited.

---

## 🙏 Credits

**Created by:** iBoss  
**Community:** The Land of Wolves  
**Website:** [www.wolves.land](https://www.wolves.land)  
**Version:** 1.0.0

---

<div align="center">

### 🐺 THE LAND OF WOLVES 🐺

*Where legends are born and adventures never end*

**[www.wolves.land](https://www.wolves.land)**

</div>
