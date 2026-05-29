AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_cthulhu/hideousmeatmassbottle.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 50
ENT.HullType = HULL_HUMAN
ENT.VJC_Data = {
    ThirdP_Offset = Vector(-5, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_yellow"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Yellow"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.VJ_NPC_Class = {"CLASS_CTHULHU","CLASS_PLAYER_ALLY"} -- NPCs with the same class with be allied to each other
ENT.Bleeds = false -- Does the SNPC bleed? (Blood decal, particle, etc.)

ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 50 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 80 -- How far does the damage go?
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(10, 10, 18), Vector(-10, -10, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo,hitgroup)
		VJ_EmitSound(self, {"vj_cthulhu/common/bustglass1.wav","vj_cthulhu/common/bustglass2.wav","vj_cthulhu/common/bustglass3.wav"}, 75, 100)
	self:VJ_ACT_PLAYACTIVITY("toss", true, false, true) -- Angry animation
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
		local effectBlood = EffectData()
		effectBlood:SetOrigin(self:GetPos() + self:OBBCenter())
		effectBlood:SetColor(VJ_Color2Byte(Color(130,19,10)))
		effectBlood:SetScale(550)
		util.Effect("VJ_Blood1",effectBlood)
local Buglin = ents.Create("npc_vj_cthulhu_hideousmeatmass")
Buglin:SetPos(self:GetPos())
Buglin:SetAngles(self:GetAngles())
Buglin:Spawn()
Buglin:Activate()
VJ_EmitSound(self,"vj_cthulhu/common/bustglass1.wav",110)
VJ_EmitSound(self,"vj_cthulhu/common/bustglass1.wav",110)VJ_EmitSound(self,"vj_cthulhu/common/bustglass1.wav",110)
end

