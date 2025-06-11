---@diagnostic disable: undefined-global, undefined-field

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
    if (Constants.OriginCharacterCreationAppearances[uuid] and originEntity and (originEntity.EyeColor == Constants.DefaultUUIDs["NullTemplate"] or originEntity.SkinColor == Constants.DefaultUUIDs["NullTemplate"])) then
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

local TempChar

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                          Handlers                                           --
--                                                                                             --
-------------------------------------------------------------------------------------------------

Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", function()
    -- We track this to prevent doing operations on new game
    SaveLoaded = true
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
        elseif name == Constants.CustomSpells["Restore"] then
            if (Utils.IsOrigin(uuid)) then
                local entity = Ext.Entity.Get(uuid)

                entity.CharacterCreationStats.BodyType = Constants["OriginCharacterCreationStats"][uuid].BodyType
                entity.CharacterCreationStats.BodyShape = Constants["OriginCharacterCreationStats"][uuid].BodyShape
                entity.CharacterCreationStats.Race = Constants["OriginCharacterCreationStats"][uuid].Race
                entity.CharacterCreationStats.SubRace = Constants["OriginCharacterCreationStats"][uuid].SubRace
                entity:Replicate("CharacterCreationStats")

                Utils.ShiftEquipmentVisual(uuid, true)
                Osi.RemoveTransforms(uuid)

                Utils.TempClone(entity.CharacterCreationAppearance, Constants.OriginCharacterCreationAppearances[uuid])
                entity:Replicate("CharacterCreationAppearance")

                ModVars = Ext.Vars.GetModVariables(Constants.ModUUID)

                if (ModVars.CantripSpell and ModVars.CantripSpell[uuid] and Osi.HasSpell(SpellCaster, ModVars.CantripSpell[uuid])) then
                    Osi.RemoveSpell(uuid, ModVars.CantripSpell[uuid])
                    ModVars.CantripSpell[uuid] = nil
                    ModVars.CantripSpell = ModVars.CantripSpell
                end

                if (ModVars.OriginCopiedChars and ModVars.OriginCopiedChars[uuid]) then
                    ModVars.OriginCopiedChars[uuid] = nil
                    ModVars.OriginCopiedChars = ModVars.OriginCopiedChars
                end

                if (ModVars.OriginalTemplates and ModVars.OriginalTemplates[Utils.GetGUID(uuid)]) then
                    ModVars.OriginalTemplates[Utils.GetGUID(uuid)] = nil
                    ModVars.OriginalTemplates = ModVars.OriginalTemplates
                end

                if (ModVars.NewTemplateIcon and ModVars.NewTemplateIcon[uuid]) then
                    ModVars.NewTemplateIcon[uuid] = nil
                    ModVars.NewTemplateIcon = ModVars.NewTemplateIcon
                end

                Ext.Vars.SyncModVariables(Constants.ModUUID)

                Osi.OpenMessageBox(uuid, "Remember to use Mirror to fix portrait and save/load to fix racial traits.")

                Utils.Info("Appearance restored of " .. entity.CharacterCreationStats.Name)
            end
        end
    end
end)

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                          Mirror                                             --
--                                                                                             --
-------------------------------------------------------------------------------------------------

-- Enable origins to use the mirror
Ext.Osiris.RegisterListener("TemplateUseFinished", 4, "after", function(uuid, itemroot, item, _)
    if (itemroot == Constants.DefaultUUIDs["MagicMirrorTemplate"] and Osi.IsTagged(uuid, Constants.DefaultUUIDs["FullCeramorphTag"]) == 0) then
        if (Utils.IsOrigin(uuid)) then
            doOriginOperations(uuid)

            Osi.QRY_StartDialog_Fixed(Constants.DefaultUUIDs["MagicMirrorDialogue"], item, uuid)
        end
    end

    ModVars = Ext.Vars.GetModVariables(Constants.ModUUID)

    if (ModVars["NewTemplateIcon"][uuid]) then
        Ext.Entity.Get(uuid).ServerCharacter.Template.Icon = ModVars["NewTemplateIcon"][uuid]
    end
end)

Ext.Osiris.RegisterListener("ChangeAppearanceCancelled", 1, "before", function(uuid)
    Utils.ResetSecretOriginVoice(uuid)
end)

Ext.Osiris.RegisterListener("ChangeAppearanceCompleted", 1, "before", function(uuid)
    if (Utils.IsOrigin) then
        Utils.CopyAppearanceVisuals(uuid)
    end

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

        -- Set CC to false if it's not set to false within 2.5 seconds (should be ample time)
        -- This prevents issues of running our resculpt code on non-resculpt events
        Osi.TimerLaunch("APPEARANCE_EDIT_CREATION_CHECK", 2500)

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

local function doResculptOperations(character)
    if (SaveLoaded and CharacterCreated and SpellCaster) then
        CharacterCreated = false

        -- This prevents errors when starting a new game.
        if (Ext.Entity.Get(character).Origin == nil) then return end

        local playerID = Osi.GetReservedUserID(character)
        local recruiterID = Osi.GetReservedUserID(SpellCaster)

        if (playerID == recruiterID) then
            -- Persist Variables for SpellCaster
            Utils.PersistTemplateValues(SpellCaster, character)

            Osi.Transform(SpellCaster, character, "6f45d3b8-fa22-4bae-919c-9c2757bff470")
            Utils.FixREALLYTags(SpellCaster, character)
            -- Can't clear Genital tag properly :(
            -- Utils.FixGenitalTags(SpellCaster, uuid)

            -- Utils.Debug("CopiedTav: " .. uuid)

            local oldEntity = Ext.Entity.Get(SpellCaster)
            local newEntity = Ext.Entity.Get(character)

            for _, entry in ipairs(Constants.Replications) do
                Utils.CloneEntityEntry(oldEntity, newEntity, entry)
            end

            -- Do special work for origins/hirelings
            if (Utils.IsOrigin(SpellCaster) or Utils.IsHireling(SpellCaster)) then
                ModVars["OriginCopiedChars"][SpellCaster] = character

                -- Dirty variable
                ModVars["OriginCopiedChars"] = ModVars["OriginCopiedChars"]

                -- I'm worried this may cause issues but.... I can't think of any other workaround
                Utils.CloneProxy(oldEntity.ServerCharacter.Template, newEntity.ServerCharacter.Template)
                Utils.ShiftEquipmentVisual(SpellCaster, true)
            else
                -- Clone voice for Tavs
                Utils.CloneEntityEntry(oldEntity, newEntity, "Voice")
            end

            --ModVars["NewTemplateIcon"][SpellCaster] = newEntity.character.Template.Icon

            -- Dirty variable
            --ModVars["NewTemplateIcon"] = ModVars["NewTemplateIcon"]

            -- Extra replications that we want to only partially copy
            oldEntity.CharacterCreationStats.BodyType = newEntity.CharacterCreationStats.BodyType
            oldEntity.CharacterCreationStats.BodyShape = newEntity.CharacterCreationStats.BodyShape
            oldEntity.CharacterCreationStats.Race = newEntity.CharacterCreationStats.Race
            oldEntity.CharacterCreationStats.SubRace = newEntity.CharacterCreationStats.SubRace
            oldEntity:Replicate("CharacterCreationStats")

            oldEntity.Background.Background = newEntity.Background.Background
            oldEntity:Replicate("Background")

            --oldEntity.Character.BaseVisual = newEntity.Character.BaseVisual -- This does nothing rn, this might be the culprit

            Utils.CopyAppearanceVisuals(SpellCaster)

            -- Remove
            Utils.RemoveCharacter(character)

            TempChar = character

            Osi.TimerLaunch("APPEARANCE_EDIT_RESCULPT_FINISHED", 1000)

            Osi.MakePlayerActive(SpellCaster)
        else
            -- Non-recruiting multiplayer clicked on custom origin
            Utils.RemoveCharacter(character)
        end
    end
end

Ext.Osiris.RegisterListener("TimerFinished", 1, "after", function(event)
    if event == "APPEARANCE_EDIT_RESCULPT_FINISHED" then
        if SaveLoaded and SpellCaster and TempChar then
            ModVars = Ext.Vars.GetModVariables(Constants.ModUUID)

            local copiedEntity = Ext.Entity.Get(TempChar)

            -- Clone Racial Cantrip
            for _, s in pairs(copiedEntity.SpellBookPrepares.PreparedSpells) do
                if (s.SourceType == "Progression2") then
                    if (ModVars.CantripSpell[SpellCaster] and Osi.HasSpell(SpellCaster, ModVars.CantripSpell[SpellCaster])) then
                        Osi.RemoveSpell(SpellCaster, ModVars.CantripSpell[SpellCaster])
                    end

                    Osi.AddSpell(SpellCaster, s.OriginatorPrototype)

                    ModVars.CantripSpell[SpellCaster] = s.OriginatorPrototype
                    ModVars.CantripSpell = ModVars.CantripSpell
                end
            end
            TempChar = nil
            SpellCaster = false
        end
    elseif event == "APPEARANCE_EDIT_CREATION_CHECK" then
        CharacterCreated = false
    elseif event == "APPEARANCE_EDIT_RESCULPT_STARTED" then
        doResculptOperations(TempChar)
    end
end)

Ext.Osiris.RegisterListener("CharacterJoinedParty", 1, "after", function(character)
    TempChar = character
    Osi.TimerLaunch("APPEARANCE_EDIT_RESCULPT_STARTED", 1500)
end)
