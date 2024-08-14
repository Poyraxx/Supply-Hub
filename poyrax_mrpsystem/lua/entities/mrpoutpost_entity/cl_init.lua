include( "shared.lua" )

local siyah_renk = Color(28,28,28,92)
local beyaz_renk = Color(255,255,255)
surface.CreateFont( "mrpoutput_entity_large", {
	font = "Tahoma", 
	extended = true,
	size = 73,
	weight = 500,
	antialias = true,
	shadow = true,
	additive = true,
} )
surface.CreateFont( "mrpoutput_entity_small", {
	font = "Tahoma", 
	extended = true,
	size = 43,
	weight = 500,
	antialias = true,
	shadow = true,
	additive = true,
} )

function ENT:Draw()
    self:DrawModel()
    local ply = LocalPlayer()
	if ply:GetPos():DistToSqr( self:GetPos() ) >= 1240000 then
		return
	end
	
	local Ang = self:GetAngles()
	local AngEyes = ply:EyeAngles()

	Ang:RotateAroundAxis( Ang:Forward(), 90 )
	Ang:RotateAroundAxis( Ang:Right(), -90 )
	
	cam.Start3D2D( self:GetPos() + self:GetUp() * 40 , Angle( 0, AngEyes.y - 90, 90 )  , 0.05 )
			draw.RoundedBox( 58, -500, 20, 1000, 280, siyah_renk )
			if self:GetNWString("outpost_faction", "Alman") != hangibolge(ply) then 
				draw.SimpleTextOutlined( "Düşman Çıkarma Noktası", "mrpoutput_entity_large", -350, 85, beyaz_renk, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, siyah_renk )
			else 
				draw.SimpleTextOutlined( "Takım Çıkarma Noktası", "mrpoutput_entity_large", -350, 85, beyaz_renk, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, siyah_renk )
			end
			draw.SimpleTextOutlined( self:GetNWString("outpost_isim", "Bilinmiyor"), "mrpoutput_entity_large", -50, 155, beyaz_renk, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, siyah_renk )
			draw.SimpleTextOutlined( "Güvenlik: "..self:GetNWString("outpost_guvenlik", "Güvenli"), "mrpoutput_entity_small", -480, 220, beyaz_renk, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, siyah_renk )
            draw.SimpleTextOutlined( "Sağlık: "..self:Health().." Can", "mrpoutput_entity_small", 150, 220, beyaz_renk, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, siyah_renk )
	cam.End3D2D()
end
