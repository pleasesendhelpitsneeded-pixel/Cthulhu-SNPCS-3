/*--------------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Red orb"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectiles for my addons"
ENT.Category		= "Projectiles"

ENT.VJ_IsDetectableDanger = true

if CLIENT then
	local Name = "Cthulhu"
	local LangName = "obj_vj_cthulhu_redorb"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.Model = {"models/spitball_large.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.EntitiesToNoCollide = {"obj_vj_cthulhu_redorb"} -- Entities to not collide with when HasEntitiesToNoCollide is set to true
ENT.PhysicsInitType = SOLID_VPHYSICS
ENT.MoveCollideType = MOVETYPE_NONE
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.DoesDirectDamage = true -- Should it do a direct damage when it hits something?
ENT.DirectDamage = 100 -- How much damage should it do when it hits something
ENT.DirectDamageType = DMG_DISSOLVE -- Damage type'
ENT.DecalTbl_DeathDecals = {"VJ_HLR_Scorch_Small"} -- Decals that paint when the projectile dies | It picks a random one from this table
ENT.SoundTbl_Startup = {"vj_cthulhu/garg/blackholelaunch.wav"}
ENT.SoundTbl_OnCollide = {"vj_cthulhu/garg/black hole explosion.wav"}
ENT.SoundTbl_Idle = {"vj_cthulhu/garg/blackholeloop.wav"}
ENT.RadiusDamageRadius = 60 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 100 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_DISSOLVE -- Damage type
ENT.RadiusDamageForce = 90 -- Put the force amount it should apply | false = Don't apply any force

-- ENT.RemoveOnHit = false
-- ENT.CollideCodeWithoutRemoving = true

ENT.StartupSoundPitch = VJ_Set(100, 100)

-- Custom
local defVec = Vector(0, 0, 0)

ENT.Track_Enemy = NULL
ENT.Track_Position = defVec
ENT.Track_OrbSpeed = 200
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:SetMass(1)
	phys:SetBuoyancyRatio(0)
	phys:EnableDrag(false)
	phys:EnableGravity(false)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetNoDraw(true)
	self.StartGlow1 = ents.Create("env_sprite")
	self.StartGlow1:SetKeyValue("model","vj_cthulhu/sprites/cthulhuorb.vmt")
	self.StartGlow1:SetKeyValue("rendercolor","224 224 255")
	self.StartGlow1:SetKeyValue("GlowProxySize","5.0")
	self.StartGlow1:SetKeyValue("HDRColorScale","1.0")
	self.StartGlow1:SetKeyValue("renderfx","14")
	self.StartGlow1:SetKeyValue("rendermode","3")
	self.StartGlow1:SetKeyValue("renderamt","255")
	self.StartGlow1:SetKeyValue("disablereceiveshadows","0")
	self.StartGlow1:SetKeyValue("mindxlevel","0")
	self.StartGlow1:SetKeyValue("maxdxlevel","0")
	self.StartGlow1:SetKeyValue("framerate","100.0")
	self.StartGlow1:SetKeyValue("spawnflags","0")
	self.StartGlow1:SetKeyValue("scale","0.2")
	self.StartGlow1:SetPos(self:GetPos())
	self.StartGlow1:Spawn()
	self.StartGlow1:SetParent(self)
	self:DeleteOnRemove(self.StartGlow1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if IsValid(self:GetOwner()) then
		self.Track_Enemy = self:GetOwner():GetEnemy()
	end
	if IsValid(self.Track_Enemy) then
		local pos = (self.Track_Enemy:EyePos()) or (self.Track_Enemy:GetPos() + self.Track_Enemy:OBBCenter())
		if self:VisibleVec(pos) or self.Track_Position == defVec then
			self.Track_Position = pos
		end
		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			-- phys:SetVelocity(self:CalculateProjectile("Line", self:GetPos(), self.Track_Enemy:GetPos() + self.Track_Enemy:OBBCenter(), 200))
			phys:SetVelocity(self:CalculateProjectile("Line", self:GetPos(), self.Track_Position, self.Track_OrbSpeed))
		end
	end
	self.Track_OrbSpeed = math.Clamp(self.Track_OrbSpeed + 10, 200, 2000)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPhysicsCollide(data, phys)
	self.StartGlow1:Remove()
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vecZ80 = Vector(0, 0, 0)
--
function ENT:DeathEffects(data, phys)
	util.ScreenShake(data.HitPos, 16, 200, 1, 3000)
	if IsValid(self.StartGlow1) then self.StartGlow1:Remove() end
	
	self:SetNW2Bool("VJ_Dead", true)

	local spr = ents.Create("env_sprite")
	spr:SetKeyValue("model","vj_cthulhu/sprites/redorbexplosion.vmt")
	spr:SetKeyValue("GlowProxySize","2.0")
	spr:SetKeyValue("HDRColorScale","1.0")
	spr:SetKeyValue("renderfx","14")
	spr:SetKeyValue("rendermode","5")
	spr:SetKeyValue("renderamt","255")
	spr:SetKeyValue("disablereceiveshadows","0")
	spr:SetKeyValue("mindxlevel","0")
	spr:SetKeyValue("maxdxlevel","0")
	spr:SetKeyValue("framerate","40.0")
	spr:SetKeyValue("spawnflags","0")
	spr:SetKeyValue("scale","0.5")
	spr:SetPos(self:GetPos() + vecZ80)
	spr:Spawn()
	spr:Fire("Kill","",0.48)
	timer.Simple(0.8, function() if IsValid(spr) then spr:Remove() end end)
	
	local expLight = ents.Create("light_dynamic")
	expLight:SetKeyValue("brightness", "4")
	expLight:SetKeyValue("distance", "300")
	expLight:SetLocalPos(data.HitPos)
	expLight:SetLocalAngles(self:GetAngles())
	expLight:Fire("Color", "255 150 0")
	expLight:SetParent(self)
	expLight:Spawn()
	expLight:Activate()
	expLight:Fire("TurnOn", "", 0)
	expLight:Fire("Kill", "", 0.1)
	self:DeleteOnRemove(expLight)
end