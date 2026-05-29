AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_cthulhu/butler.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 80
ENT.HullType = HULL_HUMAN
ENT.VJC_Data = {
    ThirdP_Offset = Vector(10, 0, -30), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip02 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY","CLASS_GANSTER"} -- NPCs with the same class with be allied to each other
ENT.FriendsWithAllPlayerAllies = true -- Should this SNPC be friends with all other player allies that are running on VJ Base?
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.Behavior = VJ_BEHAVIOR_PASSIVE -- Doesn't attack anything
ENT.BecomeEnemyToPlayer = true -- Should the friendly SNPC become enemy towards the player if it's damaged by a player?
ENT.HasItemDropsOnDeath = false -- Should it drop items on death?
ENT.HasOnPlayerSight = true -- Should do something when it sees the enemy? Example: Play a sound
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.IsMedicSNPC = false -- Is this SNPC a medic? Does it heal other friendly friendly SNPCs, and players(If friendly)
ENT.Medic_DisableAnimation = true -- if true, it will disable the animation code
ENT.Medic_TimeUntilHeal = 4 -- Time until the ally receives health | Set to false to let the base decide the time
ENT.Medic_SpawnPropOnHeal = false -- Should it spawn a prop, such as small health vial at a attachment when healing an ally?
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {ACT_DIEBACKWARD,ACT_DIEFORWARD,ACT_DIESIMPLE} -- Death Animations
ENT.DeathAnimationTime = false -- Time until the SNPC spawns its corpse and gets removed
ENT.CombatFaceEnemy = false -- If enemy is exists and is visible
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_SMALL_FLINCH} -- If it uses normal based animation, use this
ENT.HitGroupFlinching_Values = {{HitGroup = {HITGROUP_LEFTLEG}, Animation = {ACT_FLINCH_LEFTLEG}},{HitGroup = {HITGROUP_RIGHTLEG}, Animation = {ACT_FLINCH_RIGHTLEG}}}
	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
local sdTie = {}
local sdStep = {"vj_cthulhu/common/npc_step1.wav","vj_cthulhu/common/npc_step2.wav","vj_cthulhu/common/npc_step3.wav","vj_cthulhu/common/npc_step4.wav"}

ENT.SoundTbl_FootStep = sdStep

/*
-- Can't move, unfollow
"vj_hlr/hl1_npc/scientist/dangerous.wav"
vj_hlr/hl1_npc/scientist/stop1.wav
vj_hlr/hl1_npc/scientist/stop2.wav
vj_hlr/hl1_npc/scientist/stop3.wav
vj_hlr/hl1_npc/scientist/stop4.wav

"vj_hlr/hl1_npc/scientist/limitsok.wav",

vj_hlr/hl1_npc/scientist/assist.wav
vj_hlr/hl1_npc/scientist/b01_sci02_briefcase.wav
vj_hlr/hl1_npc/scientist/b01_sci03_sirplease.wav
vj_hlr/hl1_npc/scientist/c1a0_sci_catscream.wav
vj_hlr/hl1_npc/scientist/c1a0_sci_crit1a.wav
vj_hlr/hl1_npc/scientist/c1a0_sci_crit2a.wav
vj_hlr/hl1_npc/scientist/c1a0_sci_crit3a.wav
vj_hlr/hl1_npc/scientist/c1a0_sci_ctrl1a.wav
vj_hlr/hl1_npc/scientist/c1a0_sci_ctrl2a.wav
vj_hlr/hl1_npc/scientist/c1a0_sci_ctrl3a.wav
-- vj_hlr/hl1_npc/scientist/c1a0_sci_dis10a.wav ----> vj_hlr/hl1_npc/scientist/c1a0_sci_disa.wav
vj_hlr/hl1_npc/scientist/c1a0_sci_getaway.wav
-- vj_hlr/hl1_npc/scientist/c1a0_sci_lock1a.wav ----> vj_hlr/hl1_npc/scientist/c1a0_sci_lock8a.wav
vj_hlr/hl1_npc/scientist/c1a0_sci_mumble.wav
vj_hlr/hl1_npc/scientist/c1a0_sci_samp.wav
vj_hlr/hl1_npc/scientist/c1a1_sci_4scan.wav
vj_hlr/hl1_npc/scientist/c1a2_sci_6zomb.wav
vj_hlr/hl1_npc/scientist/c1a2_sci_elevator.wav
vj_hlr/hl1_npc/scientist/c1a2_sci_lounge.wav
vj_hlr/hl1_npc/scientist/c1a2_sci_transm.wav
vj_hlr/hl1_npc/scientist/c1a3_sci_atlast.wav
vj_hlr/hl1_npc/scientist/c1a3_sci_rescued.wav
vj_hlr/hl1_npc/scientist/c1a3_sci_silo1a.wav
vj_hlr/hl1_npc/scientist/c1a4_sci_blind.wav
vj_hlr/hl1_npc/scientist/c1a4_sci_gener.wav
vj_hlr/hl1_npc/scientist/c1a4_sci_pwr.wav
vj_hlr/hl1_npc/scientist/c1a4_sci_rocket.wav
vj_hlr/hl1_npc/scientist/c1a4_sci_tent.wav
vj_hlr/hl1_npc/scientist/c1a4_sci_trust.wav
"vj_hlr/hl1_npc/scientist/c1a4_sci_pwroff.wav",
"vj_hlr/hl1_npc/scientist/c1a2_sci_darkroom.wav",
vj_hlr/hl1_npc/scientist/c2a3_sci_icky.wav
vj_hlr/hl1_npc/scientist/c2a3_sci_track.wav
vj_hlr/hl1_npc/scientist/c2a4_sci_2tau.wav
vj_hlr/hl1_npc/scientist/c2a4_sci_4tau.wav
vj_hlr/hl1_npc/scientist/c2a4_sci_letout.wav
vj_hlr/hl1_npc/scientist/c2a4_sci_scanner.wav
vj_hlr/hl1_npc/scientist/c2a4_sci_sugicaloff.wav
"vj_hlr/hl1_npc/scientist/c2a4_sci_arg2a.wav",
"vj_hlr/hl1_npc/scientist/c2a4_sci_arg4a.wav",
vj_hlr/hl1_npc/scientist/c2a5_sci_boobie.wav
vj_hlr/hl1_npc/scientist/c2a5_sci_lebuz.wav
vj_hlr/hl1_npc/scientist/c3a1_sci_2sat.wav
vj_hlr/hl1_npc/scientist/c3a1_sci_4sat.wav
vj_hlr/hl1_npc/scientist/c3a1_sci_6sat.wav
vj_hlr/hl1_npc/scientist/c3a1_sci_dome.wav
vj_hlr/hl1_npc/scientist/c3a1_sci_done.wav
vj_hlr/hl1_npc/scientist/c3a2_sci_2glu.wav
vj_hlr/hl1_npc/scientist/c3a2_sci_3glu.wav
vj_hlr/hl1_npc/scientist/c3a2_sci_3surv.wav
vj_hlr/hl1_npc/scientist/c3a2_sci_5surv.wav
vj_hlr/hl1_npc/scientist/c3a2_sci_7surv.wav
vj_hlr/hl1_npc/scientist/c3a2_sci_flood.wav
vj_hlr/hl1_npc/scientist/c3a2_sci_forever.wav
vj_hlr/hl1_npc/scientist/c3a2_sci_linger.wav
vj_hlr/hl1_npc/scientist/c3a2_sci_ljump.wav
-- vj_hlr/hl1_npc/scientist/c3a2_sci_notyet.wav ----> vj_hlr/hl1_npc/scientist/c3a2_sci_uphere_alt.wav
vj_hlr/hl1_npc/scientist/crossgreen.wav
-- vj_hlr/hl1_npc/scientist/d01_sci01_waiting.wav ----> vj_hlr/hl1_npc/scientist/d01_sci09_pushsample2.wav
-- vj_hlr/hl1_npc/scientist/d01_sci11_shouldnthappen.wav ----> vj_hlr/hl1_npc/scientist/d01_sci13_jammed.wav
-- vj_hlr/hl1_npc/scientist/d01_sci15_onschedule.wav ----> vj_hlr/hl1_npc/scientist/d08_sci05_osprey.wav
vj_hlr/hl1_npc/scientist/dontgothere.wav
vj_hlr/hl1_npc/scientist/forcefield_b.wav
vj_hlr/hl1_npc/scientist/g_bounce1.wav
vj_hlr/hl1_npc/scientist/helloladies.wav
vj_hlr/hl1_npc/scientist/letyouin.wav
-- vj_hlr/hl1_npc/scientist/of1a1_sc01.wav ----> vj_hlr/hl1_npc/scientist/of4a1_sc01.wav
vj_hlr/hl1_npc/scientist/perfume.wav
-- vj_hlr/hl1_npc/scientist/sci_1thou.wav ----> vj_hlr/hl1_npc/scientist/sci_5thou.wav
vj_hlr/hl1_npc/scientist/sci_aftertest.wav
vj_hlr/hl1_npc/scientist/sci_alone.wav
vj_hlr/hl1_npc/scientist/sci_busy.wav
vj_hlr/hl1_npc/scientist/shesgonemad.wav
vj_hlr/hl1_npc/scientist/spinals.wav
vj_hlr/hl1_npc/scientist/tram.wav
vj_hlr/hl1_npc/scientist/underbarrel.wav
vj_hlr/hl1_npc/scientist/ushouldsee.wav
vj_hlr/hl1_npc/scientist/whoareyou.wav
vj_hlr/hl1_npc/scientist/xena.wav
vj_hlr/hl1_npc/scientist/scream7.wav (duplicate of scream6)
*/

ENT.GeneralSoundPitch1 = 100

-- Custom
ENT.SCI_NextMouthMove = 0
ENT.SCI_NextMouthDistance = 0
ENT.SCI_Type = 0
	-- 0 = Regular Scientist and Dr. Rosenberg
	-- 1 = Cleansuit Scientist
	-- 2 = Dr. Keller
	-- 3 = Alpha Scientist
ENT.SCI_CurAnims = -1 -- 0 = Regular | 1 = Scared | 2 = Grabbed by barnacle
ENT.SCI_NextTieAnnoyanceT = 0
ENT.SCI_ControllerAnim = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	if self:GetModel() == "models/vj_hlr/hl1/scientist.mdl" then
		self.SCI_Type = 0
	elseif self:GetModel() == "models/vj_hlr/opfor/cleansuit_scientist.mdl" then
		self.SCI_Type = 1
	elseif self:GetModel() == "models/vj_hlr/decay/wheelchair_sci.mdl" then
		self.SCI_Type = 2
	elseif self:GetModel() == "models/vj_hlr/hla/scientist.mdl" then
		self.SCI_Type = 3
	end
	self:SCI_CustomOnInitialize()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SCI_CustomOnInitialize()
	self.SoundTbl_Idle = {"vj_cthulhu/butler/but_idle1.wav","vj_cthulhu/butler/but_idle2.wav"}
	self.SoundTbl_OnPlayerSight = {"vj_cthulhu/butler/but_hello.wav","vj_cthulhu/butler/but_inlibrary.wav"}
	self.SoundTbl_BecomeEnemyToPlayer = {"vj_cthulhu/butler/but_night.wav"}
	self.SoundTbl_Death = {"vj_cthulhu/butler/yeahthisisastockaudiososhutup1.ogg","vj_cthulhu/butler/yeahthisisastockaudiososhutup2.ogg","vj_cthulhu/butler/yeahthisisastockaudiososhutup3.ogg"}
	
	local randBG = math.random(0, 4)
	self:SetBodygroup(1, randBG)
	if randBG == 2 && self.SCI_Type == 0 then
		self:SetSkin(1)
	end
	//self:GetPoseParameters(true)
	
	self.SCI_NextTieAnnoyanceT = CurTime() + math.Rand(10, 100)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply, controlEnt)
	self.SCI_ControllerAnim = 0
	self.SCI_NextTieAnnoyanceT = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)
	ply:ChatPrint("RELOAD: Toggle scared animations")
	ply:ChatPrint("LMOUSE: Play tie annoyance (if not scared & possible)")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "step" or key == "wheelchair" then
		self:FootStepSoundCode()
	elseif key == "tie" /*&& !self:BusyWithActivity()*/ then
		self:StopAllCommonSpeechSounds()
		self:PlaySoundSystem("GeneralSpeech", sdTie)
		//VJ_EmitSound(self, {"vj_hlr/hl1_npc/scientist/weartie.wav","vj_hlr/hl1_npc/scientist/ties.wav"}, 80, 100)
	elseif key == "draw" then
		self:SetBodygroup(2,1)
	elseif key == "holster" then
		self:SetBodygroup(2,0)
	elseif key == "body" then
		VJ_EmitSound(self, {"vj_cthulhu/common/bodydrop1.wav","vj_cthulhu/common/bodydrop2.wav","vj_cthulhu/common/bodydrop3.wav","vj_cthulhu/common/bodydrop4.wav"}, 75, 100)
	// keller
	elseif key == "keller_surprise" then
		self.SoundTbl_FootStep = sdStep
		self:StopAllCommonSpeechSounds()
		self:PlaySoundSystem("GeneralSpeech", "vj_hlr/hl1_npc/keller/dk_furher.wav")
	elseif key == "keller_die" then
		self.HasDeathAnimation = false
		self.DeathCorpseApplyForce = false
		local dmg = DamageInfo()
		dmg:SetDamage(self:Health())
		dmg:SetDamageType(bit.band(DMG_GENERIC, DMG_PREVENT_PHYSICS_FORCE))
		dmg:SetAttacker(self)
		dmg:SetInflictor(self)
		self:TakeDamageInfo(dmg)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMedic_BeforeHeal()
	-- Healing routine
	self:VJ_ACT_PLAYACTIVITY("pull_needle", true, false, false, 0, {OnFinish=function(interrupted, anim)
		if interrupted then return end
		self:VJ_ACT_PLAYACTIVITY("give_shot", true, false, false, 0, {OnFinish=function(interrupted2, anim2)
			if interrupted2 then return end
			self:VJ_ACT_PLAYACTIVITY("return_needle", true, false)
		end})
	end})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMedic_OnReset()
	timer.Simple(1.5, function() if IsValid(self) then self:SetBodygroup(2, 0) end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	if self.VJ_IsBeingControlled then return end
	if self.SCI_Type != 2 && self.SCI_Type != 3 then
		if math.random(1, 2) == 1 && (ent.VJTags[VJ_TAG_HEADCRAB] or ent:GetClass() == "npc_headcrab" or ent:GetClass() == "npc_headcrab_black" or ent:GetClass() == "npc_headcrab_fast") then
			self:PlaySoundSystem("Alert", {"vj_hlr/hl1_npc/scientist/seeheadcrab.wav"})
			self.NextAlertSoundT = CurTime() + math.Rand(self.NextSoundTime_Alert.a, self.NextSoundTime_Alert.b)
		end
		if ent:GetPos():Distance(self:GetPos()) >= 300 && math.random(1, 2) == 1 then
			self:VJ_ACT_PLAYACTIVITY({"vjseq_eye_wipe", "vjseq_fear1", "vjseq_fear2"}, true, false, true)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	-- NPC Controller behavior setting
	if self.VJ_IsBeingControlled && self.VJ_TheController:KeyDown(IN_RELOAD) then
		if self.SCI_ControllerAnim == 0 then
			self.SCI_ControllerAnim = 1
			self.VJ_TheController:ChatPrint("I am scared!")
		else
			self.SCI_ControllerAnim = 0
			self.VJ_TheController:ChatPrint("Calming down...")
		end
	end
	
	-- self.SCI_CurAnims --> 0 = Regular | 1 = Scared | 2 = Grabbed by barnacle
	if self:IsEFlagSet(EFL_IS_BEING_LIFTED_BY_BARNACLE) then
		if self.SCI_CurAnims != 2 then
			self.SCI_CurAnims = 2
			self.AnimTbl_ScaredBehaviorStand = {ACT_BARNACLE_PULL}
			self.AnimTbl_IdleStand = {ACT_BARNACLE_PULL}
			self:SelectSchedule() -- Make sure to update the idle anims because AI is suspended when EFL_IS_BEING_LIFTED_BY_BARNACLE
		end
	elseif self.SCI_Type != 3 && ((!self.VJ_IsBeingControlled && IsValid(self:GetEnemy())) or (self.VJ_IsBeingControlled && self.SCI_ControllerAnim == 1)) then
		if self.SCI_CurAnims != 1 then
			self.SCI_CurAnims = 1
			self.AnimTbl_ScaredBehaviorStand = {ACT_CROUCHIDLE}
			self.AnimTbl_IdleStand = {ACT_CROUCHIDLE}
			if self.SCI_Type != 2 then
				self.AnimTbl_Walk = {ACT_WALK_SCARED}
			end
			self.AnimTbl_Run = {ACT_RUN_SCARED}
		end
	elseif (!self.VJ_IsBeingControlled) or (self.VJ_IsBeingControlled && self.SCI_ControllerAnim == 0) then
		if self.SCI_CurAnims != 0 then
			self.SCI_CurAnims = 0
			/*if self.SCI_Type == 0 && math.random(1,25) == 1 then
				self.AnimTbl_IdleStand = {ACT_VM_IDLE_1}
			else
				self.AnimTbl_IdleStand = {ACT_IDLE}
			end*/
			self.AnimTbl_IdleStand = {ACT_IDLE}
			self.AnimTbl_Walk = {ACT_WALK}
			self.AnimTbl_Run = {ACT_RUN}
		end
		-- Tie annoyance
		if CurTime() > self.SCI_NextTieAnnoyanceT && !self:BusyWithActivity() && ((!self.VJ_IsBeingControlled) or (self.VJ_IsBeingControlled && self.VJ_TheController:KeyDown(IN_ATTACK))) then
			if math.random(1, (self.VJ_IsBeingControlled and 1) or 2) == 1 && self:GetClass() != "npc_vj_hlrbs_rosenberg" then
				self:VJ_ACT_PLAYACTIVITY(ACT_VM_IDLE_1, true, false)
			end
			self.SCI_NextTieAnnoyanceT = CurTime() + ((self.VJ_IsBeingControlled and 4) or math.Rand(15, 100))
		end
	end
	
	-- Is the wheel chair gone? Then kill Dr. Keller!
	if self.SCI_Type == 2 && self:GetBodygroup(0) == 1 then
		self.HasDeathAnimation = false
		self:TakeDamage(self:Health(), self, self)
	end
	
	-- Mouth animation when talking
	if CurTime() < self.SCI_NextMouthMove then
		if self.SCI_NextMouthDistance == 0 then
			self.SCI_NextMouthDistance = math.random(10,70)
		else
			self.SCI_NextMouthDistance = 0
		end
		self:SetPoseParameter("m", self.SCI_NextMouthDistance)
	else
		self:SetPoseParameter("m", 0)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnPlayCreateSound(sdData, sdFile)
	self.SCI_NextMouthMove = CurTime() + SoundDuration(sdFile)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)
	self:SetBodygroup(2, 0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)
	self.HasDeathSounds = false
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
	VJ_EmitSound(self, {"vj_cthulhu/butler/yeahthisisastockaudiososhutup1.ogg","vj_cthulhu/butler/yeahthisisastockaudiososhutup2.ogg","vj_cthulhu/butler/yeahthisisastockaudiososhutup3.ogg"}, 90, 100)
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	if self.SCI_Type == 3 then return end
	if hitgroup == HITGROUP_HEAD then
		self.AnimTbl_Death = {ACT_DIE_HEADSHOT}
	elseif hitgroup == HITGROUP_STOMACH && self.SCI_Type != 2 then
		self.AnimTbl_Death = {ACT_DIE_GUTSHOT}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibsgreen = {"models/vj_cthulhu/humangib1.mdl","models/vj_cthulhu/humangib2.mdl","models/vj_cthulhu/humangib3.mdl","models/vj_cthulhu/humangib4.mdl","models/vj_cthulhu/humangib5.mdl","models/vj_cthulhu/humangib6.mdl","models/vj_cthulhu/humangib7.mdl","models/vj_cthulhu/humangib8.mdl","models/vj_cthulhu/humangib9.mdl","models/vj_cthulhu/humangib10.mdl","models/vj_cthulhu/humangib11.mdl"}

function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
		VJ_HLR_ApplyCorpseEffects(self, corpseEnt, gibsgreen)
end