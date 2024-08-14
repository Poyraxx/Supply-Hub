SWEP.Base = "weapon_base"
SWEP.PrintName = "Mühendis Outpost" 
SWEP.Author = "BinBon"
SWEP.Category = "OutPost" 
SWEP.Spawnable = true 
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic	= false
SWEP.Primary.Ammo		= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
SWEP.ViewModel 		= ""
SWEP.WorldModel 	= ""
SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.DrawCrosshair = true 
SWEP.DrawAmmo = false

SWEP.ViewModel			    = "models/props_c17/tools_pliers01a.mdl"
SWEP.WorldModel			    = "models/props_c17/tools_pliers01a.mdl"
if CLIENT then 
    surface.CreateFont( "mrpoutput_weapon_font", {
        font = "Tahoma", 
        extended = true,
        size = 23,
        weight = 500,
        antialias = true,
        shadow = true,
        additive = true,
    } )

end
SWEP.HoldType = "melee" 
bboutpost = bboutpost or {}
function SWEP:GetViewModelPosition( pos, ang )
    pos = pos + ang:Right() * 9 + ang:Forward() * 18 + ang:Up() * -9

    ang:RotateAroundAxis( ang:Right(), 90 )
    ang:RotateAroundAxis( ang:Up(), -90 )

    return pos, ang
end

function SWEP:Initialize()
self:SetWeaponHoldType( self.HoldType )
end 

function SWEP:PrimaryAttack()

if IsFirstTimePredicted() then 

if CLIENT then

    local Frame = vgui.Create( "DFrame" )
    Frame:SetSize( ScreenScale(200), ScreenScaleH(100) ) 
    Frame:SetTitle( "" ) 
    Frame:SetVisible( true ) 
    Frame:SetDraggable( false ) 
    Frame:ShowCloseButton( false ) 
    Frame:MakePopup()
    Frame:Center()
function Frame:Paint( w, h )
    draw.RoundedBox( 8, 0, 0, w, h, Color( 38, 38, 38 ) )
end


local CloseButton = vgui.Create( "DButton", Frame ) 
CloseButton:SetText( "X" )			
CloseButton:SetFont("Trebuchet24")
CloseButton:SetTextColor(Color(225,25,25))	
CloseButton:SetPos( 555, 5 )				
CloseButton:SetSize( 40, 30 )				
CloseButton.DoClick = function()			
	Frame:Remove()	
end
function CloseButton:Paint( w, h )
    draw.RoundedBox( 5, 0, 0, w, h, Color( 42, 42, 42 ) )
end

local TextEntry = vgui.Create( "DTextEntry", Frame ) 
TextEntry:SetPos(150,125)
TextEntry:SetSize(325,30)
TextEntry:SetTextColor(Color(0,0,0))
TextEntry:SetCursorColor(Color(150,150,150))

local DLabel = vgui.Create( "DLabel", Frame )
DLabel:SetPos( 95, 70 )
DLabel:SetSize(800,50)
DLabel:SetFont("mrpoutput_weapon_font")
DLabel:SetText( bboutpost.yazi )

local DLabelMalzeme = vgui.Create( "DLabel", Frame )
DLabelMalzeme:SetPos( 25, 10 )
DLabelMalzeme:SetSize(800,50)
DLabelMalzeme:SetFont("mrpoutput_weapon_font")
DLabelMalzeme:SetText( "Gidecek Malzeme: "..bboutpost.gidecek_malzeme )

local DermaButton = vgui.Create( "DButton", Frame ) 
DermaButton:SetText( "Oluştur" )			
DermaButton:SetFont("Trebuchet24")
DermaButton:SetTextColor(Color(235,235,235))	
DermaButton:SetPos( 210, 180 )				
DermaButton:SetSize( 190, 30 )				
DermaButton.DoClick = function()			
local yazi = TextEntry:GetValue()
Frame:Remove()
if yazi == nil or yazi == "" or string.len(yazi) < 5 then
    notification.AddLegacy("Yazdığın isim çok kısa!", NOTIFY_ERROR, 10) 
    return 
end 	
--if bboutpost.malzeme_kontrol(LocalPlayer()) == false then 
--surface.PlaySound("vo/eli_lab/al_buildastack.wav")
--notification.AddLegacy("Malzemelerin bunu oluşturmaya yetmiyor!", NOTIFY_ERROR, 10) 
  --  return 
--end 
net.Start("outpost_engineer")
net.WriteString(yazi)
net.SendToServer()
surface.PlaySound("ambient/levels/streetwar/building_rubble5.wav")

end
function DermaButton:Paint( w, h )
    draw.RoundedBox( 8, 0, 0, w, h, Color( 70, 70, 70 ) )
end


end

end
   self:SetNextPrimaryFire( CurTime() + 0.5 )
end 

function SWEP:SecondaryAttack()

end

function SWEP:Reload()

end