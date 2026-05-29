AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_cthulhu/shambler.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 150
ENT.HullType = HULL_HUMAN
ENT.VJC_Data = {
	FirstP_Bone = "bip01 head", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(5, 0, 0), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CTHULHU"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.CanEat = true -- Should it search and eat organic stuff when idle?

ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 60 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 80 -- How far does the damage go?

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.RangeDistance = 1020 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 100 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 1 -- How much time until it can use a range attack?
ENT.DisableDefaultRangeAttackCode = true -- When true, it won't spawn the range attack entity, allowing you to make your own

ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = "UseRangeDistance" -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = "UseRangeDistance" -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "OnlyRange" -- "Regular" = Default behavior | "OnlyRange" = Only does it if it's able to range attack
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {"death"} -- Death Animations
ENT.DeathAnimationTime = false -- Time until the SNPC spawns its corpse and gets removed
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {"pain"} -- If it uses normal based animation, use this
ENT.FlinchChance = 2 -- Chance of it flinching from 1 to x | 1 will make it always flinch

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_hlr/hl1_npc/aslave/vort_foot1.wav","vj_hlr/hl1_npc/aslave/vort_foot2.wav","vj_hlr/hl1_npc/aslave/vort_foot3.wav","vj_hlr/hl1_npc/aslave/vort_foot4.wav"}
ENT.SoundTbl_Idle = {"vj_cthulhu/shambler/idle.wav"}
ENT.SoundTbl_Alert = {"vj_cthulhu/shambler/sight.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_cthulhu/common/claw_strike1.wav","vj_cthulhu/common/claw_strike2.wav","vj_cthulhu/common/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_cthulhu/common/claw_miss1.wav","vj_cthulhu/common/claw_miss2.wav"}
ENT.SoundTbl_BeforeRangeAttack = {"vj_cthulhu/shambler/charge.wav"}
ENT.SoundTbl_RangeAttack = {"vj_hlr/hl1_npc/hassault/hw_shoot1.wav"}
ENT.SoundTbl_Pain = {"vj_cthulhu/shambler/hurt.wav"}
ENT.SoundTbl_Death = {"vj_cthulhu/shambler/death.wav"}


ENT.FootStepSoundLevel = 60

ENT.GeneralSoundPitch1 = 100
ENT.RangeAttackPitch = VJ_Set(130, 160)

ENT.AAHW_NextRunT = 0
ENT.Vort_RunAway = false
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
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/fx/bodydrop"..math.random(3, 4)..".wav", 75, 100)
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
	util.Effect("vj_cthulhu_electric",elec)
	
	elec = EffectData()
	elec:SetStart(startpos)
	elec:SetOrigin(hitpos)
	elec:SetEntity(self)
	elec:SetAttachment(2)
	util.Effect("vj_cthulhu_electric",elec)
	
	util.VJ_SphereDamage(self, self, hitpos, 30, 20, DMG_SHOCK, true, false, {Force=90})
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
local gibsgreen = {"models/vj_cthulhu/humangib2.mdl","models/vj_cthulhu/humangib3.mdl","models/vj_cthulhu/humangib4.mdl","models/vj_cthulhu/humangib5.mdl","models/vj_cthulhu/humangib6.mdl","models/vj_cthulhu/humangib7.mdl","models/vj_cthulhu/humangib8.mdl","models/vj_cthulhu/humangib9.mdl","models/vj_cthulhu/humangib10.mdl","models/vj_cthulhu/humangib11.mdl"}

function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
		VJ_HLR_ApplyCorpseEffects(self, corpseEnt, gibsgreen)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	if hitgroup == HITGROUP_HEAD then
		self.AnimTbl_Death = {"death"}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if math.random(1, 2) == 1 then
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.MeleeAttackDamage = 20
	else
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.MeleeAttackDamage = 40
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	if self.VJ_IsBeingControlled or self.IsGuard or !IsValid(self:GetEnemy()) or self.Dead then return end
	if CurTime() > self.AAHW_NextRunT then
		timer.Simple(5, function() 
			if IsValid(self) && !self:IsMoving() && !self.Dead then
				self:VJ_TASK_COVER_FROM_ENEMY("TASK_RUN_PATH")
	end
end)
		self.AAHW_NextRunT = CurTime() + 5
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnEat(status, statusInfo)
	-- The following code is a ideal example based on Half-Life 1 Zombie
	//print(self, "Eating Status: ", status, statusInfo)
	
	if status == "CheckFood" then
		return true //statusInfo.owner.BloodData && statusInfo.owner.BloodData.Color == "Red"
	elseif status == "BeginEating" then
		self:SetIdleAnimation({"smash"}, true)
		return self:VJ_ACT_PLAYACTIVITY(ACT_ARM, true, false)
	elseif status == "Eat" then
		VJ_EmitSound(self, {"vj_cthulhu/common/claw_strike1.wav","vj_cthulhu/common/claw_strike2.wav","vj_cthulhu/common/claw_strike3.wav"}, 100) --more accurate to the mod - epicplayer
		-- Health changes
		local food = self.EatingData.Ent
		local damage = 200 -- How much damage food will receive
		local foodHP = food:Health() -- Food's health
		self:SetHealth(math.Clamp(self:Health() + ((damage > foodHP and foodHP) or damage), self:Health(), self:GetMaxHealth())) -- Give health to the NPC
		food:SetHealth(foodHP - damage) -- Decrease corpse health
		-- Blood effects
		local bloodData = food.BloodData
		if bloodData then
			local bloodPos = food:GetPos() + food:OBBCenter()
			local bloodParticle = VJ_PICK(bloodData.Particle)
			if bloodParticle then
				ParticleEffect(bloodParticle, bloodPos, self:GetAngles())
			end
			local bloodDecal = VJ_PICK(bloodData.Decal)
		end
		return 1 -- Changed to match the speed of the HLZE mod - epicplayer
	elseif status == "StopEating" then
		if statusInfo != "Dead" && self.EatingData.AnimStatus != "None" then -- Do NOT play anim while dead or has NOT prepared to eat
			return self:VJ_ACT_PLAYACTIVITY(ACT_DISARM, true, false)
		end
	end
	return 0
end