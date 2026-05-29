AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_cthulhu/priest.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 100
ENT.HullType = HULL_HUMAN
ENT.VJC_Data = {
    ThirdP_Offset = Vector(-5, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.VJ_NPC_Class = {"CLASS_CTHULHU"} -- NPCs with the same class with be allied to each other
ENT.CanEat = false -- Should it search and eat organic stuff when idle?

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 50 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 80 -- How far does the damage go?

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.RangeDistance = 1500 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 100 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 5 -- How much time until it can use a range attack?
ENT.DisableDefaultRangeAttackCode = true -- When true, it won't spawn the range attack entity, allowing you to make your own

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.AnimTbl_Death = {ACT_DIESIMPLE} -- Death Animationsed
ENT.AnimTbl_Walk = {ACT_RUN} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
--ENT.DeathAnimationTime = 0.8 -- Time until the SNPC spawns its corpse and gets removed
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 0 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS} -- If it uses normal based animation, use this
ENT.HitGroupFlinching_Values = {
	{HitGroup={HITGROUP_LEFTARM}, Animation={ACT_FLINCH_LEFTARM}},
	{HitGroup={HITGROUP_LEFTLEG}, Animation={ACT_FLINCH_LEFTLEG}},
	{HitGroup={HITGROUP_RIGHTARM}, Animation={ACT_FLINCH_RIGHTARM}},
	{HitGroup={HITGROUP_RIGHTLEG}, Animation={ACT_FLINCH_RIGHTLEG}}
}
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_cthulhu/common/npc_step1.wav","vj_cthulhu/common/npc_step2.wav","vj_cthulhu/common/npc_step3.wav","vj_cthulhu/common/npc_step4.wav"}
ENT.SoundTbl_Idle = {"vj_cthulhu/cultist/cu_idle1.wav","vj_cthulhu/cultist/cu_idle2.wav","vj_cthulhu/cultist/cu_idle3.wav","vj_cthulhu/cultist/cu_idle4.wav","vj_cthulhu/cultist/cu_idle5.wav","vj_cthulhu/cultist/cu_idle6.wav"}
ENT.SoundTbl_Alert = {"vj_cthulhu/cultist/cu_alert1.wav","vj_cthulhu/cultist/cu_alert2.wav","vj_cthulhu/cultist/cu_alert3.wav","vj_cthulhu/cultist/cu_alert4.wav","vj_cthulhu/cultist/cu_alert5.wav","vj_cthulhu/cultist/cu_alert6.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_cthulhu/common/cbar_hitbod1.wav","vj_cthulhu/common/cbar_hitbod2.wav","vj_cthulhu/common/cbar_hitbod3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_cthulhu/common/cbar_miss1.wav"}
ENT.SoundTbl_Death = {"vj_cthulhu/butler/yeahthisisastockaudiososhutup1.ogg","vj_cthulhu/butler/yeahthisisastockaudiososhutup2.ogg","vj_cthulhu/butler/yeahthisisastockaudiososhutup3.ogg"}
ENT.SoundTbl_Pain = {"vj_hlr/hl1_npc/hgrunt/gr_pain1.wav","vj_hlr/hl1_npc/hgrunt/gr_pain2.wav","vj_hlr/hl1_npc/hgrunt/gr_pain3.wav","vj_hlr/hl1_npc/hgrunt/gr_pain4.wav","vj_hlr/hl1_npc/hgrunt/gr_pain5.wav"}
ENT.SoundTbl_BeforeRangeAttack = {"vj_hlr/fx/zap4.wav"}
ENT.SoundTbl_RangeAttack = {"vj_cthulhu/greatrace/zap4.wav"}

ENT.GeneralSoundPitch1 = 100

-- Custom
ENT.Zombie_Type = 0
	-- 0 = Default / Not Categorized
	-- 1 = Default Zombie Scientist
ENT.Tor_NextSpawnT = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "step" then
		self:FootStepSoundCode()
	elseif key == "swinghaha" then
		self:MeleeAttackCode()
	elseif key == "shoot" then
		self:RangeAttackCode()
	elseif key == "body" then
		VJ_EmitSound(self, {"vj_cthulhu/common/bodydrop1.wav","vj_cthulhu/common/bodydrop2.wav","vj_cthulhu/common/bodydrop3.wav","vj_cthulhu/common/bodydrop4.wav"}, 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if math.random(1, 2) == 1 then
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.MeleeAttackDamage = 15
	else
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.MeleeAttackDamage = 15
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnFlinch_BeforeFlinch(dmginfo, hitgroup)
	if dmginfo:GetDamage() > 30 then
		self.FlinchChance = 8
		self.AnimTbl_Flinch = {ACT_BIG_FLINCH}
	else
		self.FlinchChance = 16
		self.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)
	if self.HasGibDeathParticles == true then
		local effectBlood = EffectData()
		effectBlood:SetOrigin(self:GetPos() + self:OBBCenter())
		effectBlood:SetColor(VJ_Color2Byte(Color(130,19,10)))
		effectBlood:SetScale(120)
		util.Effect("VJ_Blood1",effectBlood)
		
		local bloodspray = EffectData()
		bloodspray:SetOrigin(self:GetPos())
		bloodspray:SetScale(8)
		bloodspray:SetFlags(3)
		bloodspray:SetColor(0)
		util.Effect("bloodspray",bloodspray)
		util.Effect("bloodspray",bloodspray)
	end
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib1.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib2.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib4.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib5.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,50))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib6.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib7.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib8.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib9.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib10.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,60))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib11.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,15))})
	return true -- Return to true if it gibbed!
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
	VJ_EmitSound(self, "vj_cthulhu/common/bodysplat.wav", 90, 100)
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibsgreen = {"models/vj_cthulhu/humangib1.mdl","models/vj_cthulhu/humangib2.mdl","models/vj_cthulhu/humangib3.mdl","models/vj_cthulhu/humangib4.mdl","models/vj_cthulhu/humangib5.mdl","models/vj_cthulhu/humangib6.mdl","models/vj_cthulhu/humangib7.mdl","models/vj_cthulhu/humangib8.mdl","models/vj_cthulhu/humangib9.mdl","models/vj_cthulhu/humangib10.mdl","models/vj_cthulhu/humangib11.mdl"}

function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
		VJ_HLR_ApplyCorpseEffects(self, corpseEnt, gibsgreen)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialKilled(dmginfo, hitgroup)
self:SetBodygroup(1,1)
 end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Vort_DoElecEffect(sp, hp, hn, a, t)
	local elec = EffectData()
	elec:SetStart(sp)
	elec:SetOrigin(hp)
	elec:SetNormal(hn)
	elec:SetEntity(self)
	elec:SetAttachment(a)
	elec:SetScale(2.2 - t)
	util.Effect("VJ_HLR_Electric_Charge", elec)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRangeAttack_AfterStartTimer()
	if self.CurrentBeforeRangeAttackSound then self.CurrentBeforeRangeAttackSound:ChangePitch(90 + 90, 1.2) end
	local myPos = self:GetPos()
	-- Tsakh --------------------------
	local tsakhSpawn = myPos + self:GetUp()*45 + self:GetRight()*20
	local tsakhLocations = {
		myPos + self:GetRight()*math.Rand(150, 500) + self:GetUp()*-200,
		myPos + self:GetRight()*math.Rand(150, 500) + self:GetUp()*-200 + self:GetForward()*-math.Rand(150, 500),
		myPos + self:GetRight()*math.Rand(150, 500) + self:GetUp()*-200 + self:GetForward()*math.Rand(150, 500),
		myPos + self:GetRight()*math.Rand(1, 150) + self:GetUp()*200 + self:GetForward()*math.Rand(-100, 100),
	}
	for i = 1, 4 do
		local randt = math.Rand(0, 0.6)
		timer.Simple(randt,function()
			if IsValid(self) then
				local tr = util.TraceLine({
					start = tsakhSpawn,
					endpos = tsakhLocations[i],
					filter = self
				})
				if tr.Hit == true then self:Vort_DoElecEffect(tr.StartPos, tr.HitPos, tr.HitNormal, 1, randt) end
			end
		end)
	end
	-- Ach --------------------------
	local achSpawn = myPos + self:GetUp()*45 + self:GetRight()*-20
	local achLocations = {
		myPos + self:GetRight()*-math.Rand(150, 500) + self:GetUp()*-200,
		myPos + self:GetRight()*-math.Rand(150, 500) + self:GetUp()*-200 + self:GetForward()*-math.Rand(150, 500),
		myPos + self:GetRight()*-math.Rand(150, 500) + self:GetUp()*-200 + self:GetForward()*math.Rand(150, 500),
		myPos + self:GetRight()*-math.Rand(1, 150) + self:GetUp()*200 + self:GetForward()*math.Rand(-100, 100),
	}
	for i = 1, 4 do
		local randt = math.Rand(0, 0.6)
		timer.Simple(randt,function()
			if IsValid(self) then
				local tr = util.TraceLine({
					start = achSpawn,
					endpos = achLocations[i],
					filter = self
				})
				if tr.Hit == true then self:Vort_DoElecEffect(tr.StartPos, tr.HitPos, tr.HitNormal, 1, randt) end
			end
		end)
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
	elec:SetAttachment(2)
	util.Effect("VJ_HLR_Electric",elec)
	
	util.VJ_SphereDamage(self, self, hitpos, 30, 20, DMG_SHOCK, true, false, {Force=90})
end