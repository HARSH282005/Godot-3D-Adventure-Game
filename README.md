# 🎮 Godot 3D Adventure Game

A complete, professional-grade 3D first-person adventure game built with **Godot Engine 4.x**.

## 🌟 Features

✅ **Multiple Weapons** - Pistol, Rifle, Shotgun with unique stats
✅ **Advanced Enemy AI** - Detection, chase, and attack mechanics  
✅ **Boss Fights** - Multi-phase boss battles with scaling difficulty
✅ **Inventory System** - Collect items, use consumables
✅ **Story & Missions** - 4 progressive missions with dialog
✅ **Vehicle System** - Drive a car through the level
✅ **Multiplayer Ready** - Network architecture in place
✅ **Procedural Levels** - Randomly generated platforms and enemies
✅ **HUD & UI** - Health, ammo, score, and mission tracking

## 📋 Game Scripts

| Script | Purpose |
|--------|---------|
| `game_manager.gd` | Core game loop, level loading, scoring |
| `player.gd` | Player controller, movement, weapons |
| `weapon_system.gd` | Shooting mechanics, ammo, damage |
| `enemy_ai.gd` | Basic enemy behavior |
| `boss_ai.gd` | Boss fights with phases |
| `inventory.gd` | Item collection and usage |
| `vehicle.gd` | Car driving mechanics |
| `story_manager.gd` | Mission tracking and dialogs |
| `multiplayer_manager.gd` | Network sync (ready for expansion) |
| `hud.gd` | UI elements and status display |
| `level.gd` | Level generation and spawning |

## 🎮 Controls

| Action | Key |
|--------|-----|
| Move | W/A/S/D |
| Sprint | SHIFT |
| Jump | SPACE |
| Look | Mouse |
| Shoot | Left Click |
| Switch Weapon | 1/2/3 |
| Reload | R |
| Inventory | I |
| Pause | ESC |

## 🚀 Quick Start

1. **Download Godot 4.x**: https://godotengine.org/download
2. **Open Project**: Clone this repo and open in Godot
3. **Setup Input Map** (Project Settings → Input Map):
   - Add `sprint`, `weapon_1`, `weapon_2`, `weapon_3`, `reload`, `inventory`, `interact`
4. **Run Game**: Press F5 or click Play

## 📁 Project Structure

```
project/
├── scripts/
│   ├── game_manager.gd
│   ├── player.gd
│   ├── weapon_system.gd
│   ├── enemy_ai.gd
│   ├── boss_ai.gd
│   ├── inventory.gd
│   ├─�� vehicle.gd
│   ├── story_manager.gd
│   ├── multiplayer_manager.gd
│   ├── hud.gd
│   └── level.gd
├── scenes/
│   ├── main.tscn
│   ├── player.tscn
│   ├── enemy.tscn
│   ├── boss.tscn
│   ├── level1.tscn
│   └── level2.tscn
└── assets/
    ├── models/
    ├── sounds/
    └── textures/
```

## 🎯 Future Enhancements

- [ ] Additional weapon types (Laser, Explosives)
- [ ] RPG skill trees and perks
- [ ] Side quests and NPCs
- [ ] Minimap and navigation
- [ ] Save/Load system
- [ ] Achievements & leaderboards
- [ ] Multiplayer networking
- [ ] More levels and biomes
- [ ] Advanced graphics (shadows, reflections)
- [ ] Voice acting and cinematics

## 🛠️ Technology Stack

- **Engine**: Godot 4.x
- **Language**: GDScript
- **Platform**: Windows, macOS, Linux, Web
- **License**: MIT

## 📞 Contributing

Feel free to submit issues, fork, and create pull requests for any improvements!

## 📜 License

This project is licensed under the MIT License - see LICENSE file for details.

---

**Made with ❤️ using Godot Engine**

For questions or support, open an issue on GitHub!