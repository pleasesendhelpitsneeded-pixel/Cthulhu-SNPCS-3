AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/vj_cthulhu/formless.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 100
ENT.HullType = HULL_HUMAN
ENT.VJC_Data = {
    ThirdP_Offset = Vector(-5, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bone0", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = false -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.VJ_NPC_Class = {"CLASS_CTHULHU"} -- NPCs with the same class with be allied to each other

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 50 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 80 -- How far does the damage go?

ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.LeapAttackAnimationDelay = 0.5 -- It will wait certain amount of time before playing the animation
ENT.LeapAttackDamage = 10
ENT.AnimTbl_LeapAttack = {"leap"} -- Melee Attack Animations
ENT.LeapDistance = 256 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 30 -- How close does it have to be until it uses melee?
ENT.LeapAttackDamageDistance = 50 -- How far does the damage go?
ENT.TimeUntilLeapAttackDamage = 0.4 -- How much time until it runs the leap damage code?
ENT.TimeUntilLeapAttackVelocity = 0.4 -- How much time until it runs the velocity code?
ENT.NextLeapAttackTime = 1 -- How much time until it can use a leap attack?
ENT.LeapAttackExtraTimers = {0.6, 0.8, 1, 1.2, 1.4} -- Extra leap attack timers | it will run the damage code after the given amount of seconds
ENT.NextAnyAttackTime_Leap = 3 -- How much time until it can use any attack again? | Counted in Seconds
ENT.StopLeapAttackAfterFirstHit = true -- Should it stop the leap attack from running rest of timers when it hits an enemy?
ENT.LeapAttackVelocityForward = 70 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 200 -- How much upward force should it apply?

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.DeathAnimationTime = 2 -- Time until the SNPC spawns its corpse and gets removed
ENT.AnimTbl_Death = {ACT_DIESIMPLE} -- Death Animationsed
ENT.DeathCorpseEntityClass = "prop_vj_animatable" -- The entity class it creates | "UseDefaultBehavior" = Let the base automatically detect the type
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
ENT.SoundTbl_FootStep = {}
ENT.SoundTbl_Idle = {"vj_cthulhu/formless_spawn/fs_idle1.wav","vj_cthulhu/formless_spawn/fs_idle2.wav"}
ENT.SoundTbl_Alert = {"vj_cthulhu/formless_spawn/fs_alert1.wav","vj_cthulhu/formless_spawn/fs_alert2.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_cthulhu/formless_spawn/fs_attack1.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_cthulhu/common/claw_strike1.wav","vj_cthulhu/common/claw_strike2.wav","vj_cthulhu/common/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_cthulhu/common/claw_miss1.wav","vj_cthulhu/common/claw_miss2.wav"}
ENT.SoundTbl_Pain = {"vj_cthulhu/formless_spawn/fs_pain1.wav","vj_cthulhu/formless_spawn/fs_pain2.wav"}
ENT.SoundTbl_Death = {"vj_cthulhu/formless_spawn/fs_pain1.wav","vj_cthulhu/formless_spawn/fs_pain2.wav"}
ENT.SoundTbl_LeapAttackDamage = {"vj_cthulhu/common/claw_strike1.wav","vj_cthulhu/common/claw_strike2.wav","vj_cthulhu/common/claw_strike3.wav"}

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "melee" then
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if math.random(1, 2) == 1 then
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.MeleeAttackDamage = 20
	else
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.MeleeAttackDamage = 20
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(20, 20 , 31), Vector(-20, -20, 0))
	timer.Simple(0.14,function() if IsValid(self) then self:VJ_ACT_PLAYACTIVITY("spawn", true, false, false) end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	corpseEnt:DrawShadow(false)
	corpseEnt:ResetSequence("die")
	corpseEnt:SetCycle(1)

        if math.random(1,4) == 1 then
        print("I'm alive lmao.")
	timer.Simple(math.random(5,12), function()
		if IsValid(corpseEnt) then
			local Evolution = ents.Create("npc_vj_cthulhu_formless_spawn")
			Evolution.EvolveNow = true

			Evolution:SetPos(corpseEnt:GetPos())
			Evolution:SetAngles(corpseEnt:GetAngles())
			Evolution:Spawn()
			Evolution:Activate()

			if Evolution.EvolveNow == true then
				VJ_EmitSound(Evolution, {"vj_cthulhu/formless_spawn/fs_alert1.wav"}, 100, math.random(100, 80))
			end
	               local ReviveAnim = VJ_PICK({"spawn"})
		       Evolution:VJ_ACT_PLAYACTIVITY(ReviveAnim, true, false, true,{SequenceDuration= Evolution:SetState(VJ_STATE_ONLY_ANIMATION)})
                        Evolution:SetState()
			if IsValid(corpseEnt) then
			corpseEnt:Remove()
			end
		end
	end)
end
end

ENT.EvolveNow = false
