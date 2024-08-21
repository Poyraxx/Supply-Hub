print("Poyrax ve Binbon Buradaydı")

util.AddNetworkString("outpost_engineer")
util.AddNetworkString("outpost_teleport")
local IsValid = IsValid 

net.Receive("outpost_engineer", function(len, ply)
if not IsValid(ply) then return end
if not bboutpost.muhendismeslekleri[team.GetName(ply:Team())] then return end 
if not IsValid(ply:GetActiveWeapon()) then return end 
if ply:GetActiveWeapon():GetClass() != "mechanic_outpost" then return end

local yazi = net.ReadString()
if yazi == nil or yazi == "" or string.len(yazi) < 5 then
    notification.AddLegacy("Yazdığın isim çok kısa!", NOTIFY_ERROR, 10) 
    return 
end 	

if bboutpost.malzeme_kontrol(ply) == false then 
    surface.PlaySound("vo/eli_lab/al_buildastack.wav")
    notification.AddLegacy("Malzemelerin bunu oluşturmaya yetmiyor!", NOTIFY_ERROR, 10) 
  return 
end 

local outpost = ents.Create("mrpoutpost_entity")
if IsValid(outpost) then
    outpost:SetPos(ply:GetPos() + ply:GetUp() * 35)
    outpost:Spawn()
    outpost:CPPISetOwner(ply)
    if bboutpost.outpost_faction["Almanya"][team.GetName(ply:Team())] then 
        outpost.takim = "Almanya"
        outpost:SetNWString("outpost_faction", "Almanya")
    elseif bboutpost.outpost_faction["Polonya"][team.GetName(ply:Team())] then 
        outpost.takim = "Polonya"
        outpost:SetNWString("outpost_faction", "Polonya")
    end 
    outpost:SetNWString("outpost_isim", yazi)
end

end)

-- The teleport part will be completed later
net.Receive("Npc_SkyDiving_NET_Lauch_Parachutage", function(len, ply)
    if not IsValid(ply) then return end
    local ent = ply:GetEyeTrace().Entity
if not IsValid(ent) then return end 
if ent:GetClass() != "mrpoutpost_entity" then return end
if ply:GetPos():Distance(ent:GetPos()) > 25 then return end
end)
