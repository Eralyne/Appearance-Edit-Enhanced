---@diagnostic disable: undefined-global
Ext.Require("Shared/_Init.lua")
Ext.Require("Shared/Constants.lua")
Ext.Require("Shared/Utils.lua")
Ext.Require("Shared/Patches.lua")
Ext.Require("AppearanceEditEnhanced/Main.lua")

local function OnSessionLoaded()
    Utils.Info(AEE.modTableKey .. " Version: " .. AEE.modVersion.major .. '.' .. AEE.modVersion.minor .. '.' .. AEE.modVersion.revision .. ' Loaded')

    -- Merge PersistentVar Keys --

    -- Remove keys we no longer use in the Template
    for k, _ in pairs(PersistentVars) do
        if (PersistentVarsTemplate[k] == nil) then
            PersistentVars[k] = nil
        end
    end

    -- Add new keys to the PersistentVars
    for k, _ in pairs(PersistentVarsTemplate) do
        if (PersistentVars[k] == nil) then
            PersistentVars[k] = {}
        end
    end

    -- Run PersistantVar patches
    for k, _ in pairs(Patches) do
        Patches[k]()
    end
end

Ext.Events.SessionLoaded:Subscribe(OnSessionLoaded)
