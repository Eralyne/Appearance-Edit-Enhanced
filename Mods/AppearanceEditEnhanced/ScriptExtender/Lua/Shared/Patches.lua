---@diagnostic disable: undefined-global

-- Patch for upgrading from < 3.1.0
-- Shift all PersistantVars to Mod Variables
function Patches.ShiftPersistentToModVars()
    -- Retrieve Mod Variables --
    ModVars = Ext.Vars.GetModVariables(Constants.ModUUID)

    for k, _ in pairs(PersistentVars) do
        if (PersistentVars[k] and Utils.Size(PersistentVars[k]) > 0) then
            ModVars[k] = PersistentVars[k]

            PersistentVars[k] = nil
        end
    end
end
