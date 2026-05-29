AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_cthulhu/greatrace_zikshadows.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 175
ENT.HullType = HULL_HUMAN
ENT.EntitiesToNoCollide = {"npc_vj_cthulhu_eyetentacle","npc_vj_cthulhu_greatrace","npc_vj_cthulhu_greatrace_zikshadows"}
ENT.VJC_Data = {
	FirstP_Bone = "apex", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(5, 0, 0), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_yellow"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Yellow"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.VJ_NPC_Class = {"CLASS_CTHULHU"} -- NPCs with the same class with be allied to each other

ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 40 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 60 -- How far does the damage go?

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.RangeDistance = 1420 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 100 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 0 -- How much time until it can use a range attack?
ENT.DisableDefaultRangeAttackCode = true -- When true, it won't spawn the range attack entity, allowing you to make your own

ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = "UseRangeDistance" -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = "UseRangeDistance" -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "OnlyRange" -- "Regular" = Default behavior | "OnlyRange" = Only does it if it's able to range attack
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {"die"} -- Death Animations
ENT.DeathAnimationTime = false -- Time until the SNPC spawns its corpse and gets removed
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 0 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_SMALL_FLINCH} -- If it uses normal based animation, use this
ENT.HitGroupFlinching_Values = {{HitGroup = {HITGROUP_LEFTARM}, Animation = {ACT_FLINCH_LEFTARM}},{HitGroup = {HITGROUP_RIGHTARM}, Animation = {ACT_FLINCH_RIGHTARM}},{HitGroup = {HITGROUP_LEFTLEG}, Animation = {ACT_FLINCH_LEFTLEG}},{HitGroup = {HITGROUP_RIGHTLEG}, Animation = {ACT_FLINCH_RIGHTLEG}}}
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_hlr/hl1_npc/aslave/vort_foot1.wav","vj_hlr/hl1_npc/aslave/vort_foot2.wav","vj_hlr/hl1_npc/aslave/vort_foot3.wav","vj_hlr/hl1_npc/aslave/vort_foot4.wav"}
ENT.SoundTbl_Breath = {"vj_cthulhu/greatrace/lightfuse.wav","vj_cthulhu/greatrace/lightfuse2.wav"}
ENT.SoundTbl_Idle = {"vj_cthulhu/greatrace/gr_idle1.wav","vj_cthulhu/greatrace/gr_idle2.wav","vj_cthulhu/greatrace/gr_idle3.wav","vj_cthulhu/greatrace/gr_idle5.wav","vj_cthulhu/greatrace/gr_idle6.wav"}
ENT.SoundTbl_Alert = {"vj_cthulhu/greatrace/gr_alert1.wav","vj_cthulhu/greatrace/gr_alert2.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_cthulhu/common/claw_strike1.wav","vj_cthulhu/common/claw_strike2.wav","vj_cthulhu/common/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_cthulhu/common/claw_miss1.wav","vj_cthulhu/common/claw_miss2.wav"}
ENT.SoundTbl_BeforeRangeAttack = {}
//ENT.SoundTbl_RangeAttack = {"vj_hlr/hl1_npc/hassault/hw_shoot1.wav"} - - Problems with sounds
ENT.SoundTbl_Pain = {"vj_cthulhu/greatrace/gr_pain1.wav","vj_cthulhu/greatrace/gr_pain2.wav"}
ENT.SoundTbl_Death = {"vj_cthulhu/greatrace/gr_die1.wav","vj_cthulhu/greatrace/gr_die2.wav"}


ENT.FootStepSoundLevel = 60

ENT.GeneralSoundPitch1 = 90
ENT.GeneralSoundPitch2 = 90
ENT.RangeAttackPitch = VJ_Set(130, 160)

-- Custom
ENT.AAHW_NextRunT = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(20, 20, 65), Vector(-20, -20, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "step" then
		self:FootStepSoundCode()
	elseif key == "smash" then
		self:MeleeAttackCode()
		util.ScreenShake(self:GetPos(), 16, 100, 1, 1000)
	elseif key == "swinghaha" then
		self:MeleeAttackCode()
	elseif key == "shoot" then
		self:RangeAttackCode()
		VJ_EmitSound(self, {"vj_hlr/hl1_npc/xencannon/fire.wav"}, 75, 100)
	elseif key == "body" then
		VJ_EmitSound(self, {"vj_cthulhu/common/bodydrop1.wav","vj_cthulhu/common/bodydrop2.wav","vj_cthulhu/common/bodydrop3.wav","vj_cthulhu/common/bodydrop4.wav"}, 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
		local att = self:GetAttachment(self:LookupAttachment("0"))
		local muzzleFlash = ents.Create("env_sprite")
		muzzleFlash:SetKeyValue("model", "vj_hl/sprites/muz4.vmt")
		muzzleFlash:SetKeyValue("scale", tostring(math.Rand(1, 1)))
		muzzleFlash:SetKeyValue("rendermode", "3")
		muzzleFlash:SetKeyValue("renderfx", "14")
		muzzleFlash:SetKeyValue("renderamt", "255")
		muzzleFlash:SetKeyValue("rendercolor", "255 255 255")
		muzzleFlash:SetKeyValue("spawnflags", "0")
		muzzleFlash:SetParent(self)
		muzzleFlash:SetOwner(self)
		muzzleFlash:SetPos(att.Pos + att.Ang:Forward() * 15)
		muzzleFlash:SetAngles(Angle(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100)))
		muzzleFlash:Spawn()
		muzzleFlash:Fire("Kill","",0.08)
		self:DeleteOnRemove(muzzleFlash)
	local startpos = self:GetPos() + self:GetUp()*45 + self:GetForward()*40
	local tr = util.TraceLine({
		start = startpos,
		endpos = self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(),
		filter = self
	})
	local hitpos = tr.HitPos
	
	local elec = EffectData()
	elec:SetStart(startpos)
	elec:SetOrigin(hitpos)
	elec:SetEntity(self)
	elec:SetAttachment(1)
	util.Effect("VJ_HLR_XenCannon_Beam",elec)
	
	elec = EffectData()
	elec:SetStart(startpos)
	elec:SetOrigin(hitpos)
	elec:SetEntity(self)
	elec:SetAttachment(1)
	util.Effect("VJ_HLR_XenCannon_Beam",elec)
	
	util.VJ_SphereDamage(self, self, hitpos, 15, 15, DMG_DISSOLVE, true, false, {Force=90})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)
	if self.HasGibDeathParticles == true then
		local effectBlood = EffectData()
		effectBlood:SetOrigin(self:GetPos() + self:OBBCenter())
		effectBlood:SetColor(VJ_Color2Byte(Color(255,221,35)))
		effectBlood:SetScale(120)
		util.Effect("VJ_Blood1",effectBlood)
		
		local bloodspray = EffectData()
		bloodspray:SetOrigin(self:GetPos() + self:OBBCenter())
		bloodspray:SetScale(8)
		bloodspray:SetFlags(3)
		bloodspray:SetColor(1)
		util.Effect("bloodspray",bloodspray)
		util.Effect("bloodspray",bloodspray)
		
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() + self:OBBCenter())
		effectdata:SetScale(1)
		util.Effect("StriderBlood",effectdata)
		util.Effect("StriderBlood",effectdata)
	end
	
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,20))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,30))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,35))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,50))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,55))})
	if self.Zombie_Type == 1 then
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/zombiegib.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,15))})
	end
	return true -- Return to true if it gibbed!
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
	VJ_EmitSound(self, "vj_cthulhu/common/bodysplat.wav", 90, 100)
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibsgreen = {"models/vj_cthulhu/aliengib1.mdl","models/vj_cthulhu/aliengib2.mdl","models/vj_cthulhu/aliengib3.mdl","models/vj_cthulhu/aliengib4.mdl","models/vj_cthulhu/aliengib5.mdl","models/vj_cthulhu/aliengib6.mdl"}

function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
		VJ_HLR_ApplyCorpseEffects(self, corpseEnt, gibsgreen)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	if hitgroup == HITGROUP_HEAD then
		self.AnimTbl_Death = {"die"}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if math.random(1, 2) == 1 then
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.MeleeAttackDamage = 35
	else
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.MeleeAttackDamage = 25
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialKilled(dmginfo, hitgroup)
self:SetBodygroup(1,1)
 end
