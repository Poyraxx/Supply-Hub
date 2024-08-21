print("binbon buradaydı.")
bboutpost = bboutpost or {}
------------------------------------
--        CONFIG FILES          ----
------------------------------------
bboutpost.muhendismeslekleri = {
    ["Job Name"] = true,
    ["Job Name"] = true,
}

bboutpost.outpost_health = 100
bboutpost.outpost_money = 25000



bboutpost.outpost_faction = {
    ["Faction 1"] = {
        ["Job Name"] = true,
        ["Job Name"] = true,
        ["Job Name"] = true,
    },



    ["Faction 2"] = {
        ["Job Name"] = true,
        ["Job Name"] = true,
        ["Job Name"] = true,
    },
}

bboutpost.yazi = "Hello engineer, this is your soldier decal material.\nWrite a name for this exit point below to extract it."
bboutpost.outpost_table_yazi = "From here you can go to the machines built by engineers"
bboutpost.sunucuismi = "BinBon Roleplay"

bboutpost.almanya_limit = 5
bboutpost.polonya_limit = 5
bboutpost.deneme = 5

bboutpost.gidecek_malzeme = 5000

function bboutpost.malzeme_kontrol(ply)
    if ply:GetNWInt("malzeme", 0) < bboutpost.gidecek_malzeme  then 
        return false 
    end
    return true 
end
------------------------------------------
--        CONFIG FILES FINISH         ----
------------------------------------------

function hangibolge(ply)
    if bboutpost.outpost_faction["Faction 1"][team.GetName(ply:Team())]  then 
        return "Alman"
    end 
    if bboutpost.outpost_faction["Faction 2"][team.GetName(ply:Team())]  then 
        return "Polon"
    end 
    return ""
end