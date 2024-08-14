include( "shared.lua" )

local siyah_renk = Color(28,28,28,242)
local beyaz_renk = Color(255,255,255)
surface.CreateFont( "mrpoutput_table_large", {
	font = "Tahoma", 
	extended = true,
	size = 103,
	weight = 500,
	antialias = true,
	shadow = true,
	additive = true,
} )
surface.CreateFont( "mrpoutput_table_small", {
	font = "Tahoma", 
	extended = true,
	size = 73,
	weight = 500,
	antialias = true,
	shadow = true,
	additive = true,
} )
surface.CreateFont( "mrpoutput_table_liste", {
	font = "Tahoma", 
	extended = true,
	size = 23,
	weight = 500,
	antialias = true,
	shadow = true,
	additive = true,
} )

function ENT:Draw()
    self:DrawModel()
    local ply = LocalPlayer()
	if ply:GetPos():DistToSqr( self:GetPos() ) >= 3240000 then
		return
	end
	
	local Ang = self:GetAngles()
	local AngEyes = ply:EyeAngles()

	Ang:RotateAroundAxis( Ang:Forward(), 90 )
	Ang:RotateAroundAxis( Ang:Right(), -90 )
	
	cam.Start3D2D( self:GetPos() + self:GetUp() * 55, Angle( 0, AngEyes.y - 90, 90 ), 0.05 )

			draw.RoundedBox( 48, -800, 20, 1550, 280, siyah_renk )
			draw.SimpleTextOutlined( "Çıkarma Noktası", "mrpoutput_table_large", -350, 85, beyaz_renk, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, siyah_renk )
			draw.SimpleTextOutlined( "Buradan çıkarma noktalarını bakıp oraya gidebilirsiniz!", "mrpoutput_table_small", -750, 220, beyaz_renk, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, siyah_renk )

	cam.End3D2D()
end

net.Receive("outpost_table_derma", function()
local ply = LocalPlayer()
local Frame = vgui.Create( "DFrame" )
Frame:SetSize( ScreenScale(200), ScreenScaleH(100) ) 
Frame:SetTitle( "" ) 
Frame:SetVisible( true ) 
Frame:SetDraggable( false ) 
Frame:ShowCloseButton( false ) 
Frame:MakePopup()
Frame:Center()
function Frame:Paint( w, h )
draw.RoundedBox( 3, 0, 0, w, h, Color( 50, 48, 48) )
end


local CloseButton = vgui.Create( "DButton", Frame ) 
CloseButton:SetText( "X" )			
CloseButton:SetFont("Trebuchet24")
CloseButton:SetTextColor(Color(158,0,0))	
CloseButton:SetPos( 555, 5 )				
CloseButton:SetSize( 40, 30 )				
CloseButton.DoClick = function()			
Frame:Remove()	
end
function CloseButton:Paint( w, h )
draw.RoundedBox( 5, 0, 0, w, h, Color( 31, 31, 31,200) )
end

local DLabel = vgui.Create( "DLabel", Frame )
DLabel:SetPos( 95, 35 )
DLabel:SetSize(800,50)
DLabel:SetFont("mrpoutput_weapon_font")
DLabel:SetText( bboutpost.outpost_table_yazi )

local DLabelMalzeme = vgui.Create( "DLabel", Frame )
DLabelMalzeme:SetPos( 15, 0 )
DLabelMalzeme:SetSize(800,50)
DLabelMalzeme:SetFont("mrpoutput_weapon_font")
DLabelMalzeme:SetText( bboutpost.sunucuismi )
DLabelMalzeme:SetTextColor(Color(255,255,255))	



local DScrollPanel = vgui.Create( "DScrollPanel", Frame )
DScrollPanel:SetSize( 220,120 )
DScrollPanel:SetPos(220,80)

for i, ent in ipairs(ents.FindByClass("mrpoutpost_entity")) do
 if hangibolge(ply) != ent:GetNWString("outpost_faction", "Alman") then 
	local DButton = DScrollPanel:Add( "DButton" )
	DButton:SetText( ent:GetNWString("outpost_isim", "Bilinmiyor") )
	DButton:Dock( TOP )
	DButton:SetTextColor(Color(255,255,255))	
	DButton:DockMargin( 0, 0, 5, 10 )
	DButton:SetFont("mrpoutput_table_liste")
	DButton.DoClick = function() 
		net.Start("Npc_SkyDiving_NET_Lauch_Parachutage")
		net.SendToServer()
	end
	function DButton:Paint( w, h )
		draw.RoundedBox( 5, 0, 0, w, h, Color( 82, 82, 82) )
	end
 end

 DButton.DoClick = function() 
	net.Start("Npc_SkyDiving_NET_Lauch_Parachutage")
	net.WriteTable(Map:ConvertMousePosToVector())
	net.SendToServer()
end


end

end)

local function OpenOutpostSelectionMenu()
    local Frame = vgui.Create("DFrame")
    Frame:SetTitle("Select Outpost Entity")
    Frame:SetSize(300, 400)
    Frame:Center()
    Frame:MakePopup()

    local List = vgui.Create("DListView", Frame)
    List:Dock(FILL)
    List:SetMultiSelect(false)
    List:AddColumn("Outpost Entities")


    net.Start("RequestOutpostEntitiesList")
    net.SendToServer()

    net.Receive("SendOutpostEntitiesList", function()
        local entities = net.ReadTable()
        for _, entity in ipairs(entities) do
            List:AddLine(entity)
        end
    end)

    List.OnRowSelected = function(panel, rowIndex, row)
        local selectedEntityName = row:GetValue(1)

        net.Start("RequestTeleportToOutpostEntity")
        net.WriteString(selectedEntityName)
        net.SendToServer()
        Frame:Close()
    end
end


net.Receive("outpost_table_derma", function()
    OpenOutpostSelectionMenu()
end)
