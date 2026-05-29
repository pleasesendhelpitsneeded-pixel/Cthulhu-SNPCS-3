AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_cthulhu/cthonian_classic.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 900
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
ENT.AnimTbl_Death = {ACT_DIESIMPLE} -- Death Animationsed
ENT.VJ_IsHugeMonster = true -- This is mostly used for massive or boss SNPCs, it affects certain part of the SNPC, for example the SNPC won't receive any knock back

ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 60 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 150 -- How far does the damage go?
ENT.MeleeAttackDamage = 50
ENT.MeleeAttackDamageType = DMG_CRUSH -- How close does it have to be until it attacks?

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_hlr1_toxicspit" -- The entity that is spawned when range attacking
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.RangeDistance = 4500 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 250 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "mouth" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.NextRangeAttackTime = 5 -- How much time until it can use a range attack?

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
--ENT.DeathAnimationTime = 0.8 -- Time until the SNPC spawns its corpse and gets removed
ENT.HasSoundTrack = true -- Does the SNPC have a sound track?
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS} -- If it uses normal based animation, use this
ENT.HitGroupFlinching_Values = {
	{HitGroup={HITGROUP_LEFTARM}, Animation={ACT_FLINCH_LEFTARM}},
	{HitGroup={HITGROUP_LEFTLEG}, Animation={ACT_FLINCH_LEFTLEG}},
	{HitGroup={HITGROUP_RIGHTARM}, Animation={ACT_FLINCH_RIGHTARM}},
	{HitGroup={HITGROUP_RIGHTLEG}, Animation={ACT_FLINCH_RIGHTLEG}}
}
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Alert = {"vj_cthulhu/cthonian/cth_attackgrowl.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_cthulhu/cthonian/cth_bite1.wav","vj_cthulhu/cthonian/cth_bite2.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_hlr/hl1_npc/zombie/claw_strike1.wav","vj_hlr/hl1_npc/zombie/claw_strike2.wav","vj_hlr/hl1_npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_hlr/hl1_npc/zombie/claw_miss1.wav","vj_hlr/hl1_npc/zombie/claw_miss2.wav"}
ENT.SoundTbl_Pain = {"vj_cthulhu/cthonian/cth_pain1.wav","vj_cthulhu/cthonian/cth_pain2.wav","vj_cthulhu/cthonian/cth_pain3.wav","vj_cthulhu/cthonian/cth_pain4.wav"}
ENT.SoundTbl_Death = {"vj_cthulhu/cthonian/cth_die1.wav","vj_cthulhu/cthonian/cth_die2.wav"}
ENT.SoundTbl_SoundTrack = {"vj_cthulhu/soundtrack/TheWormClassic.mp3"}

ENT.GeneralSoundPitch1 = 100
ENT.MeleeAttackMissSoundLevel = 1
ENT.MeleeAttackExtraSoundLevel = 1
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize() 
    if GetConVar("VJ_CTHULHU_Boss_Music"):GetInt() == 1 then
        self.HasSoundTrack = false 
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "spit" then
		self:RangeAttackCode()
		VJ_EmitSound(self, {"vj_hlr/hl1_npc/bullchicken/bc_attack2.wav","vj_hlr/hl1_npc/bullchicken/bc_attack3.wav"}, 75, 100)
	elseif key == "melee" then
		self:MeleeAttackCode()
	elseif key == "burst" then
        self:CreateGibEntity("obj_vj_gib", "models/vj_cthulhu/bigrock.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(-350, -15, 0)),CollideSound={}})
        self:CreateGibEntity("obj_vj_gib", "models/vj_cthulhu/bigrock.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(-350, -15, 0)),CollideSound={}})
        self:CreateGibEntity("obj_vj_gib", "models/vj_cthulhu/bigrock.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(-350, -15, 0)),CollideSound={}})
        self:CreateGibEntity("obj_vj_gib", "models/vj_cthulhu/bigrock.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(-350, -15, 0)),CollideSound={}})
        self:CreateGibEntity("obj_vj_gib", "models/vj_cthulhu/bigrock.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(-350, -15, 0)),CollideSound={}})
        self:CreateGibEntity("obj_vj_gib", "models/vj_cthulhu/bigrock.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(-350, -15, 0)),CollideSound={}})
        self:CreateGibEntity("obj_vj_gib", "models/vj_cthulhu/bigrock.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(-350, -15, 20)),CollideSound={}})
        self:CreateGibEntity("obj_vj_gib", "models/vj_cthulhu/bigrock.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(-350, -15, 20)),CollideSound={}})
        self:CreateGibEntity("obj_vj_gib", "models/vj_cthulhu/bigrock.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(-350, -15, 20)),CollideSound={}})
        self:CreateGibEntity("obj_vj_gib", "models/vj_cthulhu/bigrock.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(-350, -15, 35)),CollideSound={}})
        self:CreateGibEntity("obj_vj_gib", "models/vj_cthulhu/bigrock.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(-350, -15, 35)),CollideSound={}})
        self:CreateGibEntity("obj_vj_gib", "models/vj_cthulhu/bigrock.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(-350, -15, 35)),CollideSound={}})
	util.Decal("VJ_CTHULHU_Scorch", self:GetPos() + self:GetRight()*0 + self:GetForward()*-350, self:GetPos() + self:GetRight()*0 + self:GetForward()*-350 + self:GetUp()*-100, self)
	util.ScreenShake(self:GetPos(), 100, 200, 1, 2500)
		VJ_EmitSound(self, {"vj_cthulhu/cthonian/burst.wav"}, 100, 100)
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/fx/bodydrop"..math.random(3, 4)..".wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
        self.MovementType = VJ_MOVETYPE_STATIONARY
        self.CanTurnWhileStationary = false
	self:SetCollisionBounds(Vector(40, 40 , 120), Vector(-40, -40, 0))
	timer.Simple(0.0,function() if IsValid(self) then self:VJ_ACT_PLAYACTIVITY("burst", true, false, false) end end)
	timer.Simple(3.30,function() if IsValid(self) then self.MovementType = VJ_MOVETYPE_GROUND end end)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(projectile)
	local ene = self:GetEnemy()
	if self.Bullsquid_BullSquidding == true then
		return self:CalculateProjectile("Line", projectile:GetPos(), ene:GetPos() + ene:OBBCenter(), 250000)
	else
		return self:CalculateProjectile("Curve", projectile:GetPos(), ene:GetPos() + ene:OBBCenter(), 1500)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
    dmginfo:ScaleDamage(0.25)	
end