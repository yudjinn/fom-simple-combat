# Easy Combat

**One-shot every monster. Take one damage per hit. That's it.**

## Description

Easy Combat strips combat down to the essentials: every hit you land kills a monster outright, and every hit a monster lands on you costs exactly 1 health. No damage tables, no per-monster tuning, no grinding for better gear just to survive the mines. This is meant for players who want to breeze through combat encounters to focus on farming, fishing, socializing, or story content without combat difficulty getting in the way.

It works by hooking into the game's own damage pipeline (via MMAPI) rather than patching monster data files, so it applies uniformly to every monster the game throws at you, including species with their own special-cased damage handling (e.g. armored types like Clod).

## Features

- Every hit you deal is lethal, regardless of weapon, monster type, or armor.
- Every hit you take is clamped to 1 damage, regardless of monster attack power.
- No configuration needed — install and go.

## Requirements

This mod is built for the [Mods of Mistria Installer (MMAPI)](https://www.nexusmods.com/fieldsofmistria/mods/78?tab=description). You must have it installed for Easy Combat to load. Grab it from that page and follow its installation instructions first.

## Installation

1. Install the [Mods of Mistria Installer](https://www.nexusmods.com/fieldsofmistria/mods/78?tab=description) if you haven't already.
2. Download this mod and extract it.
3. Place the extracted `Easy Combat` folder directly inside your `mods` folder (next to `FieldsOfMistria.exe`, or `mistria-mods` in your home directory on Steam Deck/Linux). Make sure `manifest.json` sits directly inside the mod folder — no nested duplicate folders.
4. Run the Mods of Mistria Installer and click Install.
5. Launch the game.

## Compatibility

Any other mod that also hooks `combat.damage` or `player.incoming_damage` may conflict, since whichever mod's filter runs last wins for that hit. If you notice damage numbers behaving unexpectedly with another combat mod installed, try disabling one of them.

## Known Issues

None currently known. If you find a monster that survives a hit or hits harder than 1 damage, please report it (species and where you encountered it help a lot).

## Permissions

Feel free to reference this mod's approach for your own MMAPI mods. Please don't re-upload this mod itself without permission.

## Credits

- **Author:** yudjinn
- Built against the [Mods of Mistria Installer (MMAPI)](https://www.nexusmods.com/fieldsofmistria/mods/78?tab=description) modding framework.

## Changelog

### 1.0.0
- Initial release. One-hit kills for the player's attacks, 1-damage clamp for incoming monster attacks.
