--itemhandlers README.md


# Item Proc/Trinket Function Documentation

This documentation outlines the core functions for handling item procs and trinkets, based on the implementation from wowsims/cata.

## Core Functions Overview

### Important Note: WoWsims Compatibility
The NAG system is designed to work in conjunction with wowsims/cata (https://github.com/wowsims/cata). As such, all function implementations MUST strictly adhere to the following principles:
1. Functions must accept exactly the same parameters as their WoWsims counterparts
2. Function behavior must match WoWsims implementation exactly
3. No additional parameters or functionality can be added that isn't present in WoWsims
4. All APL translations must maintain exact parity with WoWsims logic

This is crucial because NAG interprets rotation logic exported from WoWsims. Any deviation from WoWsims' implementation will result in incorrect rotation suggestions.

### Recent Changes - Stack Counting Alignment
The following changes were made to align with WoWsims' stack counting implementation:

**2024-03-XX - Stack Counting Update**
- Removed `minStacks` parameter from `AllTrinketStatProcsActive` to match WoWsims
- Modified proc active check to only consider procs "active" when at max stacks
- Updated stack counting logic to use trinket's defined max stacks
- Added debug logging for current/max stack tracking
- Improved cache key generation to reflect stack changes
- Updated documentation to clarify max stack requirement

### 1. AllItemProcBuffsActive
**Purpose**: Verifies if ALL equipped items matching specific stat types have their procs active at maximum stacks.

**Implementation Requirements**:
- Check if proc is active
- Verify proc is at maximum stacks
- Confirm item can still proc
- Return false if ANY matching item fails these conditions

**Usage Context**: 
- Used when an action requires all proc effects to be active
- Typically used in optimization scenarios where you want to stack all buffs

### 2. AnyItemProcBuffActive
**Purpose**: Checks if ANY equipped item matching specific stat types has its proc active.

**Implementation Requirements**:
- Only needs one item to be active at max stacks
- Returns true on first found active proc at max stacks
- Should still verify proc capability

**Usage Context**:
- Used when you need at least one proc effect to be active
- Useful for abilities that consume or benefit from any proc

### 3. ItemProcsMinRemainingTime
**Purpose**: Determines the shortest remaining duration among active procs.

**Implementation Requirements**:
- Track only currently active procs
- Calculate remaining duration for each proc
- Return maximum duration if no procs are active
- Take minimum of all active proc durations

**Usage Context**:
- Used to time actions based on proc expiration
- Helpful for planning when to refresh buffs

### 4. ItemProcsMaxRemainingICD
**Purpose**: Finds the longest remaining internal cooldown among matching items.

**Implementation Requirements**:
- Check only items that:
  * Can proc
  * Are not currently active
  * Have an internal cooldown
- Calculate remaining ICD time

**Usage Context**:
- Used to know when all items will be ready to proc again
- Helpful for planning burst windows

### 5. NumEquippedStatProcItems
**Purpose**: Counts equipped items that match specified stat types.

**Implementation Requirements**:
- Count items that:
  * Match requested stat types
  * Can currently proc
- Don't consider active status
- Handle both custom and hardcoded items

**Usage Context**:
- Used to know how many potential proc sources are available
- Helpful for decision making in rotations

## Core Components

### Item Registration System
```lua
-- Example structure for registering items
function Character:AddStatProcBuff(effectID, procAura, isEnchant, eligibleSlots)
    -- Check if item/enchant is equipped
    -- Track proc aura
    -- Handle equipment swap events
end
```

### Stat Type Matching System
Needs to handle:
- Single stat matching
- Multiple stat combinations
- Any/All matching logic
- Minimum ICD requirements

### Aura Tracking System
Requirements:
- Track active procs
- Monitor stack counts
- Handle internal cooldowns
- Manage proc chances

## Implementation Considerations

### 1. Data Sources
- Custom user-added trinkets
- Hardcoded database trinkets
- Need to handle both sources uniformly

### 2. Performance
- Efficient aura tracking
- Smart caching of frequently accessed values
- Minimize unnecessary checks

### 3. Error Handling
- Handle missing items gracefully
- Validate stat types
- Check for nil values

### 4. Extensibility
- Allow for new trinket types
- Support custom proc conditions
- Maintain backwards compatibility

## Usage Examples
```lua
-- Example: Check if all haste procs are active
local allActive = AllItemProcBuffsActive(Stats.HASTE)

-- Example: Get minimum remaining time on crit procs
local timeLeft = ItemProcsMinRemainingTime(Stats.CRIT)

-- Example: Count equipped proc trinkets
local count = NumEquippedStatProcItems(Stats.HASTE, Stats.CRIT)
```

## Best Practices
1. Always validate inputs
2. Handle both custom and hardcoded trinkets
3. Consider ICD requirements
4. Implement proper error handling
5. Add debug logging for troubleshooting
6. Maintain consistent API across functions
7. Document edge cases and limitations

## Related Systems
- Equipment Manager
- Aura Tracking
- Stat Management
- Combat Log Processing
- Event Handling

## Function Cascade and Interactions

### Base Structure
All item proc functions inherit from a common base structure that handles core functionality:
```go
type APLValueItemStatProcCheck struct {
    DefaultAPLValueImpl
    baseName        string
    includeWarnings bool
    statTypesToMatch []stats.Stat
    matchingAuras    []*StatBuffAura
}
```

### Core Systems Integration

1. Aura System
- Primary system for buff tracking
- Handles proc conditions and stacks
- Manages buff durations and expirations
```go
type StatBuffAura struct {
    *Aura
    BuffedStatTypes []stats.Stat
    CustomProcCondition func(sim *Simulation, aura *Aura) bool
    IsSwapped bool
}
```

2. Proc Trigger System
- Manages proc chances and conditions
- Handles internal cooldowns
- Integrates with combat events

3. Item Registration System
- Tracks equipped items
- Manages item swapping
- Handles item set bonuses

### Function Flow Examples

1. AllItemProcBuffsActive Flow:
```
APL Call
↓
APLValueItemStatProcCheck (base functionality)
↓
GetAPLItemProcAuras (get matching auras)
↓
For each aura:
  - Check IsActive()
  - Verify GetStacks() vs MaxStacks
  - Confirm CanProc()
```

2. ItemProcsMinRemainingTime Flow:
```
APL Call
↓
APLValueItemStatProcCheck (base functionality)
↓
GetAPLItemProcAuras (get matching auras)
↓
For each active aura:
  - Check IsActive()
  - Get RemainingDuration()
  - Track minimum duration
```

### Data Flow

1. Item Registration:
```
AddStatProcBuff
↓
Register with TrinketTrackingManager
↓
Create StatBuffAura
↓
Setup proc triggers
```

2. Proc Handling:
```
Combat Event
↓
Check ProcTrigger conditions
↓
Verify ICD status
↓
Apply proc effects
↓
Update aura status
```

### System Interactions

1. Stat System Integration:
- Procs can modify character stats
- Stats are updated dynamically
- Changes trigger recalculations

2. Combat System Integration:
- Procs respond to combat events
- Can trigger additional effects
- May modify combat mechanics

3. Equipment System Integration:
- Tracks equipped items
- Handles set bonuses
- Manages item swapping

This cascade system ensures:
- Efficient proc tracking
- Accurate buff management
- Proper stat calculations
- Combat event integration
- Equipment state tracking

This documentation is based on the implementation from wowsims/cata and adapted for our NAG addon's needs.

## Technical Implementation Details

### Core Components

1. Base Structure (`APLValueItemStatProcCheck`)
```go
type APLValueItemStatProcCheck struct {
    DefaultAPLValueImpl
    baseName        string
    includeWarnings bool
    statTypesToMatch []stats.Stat
    matchingAuras    []*StatBuffAura
}
```
This parent struct provides:
- Common functionality for all proc checks
- Stat type matching logic
- Warning and validation handling
- Aura tracking and management

2. Aura System (`StatBuffAura`)
```go
type StatBuffAura struct {
    *Aura
    BuffedStatTypes []stats.Stat
    CustomProcCondition func(sim *Simulation, aura *Aura) bool
    IsSwapped bool
}
```
Handles:
- Buff state tracking
- Duration management
- Stack counting
- Custom proc conditions
- Item swap state

### Function Implementations

1. AllItemProcBuffsActive
```go
func (value *APLValueAllItemStatProcsActive) GetBool(sim *Simulation) bool {
    for _, aura := range value.matchingAuras {
        if (!aura.IsActive() || (aura.GetStacks() < aura.MaxStacks)) && aura.CanProc(sim) {
            return false
        }
    }
    return true
}
```
- Checks all matching auras
- Verifies active state and stacks
- Confirms proc availability

2. NumEquippedStatProcTrinkets
```go
func (character *Character) GetMatchingItemProcAuras(statTypesToMatch []stats.Stat, minIcd time.Duration) []*StatBuffAura {
    includeIcdFilter := (minIcd > 0)
    return FilterSlice(character.ItemProcBuffs, func(aura *StatBuffAura) bool {
        return aura.BuffsMatchingStat(statTypesToMatch) && 
               (!includeIcdFilter || ((aura.Icd != nil) && (aura.Icd.Duration > minIcd)))
    })
}
```
- Filters proc buffs by stat type
- Handles ICD requirements
- Manages both custom and hardcoded trinkets

### Data Flow

1. Proc Registration:
```
AddStatProcBuff
↓
Register with TrinketTrackingManager
↓
Create StatBuffAura
↓
Setup proc triggers and conditions
```

2. Proc Activation:
```
Combat Event
↓
Check ProcTrigger conditions
↓
Verify ICD status
↓
Apply proc effects
↓
Update aura state
```

### Integration Points

1. Combat System:
- Procs respond to combat events
- Manages ICD tracking
- Handles proc chance calculations

2. Stat System:
- Dynamic stat modifications
- Buff stacking
- Stat type matching

3. Equipment System:
- Item swap management
- Set bonus integration
- Equipment state tracking

### Best Practices

1. Proc Management:
- Always check both custom and hardcoded sources
- Validate proc conditions before activation
- Handle ICD properly

2. Stat Handling:
- Use proper stat type matching
- Handle stat stacking correctly
- Manage buff durations

3. Error Prevention:
- Validate aura existence
- Check for nil values
- Handle edge cases

4. Performance:
- Cache frequently accessed values
- Use efficient filtering
- Minimize redundant checks

## Implementation Examples

### 1. Basic Stat Proc Trinket
```go
// Example: Heart of Ignacious
procAura := core.MakeStackingAura(character, core.StackingStatAura{
    Aura: core.Aura{
        Label:     "Heart's Revelation",
        ActionID:  core.ActionID{SpellID: 91027},
        Duration:  time.Second * 15,
        MaxStacks: 5,
    },
    BonusPerStack: stats.Stats{stats.SpellPower: 77},
})

triggerAura := core.MakePermanent(core.MakeProcTriggerAura(&character.Unit, core.ProcTrigger{
    Name:       "Heart of Ignacious Aura",
    ActionID:   core.ActionID{ItemID: heartItemID},
    Callback:   core.CallbackOnSpellHitDealt,
    ProcMask:   core.ProcMaskSpellDamage,
    ProcChance: 1,
    Outcome:    core.OutcomeLanded,
    ICD:        time.Second * 2,
    Handler: func(sim *core.Simulation, spell *core.Spell, result *core.SpellResult) {
        procAura.Activate(sim)
        procAura.AddStack(sim)
    },
}))
```

### 2. Complex Multi-Stat Proc
```go
// Example: Deathbringer's Will
strAura := character.NewTemporaryStatsAura("Strength Proc", actionID, 
    stats.Stats{stats.Strength: amount}, time.Second*30)
agiAura := character.NewTemporaryStatsAura("Agility Proc", actionID, 
    stats.Stats{stats.Agility: amount}, time.Second*30)
apAura := character.NewTemporaryStatsAura("AP Proc", actionID, 
    stats.Stats{stats.AttackPower: amount * 2}, time.Second*30)

triggerAura := core.MakeProcTriggerAura(&character.Unit, core.ProcTrigger{
    Name:       "Deathbringer's Will",
    Callback:   core.CallbackOnSpellHitDealt,
    ProcMask:   core.ProcMaskMeleeOrRanged,
    Outcome:    core.OutcomeLanded,
    ProcChance: 0.35,
    ICD:        time.Second * 105,
    Handler: func(sim *core.Simulation, spell *core.Spell, result *core.SpellResult) {
        rand := sim.RandomFloat("Deathbringer's Will")
        if rand < 1.0/3.0 {
            strAura.Activate(sim)
        } else if rand < 2.0/3.0 {
            agiAura.Activate(sim)
        } else {
            apAura.Activate(sim)
        }
    },
})
```

### 3. Defensive Proc with Health Check
```go
// Example: Corpse Tongue Coin
procAura := character.NewTemporaryStatsAura("Corpse Tongue Coin Proc", 
    actionID, stats.Stats{stats.Armor: amount}, time.Second*10)

icd := core.Cooldown{
    Timer:    character.NewTimer(),
    Duration: time.Second * 30,
}

triggerAura := core.MakeProcTriggerAura(&character.Unit, core.ProcTrigger{
    Name:     "Corpse Tongue Coin Trigger",
    Callback: core.CallbackOnSpellHitTaken,
    ProcMask: core.ProcMaskMelee,
    Harmful:  true,
    Handler: func(sim *core.Simulation, spell *core.Spell, result *core.SpellResult) {
        if icd.IsReady(sim) && character.CurrentHealthPercent() < 0.35 {
            icd.Use(sim)
            procAura.Activate(sim)
        }
    },
})
```

### 4. Stacking Proc System
```go
// Example: Stacking Stat Bonus
buffAura := core.MakeStackingAura(character, core.StackingStatAura{
    Aura: core.Aura{
        Label:     "Stacking Proc",
        ActionID:  auraID,
        Duration:  duration,
        MaxStacks: maxStacks,
    },
    BonusPerStack: bonusPerStack,
})

core.ApplyProcTriggerCallback(&character.Unit, buffAura, core.ProcTrigger{
    Name:       name,
    Callback:   callback,
    ProcMask:   procMask,
    SpellFlags: spellFlags,
    Outcome:    outcome,
    Handler: func(sim *core.Simulation, spell *core.Spell, result *core.SpellResult) {
        buffAura.AddStack(sim)
    },
})
```

### 5. Item Swap Integration
```go
// Example: Registering proc with item swap handling
character.AddStatProcBuff(effectID, procAura, isEnchant, eligibleSlots)

character.RegisterItemSwapCallback(eligibleSlots, func(sim *core.Simulation, slot proto.ItemSlot) {
    procAura.IsSwapped = !hasEquippedCheck(effectID, eligibleSlots)
})
```

### Common Patterns

1. Proc Registration:
```go
// Basic pattern for registering a proc
core.MakeProcTriggerAura(&character.Unit, core.ProcTrigger{
    Name:       name,
    ActionID:   actionID,
    Callback:   callback,
    ProcMask:   procMask,
    ProcChance: chance,
    ICD:        cooldown,
    Handler:    handler,
})
```

2. Stat Management:
```go
// Managing stats with auras
aura := character.NewTemporaryStatsAura(name, actionID, stats, duration)
aura.OnGain = func(aura *core.Aura, sim *core.Simulation) {
    character.AddStatDynamic(sim, stat, value)
}
aura.OnExpire = func(aura *core.Aura, sim *core.Simulation) {
    character.AddStatDynamic(sim, stat, -value)
}
```

3. ICD Handling:
```go
// Internal cooldown management
icd := core.Cooldown{
    Timer:    character.NewTimer(),
    Duration: cooldownDuration,
}

if icd.IsReady(sim) {
    icd.Use(sim)
    // Apply proc effects
}
```

4. Stack Management:
```go
// Managing stacks on procs
aura.OnStacksChange = func(aura *core.Aura, sim *core.Simulation, oldStacks, newStacks int32) {
    deltaValue := valuePerStack * float64(newStacks-oldStacks)
    character.AddStatDynamic(sim, stat, deltaValue)
}
```

These examples demonstrate the various ways trinket procs can be implemented, from simple stat buffs to complex multi-state systems with stacking effects and conditional triggers.

## Core Systems

### Aura System

The aura system is the foundation for managing buffs, debuffs, and proc effects. Key components include:

1. Base Aura Structure:
```go
type Aura struct {
    Label    string
    Tag      string
    ActionID ActionID
    Duration time.Duration
    Unit     *Unit
    
    // Lifecycle callbacks
    OnInit          func(aura *Aura, sim *Simulation)
    OnGain          func(aura *Aura, sim *Simulation)
    OnExpire        func(aura *Aura, sim *Simulation)
    OnStacksChange  func(aura *Aura, sim *Simulation, oldStacks, newStacks int32)
    
    // Event callbacks
    OnSpellHitDealt       func(aura *Aura, sim *Simulation, spell *Spell, result *SpellResult)
    OnSpellHitTaken       func(aura *Aura, sim *Simulation, spell *Spell, result *SpellResult)
    OnPeriodicDamageDealt func(aura *Aura, sim *Simulation, spell *Spell, result *SpellResult)
}
```

2. Stat Management:
```go
type StatBuffAura struct {
    *Aura
    BuffedStatTypes []stats.Stat
    CustomProcCondition func(sim *Simulation, aura *Aura) bool
    IsSwapped bool
}

// Example of stat management
aura := character.NewTemporaryStatsAura("Proc Name", actionID, stats.Stats{
    stats.SpellPower: 1234,
    stats.Haste: 850,
}, duration)
```

3. Proc Trigger System:
```go
type ProcTrigger struct {
    Name       string
    ActionID   ActionID
    Callback   AuraCallback
    ProcMask   ProcMask
    Outcome    HitOutcome
    ProcChance float64
    ICD        time.Duration
    Handler    func(sim *Simulation, spell *Spell, result *SpellResult)
}
```

### Stat System

The stat system handles all attribute modifications and dependencies:

1. Direct Stat Changes:
```go
// Adding stats directly
character.AddStats(stats.Stats{
    stats.Strength: 100,
    stats.AttackPower: 200,
})

// Dynamic stat changes
character.AddStatDynamic(sim, stats.Stats{
    stats.CritRating: 150,
})
```

2. Stat Dependencies:
```go
// Creating stat dependencies
dependency := character.NewStatDependency(stats.Strength, stats.AttackPower, 2.0)

// Applying dependencies
aura.AttachStatDependency(dependency)
```

3. Stat Multipliers:
```go
// Multiplicative modifiers
character.AddStatMultiplier(stats.Stats{
    stats.SpellPower: 1.15, // 15% increase
})
```

### Integration Points

1. Combat System Integration:
```go
// Registering combat event handlers
core.MakeProcTriggerAura(&character.Unit, core.ProcTrigger{
    Name:     "Combat Proc Handler",
    Callback: core.CallbackOnSpellHitDealt,
    ProcMask: core.ProcMaskMelee,
    Handler: func(sim *Simulation, spell *Spell, result *SpellResult) {
        // Handle combat event
    },
})
```

2. Equipment System Integration:
```go
// Registering equipment procs
character.ItemSwap.RegisterProc(itemID, triggerAura)
character.ItemSwap.RegisterEnchantProc(enchantID, triggerAura)
```

3. APL (Action Priority List) Integration:
```go
type APLValueItemStatProcCheck struct {
    statTypesToMatch []stats.Stat
    matchingAuras    []*StatBuffAura
}

// Example APL value implementation
func (value *APLValueAllItemStatProcsActive) GetBool(sim *Simulation) bool {
    for _, aura := range value.matchingAuras {
        if !aura.IsActive() {
            return false
        }
    }
    return true
}
```

### Performance Considerations

1. Aura Management:
- Use aura pools for frequently created/destroyed auras
- Cache aura lookups when possible
- Minimize the number of active auras

2. Stat Calculations:
- Batch stat updates when possible
- Cache derived stats
- Use efficient data structures for stat dependencies

3. Event Handling:
- Filter events early based on proc masks
- Use efficient callback systems
- Minimize the number of registered handlers

### Best Practices

1. Aura Implementation:
```go
// Good: Efficient aura implementation
aura := core.MakeStackingAura(character, core.StackingStatAura{
    Aura: core.Aura{
        Label:     "Efficient Proc",
        Duration:  time.Second * 15,
        MaxStacks: 5,
    },
    BonusPerStack: stats.Stats{stats.SpellPower: 100},
})

// Bad: Inefficient implementation with multiple callbacks
aura := character.RegisterAura(core.Aura{
    Label:    "Inefficient Proc",
    Duration: time.Second * 15,
    OnGain: func(aura *core.Aura, sim *core.Simulation) {
        // Multiple separate stat updates
        character.AddStatDynamic(sim, stats.Stats{stats.SpellPower: 100})
        character.AddStatDynamic(sim, stats.Stats{stats.Haste: 50})
    },
})
```

2. Proc Handling:
```go
// Good: Efficient proc handling
core.MakeProcTriggerAura(&character.Unit, core.ProcTrigger{
    Name:     "Efficient Proc",
    ProcMask: core.ProcMaskMelee,
    Handler: func(sim *core.Simulation, spell *Spell, result *SpellResult) {
        if result.Landed() {
            procAura.Activate(sim)
        }
    },
})

// Bad: Inefficient proc handling
core.MakeProcTriggerAura(&character.Unit, core.ProcTrigger{
    Name:     "Inefficient Proc",
    Callback: core.CallbackOnSpellHitDealt,
    Handler: func(sim *core.Simulation, spell *Spell, result *core.SpellResult) {
        // Unnecessary checks and operations
        if spell.ProcMask.Matches(core.ProcMaskMelee) {
            if result.Landed() {
                if sim.RandomFloat("proc") < 0.15 {
                    procAura.Activate(sim)
                }
            }
        }
    },
})
```

3. Stat Management:
```go
// Good: Efficient stat management
character.NewTemporaryStatsAuraWrapped("Efficient Stats", actionID, 
    stats.Stats{stats.SpellPower: 500}, duration,
    func(aura *core.Aura) {
        aura.OnGain = func(aura *core.Aura, sim *core.Simulation) {
            // Single batch update
            character.AddStatsDynamic(sim, allStats)
        }
    })

// Bad: Inefficient stat management
character.RegisterAura(core.Aura{
    Label:    "Inefficient Stats",
    Duration: duration,
    OnGain: func(aura *core.Aura, sim *core.Simulation) {
        // Multiple separate updates
        character.AddStatDynamic(sim, stats.Stats{stats.SpellPower: 500})
        character.AddStatDynamic(sim, stats.Stats{stats.CritRating: 200})
        character.AddStatDynamic(sim, stats.Stats{stats.Haste: 300})
    },
})
```

## Aura Management and Tracking

The APL system provides comprehensive management of auras (buffs/debuffs) and their tracking. Here's how it works:

### 1. Core Aura System

1. Aura Structure:
```go
// Core aura structure
type Aura struct {
    Label     string
    Tag       string
    ActionID  ActionID
    Duration  time.Duration
    Unit      *Unit
    
    // Timing management
    startTime time.Duration
    expires   time.Duration
    fadeTime  time.Duration
    
    // State tracking
    active       bool
    activeIndex  int32
    stacks       int32
    MaxStacks    int32
    
    // Callbacks
    OnGain       func(*Aura, *Simulation)
    OnExpire     func(*Aura, *Simulation)
    OnStacksChange func(*Aura, *Simulation, int32, int32)
}

// Aura tracking system
type auraTracker struct {
    auras            []*Aura
    aurasByTag       map[string][]*Aura
    activeAuras      []*Aura
    minExpires       time.Duration
    resetEffects     []ResetEffect
}
```

2. Aura Management Functions:
```go
// Aura state management
func (aura *Aura) IsActive() bool {
    return aura.active
}

func (aura *Aura) RemainingDuration(sim *Simulation) time.Duration {
    if aura.expires == NeverExpires {
        return NeverExpires
    }
    return aura.expires - sim.CurrentTime
}

func (aura *Aura) TimeActive(sim *Simulation) time.Duration {
    if aura.IsActive() {
        return sim.CurrentTime - aura.startTime
    }
    return 0
}

// Stack management
func (aura *Aura) SetStacks(sim *Simulation, newStacks int32) {
    if aura.OnStacksChange != nil {
        aura.OnStacksChange(aura, sim, aura.stacks, newStacks)
    }
    aura.stacks = newStacks
}
```

### 2. APL Integration

1. Aura Value Types:
```go
// Aura state checks
type APLValueAuraIsActive struct {
    DefaultAPLValueImpl
    aura AuraReference
}

func (value *APLValueAuraIsActive) GetBool(sim *Simulation) bool {
    return value.aura.Get().IsActive()
}

// Aura timing checks
type APLValueAuraRemainingTime struct {
    DefaultAPLValueImpl
    aura AuraReference
}

func (value *APLValueAuraRemainingTime) GetDuration(sim *Simulation) time.Duration {
    aura := value.aura.Get()
    return TernaryDuration(aura.IsActive(), aura.RemainingDuration(sim), 0)
}
```

2. Aura Actions:
```go
// Aura manipulation
type APLActionCancelAura struct {
    defaultAPLActionImpl
    aura *Aura
}

func (action *APLActionCancelAura) Execute(sim *Simulation) {
    if sim.Log != nil {
        action.aura.Unit.Log(sim, "Cancelling aura %s", action.aura.ActionID)
    }
    action.aura.Deactivate(sim)
}

type APLActionActivateAura struct {
    defaultAPLActionImpl
    aura *Aura
}

func (action *APLActionActivateAura) Execute(sim *Simulation) {
    if !action.IsReady(sim) {
        return
    }
    
    action.aura.Activate(sim)
    if action.aura.Icd != nil {
        action.aura.Icd.Use(sim)
    }
}
```

### 3. Proc and Trinket Integration

1. Proc Aura Structure:
```go
// Proc aura management
type StatBuffAura struct {
    *Aura
    BuffedStatTypes []stats.Stat
    CustomProcCondition CustomStatBuffProcCondition
    IsSwapped bool
}

func (aura *StatBuffAura) CanProc(sim *Simulation) bool {
    return !aura.IsSwapped && 
           ((aura.CustomProcCondition == nil) || 
             aura.CustomProcCondition(sim, aura.Aura))
}

// Stacking proc management
type StackingStatAura struct {
    Aura          Aura
    BonusPerStack stats.Stats
}

func MakeStackingAura(character *Character, config StackingStatAura) *StatBuffAura {
    bonusPerStack := config.BonusPerStack
    config.Aura.OnStacksChange = func(aura *Aura, sim *Simulation, oldStacks int32, newStacks int32) {
        character.AddStatsDynamic(sim, 
            bonusPerStack.Multiply(float64(newStacks-oldStacks)))
    }
    return &StatBuffAura{
        Aura:            character.GetOrRegisterAura(config.Aura),
        BuffedStatTypes: bonusPerStack.GetBuffedStatTypes(),
    }
}
```

2. Set Bonus Management:
```go
// Set bonus tracking
func (character *Character) makeSetBonusStatusAura(setName string, numPieces int32, slots []proto.ItemSlot, activeAtStart bool) *Aura {
    statusAura := character.GetOrRegisterAura(Aura{
        Label:      fmt.Sprintf("%s %dP", setName, numPieces),
        BuildPhase: Ternary(activeAtStart, CharacterBuildPhaseGear, CharacterBuildPhaseNone),
        Duration:   NeverExpires,
    })

    if activeAtStart {
        statusAura = MakePermanent(statusAura)
    }

    character.RegisterItemSwapCallback(slots, func(sim *Simulation, _ proto.ItemSlot) {
        if character.hasActiveSetBonus(setName, numPieces) {
            if !statusAura.IsActive() {
                statusAura.Activate(sim)
            }
        } else {
            statusAura.Deactivate(sim)
        }
    })

    return statusAura
}
```

### 4. Aura Set Management

1. Aura Set Checks:
```go
// Aura set value types
type APLValueAllItemStatProcsActive struct {
    *APLValueItemStatProcCheck
}

func (value *APLValueAllItemStatProcsActive) GetBool(sim *Simulation) bool {
    for _, aura := range value.matchingAuras {
        if (!aura.IsActive() || (aura.GetStacks() < aura.MaxStacks)) && 
            aura.CanProc(sim) {
            return false
        }
    }
    return true
}

type APLValueAnyItemStatProcsActive struct {
    *APLValueItemStatProcCheck
}

func (value *APLValueAnyItemStatProcsActive) GetBool(sim *Simulation) bool {
    for _, aura := range value.matchingAuras {
        if aura.IsActive() && (aura.GetStacks() == aura.MaxStacks) {
            return true
        }
    }
    return false
}
```

### 5. Best Practices

1. Aura Registration:
```go
// Good: Safe aura registration
func registerAura(unit *Unit, aura Aura) *Aura {
    if unit == nil {
        panic("Aura unit is required!")
    }
    if aura.Label == "" {
        panic("Aura label is required!")
    }
    
    newAura := &Aura{}
    *newAura = aura
    newAura.Unit = unit
    
    return newAura
}

// Bad: Unsafe registration
func unsafeRegistration(unit *Unit, aura Aura) {
    unit.auras = append(unit.auras, &aura) // No validation
}
```

2. Aura State Management:
```go
// Good: Safe state changes
func handleAuraState(aura *Aura, sim *Simulation) {
    if !aura.IsActive() {
        return
    }
    
    if aura.RemainingDuration(sim) <= 0 {
        aura.Deactivate(sim)
    }
}

// Bad: Unsafe state management
func unsafeStateManagement(aura *Aura) {
    aura.active = true // Direct state manipulation
}
```

3. Stack Management:
```go
// Good: Safe stack management
func handleStacks(aura *Aura, sim *Simulation, newStacks int32) {
    if newStacks > aura.MaxStacks {
        newStacks = aura.MaxStacks
    }
    
    if newStacks != aura.stacks {
        aura.SetStacks(sim, newStacks)
    }
}

// Bad: Unsafe stack management
func unsafeStackManagement(aura *Aura) {
    aura.stacks++ // Direct manipulation without bounds checking
}
```

## NAG to Wowsims/Cata Function Correlations

### Core Function Mappings

1. `AllItemProcBuffsActive` (wowsims) → `NAG:AllTrinketStatProcsActive` (NAG)
```lua
-- Located in NAG/handlers/ItemHandlers.lua
function NAG:AllTrinketStatProcsActive(statType1, statType2, statType3, minIcdSeconds)
    -- Checks if all equipped trinkets matching stat types have active procs
    -- Uses TrinketTrackingManager and TrinketRegistrationManager
```

2. `AnyItemProcBuffActive` (wowsims) → `NAG:AnyTrinketStatProcsActive` (NAG)
```lua
-- Located in NAG/handlers/ItemHandlers.lua
function NAG:AnyTrinketStatProcsActive(statType1, statType2, statType3, minIcdSeconds)
    -- Checks if any equipped trinket matching stat types has an active proc
    -- Uses TrinketTrackingManager for proc verification
```

3. `ItemProcsMinRemainingTime` (wowsims) → `NAG:TrinketProcsMinRemainingTime` (NAG)
```lua
-- Located in NAG/handlers/ItemHandlers.lua
function NAG:TrinketProcsMinRemainingTime(statType1, statType2, statType3, minIcdSeconds)
    -- Returns minimum remaining time among active trinket procs
    -- Handles both custom and hardcoded trinkets
```

4. `ItemProcsMaxRemainingICD` (wowsims) → `NAG:TrinketProcsMaxRemainingIcd` (NAG)
```lua
-- Located in NAG/handlers/ItemHandlers.lua
function NAG:TrinketProcsMaxRemainingIcd(statType1, statType2, statType3, minIcdSeconds)
    -- Returns maximum remaining ICD time among matching trinkets
    -- Uses TrinketTrackingManager:GetInternalCooldownRemaining
```

5. `NumEquippedStatProcItems` (wowsims) → `NAG:NumEquippedStatProcTrinkets` (NAG)
```lua
-- Located in NAG/handlers/ItemHandlers.lua
function NAG:NumEquippedStatProcTrinkets(statType1, statType2, statType3, minIcdSeconds)
    -- Counts equipped trinkets matching stat types
    -- Considers both custom and hardcoded trinkets
```

6. `NumStatBuffCooldowns` (wowsims) → `NAG:NumStatBuffCooldowns` (NAG)
```lua
-- Located in NAG/handlers/ItemHandlers.lua
function NAG:NumStatBuffCooldowns(statType1, statType2, statType3)
    -- Counts equipped on-use trinkets with matching stat buffs
    -- Checks for usable stat buff trinkets
```

### Supporting Systems Correlation

1. Trinket Registration System:
- Wowsims: `AddStatProcBuff` in Character class
- NAG: `TrinketRegistrationManager:RegisterTrinket` and `TrinketTrackingManager:RegisterTrinket`

2. Aura Tracking:
- Wowsims: `StatBuffAura` struct
- NAG: Combined functionality in `TrinketTrackingManager` and state tracking in `StateManager`

3. ICD Management:
- Wowsims: Built into `ProcTrigger` system
- NAG: Handled by `TrinketTrackingManager:GetInternalCooldownRemaining`

### Key Differences

1. Stat Type Handling:
- Wowsims: Uses `stats.Stat` enum
- NAG: Uses our own `Type.Stat` enumeration

2. Proc Tracking:
- Wowsims: Direct aura management
- NAG: Split between TrinketTrackingManager and StateManager

3. Stack Management:
- Wowsims: Built into StatBuffAura
- NAG: Handled through aura tracking system

### Integration Points

1. APL System:
```lua
-- Both systems use APL for decision making
-- Wowsims: APLValueItemStatProcCheck struct
-- NAG: Direct function calls in rotation logic
```

2. Combat Events:
```lua
-- Wowsims: ProcTrigger system
-- NAG: Event handling through TrinketTrackingManager
```

3. Equipment Management:
```lua
-- Wowsims: ItemSwap system
-- NAG: Handled through inventory slot tracking
```

### File Locations

1. Core Functions:
- `NAG/handlers/ItemHandlers.lua`: Main trinket/proc functions
- `NAG/managers/TrinketTrackingManager.lua`: Trinket tracking
- `NAG/managers/TrinketRegistrationManager.lua`: Custom trinket registration

2. Supporting Systems:
- `NAG/managers/StateManager.lua`: State tracking
- `NAG/core/Types.lua`: Stat type definitions
- `NAG/core/Constants.lua`: System constants

### Usage Examples

1. Checking All Procs:
```lua
-- Wowsims
if AllItemProcBuffsActive(Stats.HASTE) then
    -- Execute action
end

-- NAG
if NAG:AllTrinketStatProcsActive(Type.Stat.HASTE) then
    -- Execute action
end
```

2. Getting Remaining Time:
```lua
-- Wowsims
local minTime = ItemProcsMinRemainingTime(Stats.CRIT)

-- NAG
local minTime = NAG:TrinketProcsMinRemainingTime(Type.Stat.CRIT)
```

### Best Practices for NAG Implementation

1. Always use TrinketTrackingManager for:
- ICD tracking
- Proc verification
- Buff duration monitoring

2. Use TrinketRegistrationManager for:
- Custom trinket registration
- User-defined proc effects
- Non-standard trinket behavior

3. Maintain compatibility with:
- Different WoW versions
- Various client builds
- Custom user configurations

[Previous content remains unchanged...]

