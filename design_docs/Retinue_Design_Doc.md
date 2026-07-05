# RETINUE — Design Doc
*Working title. Arcade-style co-op party action game.*

Last updated: 2026-07-01

---

## 1. Elevator Pitch

An arcade-style, top-down party action game inspired by Gauntlet, Guild Wars 1's build-crafting, and Dragon's Dogma's companion system. You play a Warden with a magical affinity, fighting alongside a small guild of fellow Wardens (human co-op or AI companions) to wake a sleeping, overgrown world back up — one region at a time.

Local co-op, drop-in/drop-out, low-bit pixel art, short arcade-length sessions ("credits").

---

## 2. World Concept

**Premise:** A great Keeper once tended the world's regions — enchanted forests, snowy woods, crumbling ruins — and led a guild of adult Wardens, one bonded to each region. When the Keeper vanished, the Wardens had nothing to anchor them. One by one, they fell asleep in their own regions — and without anyone tending it, each region's magic began to dream alongside its sleeping Warden, growing wild and unshaped in the process.

**You play a Junior Warden** — a kid who found and bonded with magic on their own, self-appointed rather than trained, with no formal guild to back them up. Whether that's one determined kid or a small band of them (co-op), the Junior Wardens set out to reach the sleeping adult Wardens, calm their dreams, and **wake the world back up.**

**Tone:** Warm, positive, kid-friendly. Not grimdark. Designed to be enjoyable for the creator and his daughters alike.

**Biomes (launch set):** Enchanted forest, snowy forest, crumbling ruins. (Expandable later — swamp, coastline, mountains, etc.)

---

## 3. Who You're Fighting

**No traditional villains.** Every enemy in a zone is a piece of that zone's sleeping Warden's own dream — not a separate species, not malice, just unattended magic drifting without its dreamer awake to shape it.

- **Tangleweed / Drift-things** (working name) — rank-and-file enemies, small fragments/echoes of the dream. Manifests differently per biome: brambles/vine-golems in forests, ice-things in snow, rubble/echo-things in ruins.
- **The zone boss is the dream itself, given a larger elemental form** — directly *of* that zone's sleeping Warden, not a generic monster. Defeating it isn't a kill, it's **pacifying the dream** — which is what lets the Warden actually wake up.
- Framing throughout: not evil, just confused/reactive/out of place. Some rank-and-file enemies could be calmed/untangled rather than only fought (design option for younger players, TBD).
- Fighting is framed as part of "waking" the region, not slaying enemies — ties combat mechanically and narratively into the theme, boss included.

*(Alternative concepts considered and shelved: "Sleepwalkers" acting out old memories; "Snarl-spirits" swarming chaotically — largely folded into the dream framing above, since "sleepwalking/dreaming" is now the literal explanation for every enemy in a zone.)*

---

## 4. Party & Class System

**Terminology (finalized):**
- **Junior Wardens** = the playable characters (human or AI-controlled), always. Self-appointed kids, not formally trained.
- **Wardens** = the adult guild members, one per region, currently asleep and dreaming (see §2, §3). Non-playable.

**Core structure:** Party is always exactly **4 slots**, filled by any mix of human players and AI-controlled Junior Wardens.
- Solo: 1 human + 3 AI Junior Wardens
- Full co-op: up to 4 humans, AI fills any remaining slots
- This keeps balance simple — only ever tuning encounters around "a party of 4," never varying party size.

**Classes (affinities), Gauntlet-style — one clear job, one clear weakness:**

| Affinity | Role | Strength | Weakness |
|---|---|---|---|
| Warrior | Tank/melee | High HP, high melee dmg | No ranged, no sustain |
| Cleric | Support | Healing, buffs | Weak damage |
| Mage | AoE damage | Clears groups | Fragile, limited resource |
| Rogue | Mobility/burst | Fast, high single-target burst | Squishy, no crowd control |

- Class choice made at a Character Select screen, arcade-fighting-game style — no in-run menus.
- Small loadout variants per class possible later (2-3 flavors), but kept light — NOT a full GW1 skill-bar system in the party-select context (that depth lives in the solo prototype, see §7).

**Resource system — resolved decision:** No shared energy/food-style meter. Each skill has its own individual cooldown; health is the only resource being managed. Chosen deliberately to keep the game accessible and not punishing for younger/first-time players — party interdependence (e.g. Warrior needing Cleric nearby) comes from role design alone, not an added meter. A **"Drowsy" status effect** is under consideration as a later, enemy-specific mechanic (not a base-layer system) — certain Tangleweed enemies could inflict a stacking slow/blur effect if the player lingers too close, clearable by moving away or a Cleric buff. Thematically ties into "risk of being pulled into the dream," but scoped to specific harder enemies/zones rather than an always-on tax.

**Class access — resolved decision:** All 4 classes/affinities are playable from the very first credit. No grinding to "unlock" the ability to play a role you want — this avoids frustration (especially for younger players) of being locked out of a favorite class early on. Meta-progression unlocks *flavor and variety*, not core access.

**Waking a Warden — resolved decision:** A Warden is **not** a playable/recruitable party member. Waking one (by pacifying their zone's boss/dream, see §3) makes them a **non-playable mentor figure** who grants a **buff tied to that specific zone** — kept simple and thematic rather than expanding the roster. Keeps the fixed 4-class party clean; "the adults guide, the kids fight" is a deliberate split, not a gap to fill later.

---

## 4a. Character Concepts (Sketches)

Early visual/personality sketches for the four launch classes. Working names only. Soft pattern across the four: each character's magic either **contrasts** with their look/personality (surprising) or **amplifies** it (larger than life) — not a rigid rule, just an observed thread worth keeping in mind for consistency.

**Warrior — "Glasses Kid"**
Skinny, small, glasses. Floating translucent blue armor plates orbit him loosely rather than being worn (pauldrons, a helm, a shield) — the armor does the actual tanking. *Contrast:* looks like the last kid you'd expect to front-line a fight. Possible mechanical tie-in: HP pool visually represented as the armor's integrity, chipping/dimming as he takes hits; if it fully breaks he's briefly exposed (small, unarmored) before it reforms — makes "low HP" a readable visual state rather than just a bar.

**Cleric — "Big Heart"**
Biggest, sturdiest-looking kid of the four — reads as a tank or brawler on sight. Instead, warm gold-green light motes drift around them like fireflies/floating lanterns, mending wounds and buffing allies. *Contrast:* imposing frame, gentlest kid in the group. Warm palette pairs nicely against the Warrior's cold blue armor — two "defensive-ish" roles with opposite color language.

**Mage — "Static"**
Small, quiet, a little scruffy — oversized bag stuffed with loose junk, messy hair, seems distracted or half-elsewhere. When casting, sudden total focus: precise geometric magic circles and orbiting elemental shapes snap into being, wildly at odds with how disheveled they look standing still. *Contrast:* chaotic exterior, exacting/powerful magic — fittingly fragile once the spell's cast, ties into the class's limited-resource weakness.

**Rogue — "Blink"**
Youngest-looking, fidgety and quick even without magic. Twin blades of condensed light/wind, visible afterimage trails when dashing. *Amplifies* rather than contrasts — the magic is just "more of what they already are." Reads almost like a hummingbird: all speed, no armor, matching the class's squishy/no-crowd-control weakness honestly.

---

## 4b. Combat Depth & Class Kits

Goal: low skill floor, high skill ceiling. Every class should feel simple to pick up but reward positioning, timing, and party coordination. All four classes contribute real damage, even Cleric — just shaped to fit their identity rather than a separate bolted-on damage kit.

### Weapon identities

| Class | Weapon | Notes |
|---|---|---|
| Warrior | Sword and shield | Shield could visually be one of the floating armor plates already established (§4a); natural fit for a block/parry skill slot |
| Cleric | Lantern-topped crook/staff | **Resolved** — ties directly into the firefly/light-motes visual already established. Deliberately avoided mace+shield (considered but risked implying front-line melee tank, at odds with the support/fragile identity in §4's role table) |
| Mage | Staff | Visually distinct from Cleric's crook — thinner/darker/more angular |
| Rogue | Daggers (melee + throwable) | **Resolved against** bow/dagger range-based auto-swap — deemed too hard to read (invisible rule tied to distance). Daggers alone cover both ranges via throwing, keeping one consistent weapon silhouette |

### Setup-and-payoff framework

Instead of one fixed combo (e.g. "Rogue traps, Mage AoEs"), each class gets both setup and payoff moments — a web of synergies rather than a single scripted interaction. Rewards party coordination without requiring it.

| Class | Setup (idea) | Payoff it enables |
|---|---|---|
| Rogue | Well/trap — roots or groups enemies in an area (see kit below) | Mage AoE deals bonus damage to grouped/rooted targets |
| Warrior | Shield bash/taunt — pulls nearby enemies together or staggers them | Same Mage AoE payoff; also sets up Rogue's burst on an isolated, staggered target |
| Mage | AoE that applies a lingering status (e.g. "marked"/"chilled") | Warrior or Rogue follow-up deals bonus to marked enemies — Mage becomes a setup role too, not just payoff |
| Cleric | Buff/mark — "detonate" version converts a status into a burst heal or party shield | Rewards thoughtful status use, not just offensive stacking |

### Cleric kit (sketch)

- **Basic attack — Lantern Sweep:** short arc swing of the crook, warm light trailing through it. Modest damage to any Tangleweed caught in the arc; rewards positioning to catch multiple enemies (ties into the grouping payoff above).
- **Signature skill — Light Bolt / Beacon:** a warm, drifting firefly-like orb (not a fast projectile) that travels in a line. One mechanic, two readings — anything it passes through gets hit by whichever effect applies: damage to enemies, healing to allies. Low floor (aim, cast), high ceiling (line up an ally and an enemy in the same throw for full value). Can **detonate** a Mage's "marked" status on contact for a burst of damage + nearby heal — theme/mechanics unity ("punish the dark, nurture the light" in one animation).
- Remaining slots: open (§8).

### Rogue kit (sketch)

- **Basic attack — dagger combo:** standard hits on the same target build a visible stacking combo counter (pips or a brightening glow above the character — must be visually legible, not an invisible rule). The 4th hit is an empowered finisher, dealing bigger damage and applying an "exposed"/vulnerable status other classes can capitalize on.
- **Skill slot — Blink Strike:** short teleport toward/through an enemy, dealing damage on arrival. Visually an exaggerated version of the existing afterimage-trail motif (§4a), so it reads as more of the same language rather than a new effect from nowhere. Keep teleport range fairly short — a shared single-camera co-op screen risks losing a character who zips too far.
- **Skill slot — Well:** a stationary pulsing zone (GW2 Spectre-inspired) rather than a one-shot trap. Double duty like Cleric's orb: enemies inside get slowed/grouped each pulse (setup for Mage AoE), allies standing in it get a small buff (e.g. brief speed boost, or easier "exposed" triggering).
- 4th slot: open — candidates include a defensive/escape option (offsets Rogue's fragility) or a second offensive tool that specifically punishes the "exposed" status, closing the loop with the basic-attack combo.

### Warrior and Mage kits

Not yet sketched in detail beyond weapon identity and role table (§4). To be fleshed out alongside a full skill matrix (see §8).

---

- **Session ("credit") length:** ~10 minutes, 8-15 rooms.
- **Room-to-room loop** (Gauntlet template): enter room → clear/survive enemies → path opens → repeat. Occasional loot, occasional bigger "arena" rooms.
- **Controls:** Joystick/d-pad + 2-3 buttons per player max (Attack, Skill, Dodge/Block). No mid-run menus.
- **Camera:** Single shared screen, no split-screen — keeps the "party together" feeling intact.
- **Difficulty:** Escalates room to room / region to region.
- **Death/lives:** Shared party life pool under consideration (lose a life only when the whole party is down at once) — keeps co-op forgiving without losing stakes. TBD exact rule.

**Setting NOT framed as a "dungeon":** visually reskinned per world concept — overgrown clearings, ruined watchtowers, snowbound glades, etc. Room-based structure is a spatial/encounter template, not a genre commitment.

**Zone selection — nonlinear map:** Between credits (or as a hub screen), the player chooses which zone/region to tackle next from a map — not a fixed linear order. Each zone's Warden, once awakened, grants a **different buff specific to that zone** (exact buffs TBD — e.g. forest Warden might grant a movement/dash boost, snow Warden a defensive buff, ruins Warden something utility-focused). This gives zone choice real strategic weight ("which buff do I want before tackling a harder zone next") rather than being purely cosmetic order-of-play.

**HUD / skill display — resolved decision:** Each Junior Warden has 4 skills, mapped directly to 4 face buttons (no selection step, tap-to-fire if ready) — fits arcade input norms better than a scrollable hotbar. On-screen, the shared HUD is a **segmented bottom strip**, one column per party slot: portrait + name + HP bar, with a compact row of 4 skill icons underneath for human-controlled slots only. AI-controlled slots collapse to a slim portrait+HP strip (no button prompts needed since there's no input to show), so the HUD's visual weight scales down naturally with fewer human players rather than always reserving space for a full 16 icons. Cooldowns shown as a dark overlay wipe on each icon. Alternative considered: per-character floating mini-bars in the world (rejected for v1 — more implementation work for a moving-anchor UI vs. a fixed CanvasLayer strip).

---

## 5a. Level & Zone Structure

**First zone: Enchanted Forest.** Most welcoming/least threatening biome — good emotional on-ramp for a first level, especially for younger players. Diegetic justification: the Forest Warden fell asleep most recently, so their dream (Tangleweed) is the mildest and least tangled — a natural, in-world reason for it to be the easiest zone rather than an arbitrary "level 1" label. Also the best-covered biome in the currently sourced asset pack (anokolisa's 16x16 pack), making it the most practical first build target.

**Zone map — resolved decision:** Not a walkable overworld (would eat into arcade session length). Instead, a **stylized node map** (Mario World / Slay the Spire style) — zones shown as illustrated nodes the player selects directly, no travel time. All zones are technically selectable from the start (true nonlinear choice), but the Forest node is visually the most inviting/lit-up by default, softly nudging new players there without hard-locking anything.

**Within-zone room flow:**
- Mostly linear critical path, Gauntlet-style: clear room → door/path visibly opens → move to next room.
- Optional branch rooms off the main path (bonus loot, rejoin critical path after) add light exploration without threatening session length — always skippable.
- Transition trigger requires the whole party present/ready before advancing (co-op friendly, no one player racing ahead and stranding others).

**Room and zone sizing (concrete numbers):**
- **Room size:** Single screen, no in-room scrolling (matters for shared-camera co-op legibility). Roughly **20×15 tiles** (320×240px native at 16x16, scaled up for modern displays) — comparable to a classic Zelda/Gauntlet room.
- **Zone length:** ~8-12 rooms + 1 boss room, matching the ~10 minute credit length (§5).
- **First zone (Forest) specifically:** shorter than later zones — ~5-6 rooms + boss — acts as a soft on-ramp without being narratively framed as a "tutorial."
- **Boss room:** visually distinct (larger space, hazy/dreamlike border effect fits the "pacifying a dream" theme) so it's unmistakable before the player even enters.

---

Two layers, reinforcing each other:

1. **Score (moment-to-moment hook):** Classic arcade "beat your best." Combo/style multipliers, bonuses for freeing stranded Wardens, clean-play bonuses. Build this first — testable in the very first playable prototype.
2. **Light roguelite meta-progression (session-to-session hook):** Loadout variants and other unlocks accrue over time (see §4). Possible diegetic twist: regions permanently brighten/calm slightly as you replay them successfully, and awakened Wardens' buffs persist across future credits — tying progression directly into the "waking the world" theme rather than a bare stats/unlock screen. Build this after core loop feels good.

---

## 7. Prototype Plan (separate from full party game)

Before building the full party/arcade version, a smaller solo prototype tests the GW1-inspired build-crafting loop in isolation:

- One character, top-down, no party yet.
- 4-5 skills on a bar, individual cooldowns, shared energy pool.
- Skills defined as data (Godot `Resource`/`.tres` files) rather than hardcoded — swappable "build" pieces.
- Attributes (2-3, e.g. Strength/Vitality/Tactics) scale skill effectiveness.
- Build order:
  1. Player movement in empty scene
  2. One hardcoded skill damaging a dummy enemy
  3. Convert to data-driven `SkillData` resources, add 2-3 more
  4. Add energy pool + cooldowns
  5. Build skill bar UI wired to signals

**Engine/stack:** Godot 4.x, GDScript (not C# — negligible work-transfer benefit vs. GDScript's faster iteration and better docs/community support for a solo learning project).

---

## 8. Open Questions / TBD

- Whether some Tangleweed enemies can be "calmed" non-violently
- Specific loadout variants per class (how many, how different)
- Exact per-zone Warden buffs (what each region's buff actually does)
- If/when the "Drowsy" status effect gets introduced, which enemies/zones use it, and exact tuning (stack rate, clear conditions)
- Full skill matrix — Warrior and Mage kits not yet sketched (only weapon identity + role table so far); Cleric and Rogue kits sketched but not final (§4b); Rogue's 4th skill slot still open
- Life/continue rules for co-op
- Naming: world name, specific enemy names, specific Warden and Junior Warden character names
- Visual style reference pack / palette decisions
- Future in-run flavor mechanics (TBD — old "find a stranded Junior Warden" idea scrapped, may revisit with something else later)

---

## 9. Reference Points (prior art discussed)

- **Guild Wars 1** — skill bar as build, dual-profession (simplified out for prototype), attributes, henchmen, energy/recharge economy
- **Dragon's Dogma** — Pawn companions, inclination/behavior-driven AI
- **Gauntlet** — room-based arcade structure, class role-locking, shared resource pressure, drop-in/drop-out co-op
- **Guardian Heroes** — closest existing hybrid of beat-em-up + party RPG builds
- **Capcom D&D beat-em-ups** (Tower of Doom, Shadow over Mystara) — visual/combat-feel inspiration, aspirational art bar
- **TMNT: Shredder's Revenge** — proof modern beat-em-ups can have real combat depth
- **Minecraft Dungeons** — presentation/co-op accessibility reference; contrast case for fixed vs. flexible class roles
