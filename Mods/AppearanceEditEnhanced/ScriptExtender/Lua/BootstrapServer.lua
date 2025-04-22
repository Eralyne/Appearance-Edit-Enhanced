---@diagnostic disable: undefined-global
Ext.Require("Shared/_Init.lua")
Ext.Require("Shared/Constants.lua")

-- Register Mod Vars (Loops don't work???)
Ext.Vars.RegisterModVariable(Constants.ModUUID, "SpellOwners", {})
Ext.Vars.RegisterModVariable(Constants.ModUUID, "OriginalTemplates", {})
Ext.Vars.RegisterModVariable(Constants.ModUUID, "OriginCopiedChars", {})
Ext.Vars.RegisterModVariable(Constants.ModUUID, "NewTemplateIcon", {})
Ext.Vars.RegisterModVariable(Constants.ModUUID, "CantripSpell", {})

Ext.Require("Shared/Utils.lua")
Ext.Require("Shared/Patches.lua")
Ext.Require("Shared/Cleanup.lua")
Ext.Require("AppearanceEditEnhanced/Main.lua")
Ext.Require("AppearanceEditEnhanced/EntitySubscriptions.lua")

local function OnSessionLoaded()
    -- Run patches
    for k, _ in pairs(Patches) do
        Patches[k]()
    end

    local ModInfo = Ext.Mod.GetMod(Constants.ModUUID)["Info"]

    AEE.modTableKey = ModInfo.Name
    AEE.modVersion = { major = ModInfo.ModVersion[1], minor = ModInfo.ModVersion[2], revision = ModInfo.ModVersion[3] }

    Utils.Info(AEE.modTableKey .. " Version: " .. AEE.modVersion.major .. '.' .. AEE.modVersion.minor .. '.' .. AEE.modVersion.revision .. ' Loaded')
end

Ext.Events.SessionLoaded:Subscribe(OnSessionLoaded)
