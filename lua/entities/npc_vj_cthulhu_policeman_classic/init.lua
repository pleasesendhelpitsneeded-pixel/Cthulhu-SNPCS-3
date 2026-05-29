AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_cthulhu/policeman_classic.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 100
ENT.HullType = HULL_HUMAN
ENT.VJC_Data = {
    ThirdP_Offset = Vector(10, 0, -30), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(4, 0, 0), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"} -- NPCs with the same class with be allied to each other
ENT.FriendsWithAllPlayerAllies = true -- Should this SNPC be friends with all other player allies that are running on VJ Base?
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.Weapon_NoSpawnMenu = true -- If set to true, the NPC weapon setting in the spawnmenu will not be applied for this SNPC
ENT.DisableWeaponFiringGesture = true -- If set to true, it will disable the weapon firing gestures
ENT.MoveRandomlyWhenShooting = false -- Should it move randomly when shooting?
ENT.HasCallForHelpAnimation = false -- if true, it will play the call for help animation
ENT.AnimTbl_ShootWhileMovingRun = {ACT_RUN} -- Animations it will play when shooting while running | NOTE: Weapon may translate the animation that they see fit!
ENT.AnimTbl_ShootWhileMovingWalk = {ACT_RUN} -- Animations it will play when shooting while walking | NOTE: Weapon may translate the animation that they see fit!
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_TakingCover = {ACT_CROUCHIDLE} -- The animation it plays when hiding in a covered position, leave empty to let the base decide
ENT.AnimTbl_AlertFriendsOnDeath = {"vjseq_idle2"} -- Animations it plays when an ally dies that also has AlertFriendsOnDeath set to true
ENT.HasLostWeaponSightAnimation = true -- Set to true if you would like the SNPC to play a different animation when it has lost sight of the enemy and can't fire at it
ENT.BecomeEnemyToPlayer = true -- Should the friendly SNPC become enemy towards the player if it's damaged by a player?
ENT.HasItemDropsOnDeath = false -- Should it drop items on death?
ENT.HasOnPlayerSight = true -- Should do something when it sees the enemy? Example: Play a sound
ENT.CombatFaceEnemy = false -- If enemy is exists and is visible
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_SMALL_FLINCH} -- If it uses normal based animation, use this
ENT.HitGroupFlinching_Values = {{HitGroup = {HITGROUP_LEFTARM}, Animation = {ACT_FLINCH_LEFTARM}},{HitGroup = {HITGROUP_RIGHTARM}, Animation = {ACT_FLINCH_RIGHTARM}},{HitGroup = {HITGROUP_LEFTLEG}, Animation = {ACT_FLINCH_LEFTLEG}},{HitGroup = {HITGROUP_RIGHTLEG}, Animation = {ACT_FLINCH_RIGHTLEG}}}
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_hlr/pl_step1.wav","vj_hlr/pl_step2.wav","vj_hlr/pl_step3.wav","vj_hlr/pl_step4.wav"}

/*
-- Can't follow
vj_hlr/hl1_npc/barney/ba_stop0.wav
vj_hlr/hl1_npc/barney/ba_stop1.wav
vj_hlr/hl1_npc/barney/stop1.wav
vj_hlr/hl1_npc/barney/stophere.wav

vj_hlr/hl1_npc/barney/ba_internet.wav
vj_hlr/hl1_npc/barney/ba_attacking0.wav
vj_hlr/hl1_npc/barney/ba_attacking2.wav
vj_hlr/hl1_npc/barney/ba_becareful0.wav
vj_hlr/hl1_npc/barney/ba_button0.wav
vj_hlr/hl1_npc/barney/ba_button1.wav
vj_hlr/hl1_npc/barney/ba_canal_death1.wav
vj_hlr/hl1_npc/barney/ba_canal_wound1.wav
vj_hlr/hl1_npc/barney/ba_cure0.wav
vj_hlr/hl1_npc/barney/ba_cure1.wav
vj_hlr/hl1_npc/barney/ba_docprotect0.wav
vj_hlr/hl1_npc/barney/ba_docprotect1.wav
vj_hlr/hl1_npc/barney/ba_docprotect2.wav
vj_hlr/hl1_npc/barney/ba_docprotect3.wav
vj_hlr/hl1_npc/barney/ba_door0.wav
vj_hlr/hl1_npc/barney/ba_door1.wav
vj_hlr/hl1_npc/barney/ba_duty.wav
vj_hlr/hl1_npc/barney/ba_generic2.wav
vj_hlr/hl1_npc/barney/ba_help0.wav
-- vj_hlr/hl1_npc/barney/ba_ht01_01.wav ---> vj_hlr/hl1_npc/barney/ba_ht06_01.wav
-- vj_hlr/hl1_npc/barney/ba_ht06_04.wav ---> vj_hlr/hl1_npc/barney/ba_ht06_10.wav
--vj_hlr/hl1_npc/barney/ba_ht07_01.wav ---> vj_hlr/hl1_npc/barney/ba_ht08_03.wav
vj_hlr/hl1_npc/barney/ba_idle2.wav
vj_hlr/hl1_npc/barney/ba_idle5.wav
vj_hlr/hl1_npc/barney/ba_idle6.wav
vj_hlr/hl1_npc/barney/ba_kill1.wav
vj_hlr/hl1_npc/barney/ba_kill2.wav
vj_hlr/hl1_npc/barney/ba_lead0.wav
vj_hlr/hl1_npc/barney/ba_lead1.wav
vj_hlr/hl1_npc/barney/ba_lead2.wav
vj_hlr/hl1_npc/barney/ba_mad2.wav
vj_hlr/hl1_npc/barney/ba_ok0.wav
vj_hlr/hl1_npc/barney/ba_opgate.wav
vj_hlr/hl1_npc/barney/ba_plfear0.wav
-- vj_hlr/hl1_npc/barney/ba_pok0.wav ---> vj_hlr/hl1_npc/barney/ba_security2_nopass.wav
vj_hlr/hl1_npc/barney/ba_security2_range1.wav
vj_hlr/hl1_npc/barney/ba_security2_range2.wav
vj_hlr/hl1_npc/barney/ba_shot0.wav
vj_hlr/hl1_npc/barney/ba_stare2.wav
vj_hlr/hl1_npc/barney/ba_stare3.wav
-- vj_hlr/hl1_npc/barney/c1a0_ba_button.wav ---> vj_hlr/hl1_npc/barney/c1a2_ba_2zomb.wav
vj_hlr/hl1_npc/barney/c1a2_ba_bullsquid.wav
vj_hlr/hl1_npc/barney/c1a2_ba_climb.wav
vj_hlr/hl1_npc/barney/c1a2_ba_slew.wav
vj_hlr/hl1_npc/barney/c1a2_ba_surface.wav
vj_hlr/hl1_npc/barney/c1a2_ba_top.wav
-- vj_hlr/hl1_npc/barney/c1a4_ba_wisp.wav ---> vj_hlr/hl1_npc/barney/c3a2_ba_stay.wav
vj_hlr/hl1_npc/barney/checkwounds.wav
vj_hlr/hl1_npc/barney/imdead.wav
vj_hlr/hl1_npc/barney/killme.wav
vj_hlr/hl1_npc/barney/leavealone.wav
vj_hlr/hl1_npc/barney/of1a5_ba02.wav
vj_hlr/hl1_npc/barney/of6a4_ba01.wav
vj_hlr/hl1_npc/barney/of6a4_ba02.wav
vj_hlr/hl1_npc/barney/of6a4_ba03.wav
vj_hlr/hl1_npc/barney/of6a4_ba04.wav
vj_hlr/hl1_npc/barney/openfire.wav
vj_hlr/hl1_npc/barney/realbadwound.wav
vj_hlr/hl1_npc/barney/sir.wav
vj_hlr/hl1_npc/barney/soldier.wav
vj_hlr/hl1_npc/barney/youneedmedic.wav
*/

ENT.GeneralSoundPitch1 = 100

-- Custom
ENT.Security_NextMouthMove = 0
ENT.Security_NextMouthDistance = 0
ENT.Security_SwitchedIdle = false
ENT.Security_Type = 0
	-- 0 = Security Guard
	-- 1 = Otis
	-- 2 = Alpha Security Guard
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Security_CustomOnInitialize()
	self.SoundTbl_Idle = {"vj_cthulhu/policeman/pm_idle1.wav","vj_cthulhu/policeman/pm_idle2.wav","vj_cthulhu/policeman/pm_idle3.wav"}
	self.SoundTbl_IdleDialogue = {"vj_cthulhu/policeman/pm_pquestion1.wav","vj_cthulhu/policeman/pm_pquestion2.wav"}
	self.SoundTbl_IdleDialogueAnswer = {"vj_cthulhu/policeman/pm_answer1.wav","vj_cthulhu/policeman/pm_answer2.wav","vj_cthulhu/policeman/pm_answer3.wav"}
	self.SoundTbl_FollowPlayer = {"vj_cthulhu/policeman/pm_ok.wav"}
	self.SoundTbl_OnPlayerSight = {"vj_cthulhu/policeman/pm_hello1.wav","vj_cthulhu/policeman/pm_hello2.wav"}
	self.SoundTbl_Investigate = {"vj_cthulhu/policeman/pm_hear.wav"}
	self.SoundTbl_Alert = {"vj_cthulhu/policeman/pm_mad.wav"}
	self.SoundTbl_BecomeEnemyToPlayer = {"vj_cthulhu/policeman/pm_mad.wav"}
	self.SoundTbl_Suppressing = {"vj_cthulhu/policeman/pm_attack.wav","vj_cthulhu/policeman/pm_attack2.wav"}
	self.SoundTbl_OnKilledEnemy = {"vj_cthulhu/policeman/pm_kill.wav","vj_cthulhu/policeman/pm_kill2.wav"}
	self.SoundTbl_Pain = {"vj_cthulhu/policeman/pm_wound1.wav","vj_cthulhu/policeman/pm_wound2.wav"}
	self.SoundTbl_Death = {"vj_cthulhu/butler/yeahthisisastockaudiososhutup1.ogg","vj_cthulhu/butler/yeahthisisastockaudiososhutup2.ogg","vj_cthulhu/butler/yeahthisisastockaudiososhutup3.ogg"}

	self.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIE_GUTSHOT, ACT_DIE_HEADSHOT, ACT_DIESIMPLE} -- Death Animations
	
	self:Give("weapon_vj_cthulhu_revolver1_classic")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(13, 13, 76), Vector(-13, -13, 0))
	self:SetBodygroup(1, 0)
	self:SetWeaponState(VJ_WEP_STATE_HOLSTERED)
	
	if self:GetModel() == "models/vj_hlr/hl1/barney.mdl" then // Already the default
		self.Security_Type = 0
	elseif self:GetModel() == "models/vj_hlr/opfor/otis.mdl" then
		self.Security_Type = 1
	elseif self:GetModel() == "models/vj_hlr/hla/barney.mdl" then
		self.Security_Type = 2
	end
	self:Security_CustomOnInitialize()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply, controlEnt)
	function controlEnt:CustomOnKeyPressed(key)
		if key == KEY_SPACE && self.VJCE_NPC:GetActivity() != ACT_DISARM && self.VJCE_NPC:GetActivity() != ACT_ARM then
			if self.VJCE_NPC:GetWeaponState() == VJ_WEP_STATE_HOLSTERED then
				self.VJCE_NPC:Security_UnHolsterGun()
			elseif self.VJCE_NPC:GetWeaponState() == VJ_WEP_STATE_READY then
				self.VJCE_NPC:Security_HolsterGun()
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)
	ply:ChatPrint("SPACE: Holster / Unholster gun")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "step" then
		self:FootStepSoundCode()
	elseif key == "shoot" then
		local wep = self:GetActiveWeapon()
		if IsValid(wep) then
			wep:NPCShoot_Primary()
		end
	elseif key == "body" then
		VJ_EmitSound(self, "vj_hlr/fx/bodydrop"..math.random(3, 4)..".wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self.Security_Type != 2 then -- If it's regular or Otis...
		-- Mouth movement
		if CurTime() < self.Security_NextMouthMove then
			if self.Security_NextMouthDistance == 0 then
				self.Security_NextMouthDistance = math.random(10, 70)
			else
				self.Security_NextMouthDistance = 0
			end
			self:SetPoseParameter("m", self.Security_NextMouthDistance)
		else
			self:SetPoseParameter("m", 0)
		end
		
		-- For guarding
		if self.IsGuard == true && self:GetWeaponState() == VJ_WEP_STATE_HOLSTERED && !IsValid(self:GetEnemy()) then
			if self.Security_SwitchedIdle == false then
				self.Security_SwitchedIdle = true
				self.AnimTbl_IdleStand = {ACT_GET_DOWN_STAND, ACT_GET_UP_STAND}
			end
		elseif self.Security_SwitchedIdle == true then
			self.Security_SwitchedIdle = false
			self.AnimTbl_IdleStand = {ACT_IDLE}
		end
	elseif IsValid(self:GetActiveWeapon()) then -- Alpha Security Guard can't reload!
		self:GetActiveWeapon():SetClip1(999)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnPlayCreateSound(sdData, sdFile)
	self.Security_NextMouthMove = CurTime() + SoundDuration(sdFile)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	if self.VJ_IsBeingControlled then return end
	
	if math.random(1, 2) == 1 then
		if self.Security_Type == 0 then
			if ent:GetClass() == "npc_vj_hlr1_bullsquid" then
				self:PlaySoundSystem("Alert", {})
				self.NextAlertSoundT = CurTime() + math.Rand(self.NextSoundTime_Alert.a, self.NextSoundTime_Alert.b)
			elseif ent.IsVJBaseSNPC_Creature == true then
				self:PlaySoundSystem("Alert", {})
				self.NextAlertSoundT = CurTime() + math.Rand(self.NextSoundTime_Alert.a, self.NextSoundTime_Alert.b)
			end
		elseif self.Security_Type == 1 && ent.IsVJBaseSNPC_Creature == true then
			self:PlaySoundSystem("Alert", {})
			self.NextAlertSoundT = CurTime() + math.Rand(self.NextSoundTime_Alert.a, self.NextSoundTime_Alert.b)
		end
	end
	
	if self:GetWeaponState() == VJ_WEP_STATE_HOLSTERED then
		self:Security_UnHolsterGun()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Security_HolsterGun()
	if self:GetBodygroup(1) != 0 then self:VJ_ACT_PLAYACTIVITY(ACT_DISARM, true, false, true) end
	self:SetWeaponState(VJ_WEP_STATE_HOLSTERED)
	timer.Simple(self.Security_Type == 2 and 1 or 1.5, function()
		if IsValid(self) && self:GetWeaponState() == VJ_WEP_STATE_HOLSTERED then
			self:SetBodygroup(1, 0)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Security_UnHolsterGun()
	self:StopMoving()
	self:VJ_ACT_PLAYACTIVITY(ACT_ARM, true, false, true)
	self:SetWeaponState()
	timer.Simple(0.55, function() if IsValid(self) then self:SetBodygroup(1, 1) end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	if self.VJ_IsBeingControlled or self.Dead or self:BusyWithActivity() then return end
	
	if IsValid(self:GetEnemy()) then -- If enemy is seen then make sure gun is NOT holstered
		if self:GetWeaponState() == VJ_WEP_STATE_HOLSTERED then
			self:Security_UnHolsterGun()
		end
	elseif self:GetWeaponState() == VJ_WEP_STATE_READY && (CurTime() - self.EnemyData.TimeSet) > 5 then
		self:Security_HolsterGun()
	end
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
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh1.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh2.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh4.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_bone.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,50))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_gib.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_guts.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_hmeat.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_lung.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_skull.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,60))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_legbone.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,15))})
	return true -- Return to true if it gibbed!
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
	VJ_EmitSound(self, "vj_gib/default_gib_splat.wav", 90, 100)
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	self:DropWeaponOnDeathCode(dmginfo, hitgroup)
	self:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
	if IsValid(self:GetActiveWeapon()) then self:GetActiveWeapon():Remove() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
	self:SetBodygroup(1, 0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	VJ_HLR_ApplyCorpseEffects(self, corpseEnt)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDropWeapon_AfterWeaponSpawned(dmginfo, hitgroup, wepEnt)
	wepEnt.WorldModel_Invisible = false
	wepEnt:SetNW2Bool("VJ_WorldModel_Invisible", false)
end