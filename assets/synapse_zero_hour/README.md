# SYNAPSE: ZERO-HOUR Asset Manifest & Governance

Curated on 2026-09-16 for **SYNAPSE: ZERO-HOUR**, a mobile-portrait cyberpunk lo-fi tactical auto-battler and gacha RPG.

## Upstream Provenance & Licensing

All assets in this directory are licensed under **Creative Commons Zero 1.0 Universal (CC0)** (Public Domain) or equivalent zero-restriction open licenses, verified for unrestricted commercial use, modification, and bundling.

- **Kenney.nl**: UI Pack Sci-Fi, Sci-Fi Sounds, Digital Audio, Interface Sounds, Casino Audio, Crosshair Pack, Light Masks (CC0 1.0 Universal).
- **Superpowers Asset Packs (Sparklin Labs)**: RPG Battle System Characters, Top-Down Shooter Music & Effects (CC0 1.0 Universal).

## Directory Architecture

\synapse_zero_hour/
├── audio/
│   ├── bgm/
│   │   ├── ambient_bunker_loop.ogg        # Low-drone industrial hum with periodic emergency siren resonance
│   │   └── combat_adrenaline_loop.ogg     # 140+ BPM tactical cyberpunk combat drum & synth loop
│   └── sfx/
│       ├── reroll_terminal_clack.ogg      # Mechanical keyboard key-down tactile feedback
│       ├── reroll_success_ping.ogg        # High-frequency digital chime (slot jackpot tone)
│       ├── zero_hour_alarm.ogg            # Harsh pulsating klaxon buzzer (expiration warning)
│       ├── unit_overclock_discharge.ogg   # Heavy sub-bass drop followed by electric arc
│       ├── sfx_laser_fire.ogg             # Tactical pulse laser shot
│       ├── sfx_metal_impact.ogg           # Heavy armor impact hit
│       └── sfx_glitch_flatline.ogg        # Critical glitch noise when unit is flatlined
├── shaders/
│   ├── crt_screen.gdshader                # Screen-space CRT monitor shader (scanlines, barrel curve, RGB split)
│   ├── glitch_effect.gdshader             # Procedural UV displacement glitch for crits/flatlines
│   └── holographic_foil.gdshader          # Rainbow iridescent foil shader for Glitch-Tier gear cards
├── sprites/
│   ├── grid/
│   │   ├── tile_normal.png                # 256x256 Tactical grid cell with cyan wireframe
│   │   ├── tile_highlight.png             # 256x256 Valid unit placement tile (neon green glow)
│   │   ├── tile_danger.png                # 256x256 Threat zone tile with hazard indicators
│   │   └── tile_synergy.png               # 256x256 Synergized aura tile with neon circuit glow
│   ├── gear/                              # 20 Neural Node icons (4 slots x 5 rarity tiers, 128x128)
│   │   ├── node_processor_[tier].png      # CPU silicon chip with pins across Common to Glitch tiers
│   │   ├── node_heatsink_[tier].png       # Cooling fin array across Common to Glitch tiers
│   │   ├── node_memory_[tier].png         # RAM PCB strip with DRAM blocks across Common to Glitch tiers
│   │   └── node_powerbus_[tier].png       # Capacitor energy cell across Common to Glitch tiers
│   ├── ui/
│   │   ├── terminal_frame_9slice.png      # 9-slice phosphor green CRT terminal window frame
│   │   ├── health_bar.png                 # Segmented phosphor green health bar gauge
│   │   ├── stamina_bar.png                # Segmented amber overclock/action gauge bar
│   │   ├── padlock_locked.png             # Silicon Forge stat-lock active padlock indicator
│   │   ├── padlock_unlocked.png           # Silicon Forge stat-lock unlocked padlock indicator
│   │   ├── pull_lever.png                 # Zero-Hour Gacha terminal activation lever
│   │   ├── crosshair_reticle.png          # Tactical lane targeting crosshair indicator
│   │   ├── clock_counter_badge.png        # 30-min flash overclock countdown timer HUD badge
│   │   └── button_cyber_green.png         # Tactile phosphor green terminal button
│   ├── units/                             # Base 4 Playable Cyberpunk Operatives
│   │   ├── unit_vanguard/                 # Aegis-01: Frontline Heavy Mech Tank (idle, attack, hit, portrait, sheet)
│   │   ├── unit_infiltrator/              # Kage-X: Frontline Agile Cyber-Ninja (idle, attack, hit, portrait, sheet)
│   │   ├── unit_netrunner/                # Cipher-9: Backline Glitch Weaver / Hacker (idle, attack, hit, portrait, sheet)
│   │   └── unit_medic/                    # Synapse-Core: Backline Battery / Support (idle, attack, hit, portrait, sheet)
│   └── backgrounds/                       # 1080x1920 Parallax Backgrounds (3 themes x 3 layers)
│       ├── bunker_command_terminal/       # Wall, Server racks, Tactical console
│       ├── corrupted_server_room/         # Hall, Code cascades, Power conduits
│       └── neo_voxel_slums/               # Smog skyline, Cyber-slum structures, Foreground antennas
└── MANIFEST.json                          # Machine-readable inventory with exact file metadata
