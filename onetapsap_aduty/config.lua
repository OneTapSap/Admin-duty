Config = {}

Config.Command = 'amduty' --A parancs amivel dutyzol, bármire állíthatod, nem lesz semmi baja tőle.

Config.Ped = 's_m_m_chemsec_01' --ha nem szeretnél pedet állítsd nil-re

Config.Icons = {
    {"superadmin"},
    {"adminlogo"}
} --__resource.lua ba is be kell írni!!!

Config.Admins = {
    {"8474.....", "~r~[TULAJDONOS]~w~ ", "superadmin"},  --Először rangok idéje, második oszlop:rang neve, utolsó oszlop:milyen logot használjon
    {"8474.....", "~b~[AL-TULAJDONOS]~w~ ", "superadmin"},
    {"8484.....", "~g~[FEJLESZTŐ]~w~ ", "adminlogo"},
    {"8855.....", "~g~[FEJLESZTŐ SEGÉD]~w~ ", "adminlogo"}
}

Config.GuildId = "8474...." --Szerver ID

Config.BotToken = "ODUzMzgxNzY0NTU....." --NE RAKD ELÉ A Bot szót!!!!! csak a token amit kimásolsz!!!

Config.Webhook = "https://discord.com/api/webhooks/88959115..../KolOq35fD3p9zOME......" --ha nem szeretnél webhook logot állítsd nil-re
