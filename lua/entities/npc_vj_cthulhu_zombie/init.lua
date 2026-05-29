AddCSLuaFile("shared.lua")
include('shared.lua')

/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej ***
-----------------------------------------------*/

ENT.Model = {"models/vj_cthulhu/ghoul.mdl"}
ENT.StartHealth = 100
ENT.HullType = HULL_HUMAN

ENT.VJC_Data = {
    ThirdP_Offset = Vector(-5, 0, -15),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(5, 0, 5),
}

---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"vj_hlr_blood_yellow"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Yellow"}
ENT.HasBloodPool = false
ENT.VJ_NPC_Class = {"CLASS_CTHULHU"}
ENT.CanEat = true

ENT.HasMeleeAttack = true
ENT.TimeUntilMeleeAttackDamage = false
ENT.MeleeAttackDistance = 50
ENT.MeleeAttackDamageDistance = 80

ENT.HasExtraMeleeAttackSounds = true
ENT.DisableFootStepSoundTimer = true
ENT.AnimTbl_Run = {ACT_WALK}

-- IMPORTANT: we keep this true but override behavior manually
ENT.HasDeathAnimation = true

-- Flinch
ENT.CanFlinch = 1
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS}

ENT.HitGroupFlinching_Values = {
	{HitGroup={HITGROUP_LEFTARM}, Animation={ACT_FLINCH_LEFTARM}},
	{HitGroup={HITGROUP_LEFTLEG}, Animation={ACT_FLINCH_LEFTLEG}},
	{HitGroup={HITGROUP_RIGHTARM}, Animation={ACT_FLINCH_RIGHTARM}},
	{HitGroup={HITGROUP_RIGHTLEG}, Animation={ACT_FLINCH_RIGHTLEG}}
}

-- Sounds
ENT.SoundTbl_FootStep = {"vj_cthulhu/common/npc_step1.wav","vj_cthulhu/common/npc_step2.wav","vj_cthulhu/common/npc_step3.wav","vj_cthulhu/common/npc_step4.wav"}
ENT.SoundTbl_Idle = {"vj_cthulhu/zombie/zo_idle1.wav","vj_cthulhu/zombie/zo_idle2.wav","vj_cthulhu/zombie/zo_idle3.wav","vj_cthulhu/zombie/zo_idle4.wav"}
ENT.SoundTbl_Alert = {"vj_cthulhu/zombie/zo_alert10.wav","vj_cthulhu/zombie/zo_alert20.wav","vj_cthulhu/zombie/zo_alert30.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_cthulhu/zombie/zo_attack1.wav","vj_cthulhu/zombie/zo_attack2.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_cthulhu/common/claw_strike1.wav","vj_cthulhu/common/claw_strike2.wav","vj_cthulhu/common/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_cthulhu/common/claw_miss1.wav","vj_cthulhu/common/claw_miss2.wav"}
ENT.SoundTbl_Pain = {"vj_cthulhu/zombie/zo_pain1.wav","vj_cthulhu/zombie/zo_pain2.wav","vj_cthulhu/zombie/zo_pain3.wav"}
ENT.SoundTbl_Death = {"vj_cthulhu/zombie/zo_pain1.wav","vj_cthulhu/zombie/zo_pain2.wav","vj_cthulhu/zombie/zo_pain3.wav"}

ENT.GeneralSoundPitch1 = 100

ENT.Zombie_Type = 0

---------------------------------------------------------------------------------------------------------------------------------------------
-- ✅ FIXED DEATH SYSTEM
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled(dmginfo, hitgroup)
	self.Dead = true

	-- Stop everything
	self:StopMoving()
	self:ClearSchedule()
	self:SetNPCState(NPC_STATE_DEAD)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetVelocity(Vector(0,0,0))

	-- Pick animation
	local deathAnims = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIESIMPLE}
	local anim = deathAnims[math.random(#deathAnims)]

	self:VJ_ACT_PLAYACTIVITY(anim, true, false, false)
	self:PlayDeathSound()

	-- Get animation time safely
	local seq = self:GetSequence()
	local animTime = self:SequenceDuration(seq)

	timer.Simple(animTime, function()
		if IsValid(self) then
			self:CreateDeathCorpse(dmginfo, hitgroup)
			self:Remove()
		end
	end)

	return true -- BLOCK default VJ death
end
---------------------------------------------------------------------------------------------------------------------------------------------

function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" then
		self:FootStepSoundCode()
	elseif key == "melee" then
		self:MeleeAttackCode()
	elseif key == "body" then
		VJ_EmitSound(self, {"vj_cthulhu/common/bodydrop1.wav","vj_cthulhu/common/bodydrop2.wav"}, 75, 100)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if math.random(1, 2) == 1 then
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.MeleeAttackDamage = 20
	else
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.MeleeAttackDamage = 40
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
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	if hitgroup == HITGROUP_HEAD then
		self.AnimTbl_Death = {ACT_DIE_GUTSHOT, ACT_DIE_HEADSHOT}
	else
		self.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIESIMPLE}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnEat(status, statusInfo)
	-- The following code is a ideal example based on Half-Life 1 Zombie
	//print(self, "Eating Status: ", status, statusInfo)
	
	if status == "CheckFood" then
		return (statusInfo.owner.BloodData && self:Health() != self:GetMaxHealth()) -- only start eating if the corpse is a human, and we're not at full health - epicplayer
	elseif status == "BeginEating" then
		self:SetIdleAnimation({"sic2zombeating"}, true)
		return self:VJ_ACT_PLAYACTIVITY(ACT_ARM, true, false)
	elseif status == "Eat" then
		VJ_EmitSound(self, "vj_hlr/hl1_npc/bullchicken/bc_bite"..math.random(1, 3)..".wav", 100) --more accurate to the mod - epicplayer
		-- Health changes
		local food = self.EatingData.Ent
		local damage = 8 -- How much damage food will receive
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
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoKilledEnemy(victim,attacker,inflictor)
         if victim.IsVJBaseSNPC_Human or victim:IsPlayer() then
 	local type = VJ_PICK({"npc_vj_cthulhu_zombie","npc_vj_cthulhu_fatheadlesszombie"})           

npc = ents.Create(type)
            npc:SetPos(victim:GetPos())
            npc:SetAngles(victim:GetAngles())
			//npc:VJ_ACT_PLAYACTIVITY("",true,2,true)
            npc:Spawn()		
		
         if victim.IsVJBaseSNPC == true then
                victim.HasDeathRagdoll = false
				victim.HasDeathAnimation = false				
         elseif victim:IsPlayer() then
		 if IsValid(victim:GetRagdollEntity()) then
				victim:GetRagdollEntity():Remove()
	end			
end			
                victim:Remove()
				
    end	
end