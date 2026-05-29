AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_cthulhu/cthulhu_phase_2.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 17500
ENT.HullType = HULL_HUMAN
ENT.MovementType = VJ_MOVETYPE_STATIONARY -- How does the SNPC move?
ENT.SightAngle = 180 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.VJ_IsHugeMonster = true -- Is this a huge monster?
ENT.VJC_Data = {
    ThirdP_Offset = Vector(-5, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "joint17", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_yellow_large"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Yellow"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.VJ_NPC_Class = {"CLASS_CTHULHU"} -- NPCs with the same class with be allied to each other

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 2500 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 2600 -- How far does the damage go?
ENT.MeleeAttackDamageType = DMG_ALWAYSGIB -- Type of Damage

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_cthulhu_redorb" -- The entity that is spawned when range attacking
ENT.RangeDistance = 100000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 1600 -- How close does it have to be until it uses melee?
ENT.NextRangeAttackTime = 30 -- How much time until it can use a range attack?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "hand" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.TimeUntilRangeAttackProjectileRelease = 1.1
ENT.RangeAttackExtraTimers = {1.25, 1.35, 1.47, 1.40, 1.55, 1.69, 1.60} -- Extra range attack timers | it will run the 

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.DeathAnimationTime = false -- Time until the SNPC spawns its corpse and gets removed
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 2 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchDamageTypes = {DMG_BLAST} -- If it uses damage-based flinching, which types of damages should it flinch from?
ENT.HasSoundTrack = true -- Does the SNPC have a sound track?
ENT.AnimTbl_Flinch = {"leftflinch","rightflinch"} -- If it uses normal based animation, use this
ENT.DeathCorpseEntityClass = "prop_vj_animatable" -- The entity class it creates | "UseDefaultBehavior" = Let the base automatically detect the type
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_cthulhu/dagon/dag_step1.wav","vj_cthulhu/dagon/dag_step2.wav","vj_cthulhu/dagon/dag_step3.wav","vj_cthulhu/dagon/dag_step4.wav"}
ENT.SoundTbl_Breath = {"vj_cthulhu/garg/gar_breathe1.wav","vj_cthulhu/garg/gar_breathe2.wav","vj_cthulhu/garg/gar_breathe3.wav"}
ENT.SoundTbl_Alert = {}
ENT.SoundTbl_BeforeMeleeAttack = {}
ENT.SoundTbl_MeleeAttackExtra = {"vj_cthulhu/common/claw_strike1.wav","vj_cthulhu/common/claw_strike2.wav","vj_cthulhu/common/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_cthulhu/common/claw_miss1.wav","vj_cthulhu/common/claw_miss2.wav"}
ENT.SoundTbl_Pain = {"vj_cthulhu/garg/gar_pain1.wav","vj_cthulhu/garg/gar_pain2.wav","vj_cthulhu/garg/gar_pain3.wav"}
ENT.SoundTbl_Death = {"vj_cthulhu/garg/gar_alert3.wav"}
ENT.SoundTbl_SoundTrack = {"vj_cthulhu/Soundtrack/unworthydusk.wav"}

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
ENT.AlertSoundLevel = 100
ENT.BeforeMeleeAttackSoundLevel = 100
ENT.RangeAttackSoundLevel = 100
ENT.PainSoundLevel = 100
ENT.DeathSoundLevel = 100

-- Custom
ENT.Zombie_Type = 0
	-- 0 = Default / Not Categorized
	-- 1 = Default Zombie Scientist
ENT.Tor_NextSpawnT = 0
ENT.RadiosDestroyed = false
ENT.RadiosSpawned = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize() 
    if GetConVar("VJ_CTHULHU_Boss_Music"):GetInt() == 1 then
        self.HasSoundTrack = false 
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(200, 200 , 1600), Vector(-40, -40, 0))
	timer.Simple(0.0,function() if IsValid(self) then self:VJ_ACT_PLAYACTIVITY("appear", true, false, false) end end)
	self:AddFlags(FL_NOTARGET)

        --Tentacles
		timer.Create("vlad_spawnracists"..self:EntIndex(), 10, 0, function() self:F_SpawnAlly() end)

	-- Radios
	timer.Create("skrillyd_spawnradios"..self:EntIndex(), 1, 1, function()
		for i = 1, 10 do
			local trF = util.TraceLine({
				start = self:GetPos() + self:GetUp() * 1270,
				endpos = self:GetPos() + self:GetForward() * math.Rand(-10000, 10000) + self:GetRight() * math.Rand(-15000, 15000) + self:GetUp() * -3000,
				filter = {self, self.Radio1},
			})
			local tr = util.TraceLine({
				start = trF.HitPos,
				endpos = self:GetPos() + self:GetForward() * math.Rand(-10000, 10000) + self:GetRight() * math.Rand(-15000, 15000) + self:GetUp() * -3000,
				filter = {self, self.Radio1},
			})
			-- HitNormal = Number between 0 to 1, use this to get the position the trace came from. Ex: Add it to the hit position to make it go farther away.
			local radio = ents.Create("npc_vj_cthulhu_greencrystal")
			radio:SetPos(tr.HitPos - tr.HitNormal*10) -- Take the HitNormal and minus it by 10 units to make it go inside the position a bit
			radio:SetAngles(tr.HitNormal:Angle() + Angle(math.Rand(60, 120), math.Rand(-15, 15), math.Rand(-15, 15))) -- 90 = middle and 30 degree difference to make the pitch rotate randomly | yaw and roll are applied a bit of a random number
			radio.Assignee = self
			radio:Spawn()
			radio:Activate()
			radio.VJ_NPC_Class = self.VJ_NPC_Class
			
			if i == 1 then
				self.Radio1 = radio
			elseif i == 2 then
				self.Radio2 = radio
			elseif i == 3 then
				self.Radio3 = radio
			elseif i == 4 then
				self.Radio4 = radio
			elseif i == 5 then
				self.Radio5 = radio
			elseif i == 6 then
				self.Radio6 = radio
			elseif i == 7 then
				self.Radio7 = radio
			elseif i == 8 then
				self.Radio8 = radio
			elseif i == 9 then
				self.Radio9 = radio
			elseif i == 10 then
				self.Radio10 = radio
			end
		end
		self.RadiosSpawned = true
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "step" then
		util.ScreenShake(self:GetPos(), 10, 100, 0.4, 2000)
		self:FootStepSoundCode()
	elseif key == "melee" then
		VJ_EmitSound(self, {"vj_cthulhu/garg/gar_stomp1.wav"}, 90)
		self:MeleeAttackCode()
	elseif key == "breakfloor" then
		VJ_EmitSound(self, {"vj_cthulhu/common/water_crash1.wav"}, 100, 100)
	elseif key == "summon" then
		self:Tor_SpawnAlly()
	elseif key == "roar" then
		VJ_EmitSound(self, {"vj_cthulhu/garg/gar_alert1.wav","vj_cthulhu/garg/gar_alert2.wav","vj_cthulhu/garg/gar_alert3.wav","vj_cthulhu/garg/gar_attack3.wav"}, 150, 100)
	elseif key == "headfall" then
		VJ_EmitSound(self, {"vj_cthulhu/common/bustmetal2.wav"}, 100, 80)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if math.random(1, 2) == 1 then
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.MeleeAttackDamage = 500
	else
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.MeleeAttackDamage = 500
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	if hitgroup == HITGROUP_HEAD then
		self.AnimTbl_Death = {"diesimple"}
	else
		self.AnimTbl_Death = {"diesimple"}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode_AfterProjectileSpawn(projectile)
	if IsValid(self:GetEnemy()) then
		projectile.Track_Enemy = self:GetEnemy()
	end
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
	ply:ChatPrint("SPACE: Bring a ally to the combat")
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vezZ20 = Vector(0, 0, 20)
--
function ENT:Tor_CreateAlly()
	local spawnPos = self:GetPos() + self:GetForward() * 700 + self:GetUp() * 5
	local type = VJ_PICK({"npc_vj_cthulhu_ghoul","npc_vj_cthulhu_deepone","npc_vj_cthulhu_fatheadlesszombie","npc_vj_cthulhu_zombie","npc_vj_cthulhu_shambler","npc_vj_cthulhu_serpentman","npc_vj_cthulhu_priest","npc_vj_cthulhu_cultist_knife","npc_vj_cthulhu_cultist_revolver","npc_vj_cthulhu_cultist_shotgun","npc_vj_cthulhu_dagon","npc_vj_cthulhu_yodan","npc_vj_cthulhu_yodan_zikshadows","npc_vj_cthulhu_greatrace","npc_vj_cthulhu_greatrace_zikshadows"})
	local ally = ents.Create(type)
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
	if !self:BusyWithActivity() && CurTime() > self.Tor_NextSpawnT && (!IsValid(self.Tor_Ally1) or !IsValid(self.Tor_Ally2) or !IsValid(self.Tor_Ally3) or !IsValid(self.Tor_Ally4) or !IsValid(self.Tor_Ally5) or !IsValid(self.Tor_Ally6) or !IsValid(self.Tor_Ally7) or !IsValid(self.Tor_Ally8) or !IsValid(self.Tor_Ally9) or !IsValid(self.Tor_Ally10))  then
		-- Make sure not to place it if the front of the NPC is blocked!
		local tr = util.TraceLine({
			start = self:GetPos() + self:OBBCenter(),
			endpos = self:GetPos() + self:OBBCenter() + self:GetForward()*150,
			filter = self
		})
		if !tr.Hit then
			self:VJ_ACT_PLAYACTIVITY("spawn", true, false)
			self.Tor_NextSpawnT = CurTime() + 15
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
	timer.Remove("vlad_spawnracists"..self:EntIndex())
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
	        if IsValid(self.Radio1) then self.Radio1:Remove() end
	        if IsValid(self.Radio2) then self.Radio2:Remove() end
	        if IsValid(self.Radio3) then self.Radio3:Remove() end
	        if IsValid(self.Radio4) then self.Radio4:Remove() end
	        if IsValid(self.Radio5) then self.Radio5:Remove() end
	        if IsValid(self.Radio6) then self.Radio6:Remove() end
	        if IsValid(self.Radio7) then self.Radio7:Remove() end
	        if IsValid(self.Radio8) then self.Radio8:Remove() end
	        if IsValid(self.Radio9) then self.Radio9:Remove() end
	        if IsValid(self.Radio10) then self.Radio10:Remove() end
		if IsValid(self.SovietAlly1) then self.SovietAlly1:Remove() end
		if IsValid(self.SovietAlly2) then self.SovietAlly2:Remove() end
		if IsValid(self.SovietAlly3) then self.SovietAlly3:Remove() end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	corpseEnt:DrawShadow(true)
	corpseEnt:ResetSequence("diesimple")
	corpseEnt:SetCycle(1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self.RadiosDestroyed == false && self.RadiosSpawned == true && !IsValid(self.Radio1) && !IsValid(self.Radio2) && !IsValid(self.Radio3) && !IsValid(self.Radio4) && !IsValid(self.Radio5) && !IsValid(self.Radio6) && !IsValid(self.Radio7) && !IsValid(self.Radio8) && !IsValid(self.Radio9) && !IsValid(self.Radio10) then
		self.RadiosDestroyed = true
		VJ_EmitSound(self, "vj_cthulhu/garg/gar_alert1.wav", 100)
		self:RemoveFlags(FL_NOTARGET)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if self.RadiosDestroyed == false then 
		dmginfo:SetDamage(0)
		if dmginfo:GetDamagePosition() != vec then
		local rico = EffectData()
		rico:SetOrigin(dmginfo:GetDamagePosition())
		rico:SetScale(5) -- Size
		rico:SetMagnitude(math.random(1,2)) -- Effect type | 1 = Animated | 2 = Basic
		util.Effect("VJ_HLR_Rico", rico)
	return end
end end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:F_CreateAlly()
	local type = "npc_vj_cthulhu_cthulhu_tentacle"
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetForward() * math.Rand(1200, 1000) + self:GetRight() * math.Rand(-1200, 1200) + self:GetUp() * 0,
		filter = {self, type},
		mask = MASK_ALL,
	})
	local spawnpos = tr.HitPos + tr.HitNormal*0
	local ally = ents.Create(type)
	ally:SetPos(spawnpos)
	ally:SetAngles(Angle(0, 0, 0))
	//print(ally:GetAngles())
	ally:Spawn()
	ally:Activate()
	ally.VJ_NPC_Class = self.VJ_NPC_Class
	//ally:SetMaxHealth(ally:GetHealth() + 100)
	//ally:SetHealth(ally:GetHealth() + 100)
		
	return ally
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:F_SpawnAlly()
	-- Can have a total of 3, only 1 can be spawned at a time with a delay until another one is spawned
	if !IsValid(self.SovietAlly1) then
		self.SovietAlly1 = self:F_CreateAlly()
		return 15
	elseif !IsValid(self.SovietAlly2) then
		self.SovietAlly2 = self:F_CreateAlly()
		return 15
	elseif !IsValid(self.SovietAlly3) then
		self.SovietAlly3 = self:F_CreateAlly()
		return 15
	end
	return 8
end