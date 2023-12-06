---@diagnostic disable: undefined-global

local CCTracker = {}

Ext.Entity.Subscribe("CCState", function(entity, _, _)
    -- Adjust templates
    local CCState = entity.CCState.HasDummy
    local char = entity.Uuid.EntityUuid

    if (not CCTracker[char]) then
        CCTracker[char] = CCState
        if (CCState) then
            if (Utils.Size(PersistentVars["OriginalTemplates"]) > 0) then
                Utils.ShiftEquipmentVisual(char)
            end
        else
            -- Triggers every time we change for the first time, however, keeping just in-case
            if (Utils.Size(PersistentVars["OriginalTemplates"]) > 0) then
                Utils.ShiftEquipmentVisual(char, true)
            end
        end
    elseif (not CCTracker[char] and CCState) then
        CCTracker[char] = CCState
        if (Utils.Size(PersistentVars["OriginalTemplates"]) > 0) then
            Utils.ShiftEquipmentVisual(char)
        end
    elseif (CCTracker[char] and not CCState) then
        CCTracker[char] = CCState
        if (Utils.Size(PersistentVars["OriginalTemplates"]) > 0) then
            Utils.ShiftEquipmentVisual(char, true)
        end
    end
end)

Ext.Entity.Subscribe("HotbarContainer", function(entity, _, _)
    local UUIDChar = entity.Uuid.EntityUuid

    local PersistantChar = PersistentVars["SpellOwners"][UUIDChar]

    if (PersistantChar and PersistantChar["Slot"]) then
        -- Remove duplicate
        Utils.MoveSpellToSlot(UUIDChar)
    end
end)

Ext.Entity.Subscribe("GameObjectVisual", function(entity, _, _)
    local UUIDChar = entity.Uuid.EntityUuid

    local GOV = entity.GameObjectVisual

    if (GOV.Type == 4 and PersistentVars["OriginalTemplates"]
            and PersistentVars["OriginalTemplates"][UUIDChar]
            and GOV.RootTemplateId == entity.ServerCharacter.Character.Template.Id) then
        entity.GameObjectVisual.Type = 2
        pcall(Osi.ObjectTimerLaunch, UUIDChar, "AEE_GOV_Replication", 250)
    elseif (GOV.Type == 0 or GOV.Type == 1) then
        Utils.CopyAppearanceVisuals(UUIDChar)
        pcall(Osi.ObjectTimerLaunch, UUIDChar, "AEE_GOV_Replication", 250)
    end
end)

-- Delay replication to avoid race condition
Ext.Osiris.RegisterListener("ObjectTimerFinished", 2, "after", function(uuid, event)
    if (event == "AEE_GOV_Replication") then
        Ext.Entity.Get(uuid):Replicate("GameObjectVisual")
    end
end)
