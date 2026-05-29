AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_cthulhu/cultist.mdl"}
ENT.StartHealth = 100
ENT.HullType = HULL_HUMAN
ENT.VJC_Data = {
    ThirdP_Offset = Vector(-5, 0, -15),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(5, 0, 5),
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = "Red"
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"}
ENT.HasBloodPool = false
ENT.VJ_NPC_Class = {"CLASS_CTHULHU"}
ENT.CanEat = false

ENT.HasMeleeAttack = true
ENT.TimeUntilMeleeAttackDamage = false
ENT.MeleeAttackDistance = 50
ENT.MeleeAttackDamageDistance = 80

ENT.HasExtraMeleeAttackSounds = true
ENT.DisableFootStepSoundTimer = true

-- ===== Death: fixed delayed ragdoll ===== --
ENT.AnimTbl_Death = {ACT_DIESIMPLE}
ENT.HasDeathAnimation = true
ENT.HasDeathRagdoll = false -- prevent auto ragdoll, we handle it manually
ENT.DeathCorpseEntityClass = "prop_ragdoll"

---------------------------------------------------------------------------------------------------------------------------------------------
ENT.CanFlinch = 0
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS}
ENT.HitGroupFlinching_Values = {
	{HitGroup={HITGROUP_LEFTARM}, Animation={ACT_FLINCH_LEFTARM}},
	{HitGroup={HITGROUP_LEFTLEG}, Animation={ACT_FLINCH_LEFTLEG}},
	{HitGroup={HITGROUP_RIGHTARM}, Animation={ACT_FLINCH_RIGHTARM}},
	{HitGroup={HITGROUP_RIGHTLEG}, Animation={ACT_FLINCH_RIGHTLEG}}
}

ENT.SoundTbl_FootStep = {"vj_cthulhu/common/npc_step1.wav","vj_cthulhu/common/npc_step2.wav","vj_cthulhu/common/npc_step3.wav","vj_cthulhu/common/npc_step4.wav"}
ENT.SoundTbl_Idle = {"vj_cthulhu/cultist/cu_idle1.wav","vj_cthulhu/cultist/cu_idle2.wav","vj_cthulhu/cultist/cu_idle3.wav","vj_cthulhu/cultist/cu_idle4.wav","vj_cthulhu/cultist/cu_idle5.wav","vj_cthulhu/cultist/cu_idle6.wav"}
ENT.SoundTbl_Alert = {"vj_cthulhu/cultist/cu_alert1.wav","vj_cthulhu/cultist/cu_alert2.wav","vj_cthulhu/cultist/cu_alert3.wav","vj_cthulhu/cultist/cu_alert4.wav","vj_cthulhu/cultist/cu_alert5.wav","vj_cthulhu/cultist/cu_alert6.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_cthulhu/common/cbar_hitbod1.wav","vj_cthulhu/common/cbar_hitbod2.wav","vj_cthulhu/common/cbar_hitbod3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_cthulhu/common/cbar_miss1.wav"}
ENT.SoundTbl_Death = {"vj_cthulhu/butler/yeahthisisastockaudiososhutup1.ogg","vj_cthulhu/butler/yeahthisisastockaudiososhutup2.ogg","vj_cthulhu/butler/yeahthisisastockaudiososhutup3.ogg"}
ENT.SoundTbl_Pain = {"vj_hlr/hl1_npc/hgrunt/gr_pain1.wav","vj_hlr/hl1_npc/hgrunt/gr_pain2.wav","vj_hlr/hl1_npc/hgrunt/gr_pain3.wav","vj_hlr/hl1_npc/hgrunt/gr_pain4.wav","vj_hlr/hl1_npc/hgrunt/gr_pain5.wav"}
ENT.SoundTbl_BeforeRangeAttack = {"vj_hlr/fx/zap4.wav"}
ENT.SoundTbl_RangeAttack = {"vj_cthulhu/greatrace/zap4.wav"}

ENT.GeneralSoundPitch1 = 100

ENT.Zombie_Type = 0
ENT.Tor_NextSpawnT = 0
---------------------------------------------------------------------------------------------------------------------------------------------
-- (rest of file unchanged from previous patched version)
