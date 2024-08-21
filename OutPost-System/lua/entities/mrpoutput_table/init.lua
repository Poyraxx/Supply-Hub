AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()
    self:SetModel( "models/props_c17/FurnitureTable002a.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
    self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
    local physObj = self:GetPhysicsObject()
    if ( physObj:IsValid() ) then
        physObj:Wake()
    end
end

util.AddNetworkString("outpost_table_derma")
local bekleme = CurTime() + 1
function ENT:Use( ply )
    if bekleme > CurTime() then return end 
    bekleme = CurTime() + 1 
    net.Start("outpost_table_derma")
    net.Send(ply)
end

net.Receive("Npc_SkyDiving_NET_Lauch_Parachutage", function(len, ply)
    if not IsValid(ply) then return end
    local ent = ply:GetEyeTrace().Entity
    if not IsValid(ent) then return end 
    if ent:GetClass() != "mrpoutpost_entity" then return end
    if ply:GetPos():Distance(ent:GetPos()) > 25 then return end
end)


function InitializeParachut(ply, posx, posy, posz)

    if IsValid(ply) then
        local destination = Vector(posx, posy, posz)
        ply:SetPos(destination)
    end
end

util.AddNetworkString("Npc_SkyDiving_NET_Lauch_Parachutage")

net.Receive("Npc_SkyDiving_NET_Lauch_Parachutage", function(len, ply)
    if not IsValid(ply) then return end


    local ent = ply:GetEyeTrace().Entity
    if not IsValid(ent) then return end


    local pos = ent:GetPos()
    InitializeParachut(ply, pos.x, pos.y, pos.z)
end)


function TeleportPlayerToSelectedEntity(ply, selectedEntityName)
    local allEntities = ents.FindByClass("mrpoutpost_entity") 
    for _, entity in ipairs(allEntities) do
        if entity:GetNWString("outpost_isim") == selectedEntityName then
            ply:SetPos(entity:GetPos() + Vector(0, 0, 50)) 
            return
        end
    end
    ply:ChatPrint("Specified outpost entity not found!")
end


util.AddNetworkString("RequestTeleportToOutpostEntity")
net.Receive("RequestTeleportToOutpostEntity", function(len, ply)
    local selectedEntityName = net.ReadString()
    TeleportPlayerToSelectedEntity(ply, selectedEntityName)
end)


util.AddNetworkString("RequestOutpostEntitiesList")
util.AddNetworkString("SendOutpostEntitiesList")

net.Receive("RequestOutpostEntitiesList", function(len, ply)
    local entities = ents.FindByClass("mrpoutpost_entity")
    local entityNames = {}

    for _, entity in ipairs(entities) do
        table.insert(entityNames, entity:GetNWString("outpost_isim"))
    end

    net.Start("SendOutpostEntitiesList")
    net.WriteTable(entityNames)
    net.Send(ply)
end)
