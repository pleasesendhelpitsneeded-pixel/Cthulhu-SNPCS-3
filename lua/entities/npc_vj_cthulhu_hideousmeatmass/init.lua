AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/vj_cthulhu/fleshabomination.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 5000
ENT.HullType = HULL_LARGE
ENT.VJ_IsHugeMonster = true -- Is this a huge monster?
ENT.VJC_Data = {
    ThirdP_Offset = Vector(-100, 0, -70), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Neck", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(0, 0, -5), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red_large"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.VJ_NPC_Class = {"CLASS_CTHULHU"} -- NPCs with the same class with be allied to each other
ENT.HasSoundTrack = true -- Does the SNPC have a sound track?
ENT.MeleeAttackDamageType = DMG_CRUSH -- How close does it have to be until it attacks?

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamage = 70
ENT.AnimTbl_MeleeAttack = {"claw_1","claw_2","claw_3"} -- Melee Attack Animations
ENT.MeleeAttackDistance = 80 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 230 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.HasMeleeAttackKnockBack = true -- Should knockback be applied on melee hit? | Use self:MeleeAttackKnockbackVelocity() to edit the velocity

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {"flinch"} -- Range Attack Animations
ENT.RangeAttackEntityToSpawn = "obj_vj_cthulhu_gut" -- The entity that is spawned when range attacking
ENT.TimeUntilRangeAttackProjectileRelease = 0.2
ENT.NextRangeAttackTime = 15 -- How much time until it can use a range attack?
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 256 -- How close does it have to be until it uses melee?
ENT.RangeUseAttachmentForPos = false -- Should the projectile spawn on a attachment?
ENT.RangeAttackPos_Up = 200 -- Up/Down spawning position for range attack
ENT.RangeAttackPos_Forward = 0 -- Forward/ Backward spawning position for range attack
ENT.RangeAttackPos_Right = 0 -- Right/Left spawning position for range attack
ENT.RangeAttackExtraTimers = {0.1 , 0.11, 0.15, 0.2, 0.21, 0.25, 0.3, 0.31, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.1 , 0.11, 0.15, 0.2, 0.21, 0.25, 0.3, 0.31, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85} -- Extra range attack timers | it will run the 

ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {"death"} -- Death Animations
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_cthulhu/gonarch/gon_step1.wav","vj_cthulhu/gonarch/gon_step2.wav","vj_cthulhu/gonarch/gon_step3.wav"}
ENT.SoundTbl_Idle = {}
ENT.SoundTbl_Alert = {"vj_cthulhu/gonarch/gon_alert1.wav","vj_cthulhu/gonarch/gon_alert2.wav","vj_cthulhu/gonarch/gon_alert3.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_cthulhu/gonarch/gon_attack1.wav","vj_cthulhu/gonarch/gon_attack2.wav","vj_cthulhu/gonarch/gon_attack3.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_cthulhu/common/claw_strike1.wav","vj_cthulhu/common/claw_strike2.wav","vj_cthulhu/common/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_cthulhu/common/claw_miss1.wav","vj_cthulhu/common/claw_miss2.wav"}ENT.SoundTbl_BeforeRangeAttack = {}
ENT.SoundTbl_RangeAttack = {}
ENT.SoundTbl_Pain = {"vj_cthulhu/gonarch/gon_pain2.wav","vj_cthulhu/gonarch/gon_pain4.wav","vj_cthulhu/gonarch/gon_pain5.wav"}
ENT.SoundTbl_Death = {"vj_cthulhu/gonarch/gon_die1.wav"}
ENT.SoundTbl_SoundTrack = {"vj_cthulhu/soundtrack/Youareclosedwithus.mp3"}

ENT.FootStepSoundLevel = 80
ENT.GeneralSoundPitch1 = 100
ENT.AllyDeathSoundLevel = 90

-- Custom
ENT.Gonarch_ShakeWorldOnMiss = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize() 
    if GetConVar("VJ_CTHULHU_Boss_Music"):GetInt() == 1 then
        self.HasSoundTrack = false 
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(100, 100, 290), Vector(-100, -100, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "step" then
		util.ScreenShake(self:GetPos(), 10, 100, 0.4, 2000)
		self:FootStepSoundCode()
	elseif key == "mattack leftA" or key == "mattack rightA" then -- Hit Ground
		self:MeleeAttackCode()
	elseif key == "mattack leftB" or key == "mattack rightB" then -- Swipe Air
		self:MeleeAttackCode()
	elseif key == "die" then
		local effectBlood = EffectData()
		effectBlood:SetOrigin(self:GetPos() + self:OBBCenter())
		effectBlood:SetColor(VJ_Color2Byte(Color(130,19,10)))
		effectBlood:SetScale(250)
		util.Effect("VJ_Blood1",effectBlood)
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib11.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib8.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib10.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib9.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib11.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib8.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib10.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib9.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib11.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib8.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib10.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib9.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib11.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib8.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib10.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib9.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib11.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib8.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib10.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib9.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib11.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib8.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib10.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib9.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
		VJ_EmitSound(self, {"vj_cthulhu/common/bodysplat.wav"}, 95, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
dmginfo:ScaleDamage(0.25)
if self.HasSounds == true && self.HasImpactSounds == true then 
local attacker = dmginfo:GetAttacker()
if math.random(1,60) == 1 then
		local effectBlood = EffectData()
		effectBlood:SetOrigin(self:GetPos() + self:OBBCenter())
		effectBlood:SetColor(VJ_Color2Byte(Color(130,19,10)))
		effectBlood:SetScale(250)
		util.Effect("VJ_Blood1",effectBlood)
        self:TakeDamage(750)
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib9.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib11.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib8.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib10.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib9.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib9.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib11.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib8.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:CreateGibEntity("obj_vj_gib","models/vj_cthulhu/humangib10.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,150))})
	self:VJ_ACT_PLAYACTIVITY("flinch", true, false, true) -- Angry animation
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
local Buglin = ents.Create("npc_vj_cthulhu_eyeegg")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:SetVelocity(self:GetUp()*math.Rand(450,450) + self:GetRight()*math.Rand(-100,100) + self:GetForward()*math.Rand(-100,100))
Buglin:Spawn()
Buglin:Activate()
VJ_EmitSound(self,"vj_cthulhu/common/bodysplat.wav",100) end
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	self:VJ_ACT_PLAYACTIVITY("angry1", true, false, true) -- Angry animation
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.CanEat = true -- Should it search and eat organic stuff when idle?
function ENT:CustomOnEat(status, statusInfo)
	-- The following code is a ideal example based on Half-Life 1 Zombie
	//print(self, "Eating Status: ", status, statusInfo)
	
	if status == "CheckFood" then
		return (statusInfo.owner.BloodData && self:Health() != self:GetMaxHealth()) -- only start eating if the corpse is a human, and we're not at full health - epicplayer
	elseif status == "BeginEating" then
		self:SetIdleAnimation({"defend"}, true)
		return self:VJ_ACT_PLAYACTIVITY(ACT_ARM, true, false)
	elseif status == "Eat" then
		VJ_EmitSound(self, "vj_cthulhu/common/bodysplat.wav", 100) --more accurate to the mod - epicplayer
		-- Health changes
		local food = self.EatingData.Ent
		local damage = 100 -- How much damage food will receive
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
		return 2 -- Changed to match the speed of the HLZE mod - epicplayer
	elseif status == "StopEating" then
		if statusInfo != "Dead" && self.EatingData.AnimStatus != "None" then -- Do NOT play anim while dead or has NOT prepared to eat
			return self:VJ_ACT_PLAYACTIVITY(ACT_DISARM, true, false)
		end
	end
	return 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt)
	-- Increase its health when it deals damage (Up to 2x its max health)
		-- If the enemy is less health than its melee attack, then use the enemy's health as the addition
	self:SetHealth(math.Clamp(self:Health() + ((self.MeleeAttackDamage > hitEnt:Health() and hitEnt:Health()) or self.MeleeAttackDamage), self:Health(), self:GetMaxHealth()*2))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(projectile)
	local ene = self:GetEnemy()
	ParticleEffect("vj_hlr_spit_red_spawn", self:GetPos() + self:OBBCenter() + self:GetForward()*35 + self:GetUp()*50, self:GetForward():Angle(), projectile)
	if self.Bullsquid_BullSquidding == true then
		return self:CalculateProjectile("Line", projectile:GetPos(), ene:GetPos() + ene:OBBCenter(), 250000)
	else
		return self:CalculateProjectile("Curve",self:GetPos() +self:GetUp() *self.RangeAttackPos_Up +self:GetForward() *self.RangeAttackPos_Forward, self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter() +self:GetEnemy():GetRight() *math.Rand(-90,90) +self:GetEnemy():GetForward() + ene:OBBCenter(), 1500)
	end
end
