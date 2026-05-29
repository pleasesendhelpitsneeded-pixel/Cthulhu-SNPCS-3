AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_cthulhu/serpentman.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 75
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
ENT.RangeAttackEntityToSpawn = "obj_vj_cthulhu_greenorb" -- The entity that is spawned when range attacking
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 80 -- How close does it have to be until it uses melee?
ENT.NextRangeAttackTime = 15 -- How much time until it can use a range attack?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "arm" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.AnimTbl_Death = {ACT_DIESIMPLE} -- Death Animationsed
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
ENT.SoundTbl_Idle = {}
ENT.SoundTbl_Alert = {"vj_cthulhu/serpentman/sm_alert1.wav","vj_cthulhu/serpentman/sm_alert2.wav","vj_cthulhu/serpentman/sm_alert3.wav","vj_cthulhu/serpentman/sm_alert4.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_cthulhu/common/claw_strike1.wav","vj_cthulhu/common/claw_strike2.wav","vj_cthulhu/common/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_cthulhu/common/claw_miss1.wav","vj_cthulhu/common/claw_miss2.wav"}
ENT.SoundTbl_Death = {"vj_cthulhu/serpentman/sm_die1.wav","vj_cthulhu/serpentman/sm_die2.wav"}
ENT.SoundTbl_Pain = {"vj_cthulhu/serpentman/sm_pain1.wav","vj_cthulhu/serpentman/sm_pain2.wav","vj_cthulhu/serpentman/sm_pain3.wav"}


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
	elseif key == "summon" then
		self:Tor_SpawnAlly()
	elseif key == "melee" then
		self:MeleeAttackCode()
	elseif key == "range" then
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
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.MeleeAttackDamage = 20
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
function ENT:Controller_Initialize(ply, controlEnt)
	function controlEnt:CustomOnKeyPressed(key)
		if key == KEY_SPACE then
			self.VJCE_NPC:Tor_StartSpawnAlly()
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)
	ply:ChatPrint("SPACE: Cast an Snake")
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vezZ20 = Vector(0, 0, 20)
--
function ENT:Tor_CreateAlly()
	local spawnPos = self:GetPos() + self:GetForward() * 100 + self:GetUp() * 5
	local ally = ents.Create("npc_vj_cthulhu_snake")
	ally:SetPos(spawnPos)
	ally:SetAngles(self:GetAngles())
	ally.VJ_NPC_Class = self.VJ_NPC_Class
	ally:Spawn()
	ally:Activate()
	
	local effectTeleport = VJ_HLR_Effect_PortalSpawn(spawnPos + vezZ20)
	effectTeleport:Fire("Kill", "", 1)
	self:DeleteOnRemove(effectTeleport)
	return ally
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Tor_SpawnAlly()
	-- Can have a total of a lot, only 1 can be spawned at a time with a delay until another one is spawned
	if !IsValid(self.Tor_Ally1) then
		self.Tor_Ally1 = self:Tor_CreateAlly()
		return
	elseif !IsValid(self.Tor_Ally2) then
		self.Tor_Ally2 = self:Tor_CreateAlly()
		return
	elseif !IsValid(self.Tor_Ally3) then
		self.Tor_Ally3 = self:Tor_CreateAlly()
		return
	elseif !IsValid(self.Tor_Ally4) then
		self.Tor_Ally4 = self:Tor_CreateAlly()
		return
	elseif !IsValid(self.Tor_Ally5) then
		self.Tor_Ally5 = self:Tor_CreateAlly()
		return
	elseif !IsValid(self.Tor_Ally6) then
		self.Tor_Ally6 = self:Tor_CreateAlly()
		return
	elseif !IsValid(self.Tor_Ally7) then
		self.Tor_Ally7 = self:Tor_CreateAlly()
		return
	elseif !IsValid(self.Tor_Ally8) then
		self.Tor_Ally8 = self:Tor_CreateAlly()
		return
	elseif !IsValid(self.Tor_Ally9) then
		self.Tor_Ally9 = self:Tor_CreateAlly()
		return
	elseif !IsValid(self.Tor_Ally10) then
		self.Tor_Ally10 = self:Tor_CreateAlly()
		return
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Tor_StartSpawnAlly()
	if !self:BusyWithActivity() && CurTime() > self.Tor_NextSpawnT && (!IsValid(self.Tor_Ally1) or !IsValid(self.Tor_Ally2) or !IsValid(self.Tor_Ally3)) then
		-- Make sure not to place it if the front of the NPC is blocked!
		local tr = util.TraceLine({
			start = self:GetPos() + self:OBBCenter(),
			endpos = self:GetPos() + self:OBBCenter() + self:GetForward()*150,
			filter = self
		})
		if !tr.Hit then
			self:VJ_ACT_PLAYACTIVITY("cast_serpentstaff", true, false)
			self.Tor_NextSpawnT = CurTime() + 10
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	if self.Dead or self.VJ_IsBeingControlled then return end
	
	-- Spawn an ally
	if IsValid(self:GetEnemy()) then
		self:Tor_StartSpawnAlly()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	-- If the NPC was removed, then remove its children as well, but not when it's killed!
	if !self.Dead then
		if IsValid(self.Tor_Ally1) then self.Tor_Ally1:Remove() end
		if IsValid(self.Tor_Ally2) then self.Tor_Ally2:Remove() end
		if IsValid(self.Tor_Ally3) then self.Tor_Ally3:Remove() end
		if IsValid(self.Tor_Ally4) then self.Tor_Ally3:Remove() end
		if IsValid(self.Tor_Ally5) then self.Tor_Ally3:Remove() end
		if IsValid(self.Tor_Ally6) then self.Tor_Ally3:Remove() end
		if IsValid(self.Tor_Ally7) then self.Tor_Ally3:Remove() end
		if IsValid(self.Tor_Ally8) then self.Tor_Ally3:Remove() end
		if IsValid(self.Tor_Ally9) then self.Tor_Ally3:Remove() end
		if IsValid(self.Tor_Ally10) then self.Tor_Ally3:Remove() end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode_AfterProjectileSpawn(projectile)
	if IsValid(self:GetEnemy()) then
		projectile.Track_Enemy = self:GetEnemy()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(projectile)
	return self:CalculateProjectile("Line", self:GetPos() + self:GetUp()*50, self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(), 200)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialKilled(dmginfo, hitgroup)
self:SetBodygroup(2,1)
self:CreateGibEntity("obj_vj_gib", "models/vj_cthulhu/serpentstaff.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(25, 0, 55)),CollideSound={}})
 end