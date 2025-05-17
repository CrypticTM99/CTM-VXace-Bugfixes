# 🔧 RPG Maker VX Ace Bug Fix Pack (by CrypticTM)

### What’s This?
This is a custom-built bugfix script made by yours truly, **CrypticTM**, specifically for RPG Maker VX Ace. The goal is simple — patch common engine bugs that piss us off and fix things that shouldn’t be broken in the first place. Everything here is tested and made to work *with* other scripts like Yanfly’s without throwing a fit.

---

### 💥 Fixes Included (14 so far):
1. **Poison/regen kills actually collapse enemies** — no more immortals.
2. **Pictures clear their bitmap when erased** — memory leak prevention.
3. **Star tile passability fix** — no more ghost-walking through stuff.
4. **Events don't push through the player in autoruns** — fixed dumb pathing.
5. **Crash from nil features on equip items** — patch for bad database input.
6. **Quick Save title scene crash fix** — safely returns to map now.
7. **EXP curve math rounded properly** — more accurate level scaling.
8. **Confused actors won't attack themselves (unless intended)** — sanity.
9. **Battle Test actors now recover HP/MP** — just like they should.
10. **NaN damage popups no longer show** — stops visual glitches and weird math bugs.
11. **Actors collapse properly at 0 HP** — avoids stuck-in-limbo actors.
12. **Common Events from item use actually trigger from menu** — finally.
13. **BGM autoplay doesn’t reset weirdly after loading** — smoother transitions.
14. **Switch/Var IDs are type-checked** — avoids crashes from bad calls.

---

### 🔧 How to Use:
1. Open RPG Maker VX Ace.
2. Hit F11 or open the Script Editor.
3. Paste this whole thing in a **new slot above Main**, call it something like `Bugfixes`.
4. Save. Done.

This is just the start — future versions will add more patches and possibly config toggles if anyone wants to disable specific ones.

---

### 🧠 Compatibility
- Made with **Yanfly Engine Ace** in mind.
- Doesn’t overwrite base classes in destructive ways.
- All methods are aliased where needed.

---

### 🗣️ License
Do whatever you want with this. Credit **CrypticTM** if you feel like it. Just don’t sell it as your own work — that’s lame.

---

### 🛠️ Contributions
If you find a VX Ace bug I didn’t patch yet, hit me up. Let’s squash ‘em together.

---

**- Credit: CrypticTM**
        RPG MAKER ENGINE - Enterbrain
