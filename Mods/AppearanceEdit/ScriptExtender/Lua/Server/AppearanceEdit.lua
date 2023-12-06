---@diagnostic disable: undefined-global

local DBQueries = Ext.Require("Server/DBQueries.lua")
local Tags = Ext.Require("Server/Tags.lua")
local Flags = Ext.Require("Server/Flags.lua")

local function switch(t)
  t.case = function (self,x)
    local f=self[x] or self.default
    if f then
      if type(f)=="function" then
        f(x,self)
      else
        error("case "..tostring(x).." not a function")
      end
    end
  end
  return t
end

-- local function wait(milliseconds) 
--     local start = Ext.Utils.MonotonicTime() 
--     repeat until Ext.Utils.MonotonicTime() > start + milliseconds
-- end

-- Make sure we only run CC functions in active games rather than new games
local SaveLoaded = false

local CharacterCreated = false

local SpellCaster

Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", function ()
    SaveLoaded = true
end)

-- Give players Resculpt spell on sneak
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (guid, name, _, _)
    if name == "SNEAKING" and string.find(guid, GetHostCharacter(), 1, true) then
        AddSpell(guid, "Shout_Open_Creation", 1, 1)
    end
end)

-- Remove Resculpt on sneak end
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function (guid, name, _, _)
    if name == "SNEAKING" and string.find(guid, GetHostCharacter(), 1, true) then
        RemoveSpell(guid, "Shout_Open_Creation", 0)
    end
end)

-- Do Creation Operations
Ext.Osiris.RegisterListener("CharacterCreationFinished", 0, "before", function ()
    if SaveLoaded then
        CharacterCreated = true

        -- Remove Daisies
        for _, entry in pairs(Osi["DB_GLO_DaisyAwaitsAvatar"]:Get(nil, nil)) do
            SetOnStage(entry[1], 0)
            Osi["DB_GLO_DaisyAwaitsAvatar"]:Delete(entry[1], nil)
            Ext.Utils.Print("Daisy Cleaned Up")
        end
    end
end)

-- Open character creation on spell use
Ext.Osiris.RegisterListener("UsingSpell", 5, "after", function (uuid, name, _, _, _, _)
    -- Ext.Utils.Print("UsingSpell", uuid, name)
    if name == 'Shout_Open_Creation' then
        SpellCaster = uuid
        Ext.Utils.Print(SpellCaster .. " casting spell")

        StartCharacterCreation()
        Ext.Utils.Print("Character Creator Shown")
    end
end)

local function DBOperations(uuid, entry)
    local InsertTable = {}
    local MarkedForDeletion = false
    local Modified = false

    for _, dbentry in pairs(entry) do
        if type(dbentry) == "string" then
            local DBEntryIsUUID = string.len(dbentry) == 36

            if (string.find(uuid, dbentry, 1, true)) then
                MarkedForDeletion = true
                return InsertTable, MarkedForDeletion, Modified
            elseif (string.find(SpellCaster, dbentry, 1, true)) then
                Modified = true
                if DBEntryIsUUID then
                    table.insert(InsertTable, string.sub(dbentry, -36))
                else
                    table.insert(InsertTable, uuid)
                end
            else
                table.insert(InsertTable, dbentry)
            end
        else
            table.insert(InsertTable, dbentry)
        end
    end
    
    return InsertTable, MarkedForDeletion, Modified
end

local function DBCleanOperations(uuid, entry)
    local MarkedForDelete = false
    for _, dbEntry in pairs(entry) do
        if type(dbEntry) == "string" then
            if (string.find(uuid, dbEntry, 1, true)) then
                MarkedForDelete = true
                return MarkedForDelete
            end
        end
    end
    return MarkedForDelete
end

local TimerActive
local Faction

Ext.Osiris.RegisterListener("ObjectTimerFinished", 2, "after", function (uuid, name)
    if name == "APPEARANCE_EDIT_CLEAR_FLAGGED_ITEMS" then
        TimerActive = false

        CharacterMoveTo(uuid, SpellCaster, "", "", 1)
        MoveAllItemsTo(SpellCaster, uuid, 1, 1, 1, 1)
        CopyCharacterEquipment(SpellCaster, uuid)
        MoveAllStoryItemsTo(SpellCaster, uuid, 1, 1)

        if GetFlag("f4d2be66-0443-4069-8ca2-570143f17e27", SpellCaster) == 1 then
            Osi.PROC_GLO_InfernalBox_SetPlayerOwner(uuid)
            Osi.PROC_GLO_InfernalBox_MoveBoxToCharacter(uuid)
        end
        
        ClearFlag("GEN_MaxPlayerCountReached_823b5064-8aa4-c0b7-1b8c-657b46987ccd")
        MakeNPC(SpellCaster)
        SetOnStage(SpellCaster, 0)
        Osi.PROC_RemoveAllPolymorphs(SpellCaster)
        Osi.PROC_RemoveAllDialogEntriesForSpeaker(SpellCaster)

        for _, entry in ipairs(Osi["DB_ApprovalRating"]:Get(nil, nil, nil)) do
            local InsertTable = {}
            local MarkedForDeletion = false
            local Modified = false

            InsertTable, MarkedForDeletion, Modified = DBOperations(uuid, entry)

            if MarkedForDeletion then
                Osi["DB_ApprovalRating"]:Delete(table.unpack(entry))
            elseif Modified then
                Osi["DB_ApprovalRating"](table.unpack(InsertTable))
                -- ChangeApprovalRating(InsertTable[1], uuid, 0, InsertTable[3])
                -- Ext.Utils.Print("Changing Approval Rating: ", InsertTable[1], uuid, InsertTable[3])
            end
        end

        SetFaction(uuid, Faction)
        if GetTadpolePowersCount(SpellCaster) > 0 then
            SetTadpoleTreeState(uuid, 2)
            AddTadpole(uuid, GetTadpolePowersCount(SpellCaster))
        end

        OpenMessageBox(uuid, "Appearance editing complete, enjoy. Your Tadpole powers were reset, sorry :(")
    end
end)

-- Run replacement commands only when custom character is created
Ext.Osiris.RegisterListener("Activated", 1, "before", function (uuid)
    if SaveLoaded and CharacterCreated and not (string.find(uuid, "S_", 1, true) == 1) then
        CharacterCreated = false

        Ext.Utils.Print(tostring(uuid))

        local DarkUrgeTag = 'fe825e69-1569-471f-9b3f-28fd3b929683'
        local GenericTag = '730e82f3-c067-44a4-985b-0dfe079d4fea'
        local CleanUp = false

        if ((string.find(SpellCaster, "S_", 1, true) == 1) or not (IsTagged(SpellCaster, DarkUrgeTag) == IsTagged(uuid, DarkUrgeTag) and IsTagged(SpellCaster, GenericTag) == IsTagged(uuid, GenericTag))) then
            -- Spellcaster is an origin character or Player created a dark urge character when they weren't or a generic character when they were
            Ext.Utils.Print("Spellcaster origin is not the same as new character origin, cleaning up new character")
            -- Mark for Cleanup
            CleanUp = true
        else
            OpenMessageBox(uuid, "Appearance editing begun. Please wait for it to finish, you will receive another message.")
        end
        
        Faction = GetFaction(SpellCaster)

        if not CleanUp then
            -- Do transfer operations
            SetFaction(uuid, Faction)

            -- Fix up statuses/spells that weren't auto-added
            local FixerSwitch = switch {
                ["def281a4-3806-b279-8bda-87fcb283ff79"] = function ()
                    if HasActiveStatus(SpellCaster, "COL_GITHZERAI_MIND_TECHNIQUE") == 1 and HasActiveStatus(uuid, "COL_GITHZERAI_MIND_TECHNIQUE") == 0 then
                        ApplyStatus(uuid, "COL_GITHZERAI_MIND_TECHNIQUE", -1, 0, uuid)
                    end
                end,
                ["14aec5bc-1013-4845-96ca-20722c5219e3"] = function ()
                    if HasSpell(SpellCaster, "Shout_DarkUrge_Slayer") == 1 then
                        AddSpell(uuid, "Shout_DarkUrge_Slayer", 1, 1)
                    end
                end,
                ["79067d89-0cb1-47cf-a746-cc265948b527"] = function ()
                    if HasActiveStatus(SpellCaster, "CURSEDTOME_THARCHIATE_TECHNICAL") == 1 and HasActiveStatus(uuid, "CURSEDTOME_THARCHIATE_TECHNICAL") == 0 then
                        ApplyStatus(uuid, "CURSEDTOME_THARCHIATE_TECHNICAL", 100, -1)
                        ApplyStatus(uuid, "CURSEDTOME_THARCHIATE_FALSE_LIFE", 100, -1)
                    end
                end,
                ["32fe3265-f672-4846-9b56-7400f66c899f"] = function ()
                    if HasSpell(SpellCaster, "Target_GLO_DangerousBook_SpeakWd") == 1 and HasSpell(uuid, "Target_GLO_DangerousBook_SpeakWd") == 0 then
                        AddSpell(uuid, "Target_GLO_DangerousBook_SpeakWd", 1, 1)
                    end
                end,
                ["4e24982b-24d2-7107-a817-caa317dffd26"] = function ()
                    if HasActiveStatus(SpellCaster, "CAMP_VOLO_ERSATZEYE") == 1 and HasActiveStatus(uuid, "CAMP_VOLO_ERSATZEYE") == 0 then
                        ApplyStatus(uuid, "CAMP_VOLO_ERSATZEYE", -1, 0, uuid)
                    end
                end,
            }

            for _, entry in pairs(Flags) do
                if GetFlag(entry, SpellCaster) == 1 and GetFlag(entry, uuid) == 0 then
                    SetFlag(entry, uuid, 0, 1)

                    FixerSwitch:case(entry)
                elseif GetFlag(entry, "NULL_00000000-0000-0000-0000-000000000000") == 1 then
                    FixerSwitch:case(entry)
                end
            end

            for _, entry in pairs(Tags) do
                if IsTagged(SpellCaster, entry) == 1 and IsTagged(uuid, entry) == 0 then
                    -- Ext.Utils.Print(tostring(entry))
                    SetTag(uuid, entry)
                end
            end
        end

        for key, query in pairs(DBQueries) do
            local t = {}
            for v in query:gmatch("[^(]+") do
                table.insert(t, v)
            end
            local QueryShort = t[1]
            local ParamCount = select(2, string.gsub(t[2], ",", "")) + 1
            
            for _, entry in ipairs(Osi[QueryShort]:Get(table.unpack({}, 1, ParamCount))) do
                if not (QueryShort == "DB_ApprovalRating") and not (QueryShort == "DB_ClassDeityTags_For") then
                    local InsertTable = {}
                    local MarkedForDeletion = false
                    local Modified = false
                    
                    if CleanUp then
                        MarkedForDeletion = DBCleanOperations(uuid, entry)
                    else
                        InsertTable, MarkedForDeletion, Modified = DBOperations(uuid, entry)
                    end

                    if MarkedForDeletion then
                        Osi[QueryShort]:Delete(table.unpack(entry))
                    elseif Modified then
                        Osi[QueryShort](table.unpack(InsertTable))
                        Osi[QueryShort]:Delete(table.unpack(entry))
                    end
                end
            end

            if key == #DBQueries and not CleanUp then
                ObjectTimerLaunch(uuid, "APPEARANCE_EDIT_CLEAR_FLAGGED_ITEMS", 5000, 1)
                TimerActive = true
            end
        end

        -- Remove improper character
        if CleanUp then
            MakeNPC(uuid)
            SetOnStage(uuid, 0)
            return
        end
    end
end)

Ext.Osiris.RegisterListener("AddedTo", 3, "after", function (entity, char, _)
    if TimerActive and not (string.find(entity, "Underwear", 1, true)) and not (string.find(entity, "ARM", 1, true)) and not (string.find(entity, "WPN", 1, true)) then
        RequestDelete(entity)
    end
end)

-- It's testing time as I test all over the code
