/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Lurker SNPC"
local AddonName = "Lurker"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_rage_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	local vCat = "Cthulhu: Remod"
	

	VJ.AddNPC("Butler", "npc_vj_cthulhu_butler", vCat)       
	VJ.AddNPC("Civilian", "npc_vj_cthulhu_civilian", vCat)       
	VJ.AddNPC("Cthonian", "npc_vj_cthulhu_cthonian", vCat)       
	VJ.AddNPC("Cthulhu", "npc_vj_cthulhu_cthulhu", vCat)       
	VJ.AddNPC("Cthulhu (2nd Phase)", "npc_vj_cthulhu_cthulhu_2", vCat)       
	VJ.AddNPC("Cthulhu Tentacle", "npc_vj_cthulhu_cthulhu_tentacle", vCat)       
	VJ.AddNPC("Cultist (Knife)", "npc_vj_cthulhu_cultist_knife", vCat)       
	VJ.AddNPC("Cultist (Revolver)", "npc_vj_cthulhu_cultist_revolver", vCat)       
	VJ.AddNPC("Cultist (Shotgun)", "npc_vj_cthulhu_cultist_shotgun", vCat)       
	VJ.AddNPC("Dagon", "npc_vj_cthulhu_dagon", vCat)       
	VJ.AddNPC("Deep One", "npc_vj_cthulhu_deepone", vCat)       
	VJ.AddNPC("Eye Egg", "npc_vj_cthulhu_eyeegg", vCat)       
	VJ.AddNPC("Eye Tentacle", "npc_vj_cthulhu_eyetentacle", vCat)       
	VJ.AddNPC("Fat Headless Zombie", "npc_vj_cthulhu_fatheadlesszombie", vCat)       
	VJ.AddNPC("Formless Spawn", "npc_vj_cthulhu_formless_spawn", vCat)             
	VJ.AddNPC("Gangster (Revolver)", "npc_vj_cthulhu_ganster_revolver", vCat)             
	VJ.AddNPC("Gangster (Shotgun)", "npc_vj_cthulhu_ganster_shotgun", vCat)             
	VJ.AddNPC("Gangster (Tommy Gun)", "npc_vj_cthulhu_ganster_tommygun", vCat)             
	VJ.AddNPC("Ghoul", "npc_vj_cthulhu_ghoul", vCat)             
	VJ.AddNPC("Great Race", "npc_vj_cthulhu_greatrace", vCat)             
	VJ.AddNPC("Great Race (ZikShadow's Version)", "npc_vj_cthulhu_greatrace_zikshadows", vCat)             
	VJ.AddNPC("Green Crystal", "npc_vj_cthulhu_greencrystal", vCat)             
	VJ.AddNPC("Hideous Meat Mass", "npc_vj_cthulhu_hideousmeatmass", vCat)       
	VJ.AddNPC("Hideous Meat Mass Bottle", "npc_vj_cthulhu_hideousmeatmassbottle", vCat)       
	VJ.AddNPC("Humanoid Formless Spawn", "npc_vj_cthulhu_humanoid_formless_spawn", vCat)       
	VJ.AddNPC("Humanoid Ghoul", "npc_vj_cthulhu_humanoid_ghoul", vCat)       
	VJ.AddNPC("Hunting Horror", "npc_vj_cthulhu_huntinghorror", vCat)       
	VJ.AddNPC("Night Gaunt", "npc_vj_cthulhu_nightgaunt", vCat)       
	VJ.AddNPC("Police Man", "npc_vj_cthulhu_policeman", vCat)       
	VJ.AddNPC("Priest", "npc_vj_cthulhu_priest", vCat)       
	VJ.AddNPC("Serpent Man", "npc_vj_cthulhu_serpentman", vCat)       
	VJ.AddNPC("Shambler", "npc_vj_cthulhu_shambler", vCat)       
	VJ.AddNPC("Snake", "npc_vj_cthulhu_snake", vCat)       
	VJ.AddNPC("T-Rex", "npc_vj_cthulhu_trex", vCat)       
	VJ.AddNPC("Yodan", "npc_vj_cthulhu_yodan", vCat)       
	VJ.AddNPC("Yodan (ZikShadow's Version)", "npc_vj_cthulhu_yodan_zikshadows", vCat)       
	VJ.AddNPC("Zombie", "npc_vj_cthulhu_zombie", vCat)       
	VJ.AddNPC("Remod Ver. Map Spawner", "sent_vj_cthulhu_mapspawner_remod", vCat)       

	vCat = "Cthulhu: Classic"
	VJ.AddCategoryInfo(vCat, {Icon = "vj_cthulhu/icons/FreeWebToolkit_1701917043.png"})

	VJ.AddNPC("Cthonian", "npc_vj_cthulhu_cthonianclassic", vCat)       
	VJ.AddNPC("Cthulhu", "npc_vj_cthulhu_cthulhu_classic", vCat)       
	VJ.AddNPC("Dagon", "npc_vj_cthulhu_dagon_classic", vCat)       
	VJ.AddNPC("Deep One", "npc_vj_cthulhu_deepone_classic", vCat)       
	VJ.AddNPC("Formless Spawn", "npc_vj_cthulhu_formless_spawn_classic", vCat)       
	VJ.AddNPC("Gangster (Revolver)", "npc_vj_cthulhu_ganster_revolver_classic", vCat)             
	VJ.AddNPC("Gangster (Shotgun)", "npc_vj_cthulhu_ganster_shotgun_classic", vCat)             
	VJ.AddNPC("Ghoul", "npc_vj_cthulhu_ghoulclassic", vCat)       
	VJ.AddNPC("Great Race", "npc_vj_cthulhu_greatraceclassic", vCat)       
	VJ.AddNPC("Hunting Horror", "npc_vj_cthulhu_huntinghorror_classic", vCat)       
	VJ.AddNPC("Night Gaunt", "npc_vj_cthulhu_nightgauntclassic", vCat)       
	VJ.AddNPC("Police Man", "npc_vj_cthulhu_policeman_classic", vCat)       
	VJ.AddNPC("Priest", "npc_vj_cthulhu_priest_classic", vCat)       
	VJ.AddNPC("Serpent Man", "npc_vj_cthulhu_serpentman_classic", vCat)       
	VJ.AddNPC("Shambler", "npc_vj_cthulhu_shambler_classic", vCat)       
	VJ.AddNPC("Snake", "npc_vj_cthulhu_snakeclassic", vCat)       
	VJ.AddNPC("Yodan", "npc_vj_cthulhu_yodanclassic", vCat) 

end