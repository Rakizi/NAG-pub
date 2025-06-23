Perfect. Here is your **Global Project Prompt** that fully describes the transformation plan:

---

# ✅ **Global Prompt: UptimeTracker Refactor Plan**

The goal is to evolve `UptimeTracker` ([text](UptimeTracker.lua)) into a fully standalone per-class per-spec configurable module, following the same design patterns as `RotationManager` [text](RotationManager.lua).

### **High-Level Goals:**

1. **Standalone Window:**
   UptimeTracker should have its own AceGUI window opened via a new button under `/nag` → Class tab, positioned alongside RotationManager.

2. **Per-Spec Configuration:**
   Each specialization has its own isolated list of tracked uptime bars. Switching specs automatically loads correct configuration.

3. **Multiple Bars:**

* Each uptime tracker consists of multiple bars.
* Each bar can track multiple spells (e.g., buff/debuff/cooldown type per spell).
* All visual settings (width, color, icon size, max track time, inactive behavior, etc.) apply per bar.

4. **Dynamic Management UI:**

* The bar management window allows full CRUD (Create, Read, Update, Delete) operations on bars and spells.
* Dynamic forms similar to RotationManager’s list table interface.

5. **Import/Export:**

* Full serialization and deserialization of the uptime configuration via string encoding.
* Integrated into existing `ImportExport` system.

6. **Persistence:**

* Frame position, size, state, window status, and all user changes persist via AceDB per-character profiles.

7. **Reusability:**

* Whenever possible, reuse RotationManager patterns, helper modules (`SpecializationCompat`, `ImportExport`).

---

# 🧱 **Phases of Development:**

We will proceed step-by-step in the following phases:

### Phase 1 — UI Structure

* Create new `/nag` Class button for UptimeTracker (alongside RotationManager).
* Create a standalone window (AceGUI frame, persistent size & position).

### Phase 2 — Per-Spec Data Model

* Migrate data storage from global profile to per-spec saved data structure.

### Phase 3 — Bar & Spell Management

* Design dynamic bar creation interface: add/remove bars, assign multiple spells, configure visuals.

### Phase 4 — Visibility & Spec Toggling

* Allow toggling per-bar activation by spec.

### Phase 5 — Import/Export

* Add ImportExport serialization logic for uptime trackers.

### Phase 6 — Polish & Testing

* Bug fixes, edge cases, UI polishing, and documentation.

---

# ⚠ **Principles To Follow:**

* Always follow RotationManager’s design structure as reference.
* Small incremental changes that can be immediately tested after each prompt.
* Do not modify core functionality of how buffs/debuffs/cooldowns are tracked — only re-architect the management layer.
* Keep backward compatibility as long as possible.

---

---
Plase 1:
---
# 🔧 **Prompt 1**
Add UptimeTracker Button to Class Menu
Task:
Create a new button entry under /nag > Class tab, placed alongside RotationManager button.

When clicked, it toggles the new UptimeTracker window (which for now can be an empty AceGUI frame — we will build it in later steps).

This is only the UI hook, no management logic yet.

Reference:
Use the same pattern used by RotationManager for its toggle button and frame creation.

You will likely modify the Class module file where RotationManager is being registered into the Class menu.

---

# 🔧 **Prompt 2 — Create Per-Spec Data Model for UptimeTracker**

### Task:

* Transition UptimeTracker from its current **profile-wide single configuration** to a **per-specialization configuration model**.
* Mimic the data organization used by RotationManager, which stores data per spec.

---

## 📊 **Data Structure Suggestion**

At character level (`char` DB scope):

```lua
char = {
  uptimeTrackers = {
    [specID] = {
      bars = {
        [barID] = {
          name = "Custom name",
          enabled = true,
          spells = { 12345, 67890 },  -- list of tracked spell IDs
          type = "buff" | "debuff" | "cooldown",
          unit = "player" | "target" | "focus",
          visuals = { ... }  -- bar color, size, icon size, etc
        },
        ...
      }
    },
  },
}
```

---

## 🏷 **Implementation Steps**

1️⃣ Create `defaults` with new char scope DB for UptimeTracker:

* Use `self.db = NAG.db:RegisterNamespace("UptimeTracker", defaults)`
* But in `defaults`, add `char` instead of just `profile` level.

Example:

```lua
local defaults = {
  char = {
    uptimeTrackers = {}
  }
}
```

2️⃣ On module enable, detect active specialization:

* Use `SpecializationCompat:GetActiveSpecialization()` to retrieve specID

3️⃣ Ensure that for current specID, a structure exists:

* If not, create empty `{ bars = {} }` table for that specID.

Example:

```lua
if not self.db.char.uptimeTrackers[specID] then
  self.db.char.uptimeTrackers[specID] = { bars = {} }
end
```

4️⃣ From now on, store bars under the current active specialization.

---

## 🚩 **Important Notes**

* For now, no UI changes. No need to edit the management window yet.
* The old `profile.trackedAuras` table becomes obsolete — but we keep it for now untouched for backward compatibility.
* In next steps we will migrate UI to work with this new structure.



Excellent feedback — fully agreed. You’re stable with the project direction, so we can safely *bundle* a few logically grouped steps now.

Let’s proceed with **Prompt 3 Expanded** — this will cover more ground while still being safe and fully testable.

---

# 🔧 **Prompt 3 (Expanded): Fully Migrate Management UI to Per-Spec Bars & Simplify Future Flow**

---

## 🧱 Task A — Full Switch to Per-Spec Bars

* Completely stop reading or writing from `self.db.profile.trackedAuras`.
* Fully operate on `self.db.char.uptimeTrackers[specID].bars`.
* On window open:

  * Detect current `specID` (via `SpecializationCompat`).
  * Ensure bars table exists.
  * Load and manage bars for that spec.

---

## 🧱 Task B — Adapt Bar Management UI

For each bar in `bars`:

* Show editable:

  * **Bar Name**
  * **Enabled Toggle**
  * **Type** (`buff` / `debuff` / `cooldown`)
  * **Unit** (`player` / `target` / `focus`)
  * **Spells list** (for now allow simple string of comma-separated spell IDs)
  * **Visuals (keep the existing visuals config here)**

* Allow:

  * **Add New Bar**
  * **Delete Bar**

---

## 🧱 Task C — Data Structure per Bar

For each bar:

```lua
{
  id = "unique_bar_id",
  name = "My Cool Bar",
  enabled = true,
  type = "buff",
  unit = "player",
  spells = { 12345, 67890 }, -- list of spellIDs
  visuals = {
    width = 200,
    height = 10,
    color = { r=1, g=0.5, b=0, a=1 },
    iconSize = 32,
    iconZoom = 1.0,
    showInactive = true
  }
}
```

👉 This replaces the old `trackedAuras` entirely.

---

## 🧱 Task D — Add Core CRUD Operations

* Add “Add Bar” button — creates a new bar with default values.
* Add “Delete” button per bar row.

---

## 🧱 Task E — Prepare for Future Rendering Step

* In this prompt, you don’t need to render the bars on screen yet.
* But you should **fully update the management window to reflect this new model**.

---

# 🎯 Summary Goal for this Prompt:

> By the end of this expanded Prompt 3, I expect to have a fully functioning per-spec bar manager window that allows creating, editing, and deleting bars — with all configs stored correctly per specialization.
