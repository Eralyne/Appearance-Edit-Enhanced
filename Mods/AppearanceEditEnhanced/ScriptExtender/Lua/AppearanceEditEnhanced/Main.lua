---@diagnostic disable: undefined-global

-- TODO: Move to utils
local function doOriginOperations(uuid)
    -- Set secret origin voice to enable changing appearance
    Utils.TempFixSecretOriginVoice(uuid)

    -- Fix Minsc issue caused by me :(
    if (uuid == "S_Player_Minsc_0de603c5-42e2-4811-9dad-f652de080eba" and Ext.Entity.Get(uuid).CharacterCreationStats.BodyShape == 0) then
        Ext.Entity.Get(uuid).CharacterCreationStats.BodyShape = 1
    end

    -- Assign character creation entity
    local originEntity = Ext.Entity.Get(uuid).CharacterCreationAppearance
    if (Constants.OriginCharacterCreationAppearances[uuid] and (originEntity.EyeColor == Constants.DefaultUUIDs["NullTemplate"] or originEntity.SkinColor == Constants.DefaultUUIDs["NullTemplate"])) then
        Utils.TempClone(originEntity, Constants.OriginCharacterCreationAppearances[uuid])
        Ext.Entity.Get(uuid):Replicate("CharacterCreationAppearance")
    end
end

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                            Vars                                             --
--                                                                                             --
-------------------------------------------------------------------------------------------------

local SaveLoaded = false

local CharacterCreated

local SpellCaster

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                          Handlers                                           --
--                                                                                             --
-------------------------------------------------------------------------------------------------

Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", function()
    -- We track this to prevent doing operations on new game
    SaveLoaded = true

    -- Reset GameObjectVisual to use custom looks
    for char, _ in pairs(PersistentVars["OriginalTemplates"]) do
        local Entity = Ext.Entity.Get(char)

        Entity.GameObjectVisual.Type = 2
        Entity:Replicate("GameObjectVisual")
    end
end)

-- Do work depending on spell used
Ext.Osiris.RegisterListener("UsingSpell", 5, "after", function(uuid, name, _, _, _, _)
    -- Only do work if the characters are not full mindflayer
    if ((Osi.IsTagged(uuid, Constants.DefaultUUIDs["FullCeramorphTag"]) == 0)) then
        -- local UUIDChar = Utils.GetGUID(uuid)

        if name == Constants.CustomSpells["Mirror"] then
            if (Utils.IsOrigin(uuid)) then
                doOriginOperations(uuid)
            end

            Osi.StartChangeAppearance(uuid)
            Utils.Info("Magic Mirror shown through " .. Constants.CustomSpells["Mirror"])
        elseif name == Constants.CustomSpells["Respec"] then
            Osi.StartRespec(uuid)

            Utils.Info("Respec Screen shown through " .. Constants.CustomSpells["Respec"])
        elseif name == Constants.CustomSpells["Resculpt"] then
            SpellCaster = uuid

            Osi.StartCharacterCreation()
            Utils.Info("Character Creation Screen shown through " .. Constants.CustomSpells["Resculpt"])
        end
    end
end)

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                          Mirror                                             --
--                                                                                             --
-------------------------------------------------------------------------------------------------

-- Enable origins/hirelings to use the mirror
Ext.Osiris.RegisterListener("TemplateUseFinished", 4, "after", function(uuid, itemroot, item, _)
    if (itemroot == Constants.DefaultUUIDs["MagicMirrorTemplate"] and Osi.IsTagged(uuid, Constants.DefaultUUIDs["FullCeramorphTag"]) == 0) then
        if (Utils.IsOrigin(uuid)) then
            doOriginOperations(uuid)

            Osi.QRY_StartDialog(Constants.DefaultUUIDs["MagicMirrorDialogue"], item, uuid)
        end
    end
end)

Ext.Osiris.RegisterListener("ChangeAppearanceCancelled", 1, "before", function(uuid)
    Utils.ResetSecretOriginVoice(uuid)
end)

Ext.Osiris.RegisterListener("ChangeAppearanceCompleted", 1, "before", function(uuid)
    Utils.CopyAppearanceVisuals(uuid)

    Utils.ResetSecretOriginVoice(uuid)
end)

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                        Resculpt                                             --
--                                                                                             --
-------------------------------------------------------------------------------------------------

-- Do Creation Operations
Ext.Osiris.RegisterListener("CharacterCreationFinished", 0, "before", function()
    if SaveLoaded then
        CharacterCreated = true

        -- Osi.TimerLaunch("APPEARANCE_EDIT_ORIGIN_EDIT_FINISHED", 500)

        -- Remove Daisies
        -- TODO: Potentially do this better?
        for _, entry in pairs(Osi["DB_GLO_DaisyAwaitsAvatar"]:Get(nil, nil)) do
            if (entry) then
                Utils.RemoveCharacter(entry[1])
                Osi["DB_GLO_DaisyAwaitsAvatar"]:Delete(table.unpack(entry))
                Utils.Info("Daisy Cleaned Up")
            end
        end
    else
        SaveLoaded = true
    end
end)

Ext.Osiris.RegisterListener("Activated", 1, "before", function(uuid)
    if SaveLoaded and CharacterCreated then
        -- TODO: Add object timer here to do work so we can free up Spellcaster

        -- Not generic, clean up and do nothing
        -- Although it doesn't matter if generic or DUrge for change operations, we keep this here so MP players can exit CC freely
        -- MP players CANNOT use the resulpt spell until the first player finishes or it's joeover
        if (Osi.IsTagged(uuid, Constants.DefaultUUIDs["DarkUrgeTag"]) == 1) then
            Utils.RemoveCharacter(uuid)

            return
        elseif (Osi.IsTagged(uuid, Constants.DefaultUUIDs["GenericTag"]) == 0) then
            -- Another char was activated but it wasn't one made in CC
            -- Likely we have a multiplayer situation, one exited early with DUrge while other is still editing
            return
        end

        CharacterCreated = false

        -- Persist Variables for SpellCaster
        Utils.PersistTemplateValues(SpellCaster, uuid)

        Osi.Transform(SpellCaster, uuid, "6f45d3b8-fa22-4bae-919c-9c2757bff470")
        Utils.FixREALLYTags(SpellCaster, uuid)
        -- Can't clear Genital tag properly :()
        -- Utils.FixGenitalTags(SpellCaster, uuid)

        -- Utils.Debug("CopiedTav: " .. uuid)

        local oldEntity = Ext.Entity.Get(SpellCaster)
        local newEntity = Ext.Entity.Get(uuid)

        for _, entry in ipairs(Constants.Replications) do
            Utils.CloneEntityEntry(oldEntity, newEntity, entry)
        end

        -- Do special work for origins/hirelings
        if (Utils.IsOrigin(SpellCaster) or Utils.IsHireling(SpellCaster)) then
            PersistentVars["OriginCopiedChars"][SpellCaster] = uuid
            -- I'm worried this may cause issues but.... I can't think of any other workaround
            Utils.CloneProxy(oldEntity.ServerCharacter.Character.Template, newEntity.ServerCharacter.Character.Template)
            Utils.ShiftEquipmentVisual(SpellCaster, true)
        else
            -- Clone voice for Tavs
            Utils.CloneEntityEntry(oldEntity, newEntity, "Voice")
        end

        -- Extra replications that we want to only partially copy
        oldEntity.CharacterCreationStats.BodyType = newEntity.CharacterCreationStats.BodyType
        oldEntity.CharacterCreationStats.BodyShape = newEntity.CharacterCreationStats.BodyShape
        oldEntity.CharacterCreationStats.Race = newEntity.CharacterCreationStats.Race
        oldEntity.CharacterCreationStats.SubRace = newEntity.CharacterCreationStats.SubRace
        oldEntity:Replicate("CharacterCreationStats")

        oldEntity.ServerCharacter.Character.BaseVisual = newEntity.ServerCharacter.Character.BaseVisual
        oldEntity:Replicate("ServerCharacter")

        Utils.CopyAppearanceVisuals(SpellCaster)

        -- Remove
        Utils.RemoveCharacter(uuid)

        Osi.MakePlayerActive(SpellCaster)
    end
end)


-- TODO: Allow resetting origin appearance back to original
-- Ext.Osiris.RegisterListener("TimerFinished", 1, "after", function(event)
--     if event == "APPEARANCE_EDIT_ORIGIN_EDIT_FINISHED" then
--         if SaveLoaded and CharacterCreated and not CharacterActivated then
--             CharacterCreated = false

--             Ext.Utils.Print("Origin Edited")
--         end
--     end
-- end)
