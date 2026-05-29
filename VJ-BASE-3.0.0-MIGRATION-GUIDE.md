# VJ-Base 3.0.0 Migration Guide

This guide explains all the breaking changes from pre-3.0.0 versions and how to fix them in your addon.

---

## 🔴 CRITICAL CHANGES

### 1. **Enemy Distance System** (MAJOR CHANGE)
**Issue:** `self.NearestPointToEnemyDistance` no longer exists

**OLD (Pre-3.0.0):**
```lua
if self.NearestPointToEnemyDistance <= 400 then
    -- do something
end
```

**NEW (3.0.0+):**
```lua
if self.EnemyData.Distance <= 400 then
    -- do something
end
```

**What is `EnemyData`?**
- `self.EnemyData.Distance` - Distance to nearest point on enemy
- `self.EnemyData.TimeSet` - Time when enemy was last set
- `self.EnemyData.Target` - Cached reference to current enemy

---

### 2. **Attack Type System** (MAJOR CHANGE)
**Issue:** Old attack status variables are now consolidated into `self.AttackType`

**OLD:**
```lua
if self.RangeAttacking then
    -- doing range attack
end
if self.MeleeAttacking then
    -- doing melee attack
end
```

**NEW:**
```lua
-- Use the attack type enum
if self.AttackType == VJ_ATTACK_RANGE then
    -- doing range attack
elseif self.AttackType == VJ_ATTACK_MELEE then
    -- doing melee attack
elseif self.AttackType == VJ_ATTACK_LEAP then
    -- doing leap attack
elseif self.AttackType == VJ_ATTACK_GRENADE then
    -- doing grenade attack
end
```

**Attack Type Enums:**
- `VJ_ATTACK_NONE` - No attack
- `VJ_ATTACK_CUSTOM` - Custom attack
- `VJ_ATTACK_MELEE` - Melee attack
- `VJ_ATTACK_RANGE` - Range/Projectile attack
- `VJ_ATTACK_LEAP` - Leap/Jump attack
- `VJ_ATTACK_GRENADE` - Grenade throw attack

---

### 3. **Melee Knockback Variable** (MAJOR CHANGE)
**Issue:** `HasMeleeAttackKnockBack` is deprecated

**OLD:**
```lua
self.HasMeleeAttackKnockBack = true
```

**NEW (Option 1 - Boolean):**
```lua
self.MeleeAttackHasKnockback = true
```

**NEW (Option 2 - Custom Function):**
```lua
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
    return self:GetForward() * 500 + self:GetUp() * 200
end
```

---

### 4. **Sound Pitch Variables** (CONSOLIDATED)
**Issue:** All paired sound pitch variables have been merged

| Old Variable | New Variable |
|---|---|
| `AlertSoundPitch1` / `AlertSoundPitch2` | `AlertSoundPitch` |
| `MeleeAttackSoundPitch1` / `MeleeAttackSoundPitch2` | `MeleeAttackSoundPitch` |
| `GeneralSoundPitch1` / `GeneralSoundPitch2` | `GeneralSoundPitch` |
| `BeforeMeleeAttackSoundPitch1` / `BeforeMeleeAttackSoundPitch2` | `BeforeMeleeAttackSoundPitch` |
| `PainSoundPitch1` / `PainSoundPitch2` | `PainSoundPitch` |
| `DeathSoundPitch1` / `DeathSoundPitch2` | `DeathSoundPitch` |

**OLD:**
```lua
ENT.AlertSoundPitch1 = 95
ENT.AlertSoundPitch2 = 105
```

**NEW:**
```lua
ENT.AlertSoundPitch = 100
```

---

### 5. **Sound Level Variables** (REMOVED)
**Issue:** Individual sound level variables are no longer used

**OLD:**
```lua
ENT.AlertSoundLevel = 100
ENT.BeforeMeleeAttackSoundLevel = 100
ENT.PainSoundLevel = 100
-- etc for every sound type
```

**NEW:**
Sound levels are now defined per-table or use defaults. **Remove all `*SoundLevel` variables.**

---

## 🟡 MINOR CHANGES

### 6. **Animation System Improvements**
The animation system now uses a transition system. If you have complex custom animations, test them.

---

## 📋 QUICK REFERENCE TABLE

| Old | New | Status |
|---|---|---|
| `self.NearestPointToEnemyDistance` | `self.EnemyData.Distance` | ⚠️ CRITICAL |
| `self.RangeAttacking` | `self.AttackType == VJ_ATTACK_RANGE` | ⚠️ CRITICAL |
| `self.MeleeAttacking` | `self.AttackType == VJ_ATTACK_MELEE` | ⚠️ CRITICAL |
| `self.LeapAttacking` | `self.AttackType == VJ_ATTACK_LEAP` | ⚠️ CRITICAL |
| `HasMeleeAttackKnockBack` | `MeleeAttackHasKnockback` | ⚠️ CRITICAL |
| `AlertSoundPitch1/2` | `AlertSoundPitch` | ⚠️ CRITICAL |
| `*SoundLevel` vars | Remove entirely | ⚠️ CRITICAL |

---

## ✅ VERIFICATION CHECKLIST

After updating:

- [ ] All `self.NearestPointToEnemyDistance` → `self.EnemyData.Distance`
- [ ] All attack checks use `self.AttackType == VJ_ATTACK_*`
- [ ] `HasMeleeAttackKnockBack` → `MeleeAttackHasKnockback`
- [ ] All paired pitch variables merged
- [ ] All `*SoundLevel` variables removed
- [ ] NPCs spawn without errors
- [ ] AI behaviors work
- [ ] Animations transition smoothly
