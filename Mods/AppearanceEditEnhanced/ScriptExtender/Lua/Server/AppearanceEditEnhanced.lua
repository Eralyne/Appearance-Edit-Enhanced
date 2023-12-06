---@diagnostic disable: undefined-global

----------------------
-- Helper functions --
----------------------

local function utils_set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

----------------------
----------------------

local MaleSecretOrigins = utils_set({
    "S_Player_Minsc_0de603c5-42e2-4811-9dad-f652de080eba",
    "S_GLO_Halsin_7628bc0e-52b8-42a7-856a-13a6fd413323",
})

local FemaleSecretOrigins = utils_set({
    "S_GOB_DrowCommander_25721313-0c15-4935-8176-9f134385451b",
    "S_Player_Jaheira_91b6b200-7d00-4d62-8dc9-99e8339dfa1a",
})

-- Give players Resculpt/Respec spell on sneak
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (guid, name, _, _)
    if name == "SNEAKING" and string.find(guid, Osi.GetHostCharacter(), 1, true) then
        Osi.AddSpell(guid, "Shout_Open_Creation", 1, 1)
        Osi.AddSpell(guid, "Shout_Open_Respec", 1, 1)
     end
end)

-- Remove Resculpt/Respec on sneak end
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function (guid, name, _, _)
    if name == "SNEAKING" and string.find(guid, Osi.GetHostCharacter(), 1, true) then
        Osi.RemoveSpell(guid, "Shout_Open_Creation", 0)
        Osi.RemoveSpell(guid, "Shout_Open_Respec", 0)
    end
end)

-- Open character change or respec on spell use
Ext.Osiris.RegisterListener("UsingSpell", 5, "after", function (uuid, name, _, _, _, _)
    if name == "Shout_Open_Creation" then
        -- Set secret origin voice to enable changing appearance
        if (MaleSecretOrigins[uuid]) then
            Ext.Entity.Get(uuid).Voice.Voice = "f667ae40-070f-42ad-a265-b589e157015b"
        elseif (FemaleSecretOrigins[uuid]) then
            Ext.Entity.Get(uuid).Voice.Voice = "be2f85e5-4bcb-4402-81ae-34a2bce3b179"
        end
        Osi.StartChangeAppearance(uuid)
        Ext.Utils.Print("Character Editor Shown")
    elseif name == "Shout_Open_Respec" then
        Osi.StartRespec(uuid)
        Ext.Utils.Print("Respec Screen Shown")
    end
end)

-- Enable origins/hirelings to use the mirror
Ext.Osiris.RegisterListener("TemplateUseFinished", 4, "after", function (uuid, itemroot, item, _)
    if (itemroot == "UNI_MagicMirror_72ae7a39-d0ce-4cb6-8d74-ebdf7cdccf91" and (string.find(uuid, "S_", 1, true) == 1)) and Osi.IsTagged(uuid, "FULL_CEREMORPH_3797bfc4-8004-4a19-9578-61ce0714cc0b") == 0 then
        -- Set secret origin voice to enable changing appearance
        if (MaleSecretOrigins[uuid]) then
            Ext.Entity.Get(uuid).Voice.Voice = "f667ae40-070f-42ad-a265-b589e157015b"
        elseif (FemaleSecretOrigins[uuid]) then
            Ext.Entity.Get(uuid).Voice.Voice = "be2f85e5-4bcb-4402-81ae-34a2bce3b179"
        end
        Osi.QRY_StartDialog("GLO_MagicMirror_f9af5a3b-fb57-b69d-7526-9abdaf50db78", item, uuid)
    end
end)

-- Reset secret origin voice to keep their barks the same
Ext.Osiris.RegisterListener("ChangeAppearanceCancelled", 1, "before", function (uuid)
    if (MaleSecretOrigins[uuid] or FemaleSecretOrigins[uuid]) then
        Ext.Entity.Get(uuid).Voice.Voice = "00000000-0000-0000-0000-000000000000"
    end
end)

Ext.Osiris.RegisterListener("ChangeAppearanceCompleted", 1, "before", function (uuid)
    if (MaleSecretOrigins[uuid] or FemaleSecretOrigins[uuid]) then
        Ext.Entity.Get(uuid).Voice.Voice = "00000000-0000-0000-0000-000000000000"
    end
end)
