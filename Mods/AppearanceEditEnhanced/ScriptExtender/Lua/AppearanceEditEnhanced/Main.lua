---@diagnostic disable: undefined-global

local CharacterOrigins = Utils.Set(Constants.CharacterOrigins)
local MaleSecretOrigins = Utils.Set(Constants.MaleSecretOrigins)
local FemaleSecretOrigins = Utils.Set(Constants.FemaleSecretOrigins)

local function doOriginOperations(uuid)
    -- Set secret origin voice to enable changing appearance
    if (MaleSecretOrigins[uuid]) then
        Ext.Entity.Get(uuid).Voice.Voice = Constants.DefaultUUIDs["TempMaleVoice"]
    elseif (FemaleSecretOrigins[uuid]) then
        Ext.Entity.Get(uuid).Voice.Voice = Constants.DefaultUUIDs["TempFemaleVoice"]
    end

    -- Assign character creation entity
    local originEntity = Ext.Entity.Get(uuid).CharacterCreationAppearance
    if (Constants.OriginCharacterCreationAppearances[uuid] and (originEntity.EyeColor == Constants.DefaultUUIDs["NullTemplate"] or originEntity.SkinColor == Constants.DefaultUUIDs["NullTemplate"])) then
        -- Temp
        Utils.TempClone(originEntity, Constants.OriginCharacterCreationAppearances[uuid])
    end
end

-- Give players Resculpt/Respec spell on sneak
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(guid, name, _, _)
    if name == "SNEAKING" and Osi.DB_Players:Get(guid) ~= nil then
        Osi.AddSpell(guid, "Shout_Open_Creation", 1, 1)
        Osi.AddSpell(guid, "Shout_Open_Respec", 1, 1)
    end
end)

-- Remove Resculpt/Respec on sneak end
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(guid, name, _, _)
    if name == "SNEAKING" and Osi.DB_Players:Get(guid) ~= nil then
        Osi.RemoveSpell(guid, "Shout_Open_Creation", 0)
        Osi.RemoveSpell(guid, "Shout_Open_Respec", 0)
    end
end)

-- Open character change or respec on spell use
Ext.Osiris.RegisterListener("UsingSpell", 5, "after", function(uuid, name, _, _, _, _)
    if name == "Shout_Open_Creation" then
        if (CharacterOrigins[uuid]) then
            doOriginOperations(uuid)
        end

        if (Osi.IsTagged(uuid, Constants.DefaultUUIDs["FullCeramorphTag"]) == 0) then
            Osi.StartChangeAppearance(uuid)
            Utils.Info("Magic Mirror shown through Respec")
        end
    elseif name == "Shout_Open_Respec" then
        if (Osi.IsTagged(uuid, Constants.DefaultUUIDs["FullCeramorphTag"]) == 0) then
            Osi.StartRespec(uuid)
            Utils.Info("Respec Screen shown through Respec")
        end
    end
end)

-- Enable origins/hirelings to use the mirror
Ext.Osiris.RegisterListener("TemplateUseFinished", 4, "after", function(uuid, itemroot, item, _)
    if (itemroot == Constants.DefaultUUIDs["MagicMirrorTemplate"] and (string.find(uuid, "S_", 1, true) == 1)) and Osi.IsTagged(uuid, Constants.DefaultUUIDs["FullCeramorphTag"]) == 0 then
        if (CharacterOrigins[uuid]) then
            doOriginOperations(uuid)
        end

        Osi.QRY_StartDialog(Constants.DefaultUUIDs["MagicMirrorDialogue"], item, uuid)
    end
end)

-- Reset secret origin voice to keep their barks the same
Ext.Osiris.RegisterListener("ChangeAppearanceCancelled", 1, "before", function(uuid)
    if (MaleSecretOrigins[uuid] or FemaleSecretOrigins[uuid]) then
        Ext.Entity.Get(uuid).Voice.Voice = Constants.DefaultUUIDs["NullTemplate"]
    end
end)

Ext.Osiris.RegisterListener("ChangeAppearanceCompleted", 1, "before", function(uuid)
    if (MaleSecretOrigins[uuid] or FemaleSecretOrigins[uuid]) then
        Ext.Entity.Get(uuid).Voice.Voice = Constants.DefaultUUIDs["NullTemplate"]
    end
end)
