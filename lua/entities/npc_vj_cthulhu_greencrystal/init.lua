AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_cthulhu/greencrystal.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 600
ENT.MovementType = VJ_MOVETYPE_STATIONARY -- How does the SNPC move?
ENT.SightAngle = 180 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.HullType = HULL_HUMAN
ENT.EntitiesToNoCollide = {"npc_vj_cthulhu_eyetentacle","npc_vj_cthulhu_greatrace"}
ENT.VJC_Data = {
	FirstP_Bone = "apex", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(5, 0, 0), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
//ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
//ENT.CustomBlood_Particle = {"vj_hlr_blood_yellow"}
//ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Yellow"} -- Decals to spawn when it's damaged
//ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.VJ_NPC_Class = {"CLASS_CTHULHU"} -- NPCs with the same class with be allied to each other
ENT.HasMeleeAttack = true
ENT.AnimTbl_MeleeAttack = {} -- Melee Attack Animations
ENT.MeleeAttackDistance = 164 -- How close does it have to be until it attacks?
ENT.TimeUntilMeleeAttackDamage = 0 -- This counted in seconds | This calculates the time until it hits something
ENT.NextMeleeAttackTime = 1
ENT.MeleeAttackDamageType = DMG_SONIC -- Type of Damage
ENT.MeleeAttackDSPSoundType = 34 -- What type of DSP effect? | Search online for the types
ENT.MeleeAttackDSPSoundUseDamage = false -- Should it only do the DSP effect if gets damaged x or greater amount
ENT.DisableDefaultMeleeAttackDamageCode = true -- Disables the default melee attack damage code

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 100 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = 0 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 1 -- How much time until it can use a range attack?
ENT.DisableDefaultRangeAttackCode = true -- When true, it won't spawn the range attack entity, allowing you to make your own

ENT.NoChaseAfterCertainRange = false -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = "UseRangeDistance" -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = "UseRangeDistance" -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "OnlyRange" -- "Regular" = Default behavior | "OnlyRange" = Only does it if it's able to range attack
ENT.HasDeathAnimation = false -- Does it play an animation when it dies?
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
ENT.SoundTbl_BeforeRangeAttack = {}
ENT.SoundTbl_RangeAttack = {"vj_hlr/hl1_npc/hassault/hw_shoot1.wav"}
ENT.SoundTbl_Death = {"vj_cthulhu/garg/black hole explosion.wav"}
ENT.SoundTbl_Breath = {"vj_cthulhu/garg/blackholeloop.wav"}
local blastSd = {"vj_cthulhu/garg/zap4.wav"}

ENT.FootStepSoundLevel = 60

ENT.GeneralSoundPitch1 = 100
ENT.RangeAttackPitch = VJ_Set(130, 160)

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	local StartLight1 = ents.Create("light_dynamic")
	StartLight1:SetKeyValue("brightness", "4")
	StartLight1:SetKeyValue("distance", "120")
	StartLight1:SetKeyValue("style", 5)
	StartLight1:SetLocalPos(self:GetPos() + self:GetUp()*0)
	StartLight1:SetLocalAngles(self:GetAngles())
	StartLight1:Fire("Color", "0 255 0")
	StartLight1:SetParent(self)
	StartLight1:Spawn()
	StartLight1:Activate()
	StartLight1:SetParent(self)
	StartLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(StartLight1)

	self:SetCollisionBounds(Vector(10, 10, 20), Vector(-10, -10, 0))
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
		VJ_EmitSound(self, {"vj_hlr/hl1_npc/hassault/hw_shoot1.wav"}, 75, 100)
	elseif key == "zap_charge_effect" then
		self:RangeAttackCode()
		VJ_EmitSound(self, {"vj_hlr/hl1_npc/hassault/hw_shoot1.wav"}, 75, 100)
	elseif key == "body" then
		VJ_EmitSound(self, {"vj_cthulhu/common/bodydrop1.wav","vj_cthulhu/common/bodydrop2.wav","vj_cthulhu/common/bodydrop3.wav","vj_cthulhu/common/bodydrop4.wav"}, 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
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
	util.Effect("VJ_HLR_Electric",elec)
	
	elec = EffectData()
	elec:SetStart(startpos)
	elec:SetOrigin(hitpos)
	elec:SetEntity(self)
	elec:SetAttachment(1)
	util.Effect("VJ_HLR_Electric",elec)
	
	util.VJ_SphereDamage(self, self, hitpos, 25, 25, DMG_SHOCK, true, false, {Force=90})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialKilled(dmginfo, hitgroup)
		VJ_EmitSound(self, {"vj_cthulhu/common/bustglass1.wav","vj_cthulhu/common/bustglass2.wav","vj_cthulhu/common/bustglass3.wav"}, 75, 100)

local vecZ80 = Vector(0, 0, 0)
	local spr = ents.Create("env_sprite")
	spr:SetKeyValue("model","vj_cthulhu/sprites/greenorbexplosion.vmt")
	spr:SetKeyValue("GlowProxySize","2.0")
	spr:SetKeyValue("HDRColorScale","1.0")
	spr:SetKeyValue("renderfx","14")
	spr:SetKeyValue("rendermode","5")
	spr:SetKeyValue("renderamt","255")
	spr:SetKeyValue("disablereceiveshadows","0")
	spr:SetKeyValue("mindxlevel","0")
	spr:SetKeyValue("maxdxlevel","0")
	spr:SetKeyValue("framerate","40.0")
	spr:SetKeyValue("spawnflags","0")
	spr:SetKeyValue("scale","0.5")
	spr:SetPos(self:GetPos() + vecZ80)
	spr:Spawn()
	spr:Fire("Kill","",0.48)
	timer.Simple(0.1, function() if IsValid(spr) then spr:Remove() end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
		VJ_EmitSound(self, {"vj_cthulhu/common/bustglass1.wav","vj_cthulhu/common/bustglass2.wav","vj_cthulhu/common/bustglass3.wav"}, 75, 100)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local houndeyeClasses = {npc_vj_cthulhu_greencrystal=true, npc_vj_cthulhu_greencrystal=true}
--
function ENT:CustomOnMeleeAttack_BeforeChecks()
	local friNum = 0 -- How many allies exist around the Houndeye
	local color = Color(0,255,0) -- The shock wave color
	local dmg = 15 -- How much damage should the shock wave do?
	local myPos = self:GetPos()
	for _, v in ipairs(ents.FindInSphere(myPos, 400)) do
		if v != self && houndeyeClasses[v:GetClass()] then
			friNum = friNum + 1
		end
	end
	-- More allies = more damage and different colors
	if friNum == 1 then
		color = Color(0,128,0)
		dmg = 30
	elseif friNum == 2 then
		color = Color(50,205,50)
		dmg = 45
	elseif friNum >= 3 then
		color = Color(0,255,0)
		dmg = 60
	end
	
	-- flags 0 = No fade!
	effects.BeamRingPoint(myPos, 0.3, 2, 400, 16, 0, color, {material="vj_hl/sprites/shockwave", framerate=20, flags=0})
	effects.BeamRingPoint(myPos, 0.3, 2, 200, 16, 0, color, {material="vj_hl/sprites/shockwave", framerate=20, flags=0})
	
	if self.HasSounds && self.HasMeleeAttackSounds then
		VJ_EmitSound(self, blastSd, 100, math.random(80, 100))
	end
	util.VJ_SphereDamage(self, self, myPos, 400, dmg, self.MeleeAttackDamageType, true, true, {DisableVisibilityCheck=true, Force=80})
end
