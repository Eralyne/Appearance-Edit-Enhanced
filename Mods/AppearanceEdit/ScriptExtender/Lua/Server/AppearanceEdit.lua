---@diagnostic disable: undefined-global

-- Maybe dump these instead??
local DBQueries = Ext.Require("Server/DBQueries.lua")
local Tags = Ext.Require("Server/Tags.lua")
local Flags = Ext.Require("Server/Flags.lua")

-- DB_GLO_Backgrounds_Players -- DOUBLE PORTRAITS ISSUE IS HERE, maybe

local LevelSwapFix = {
    {"ReadyCheck_ToCrecheFromGoblinCamp", "S_CRE_TeleportPosAtCrecheFromGoblinCamp_79806ca5-8fc5-4fa1-9af9-0f0a0a5c840c", "", "ReadyCheck_RegionSwap_CanReturn", 5, "ReadyCheck_RegionSwap_CanReturn_LowLevel", "CRE_Main_A"},
    {"ReadyCheck_ToCrecheFromPlains", "StartPoint_000__000_fff434fb-523d-4975-9cfa-783d22471ee9", "", "ReadyCheck_RegionSwap_CanReturn", 5, "ReadyCheck_RegionSwap_CanReturn_LowLevel", "CRE_Main_A"},
    {"ReadyCheck_ToGoblinCampFromCreche", "S_GOB_TeleportPosFromCrecheAtGoblinCamp_974c1134-7d76-4a7d-8a41-ebc27a1d0f82", "", "GLO_Waypoint_Regionswap", 1, "GLO_Waypoint_Regionswap", "WLD_Main_A"},
    {"ReadyCheck_ToPlainsFromCreche", "S_PLA_TeleportPosFromCrecheAtPlains_899000d7-238f-4a53-8350-190371bc7559", "", "GLO_Waypoint_Regionswap", 1, "GLO_Waypoint_Regionswap", "WLD_Main_A"},
    {"ReadyCheck_ToSCLFromUnderdark", "StartPoint_000_f968a8d3-b06d-4fc2-acf1-1e650e35e52d", "", "ReadyCheck_RegionSwap_CanReturn", 5, "ReadyCheck_RegionSwap_CanReturn_LowLevel", "SCL_Main_A"},
    {"ReadyCheck_ToBGFromSCL", "S_INT_ActTeleport_c9aa7107-72d5-46d4-893d-32fe41506bf0", "INT_SCK_Event_Arrived", "ReadyCheck_RegionSwap", 8, "ReadyCheck_RegionSwap_LowLevel", "INT_Main_A"},
    {"ReadyCheck_ToSCL02FromCRE", "S_SCL_EntryPoint_Mountain_ab897d27-78e4-42e8-a545-ee7815238f63", "", "ReadyCheck_RegionSwap_CanReturn", 5, "ReadyCheck_RegionSwap_CanReturn_LowLevel", "SCL_Main_A"},
    {"ReadyCheck_ToCREFromSCL02", "S_CRE_EntrypointFromSCL02_89aeb68c-dc9f-4ddd-b22d-6ecf7d876697", "", "GLO_Waypoint_Regionswap", 1, "GLO_Waypoint_Regionswap", "CRE_Main_A"},
    {"ReadyCheck_ToWLDFromSCL", "S_UND_Elevator_Fort_FromShadowlands_1c90d950-0e17-42b6-91ba-4fddeb8df5bf", "", "GLO_Waypoint_Regionswap", 1, "GLO_Waypoint_Regionswap", "WLD_Main_A"},
    {"ReadyCheck_ToLOWFromWYR", "S_Teleport_CTY_Entrance_001_f6e0b1f4-7bec-4655-84c8-72b032e199ce", "", "GLO_Waypoint_Regionswap", 10, "GLO_Waypoint_Regionswap", "CTY_Main_A"},
    {"ReadyCheck_ToWYRFromLOW", "S_WYR_NorthBridgeTeleportPos_270ad218-2c6a-4ebc-a94f-56edd76305d3", "", "GLO_Waypoint_Regionswap", 1, "GLO_Waypoint_Regionswap", "BGO_Main_A"},
}

local HagHairs = {
    "HAG_HAIR_STR",
    "HAG_HAIR_DEX",
    "HAG_HAIR_CON",
    "HAG_HAIR_INT",
    "HAG_HAIR_WIS",
    "HAG_HAIR_CHA"
}

local SharMirrorStats = {
    "LOW_SharGrotto_Mirror_StrengthBoon_Passive",
    "LOW_SharGrotto_Mirror_DexterityBoon_Passive",
    "LOW_SharGrotto_Mirror_ConstitutionBoon_Passive",
    "LOW_SharGrotto_Mirror_IntelligenceBoon_Passive",
    "LOW_SharGrotto_Mirror_WisdomBoon_Passive",
    "LOW_SharGrotto_Mirror_CharismaBoon_Passive",
    "LOW_SharGrotto_Mirror_MinorCharismaBoon_Passive"
}

----------------------
-- Helper functions --
----------------------

local function equals(o1, o2, ignore_mt)
    if o1 == o2 then return true end
    local o1Type = type(o1)
    local o2Type = type(o2)
    if o1Type ~= o2Type then return false end
    if o1Type ~= 'table' then return false end

    if not ignore_mt then
        local mt1 = getmetatable(o1)
        if mt1 and mt1.__eq then
            --compare using built in method
            return o1 == o2
        end
    end

    local keySet = {}

    for key1, value1 in pairs(o1) do
        local value2 = o2[key1]
        if value2 == nil or equals(value1, value2, ignore_mt) == false then
            return false
        end
        keySet[key1] = true
    end

    for key2, _ in pairs(o2) do
        if not keySet[key2] then return false end
    end
    return true
end

local function size(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

local function utils_set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

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

local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

-- local function wait(milliseconds) 
--     local start = Ext.Utils.MonotonicTime() 
--     repeat until Ext.Utils.MonotonicTime() > start + milliseconds
-- end

----------------------
----------------------

local DBQuerySize = size(DBQueries)

-- Make sure we only run CC functions in active games rather than new games
local SaveLoaded = false

local CharacterCreated = false

local SpellCaster

local NewTav

local Faction

-- local GlobalFlags = {}

local CharacterOrigins = utils_set({
    "S_Player_Karlach_2c76687d-93a2-477b-8b18-8a14b549304c",
    "S_Player_Minsc_0de603c5-42e2-4811-9dad-f652de080eba",
    "S_GOB_DrowCommander_25721313-0c15-4935-8176-9f134385451b",
    "S_GLO_Halsin_7628bc0e-52b8-42a7-856a-13a6fd413323",
    "S_Player_Jaheira_91b6b200-7d00-4d62-8dc9-99e8339dfa1a",
    "S_Player_Gale_ad9af97d-75da-406a-ae13-7071c563f604",
    "S_Player_Astarion_c7c13742-bacd-460a-8f65-f864fe41f255",
    "S_Player_Laezel_58a69333-40bf-8358-1d17-fff240d7fb12",
    "S_Player_Wyll_c774d764-4a17-48dc-b470-32ace9ce447d",
    "S_Player_ShadowHeart_3ed74f06-3c60-42dc-83f6-f034cb47c679"
})

-- DBs to ignore resetting when creating characters
local IgnoreDBs = utils_set({
    -- "DB_GlobalFlag",
    -- "DB_QRYRTN_CRIME_GetValidCrimeID",
    -- "DB_InternScene_CrimeActive",
    "DB_GLO_PartyMembers_Kicked",
    "DB_GLO_Tutorials_EndTheDay_DepletedShortRestResourceOrSpell",
    "DB_GLO_Playable",
    "DB_MOO_KitchenFight_QtrMasterDisrupter",
    "DB_Tadpole_CanUseDaisyPersuasion_Cached",
    "DB_CustomUseItemResponse",
    "DB_SCL_Drider_EscortedPlayer",
    "DB_OriginInPartyGlobal",
    -- "DB_ORI_DebugBook_StartBrainquakeOnDebugClose",
    -- "DB_QRYRTN_WYR_Brainquakes_SelectedChainedEvent",
    -- "DB_WYR_Brainquakes_BlockedEventTrigger",
    -- "DB_WYR_Brainquakes_ChainedEventTriggers",
    -- "DB_WYR_Brainquakes_ChainedEvents",
    -- "DB_WYR_Brainquakes_RunningEvent_Trigger",
    -- "DB_WYR_Brainquakes_User_DoneAllChainedEvents",
    -- "DB_WYR_Brainquakes_User_LastPlayedChainedEvent",
    -- "DB_END_HighHallInterior_BrainquakeActive",
    -- "DB_END_HighHallInterior_BrainquakePoints",
    -- "DB_END_HighHallInterior_BrainquakeSlowedTargets",
    -- "DB_END_MorphicPool_BrainQuakeStunTime",
    -- "DB_END_MorphicPool_BrainquakeSlowTimerFinished",
    -- "DB_END_MorphicPool_BrainquakeStunTimerFinished",
    -- "DB_END_MorphicPool_BrainquakeTarget",
    -- "DB_END_MorphicPool_BrainquakeTriggers",
    -- "DB_LOW_Brainquakes",
    -- "DB_GLO_Brainquakes_Directional_Difficult",
    -- "DB_GLO_Brainquakes_Directional_Difficult_Internal",
    -- "DB_GLO_Brainquakes_Directional_SlowTime",
    -- "DB_GLO_Brainquakes_Directional_StunTime",
    -- "DB_GLO_Brainquakes_Directional_Timer",
    -- "DB_GLO_Brainquakes_Directional_TimerSlow",
    -- "DB_GLO_Brainquakes_Directional_TimerStun",
    -- "DB_GLO_Brainquakes_Directional_Triggers",
    -- "DB_GLO_Brainquakes_EndCodes",
    -- "DB_GLO_Brainquakes_EventsData",
    -- "DB_GLO_Brainquakes_RunningEvent_AwaitingVBCompletion",
    -- "DB_GLO_Brainquakes_RunningEvent_Current",
    -- "DB_GLO_Brainquakes_RunningEvent_Users",
    -- "DB_GLO_Brainquakes_SlowZone",
    -- "DB_GLO_Brainquakes_User_DoneEvent",
    "DB_GLO_Backgrounds_Tags",
    "DB_StartedDialog",
    "DB_OffStage",
    "DB_Origins_SelfHealing_Disabled",
    "DB_CharacterCrimeEnabled",
    "DB_CharacterCrimeDisabled",
    "DB_Sees",
    "DB_NOOP",
    "DB_WasInRegion",
    "DB_DialogEnding",
    "DB_InRegion",
    "DB_DialogNPCs",
    "DB_DialogNumPlayers",
    "DB_AutomatedDialog",
    "DB_DialogNumNPCs",
    "DB_DialogName",
    "DB_HiddenCharacters",
    "DB_GLO_Tutorials_TrackedTimers",
    "DB_CRIME_Casting",
    "DB_PlayLoopEffectHandleResult",
    "DB_LoopEffect",
    "DB_COL_Vault_ChangedNodes",
    "DB_Debug_ORI_CampNight",
    "DB_DialogSpeakers",
    "DB_ClassDeityTags_For",
    "DB_CantMove"
})

local TestDBs = utils_set({
    "DB_GLO_Playable",
    "DB_MOO_KitchenFight_QtrMasterDisrupter",
    "DB_Tadpole_CanUseDaisyPersuasion_Cached",
    "DB_CustomUseItemResponse",
    "DB_SCL_Drider_EscortedPlayer",
    "DB_OriginInPartyGlobal",
})

local SavedDBs = {}

local function DBOperations(uuid, entry)
    local InsertTable = {}
    local MarkedForDeletion = false
    local Modified = false

    for _, dbentry in pairs(entry) do
        if type(dbentry) == "string" then
            local DBEntryIsUUID = string.len(dbentry) == 36

            if (string.len(dbentry) >= 36 and string.find(uuid, string.sub(dbentry, -36), 1, true)) then
                MarkedForDeletion = true
                return InsertTable, MarkedForDeletion, Modified
            elseif (string.len(dbentry) >= 36 and string.find(SpellCaster, string.sub(dbentry, -36), 1, true)) then
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
    for _, dbentry in pairs(entry) do
        if type(dbentry) == "string" then
            if (string.len(dbentry) >= 36 and string.find(uuid, string.sub(dbentry, -36), 1, true)) then
                MarkedForDelete = true
                return MarkedForDelete
            end
        end
    end
    return MarkedForDelete
end

local function RepairChangedDbs()
    for query, item in pairs(SavedDBs) do
        -- Ext.Utils.Print("Repairing DB: ", query)
        local t = {}
        for v in query:gmatch("[^(]+") do
            table.insert(t, v)
        end

        local QueryShort = t[1]
        local ParamCount = select(2, string.gsub(t[2], ",", "")) + 1

        local DBTables = {}

        for _, entry in ipairs(Osi[QueryShort]:Get(table.unpack({}, 1, ParamCount))) do
            table.insert(DBTables, entry)
        end

        local tbEquals = equals(item, DBTables, false)

        -- Ext.Utils.Print(query, " equals is ", tbEquals)

        if (not tbEquals) or string.find(QueryShort, "DB_Quest", 1, true) then
            for _, entry in ipairs(DBTables) do
                -- Ext.Utils.Print("Deleting: ", dump(entry))
                Osi[QueryShort](table.unpack(entry))
            end
            -- Ext.Utils.Print(query, " is being re-inserted", dump())
            for _, entry in ipairs(item) do
                -- Ext.Utils.Print("Reinserting: ", dump(entry))
                
                Osi[QueryShort](table.unpack(entry))
            end
        end

        -- Cleans SavedDB
        SavedDBs[query] = nil
    end
end

Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", function ()
    SaveLoaded = true

    local DBLocations = Osi["DB_GLO_LevelSwap_Location"]:Get(nil, nil, nil, nil, nil, nil, nil)
    local DBLocationsSize = size(DBLocations)

    -- Fix travel issues
    if (DBLocationsSize < size(LevelSwapFix)) then
        for _, entry in pairs(LevelSwapFix) do
            Osi["DB_GLO_LevelSwap_Location"](table.unpack(entry))
        end
        Ext.Utils.Print("LevelSwap Locations repaired")
    end
end)

-- Give players Resculpt spell on sneak
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (guid, name, _, _)
    if name == "SNEAKING" and string.find(guid, GetHostCharacter(), 1, true) then
        AddSpell(guid, "Shout_Open_Creation", 1, 1)

        -- Do some retroactive fixes here :)
        -- We get all the players in the game
        local Players = {}

        for _, entry in pairs(Osi["DB_Players"]:Get(nil)) do
            table.insert(Players, entry[1])
        end

        Players = utils_set(Players)

        local RemovedPlayers = {}

        for _, entry in pairs(Osi["DB_GLO_PartyMembers_Kicked"]:Get(nil)) do
            table.insert(RemovedPlayers, entry[1])
        end

        RemovedPlayers = utils_set(RemovedPlayers)

        for _, entry in pairs(Osi["DB_ApprovalRating"]:Get(nil, nil, nil)) do
            if (not Players[entry[2]] and not CharacterOrigins[entry[2]]) then
                -- Kill all the left over characters
                if (not RemovedPlayers[entry[2]]) then
                    SetImmortal(entry[2], 0)
                    Die(entry[2], 0, "NULL_00000000-0000-0000-0000-000000000000", 0, 0)
                    Osi["DB_GLO_PartyMembers_Kicked"](entry[2])
                    Ext.Utils.Print("Brutally murdering ", entry[2])
                    table.insert(RemovedPlayers, entry[2])
                    RemovedPlayers = utils_set(RemovedPlayers)
                end

                -- Clear left over approval ratings
                Osi["DB_ApprovalRating"]:Delete(table.unpack(entry))
            end 
        end
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
            Osi["DB_GLO_DaisyAwaitsAvatar"]:Delete(table.unpack(entry))
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

        -- for _, entry in pairs(Flags) do
        --     local FlagValue = GetFlag(entry, "NULL_00000000-0000-0000-0000-000000000000")
        --     GlobalFlags[entry] = FlagValue
        -- end

        for _, query in pairs(DBQueries) do
            -- Reset the SavedDB query before adding
            SavedDBs[query] = nil

            local t = {}
            for v in query:gmatch("[^(]+") do
                table.insert(t, v)
            end

            local QueryShort = t[1]
            local ParamCount = select(2, string.gsub(t[2], ",", "")) + 1

            if not IgnoreDBs[QueryShort] then
                local UUIDIncluded = false
                for _, entry in ipairs(Osi[QueryShort]:Get(table.unpack({}, 1, ParamCount))) do
                    if not UUIDIncluded then
                        UUIDIncluded = DBCleanOperations(uuid, entry)

                        if not UUIDIncluded then
                            if not SavedDBs[query] then
                                SavedDBs[query] = {}
                            end

                            table.insert(SavedDBs[query], entry)
                        end
                    else
                        SavedDBs[query] = nil
                    end
                end
            end
        end

        StartCharacterCreation()
        Ext.Utils.Print("Character Creator Shown")
    end
end)

Ext.Osiris.RegisterListener("EntityEvent", 2, "after", function (entity, event)
    if event == "APPEARANCE_EDIT_IterateInventory" then
        SetOwner(entity, NewTav)
    elseif event == "APPEARANCE_EDIT_IterateInventory_Done" then
        MoveAllItemsTo(SpellCaster, NewTav, 1, 1, 1, 1)
        CopyCharacterEquipment(SpellCaster, NewTav)
        if GetFlag("f4d2be66-0443-4069-8ca2-570143f17e27", SpellCaster) == 1 then
            Osi.PROC_GLO_InfernalBox_SetPlayerOwner(NewTav)
            Osi.PROC_GLO_InfernalBox_MoveBoxToCharacter(NewTav)
        end

        if GetTadpolePowersCount(SpellCaster) > 0 then
            SetTadpoleTreeState(NewTav, 2)
            AddTadpole(NewTav, GetTadpolePowersCount(SpellCaster))
        end

        MakeNPC(SpellCaster)
        SetOnStage(SpellCaster, 0)
        Osi.PROC_RemoveAllPolymorphs(SpellCaster)
        SetImmortal(SpellCaster, 0)
        Die(SpellCaster, 0, "NULL_00000000-0000-0000-0000-000000000000", 0, 0)
        Osi["DB_GLO_PartyMembers_Kicked"](SpellCaster)
    end
end)

Ext.Osiris.RegisterListener("ObjectTimerFinished", 2, "after", function (uuid, name)
    if name == "APPEARANCE_EDIT_CLEAR_FLAGGED_ITEMS" then
        -- TimerActive = false 
        CharacterMoveTo(uuid, SpellCaster, "", "", 1)

        IterateInventory(SpellCaster, "APPEARANCE_EDIT_IterateInventory", "APPEARANCE_EDIT_IterateInventory_Done")

        for _, entry in ipairs(Osi["DB_ApprovalRating"]:Get(nil, nil, nil)) do
            local InsertTable = {}
            local Modified = false

            InsertTable, _, Modified = DBOperations(uuid, entry)

            if Modified then
                Osi["DB_ApprovalRating"](table.unpack(InsertTable))
                ChangeApprovalRating(InsertTable[1], uuid, 0, InsertTable[3])
                -- Ext.Utils.Print("Changing Approval Rating: ", InsertTable[1], uuid, InsertTable[3])
            end
        end

        SetFaction(uuid, Faction)

        RepairChangedDbs()

        -- local DarkUrgeTag = 'fe825e69-1569-471f-9b3f-28fd3b929683'

        -- -- Try to fix Dark Urge, again
        -- if IsTagged(uuid, DarkUrgeTag) == 1 and IsTagged(SpellCaster, DarkUrgeTag) == 1 then
        --     for _, entry in ipairs(Osi["DB_ORI_DarkUrge"]:Get(nil)) do
        --         Osi["DB_ORI_DarkUrge"]:Delete(entry[1])
        --     end
        --     Osi["DB_ORI_DarkUrge"](uuid)
        -- end

        -- Remove Spellcaster from Inspiration Table
        -- for _, entry in ipairs(Osi["DB_GLO_Backgrounds_Players"]:Get(SpellCaster, nil)) do
        --     Osi["DB_GLO_Backgrounds_Players"]:Delete(table.unpack(entry))
        -- end

        OpenMessageBox(uuid, "Appearance editing complete, enjoy.")

        CharacterEnableAllCrimes(uuid)
        -- Cleanup
        -- NewTav = nil
        -- SpellCaster = nil
    end
end)

-- Run replacement commands only when custom character is created
Ext.Osiris.RegisterListener("Activated", 1, "before", function (uuid)
    if SaveLoaded and CharacterCreated and not (string.find(uuid, "S_", 1, true) == 1) then
        CharacterCreated = false
        Ext.Utils.Print(tostring(uuid))
        CharacterDisableAllCrimes(uuid)

        local DarkUrgeTag = 'fe825e69-1569-471f-9b3f-28fd3b929683'
        local GenericTag = '730e82f3-c067-44a4-985b-0dfe079d4fea'
        local CleanUp = false

        if ((string.find(SpellCaster, "S_", 1, true) == 1) or not (IsTagged(SpellCaster, DarkUrgeTag) == IsTagged(uuid, DarkUrgeTag) and IsTagged(SpellCaster, GenericTag) == IsTagged(uuid, GenericTag))) then
            -- Spellcaster is an origin character or Player created a dark urge character when they weren't or a generic character when they were
            -- Ext.Utils.Print("Spellcaster origin is not the same as new character origin, cleaning up new character")
            OpenMessageBox(SpellCaster, "Spellcaster origin is not the same as new character origin. If you had an extra character appear that won't go away, please reload your save. Otherwise, ignore this message.")

            return
            -- Mark for Cleanup
            -- CleanUp = true
        else
            OpenMessageBox(uuid, "Appearance editing begun. Please wait for it to finish, you will receive another message.")
        end

        Faction = GetFaction(SpellCaster)

        if not CleanUp then
            NewTav = uuid
            -- Do transfer operations
            SetFaction(uuid, Faction)
            CharacterMoveTo(uuid, SpellCaster, "", "", 1)

            -- Fix up statuses/spells that weren't auto-added
            local FixerSwitch = switch {
                ["def281a4-3806-b279-8bda-87fcb283ff79"] = function ()
                    if HasActiveStatus(SpellCaster, "COL_GITHZERAI_MIND_TECHNIQUE") == 1 and HasActiveStatus(uuid, "COL_GITHZERAI_MIND_TECHNIQUE") == 0 then
                        ApplyStatus(uuid, "COL_GITHZERAI_MIND_TECHNIQUE", -1, 0, uuid)
                    end
                end,
                ["14aec5bc-1013-4845-96ca-20722c5219e3"] = function ()
                    if HasSpell(SpellCaster, "Shout_DarkUrge_Slayer") == 1 and HasSpell(uuid, "Shout_DarkUrge_Slayer") == 0 then
                        AddSpell(uuid, "Shout_DarkUrge_Slayer", 1, 1)
                    end
                end,
                ["79067d89-0cb1-47cf-a746-cc265948b527"] = function ()
                    if HasPassive(SpellCaster, "CursedTome_FalseLife") == 1 and HasPassive(uuid, "CursedTome_FalseLife") == 0 then
                        AddPassive(uuid, "CursedTome_FalseLife")
                    end
                end,
                ["4e24982b-24d2-7107-a817-caa317dffd26"] = function ()
                    if HasActiveStatus(SpellCaster, "CAMP_VOLO_ERSATZEYE") == 1 and HasActiveStatus(uuid, "CAMP_VOLO_ERSATZEYE") == 0 then
                        ApplyStatus(uuid, "CAMP_VOLO_ERSATZEYE", -1, 0, uuid)
                    end
                end,
                -- ["d1de279e-be63-9787-474a-c001fc38dc24"] = function ()
                --     if HasActiveStatus(SpellCaster, "GLO_PIXIESHIELD") == 1 and HasActiveStatus(SpellCaster, "GLO_PIXIESHIELD") == 0 then
                --         ApplyStatus(uuid, "GLO_PIXIESHIELD", -1, 0, uuid)
                --     end
                -- end,
                ["365dbc98-808e-4c11-90df-fdc92e30720f"] = function ()
                    if HasSpell(SpellCaster, "Target_SurvivalInstinct") == 1 and HasSpell(uuid, "Target_SurvivalInstinct") == 0  then
                        AddSpell(uuid, "Target_SurvivalInstinct", 1, 1)
                    end
                end
            }

            for _, entry in pairs(Flags) do
                if GetFlag(entry, SpellCaster) == 1 and GetFlag(entry, uuid) == 0 then
                    SetFlag(entry, uuid, 0, 1)

                    FixerSwitch:case(entry)
                elseif GetFlag(entry, SpellCaster) == 0 and GetFlag(entry, uuid) == 1 then
                    SetFlag(entry, uuid, 0, 0)

                    FixerSwitch:case(entry)
                else
                    local GlobalFlag = GetFlag(entry, "NULL_00000000-0000-0000-0000-000000000000")

                    if GlobalFlag == 1 then
                        FixerSwitch:case(entry)
                    end

                    -- if not (GlobalFlags[entry] == GlobalFlag) then
                    --     -- Ext.Utils.Print(GlobalFlags[entry], GlobalFlag)
                    --     SetFlag(entry, "NULL_00000000-0000-0000-0000-000000000000", 0, GlobalFlags[entry])
                    -- end
                end
            end

            for _, entry in pairs(Tags) do
                if IsTagged(SpellCaster, entry) == 1 and IsTagged(uuid, entry) == 0 then
                    -- Ext.Utils.Print(tostring(entry))
                    SetTag(uuid, entry)

                    -- Add Necromancy of Thay Speak With Dead
                    if (entry == "673cb6af-f12b-4d6e-faab-b81bf43c44ce") or (entry == "673cb6af-f12b-4d6e-abfa-1bb83cf4ce44") then
                        if HasSpell(SpellCaster, "Target_GLO_DangerousBook_SpeakWd") == 1 and HasSpell(uuid, "Target_GLO_DangerousBook_SpeakWd") == 0 then
                            AddSpell(uuid, "Target_GLO_DangerousBook_SpeakWd", 1, 1)
                        end
                    end
                end
            end

            -- Fix non-flagged passives (we need to do this better, try looking through every passive and ignore class/equipment ones?)
            for _, entry in pairs(HagHairs) do
                if HasActiveStatus(SpellCaster, entry) == 1 and HasActiveStatus(uuid, entry) == 0 then
                    ApplyStatus(uuid, entry, -1, 0, uuid)
                end
            end

            for _, entry in pairs(SharMirrorStats) do
                if HasPassive(SpellCaster, entry) == 1 and HasPassive(uuid, entry) == 0 then
                    AddPassive(uuid, entry)
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
                    -- Ext.Utils.Print("Doing work on: ", QueryShort, dump(entry))
                    local InsertTable = {}
                    local MarkedForDeletion = false
                    local Modified = false

                    if CleanUp then
                        MarkedForDeletion = DBCleanOperations(uuid, entry)
                    else
                        InsertTable, MarkedForDeletion, Modified = DBOperations(uuid, entry)
                    end

                    if MarkedForDeletion then
                        -- Ext.Utils.Print("Deleting New: ", dump(InsertTable))
                        Osi[QueryShort]:Delete(table.unpack(entry))
                    elseif Modified then
                        -- Ext.Utils.Print("Deleting OG: ", dump(entry))
                        Osi[QueryShort]:Delete(table.unpack(entry))
                        -- Ext.Utils.Print("Inserting New: ", dump(InsertTable))
                        Osi[QueryShort](table.unpack(InsertTable))
                    end
                end
            end

            if key == DBQuerySize and not CleanUp then
                ObjectTimerLaunch(uuid, "APPEARANCE_EDIT_CLEAR_FLAGGED_ITEMS", 5000, 1)
            end
        end



        -- -- Remove improper character
        -- if CleanUp then
        --     MakeNPC(uuid)
        --     SetOnStage(uuid, 0)
        --     RepairChangedDbs()
        --     MakePlayerActive(SpellCaster)
        --     return
        -- end
    end
end)

-- It's testing time as I test all over the code

-- Ext.Osiris.RegisterListener("UsingSpell", 5, "after", function (uuid, name, _, _, _, _)
--     Ext.Utils.Print("using spell", uuid, name)
-- end)

-- Ext.Osiris.RegisterListener("AddedTo", 3, "after", function (entity, char, _)
--     if TimerActive and not (string.find(entity, "Underwear", 1, true)) and not (string.find(entity, "ARM", 1, true)) and not (string.find(entity, "WPN", 1, true)) then
--         RequestDelete(entity)
--     end
-- end)


-- local ActiveDB = utils_set({})

-- for _, query in pairs(DBQueries) do
--     local t = {}
--     for v in query:gmatch("[^(]+") do
--         table.insert(t, v)
--     end
--     local QueryShort = t[1]
--     local ParamCount = select(2, string.gsub(t[2], ",", "")) + 1

--     if not IgnoreDBs[QueryShort] then
--         -- Why this no work?
        -- Ext.Osiris.RegisterListener(QueryShort, ParamCount, "beforeDelete", function (...)
        --     local args = {...}
        --     Ext.Utils.Print("DB Delete", QueryShort, dump(args))
        --     if SaveLoaded and CharacterCreated then
        --     end
        -- end)
--         Ext.Osiris.RegisterListener(QueryShort, ParamCount, "before", function (...)
--             local args = {...}

--             if SaveLoaded and CharacterCreated and not ActiveDB[QueryShort] then
--                 -- Ext.Utils.Print("DB Insert", QueryShort, dump(args))
--                 Osi[QueryShort]:Delete(table.unpack(args))
--             end
--         end)
--     end
-- end