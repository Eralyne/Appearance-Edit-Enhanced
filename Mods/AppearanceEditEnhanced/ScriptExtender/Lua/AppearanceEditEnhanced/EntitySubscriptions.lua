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
        local barIndex, _, slotIndex = Utils.FindSpellIndexOnHotbar(UUIDChar, Constants.CustomSpells["SpellsContainer"])

        if (barIndex and slotIndex) then
            Utils.MoveSpellToSlot(UUIDChar)
        end
    end
end)

Ext.Entity.Subscribe("GameObjectVisual", function(entity, _, _)
    local UUIDChar = entity.Uuid.EntityUuid

    local GOV = entity.GameObjectVisual

    -- Check that it's a character being replicated lmao
    local success, _ = pcall(Utils.TryGetProxy, entity, "CharacterCreationAppearance")

    if (success) then
        if (PersistentVars["OriginalTemplates"]
                and PersistentVars["OriginalTemplates"][UUIDChar]
                and GOV.RootTemplateId == PersistentVars["OriginalTemplates"][UUIDChar]["CopiedId"]) then
            if (GOV.Type == 4) then
                entity.GameObjectVisual.Type = 2
                Utils.CopyAppearanceVisuals(UUIDChar)
            elseif (GOV.Type == 0 or GOV.Type == 1) then
                Utils.CopyAppearanceVisuals(UUIDChar)
            end
        end
    end
end)
