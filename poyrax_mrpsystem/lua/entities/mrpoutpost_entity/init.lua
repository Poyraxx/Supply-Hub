
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_wasteland/laundry_cart002.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
    self:CPPISetOwner(self:Getowning_ent())
    local physObj = self:GetPhysicsObject()
	if ( physObj:IsValid() ) then
		physObj:Wake()
	end
	self:SetHealth(500)
end

local outposts = ents.FindByClass("mrpoutpost_entity") or {} -- Ensure outposts is a table



function ENT:OnTakeDamage(dmg)
    self:TakePhysicsDamage(dmg)
    self:SetHealth(self:Health() - dmg:GetDamage())
    if self:Health() <= 0 then
        self:EmitSound("physics/metal/metal_box_break1.wav", 100)
        self:Remove()
    end
end
local beklemeseyi = CurTime() + 5
function ENT:Think()
if beklemeseyi > CurTime() then return end 
beklemeseyi = CurTime() + 3
self:SetNWString("outpost_guvenlik", "Güvenli")
local plys = player.GetAll()
for i = 1, #plys do 
        local ply = plys[i]
        if self:GetPos():DistToSqr(ply:GetPos()) < 125000 then 
            if self:GetNWString("outpost_faction", "Alman") != hangibolge(ply) then 
                self:SetNWString("outpost_guvenlik", "Güvenli Değil")
            break 
            end
        end 


end

end