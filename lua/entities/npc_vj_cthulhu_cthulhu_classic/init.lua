AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_cthulhu/cthulhu_classic.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 10000
ENT.HullType = HULL_HUMAN
ENT.VJ_IsHugeMonster = true -- Is this a huge monster?
ENT.VJC_Data = {
    ThirdP_Offset = Vector(-50, 0, -45), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "joint28", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(7, 0, -12), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CTHULHU"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_yellow_large"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Yellow"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 100 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageType = DMG_CRUSH -- How close does it have to be until it attacks?
ENT.MeleeAttackDistance = 200 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 310 -- How far does the damage go?
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_hlr1_garg_stomp" -- The entity that is spawned when range attacking
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 80 -- How close does it have to be until it uses melee?
ENT.NextRangeAttackTime = 2 -- How much time until it can use a range attack?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.RangeAttackPos_Up = 10 -- Up/Down spawning position for range attack
ENT.RangeAttackPos_Forward = 50 -- Forward/Backward spawning position for range attack
ENT.RangeAttackPos_Right = -20 -- Right/Left spawning position for range attack
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds

ENT.HasWorldShakeOnMove = true -- Should the world shake when it's moving?
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.DeathAnimationTime = false -- Time until the SNPC spawns its corpse and gets removed
ENT.AnimTbl_Death = {ACT_DIESIMPLE} -- Death Animations
ENT.HasSoundTrack = true -- Does the SNPC have a sound track?
ENT.DeathCorpseEntityClass = "prop_vj_animatable" -- The entity class it creates | "UseDefaultBehavior" = Let the base automatically detect the type
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 2 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchDamageTypes = {DMG_BLAST} -- If it uses damage-based flinching, which types of damages should it flinch from?
ENT.FlinchChance = 2 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = {ACT_BIG_FLINCH} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_hlr/hl1_npc/garg/gar_step1.wav","vj_hlr/hl1_npc/garg/gar_step2.wav"}
ENT.SoundTbl_Breath = {"vj_hlr/hl1_npc/garg/gar_breathe1.wav","vj_hlr/hl1_npc/garg/gar_breathe2.wav","vj_hlr/hl1_npc/garg/gar_breathe3.wav"}
ENT.SoundTbl_Idle = {"vj_hlr/hl1_npc/garg/gar_idle1.wav","vj_hlr/hl1_npc/garg/gar_idle2.wav","vj_hlr/hl1_npc/garg/gar_idle3.wav","vj_hlr/hl1_npc/garg/gar_idle4.wav","vj_hlr/hl1_npc/garg/gar_idle5.wav"}
ENT.SoundTbl_Alert = {"vj_hlr/hl1_npc/garg/gar_alert1.wav","vj_hlr/hl1_npc/garg/gar_alert2.wav","vj_hlr/hl1_npc/garg/gar_alert3.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_hlr/hl1_npc/garg/gar_attack1.wav","vj_hlr/hl1_npc/garg/gar_attack2.wav","vj_hlr/hl1_npc/garg/gar_attack3.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_hlr/hl1_npc/zombie/claw_strike1.wav","vj_hlr/hl1_npc/zombie/claw_strike2.wav","vj_hlr/hl1_npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_hlr/hl1_npc/zombie/claw_miss1.wav","vj_hlr/hl1_npc/zombie/claw_miss2.wav"}
ENT.SoundTbl_Pain = {"vj_hlr/hl1_npc/garg/gar_pain1.wav","vj_hlr/hl1_npc/garg/gar_pain2.wav","vj_hlr/hl1_npc/garg/gar_pain3.wav"}
ENT.SoundTbl_Death = {"vj_hlr/hl1_npc/garg/gar_die1.wav","vj_hlr/hl1_npc/garg/gar_die2.wav"}
ENT.SoundTbl_SoundTrack = {"vj_cthulhu/soundtrack/Inthepresenceofagod.wav"}

ENT.GeneralSoundPitch1 = 100

-- Custom
ENT.Garg_Type = 0
	-- 0 = Default Garg
	-- 1 = Baby Garg
	-- 2 = Custom (Not immune to bullets)
ENT.Garg_AttackType = -1
ENT.Garg_AbleToFlame = false
ENT.Garg_NextAbleToFlameT = 0
ENT.Garg_NextStompAttackT = 0
ENT.Garg_MeleeLargeKnockback = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize() 
    if GetConVar("VJ_CTHULHU_Boss_Music"):GetInt() == 1 then
        self.HasSoundTrack = false 
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	if self.Garg_Type == 0 then -- Adult garg
		self:SetCollisionBounds(Vector(70,70,430), Vector(-70,-70,0))
	elseif self.Garg_Type == 1 then -- Baby garg
		self:SetCollisionBounds(Vector(32,32,105), Vector(-32,-32,0))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "step" then
		self:FootStepSoundCode()
	end
	if key == "melee" then
		self:MeleeAttackCode()
	end
	if key == "laser" then
		self:RangeAttackCode()
        self:CreateGibEntity("obj_vj_gib", "models/vj_cthulhu/bigrock.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(20, 80, 0)),CollideSound={}})
       self:CreateGibEntity("obj_vj_gib", "models/vj_cthulhu/bigrock.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(20, 80, 0)),CollideSound={}})
       self:CreateGibEntity("obj_vj_gib", "models/vj_cthulhu/bigrock.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(20, 80, 0)),CollideSound={}})
		VJ_EmitSound(self, {"vj_hlr/hl1_npc/garg/gar_stomp1.wav"}, 90)
	util.Decal("VJ_CTHULHU_Scorch", self:GetPos() + self:GetRight()*-80 + self:GetForward()*20, self:GetPos() + self:GetRight()*-20 + self:GetForward()*20 + self:GetUp()*-100, self)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Garg_ResetFlame()
	self.Garg_AbleToFlame = false
	self.Garg_AttackType = -1
	self.AnimTbl_IdleStand = {ACT_IDLE}
	self.NextIdleStandTime = 0
	self.DisableChasingEnemy = false
	VJ_STOPSOUND(self.Garg_FlameSd)
	self:StopParticles()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self.Garg_AbleToFlame == false or self.AttackType != VJ_ATTACK_RANGE or !IsValid(self:GetEnemy()) then
		self:Garg_ResetFlame()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	-- If the controller (player) not range attacking, then end the timer!
	if self.VJ_IsBeingControlled && !self.VJ_TheController:KeyDown(IN_ATTACK2) then timer.Adjust("timer_range_start"..self:EntIndex(), 0) return end
	
	if IsValid(self:GetEnemy()) && (self.NearestPointToEnemyDistance <= (self.VJ_IsBeingControlled and 999999 or (self.Garg_Type == 1 and 250) or 400) && self.NearestPointToEnemyDistance > self.MeleeAttackDistance) && self.Garg_AbleToFlame == true && self.Garg_NextAbleToFlameT < CurTime() && self.Garg_AttackType == 0 && timer.Exists("timer_range_start"..self:EntIndex()) then
	//if IsValid(self:GetEnemy()) && self.Garg_AbleToFlame == true && (self.NearestPointToEnemyDistance <= 400 && self.NearestPointToEnemyDistance > self.MeleeAttackDistance) then
		local range = (self.Garg_Type == 1 and 280) or 460
		self.Garg_NextAbleToFlameT = CurTime() + 0.2
		self.DisableChasingEnemy = true
		self.AnimTbl_IdleStand = {ACT_RANGE_ATTACK1}
		self.NextIdleStandTime = 0
		self:StopMoving()
		util.VJ_SphereDamage(self, self, self:GetPos() + self:OBBCenter() + self:GetForward()*50, range, 3, DMG_BURN, true, true, {UseCone=true, UseConeDegree=30}, function(ent) if !ent:IsOnFire() && (ent:IsPlayer() or ent:IsNPC()) then ent:Ignite(2) end end)
		-- COSMETICS: Sound, particle and decal
		self.Garg_FlameSd = VJ_CreateSound(self, "vj_hlr/hl1_npc/garg/gar_flamerun1.wav")
		self:StopParticles()
		if self.Garg_Type == 1 then -- Baby Garg
			ParticleEffectAttach("vj_hlr_garg_flame_small", PATTACH_POINT_FOLLOW,self, 2)
			ParticleEffectAttach("vj_hlr_garg_flame_small", PATTACH_POINT_FOLLOW,self, 3)
		else
			ParticleEffectAttach("vj_hlr_garg_flame", PATTACH_POINT_FOLLOW,self, 2)
			ParticleEffectAttach("vj_hlr_garg_flame", PATTACH_POINT_FOLLOW,self, 3)
		end
		local startPos1 = self:GetAttachment(2).Pos
		local startPos2 = self:GetAttachment(3).Pos
		local tr1 = util.TraceLine({start = startPos1, endpos = startPos1 + self:GetForward()*range, filter = self})
		local tr2 = util.TraceLine({start = startPos2, endpos = startPos2 + self:GetForward()*range, filter = self})
		local hitPos1 = tr1.HitPos
		local hitPos2 = tr2.HitPos
		sound.EmitHint(SOUND_DANGER, (hitPos1 + startPos1) / 2, 300, 1, self) -- Pos: Midpoint of start and hit pos, same as Vector((hitPos1.x + startPos1.x ) / 2, (hitPos1.y + startPos1.y ) / 2, (hitPos1.z + startPos1.z ) / 2)
		sound.EmitHint(SOUND_DANGER, (hitPos2 + startPos2) / 2, 300, 1, self)
		util.Decal("VJ_HLR_Scorch", hitPos1 + tr1.HitNormal, hitPos1 - tr1.HitNormal)
		util.Decal("VJ_HLR_Scorch", hitPos2 + tr2.HitNormal, hitPos2 - tr2.HitNormal)
		-- Make it constantly delay the range attack timer by 1 second (Which will also successfully play the flame-end sound)
		timer.Adjust("timer_range_start"..self:EntIndex(), 1, 0, function()
			self:RangeAttackCode()
			self:Garg_ResetFlame()
			timer.Remove("timer_range_start"..self:EntIndex())
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
	return self:GetForward()*500 + self:GetUp()*(self.Garg_MeleeLargeKnockback and 300 or 10)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local r = math.random(1, 3)
	if r == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack"}
		self.HasMeleeAttackKnockBack = false
		self.Garg_MeleeLargeKnockback = false
 	elseif r == 2 then
		self.AnimTbl_MeleeAttack = {"vjseq_smash"}
		self.HasMeleeAttackKnockBack = true
		self.Garg_MeleeLargeKnockback = false
	elseif r == 3 then
		self.AnimTbl_MeleeAttack = {"vjseq_kickcar"}
		self.HasMeleeAttackKnockBack = true
		self.Garg_MeleeLargeKnockback = true
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)
	if self.Garg_Type == 1 then return end
	ply:ChatPrint("Right Mouse + CTRL: Preform Orbs Attack")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleRangeAttacks()
	local range = (self.Garg_Type == 1 and 250) or 400
	if self.VJ_IsBeingControlled then
		-- If it's being controlled then if the player is crouching then use stomp attack
		range = self.Garg_Type == 1 and 999999 or (self.VJ_TheController:KeyDown(IN_DUCK) and 1 or 999999)
	end
	if self.NearestPointToEnemyDistance <= range then -- Flame attack
		self.Garg_AttackType = 0
		self.Garg_AbleToFlame = true
		self.RangeDistance = range
		self.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1}
		self.TimeUntilRangeAttackProjectileRelease = 0.1
		self.DisableRangeAttackAnimation = true
		self.DisableDefaultRangeAttackCode = true
		self.SoundTbl_BeforeRangeAttack = {"vj_hlr/hl1_npc/garg/gar_flameon1.wav"}
		self.SoundTbl_RangeAttack = {"vj_hlr/hl1_npc/garg/gar_flameoff1.wav"}
		self.NextIdleStandTime = 0 -- Reset the idle animation
	elseif self.Garg_NextStompAttackT < CurTime() && self.Garg_Type != 1 then -- Laser stomp attack
		self.Garg_AttackType = 1
		self.Garg_AbleToFlame = false
		self.RangeDistance = 2000
		self.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK2}
		self.TimeUntilRangeAttackProjectileRelease = false
		self.DisableRangeAttackAnimation = false
		self.DisableDefaultRangeAttackCode = false
		self.SoundTbl_BeforeRangeAttack = {}
		self.SoundTbl_RangeAttack = {"vj_hlr/hl1_npc/garg/gar_stomp1.wav"}
	else
		self.Garg_AttackType = -1
		self.Garg_AbleToFlame = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode_AfterProjectileSpawn(projectile)
	self.Garg_NextStompAttackT = CurTime() + math.Rand(10,13) -- Set a delay for the next stomp attack
	if IsValid(self:GetEnemy()) then
		projectile.Track_Enemy = self:GetEnemy()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttackCheck_RangeAttack()
	if self.Garg_AttackType == -1 then return false end -- If it's -1 then don't range attack!
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(projectile)
	return self:CalculateProjectile("Line", self:GetPos() + self:GetUp()*50, self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(), 200)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vec = Vector(0, 0, 0)
--
function ENT:CustomOnTakeDamage_BeforeImmuneChecks(dmginfo, hitgroup)
	-- Make a metal ricochet effect
	if dmginfo:GetDamagePosition() != vec then
		local rico = EffectData()
		rico:SetOrigin(dmginfo:GetDamagePosition())
		rico:SetScale(5) -- Size
		rico:SetMagnitude(math.random(1,2)) -- Effect type | 1 = Animated | 2 = Basic
		util.Effect("VJ_HLR_Rico", rico)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if dmginfo:IsBulletDamage() == true then
		if self.Garg_Type == 1 then -- Make babies take half damage for bullets
			dmginfo:ScaleDamage(0.5)
		elseif self.Garg_Type == 2 then -- Custom Gargantua
			dmginfo:ScaleDamage(1)
		else -- Make regular Gargantua take no bullet damage
			dmginfo:ScaleDamage(0)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	VJ_STOPSOUND(self.Garg_FlameSd)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	corpseEnt:DrawShadow(false)
	corpseEnt:ResetSequence("die")
	corpseEnt:SetCycle(1)
end