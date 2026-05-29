AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_cthulhu/eyetentacle.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_IsHugeMonster = true -- Is this a huge monster?
ENT.SightAngle = 180 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.StartHealth = 4500
ENT.MovementType = VJ_MOVETYPE_STATIONARY -- How does the SNPC move?
ENT.HullType = HULL_LARGE
ENT.VJC_Data = {
    ThirdP_Offset = Vector(0, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Dummy04", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(23, 0, 30), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CTHULHU"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_yellow_large"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Yellow"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamage = 90
ENT.MeleeAttackDamageType = DMG_ALWAYSGIB -- Type of Damage
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 450 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 490 -- How far does the damage go?
ENT.MeleeAttackDamageAngleRadius = 10 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_cthulhu_greenorb" -- The entity that is spawned when range attacking
ENT.RangeDistance = 10000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 80 -- How close does it have to be until it uses melee?
ENT.NextRangeAttackTime = false -- How much time until it can use a range attack?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "0" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true

ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.DeathAnimationTime = 2.5 -- Time until the SNPC spawns its corpse and gets removed
ENT.AnimTbl_Death = {ACT_DIESIMPLE} -- Death Animations
ENT.IdleSounds_PlayOnAttacks = true -- It will be able to continue and play idle sounds when it performs an attack
ENT.AnimTbl_IdleStand = {ACT_IDLE_ANGRY}
ENT.AnimTbl_MeleeAttack = {ACT_RANGE_ATTACK2_LOW}
ENT.HasSoundTrack = true -- Does the SNPC have a sound track?
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Breath = {"vj_hlr/hl1_npc/tentacle/te_flies1.wav"}
ENT.SoundTbl_Idle = {"vj_cthulhu/tentacle/te_sing1.wav","vj_cthulhu/tentacle/te_sing2.wav"}
ENT.SoundTbl_Alert = {}
ENT.SoundTbl_Pain = {"vj_cthulhu/tentacle/te_roar1.wav","vj_cthulhu/tentacle/te_roar2.wav"}
ENT.SoundTbl_Death = {}

ENT.SoundTbl_SoundTrack = {"vj_cthulhu/soundtrack/GreatBase.mp3"}

ENT.GeneralSoundPitch1 = 100
ENT.SoundTrackVolume = 1
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize() 
    if GetConVar("VJ_CTHULHU_Boss_Music"):GetInt() == 1 then
        self.HasSoundTrack = false 
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
local spawnPos = Vector(0, 0, 250)
local deletepos = Vector(0, 0, -250)
	self:SetPos(self:GetPos() + spawnPos)
		self:SetCollisionBounds(Vector(190, 20, 1200), Vector(-150, -20, 0))
	timer.Simple(0.0,function() if IsValid(self) then self:VJ_ACT_PLAYACTIVITY("floor_to_lev1", true, false, false) end end)
	timer.Simple(0.5,function() if IsValid(self) then self:VJ_ACT_PLAYACTIVITY("lev2_to_lev3", true, false, false) end end)
	timer.Simple(0.81,function() if IsValid(self) then self:SetPos(self:GetPos() + deletepos) end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnHandleAnimEvent(ev, evTime, evCycle, evType, evOptions)
	-- Take care of the regular hit sound (When playing idle animations)
	if ev == 6 && !self.VJ_IsBeingControlled then
		self:PlaySoundSystem("MeleeAttack", {"vj_hlr/hl1_npc/tentacle/te_strike1.wav","vj_hlr/hl1_npc/tentacle/te_strike2.wav"}, VJ_EmitSound)
		if IsValid(self:GetEnemy()) && (self:GetEnemy():GetPos():Distance(self:GetPos() + self:GetForward()*150)) < 200 then
			self.CanTurnWhileStationary = true
			self:SetAngles(self:GetFaceAngle((self:GetEnemy():GetPos()-self:GetPos()):Angle()))
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "attack" then
		self:MeleeAttackCode()
		self:PlaySoundSystem("MeleeAttack", {"vj_hlr/hl1_npc/tentacle/te_strike1.wav","vj_hlr/hl1_npc/tentacle/te_strike2.wav"}, VJ_EmitSound)
		if IsValid(self:GetEnemy()) then self:SetAngles(self:GetFaceAngle((self:GetEnemy():GetPos()-self:GetPos()):Angle())) end
	end
end
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleRangeAttacks()
	if math.random(1, 2) == 1 then
         self.RangeAttackEntityToSpawn = "obj_vj_cthulhu_greenorb" -- The entity that is spawned when range attacking
         self.NextRangeAttackTime = 1.3 -- How much time until it can use a range attack?
         self.TimeUntilRangeAttackProjectileRelease = 0.6 -- How much time until the projectile code is ran?
         self.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
         self.RangeUseAttachmentForPosID = "0" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
         self.AnimTbl_RangeAttack = {"lev3_to_engine"} -- Range Attack Animations
             self.RangeAttackExtraTimers = {0.62, 0.64 , 0.67, 0.71, 0.74} -- Extra range attack timers | it will run the 
else
	if math.random(2, 3) == 2 then
         self.RangeAttackEntityToSpawn = "obj_vj_cthulhu_redorb" -- The entity that is spawned when range attacking
         self.NextRangeAttackTime = 2.0 -- How much time until it can use a range attack?
         self.TimeUntilRangeAttackProjectileRelease = 0.2 -- How much time until the projectile code is ran?
         self.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
         self.RangeUseAttachmentForPosID = "0" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
         self.AnimTbl_RangeAttack = {"lev3_rotate"} -- Range Attack Animations
          self.RangeAttackExtraTimers = {0.23, 0.26} -- Extra range attack timers | it will run the 
else
	if math.random(3, 4) == 3 then
         self.RangeAttackEntityToSpawn = "obj_vj_cthulhu_hornet" -- The entity that is spawned when range attacking
         self.NextRangeAttackTime = 0 -- How much time until it can use a range attack?
         self.TimeUntilRangeAttackProjectileRelease = 0.1 -- How much time until the projectile code is ran?
         self.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
         self.RangeUseAttachmentForPosID = "0" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
         self.AnimTbl_RangeAttack = {"lev3_rear"} -- Range Attack Animations
        self.RangeAttackExtraTimers = {0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2} -- Extra range attack timers | it will run the 
else
         self.RangeAttackEntityToSpawn = "obj_vj_cthulhu_gut" -- The entity that is spawned when range attacking
         self.NextRangeAttackTime = 1.4 -- How much time until it can use a range attack?
         self.TimeUntilRangeAttackProjectileRelease = 0.2 -- How much time until the projectile code is ran?
         self.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
         self.RangeUseAttachmentForPosID = "0" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
         self.AnimTbl_RangeAttack = {"lev3_to_engine"} -- Range Attack Animations
         self.RangeAttackExtraTimers = {0.1 , 0.11, 0.15, 0.2, 0.21, 0.25, 0.3, 0.31, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.1 , 0.11, 0.15, 0.2, 0.21, 0.25, 0.3, 0.31, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85} -- Extra range attack timers | it will run the 
  end
end
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
    dmginfo:ScaleDamage(0.15)	
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode_AfterProjectileSpawn(projectile)
	local ene = self:GetEnemy()
	if IsValid(ene) then
		projectile.Track_Enemy = ene
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(projectile)
	local ene = self:GetEnemy()
	if self.Bullsquid_BullSquidding == true then
		return self:CalculateProjectile("Line", projectile:GetPos(), ene:GetPos() + ene:OBBCenter(), 250000)
	else
		return self:CalculateProjectile("Curve", projectile:GetPos(), ene:GetPos() + ene:OBBCenter(), 1500)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colorWhite = Color(255,221,35)

function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
local Buglin = ents.Create("npc_vj_cthulhu_greatrace")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(750,750) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_greatrace")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(750,750) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_greatrace")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(750,750) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_greatrace")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(750,750) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_greatrace_zikshadows")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(750,750) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_greatrace_zikshadows")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(750,750) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
	VJ_EmitSound(self, "vj_cthulhu/common/bodysplat.wav", 90, 95)
	self.HasDeathSounds = false
	if self.HasGibDeathParticles == true then
		local effectBlood = EffectData()
		effectBlood:SetOrigin(self:GetPos() + self:OBBCenter())
		effectBlood:SetColor(VJ_Color2Byte(Color(255,221,35)))
		effectBlood:SetScale(1420)
		util.Effect("VJ_Blood1",effectBlood)
		
		local bloodspray = EffectData()
		bloodspray:SetOrigin(self:GetPos() + self:OBBCenter())
		bloodspray:SetScale(30)
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
	-- Screen flash effect for all the players
	for _,v in ipairs(player.GetHumans()) do
		v:ScreenFade(SCREENFADE.IN, colorWhite, 3, 0)
	end
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,200))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,300))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,400))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,500))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,600))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,700))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,800))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,900))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1000))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,200))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,300))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,400))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,500))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,600))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,700))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,800))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,900))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1000))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,200))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,300))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,400))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,500))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,600))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,700))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,800))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,900))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1000))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,200))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,300))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,400))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,500))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,600))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,700))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,800))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,900))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1000))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,200))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,300))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,400))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,500))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,600))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,700))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,800))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,900))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1000))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,200))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,300))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,400))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,500))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,600))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,700))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,800))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,900))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1000))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,200))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,300))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,400))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,500))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,600))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,700))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,800))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,900))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1000))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1100))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/aliengib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,1100))})
	return true -- Return to true if it gibbed!
 end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)
	-- Death sequence (With explosions)
	for i = 0.3, 3.5, 0.5 do
		timer.Simple(i, function()
			if IsValid(self) then
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
				spr:SetKeyValue("framerate","15.0")
				spr:SetKeyValue("spawnflags","0")
				spr:SetKeyValue("scale","6")
				spr:SetPos(self:GetPos() + self:GetUp()*math.random(320,400))
				spr:Spawn()
				spr:Fire("Kill","",0.2)
				
				util.BlastDamage(self,self,self:GetPos(),150,50)
				util.ScreenShake(self:GetPos(),100,200,1,2500)
				VJ_EmitSound(self, {"vj_cthulhu/garg/black hole explosion.wav"}, 90, 100)
			end
		end)
	end
end
