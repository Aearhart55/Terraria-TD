================================================================
 PIXEL STATUS & BUFF FX  (v1.0)
 PIXEL FX SERIES - Pack A6 - every status effect your characters can suffer or enjoy
================================================================
Debuff overlays (poisoned, burning, frozen + break free, bleeding, cursed, slowed, petrify, shocked, soaked,
debuff applied, knocked out), buff overlays (haste, heal, regen, mana regen, protect, rage, blessed, invisible,
buff applied, revive, level up), above-head loops (stunned, sleep, charmed, confused, silenced, marked, alert ! / ?,
doom countdown), stat up / down popups and 23 animated 16x16 status icons for HUDs and health bars.
All overlays are sized for 16x32 heroes (like the free 16x16 Pixel series characters) - the anchor goes at the feet.
Same FX64 palette, rules, database columns and engine layout as Packs A1-A5.

----------------------------------------------------------------
HONEST COUNT
----------------------------------------------------------------
57 original animations - 464 original frames (counted by code: global md5 dedupe over every frame cell in the
pack, empty cells skipped; a frame that appears twice counts once).
NOT counted in those numbers (listed for transparency):
  colour variants (Recolors/: stat arrows per stat colour, buff/debuff applied, etc.) .. 20 animations, 167 frames
  rotations / shifts <= 3 px / mirrors found among originals ............................ 0 frames (checked by code)
Per category (originals):
  01_Debuff_Overlays        12 animations    105 frames
  02_Buff_Overlays          11 animations     96 frames
  03_Above_Head              9 animations     60 frames
  04_Popups_OneShots         2 animations     19 frames
  05_Status_Icons_16        23 animations    184 frames

----------------------------------------------------------------
HOW TO USE THEM
----------------------------------------------------------------
  - Overlays (01, 02): anchor pivot(16,44) = the hero's feet. Draw ON TOP of the hero (they leave the body area mostly
    open so the character stays readable). Loops run while the status lasts; one-shots play once.
  - Frozen: play frozen_encase, hold its last frame, then frozen_shatter_free when the status ends.
  - Petrify: hold the last frame (it covers the hero like a statue).
  - Invisible: draw the hero dithered / faded and the shimmer loop on top.
  - Above head (03): anchor = top of the head (bottom-center of the cell), sleep_zzz anchors next to the head.
  - Icons (05): 16x16 loops for HUD rows or above health bars (8 frames at 8 fps).
  - Stat popups (04): red = attack, blue = defense, gold = crit / luck, green = speed / regen, pink = charm (recolors).

----------------------------------------------------------------
FOLDERS
----------------------------------------------------------------
  01_Debuff_Overlays ... 05_Status_Icons_16   horizontal strips: name_WxH_Nf.png (N frames of W x H, left -> right)
  Spritesheets/                               grid sheets (column count in the file name)
  Recolors/                                   colour variants (tagged, not in the headline count)
  Data/fx_database.json + .csv                name, file, sheet, cell size, frames, fps, duration, loop/once, anchor +
                                              anchor_px, hit_frame, directions, blend tip, tag
  Engine/Godot4/  Engine/Unity/               SpriteFrames .tres per category, Unity import notes
  Example_Scenes/  Previews/  Palette/        6 example screens, overview pages + GIFs, FX64 palette files

----------------------------------------------------------------
ENGINE SETUP (short)
----------------------------------------------------------------
  Godot 4: Engine/Godot4/README_GODOT.txt (Nearest filter, load the .tres, offset = -anchor_px).
  Unity: Engine/Unity/UNITY_IMPORT_NOTES.txt (PPU 16, Point, Grid By Cell Size, pivot from anchor_px).
  GameMaker: 'Import Strip Image' with frames = N from the file name, origin = anchor_px.

----------------------------------------------------------------
PALETTE - FX64 (shared with the whole PIXEL FX series)
----------------------------------------------------------------
Same 66-colour FX64 palette as Packs A1-A5 (files in Palette/). Solid shapes (badges, arrows, stone, bubbles) use the
series outline K #2b1e2f; energy and particles have no outline.

----------------------------------------------------------------
HOW A6 FITS THE SERIES
----------------------------------------------------------------
  A1  Super Pixel Effects        impacts, slashes, dust, smoke, fire, sparkles, rings, auras, portals, electric, water, liquids, light, pickups, deaths
  A2  Projectiles                bullets, arrows, fireballs, orbs, missiles, trails, muzzle flashes
  A3  Explosions                 small to huge blasts, debris, mushroom clouds, chain explosions
  A4  Elemental Magic            fire / ice / earth / wind / water / nature / holy / void spells
  A5  Sci-Fi FX                  lasers, shields, warp, holograms, tech sparks
  A6  Status & Buff FX           poison, burn, freeze, stun, shield, haste, sleep icons + overlays
  A7  Weather & Environment FX   rain, snow, fog, leaves, fireflies, lightning
  A8  UI & Pickup FX             button pops, rarity glows, number pops, reward bursts
  A4 spells cause the statuses in A6 (fire bolt -> burning, ice -> frozen, void -> cursed ...).
  Sister series (same palette + rules): PIXEL BESTIARY (monsters, bosses) and PIXEL ARSENAL (heroes, weapons, ships).
  The example scenes use art from the free 16x16 Pixel series.

----------------------------------------------------------------
MADE WITH
----------------------------------------------------------------
Made with AI assistance - programmatically generated pixel art (Python + Pillow), reviewed and curated. Cleanup pass
(no orphan pixels, no speckle, pixel-perfect lines, palette enforced) + a verifier that checks every frame.
