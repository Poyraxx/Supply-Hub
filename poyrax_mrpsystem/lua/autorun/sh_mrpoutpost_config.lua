print("binbon buradaydı.")
bboutpost = bboutpost or {}
----------------------------------------------------------------------------------
--          ALTTAKI YERDEN EKLENTININ AYARLARIYLA OYNAYABILIRSINIZZZ .)       ----
----------------------------------------------------------------------------------
bboutpost.muhendismeslekleri = {
    ["Mesleğin f4 ismi"] = true,
    ["Mesleğin f4 ismi"] = true,
}

bboutpost.outpost_health = 100

bboutpost.outpost_money = 25000

bboutpost.outpost_faction = {
    ["Almanya"] = {
        ["Mayor"] = true,
        ["Mesleğin f4 ismi"] = true,
        ["Mesleğin f4 ismi"] = true,
    },



    ["Polonya"] = {
        ["Mesleğin f4 ismi"] = true,
        ["Mesleğin f4 ismi"] = true,
        ["Mesleğin f4 ismi"] = true,
    },
}

bboutpost.yazi = "Merhaba mühendis bu senin asker çıkartma malzemen.\nÇıkartmak için aşağıya bu çıkış noktasını bir isim yaz"
bboutpost.outpost_table_yazi = "Buradan mühendislerin kurduğu makinelere gidebilirsin"
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
----------------------------------------------------------------------------------
--          USTTEKI YERDEN EKLENTININ AYARLARIYLA OYNAYABILIRSINIZZZ .)       ----
----------------------------------------------------------------------------------

function hangibolge(ply)
    if bboutpost.outpost_faction["Almanya"][team.GetName(ply:Team())]  then 
        return "Alman"
    end 
    if bboutpost.outpost_faction["Polonya"][team.GetName(ply:Team())]  then 
        return "Polon"
    end 
    return ""
end