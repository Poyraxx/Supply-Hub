
ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName		= "OutPost Entity"
ENT.Category    = "OutPost"
ENT.Author			= "Poyrax"
ENT.Spawnable       = true
function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
end