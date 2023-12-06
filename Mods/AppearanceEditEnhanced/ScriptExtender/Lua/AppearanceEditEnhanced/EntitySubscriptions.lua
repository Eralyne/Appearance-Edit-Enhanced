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

-- Ext.Entity.Subscribe("GameObjectVisual", function(entity, component, flags)
--     if (GOVType ~= 2) then
--         Ext.Entity.Get(char).GameObjectVisual.Type = 2
--         Entity:Replicate("GameObjectVisual")
--     end
-- end)
