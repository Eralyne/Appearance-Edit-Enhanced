---@diagnostic disable: undefined-global

-- Maybe dump these instead??
local DBQueries = Ext.Require("Server/DBQueries.lua")

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

local function try_get_db(query, arity)
    local db = Osi[query]
    if db and db.Get then
        return db:Get(table.unpack({}, 1, arity))
    end
end

-- TODO: Check for length and set reversed, loop through the longer one and delete if reversed, add if not
-- local function deepWrite(old, new, reversed)
--     if type(old) == "table" or type(old) == "userdata" then
--         for k,v in pairs(new) do
--             _P(k, v)
--             if (type(v) == "table" or type(v) == "userdata") then
--                 if (size(v) > size(old[k])) then
--                     deepWrite(v, old[k], true)
--                 else
--                     deepWrite(old[k], v, false) 
--                 end
--             else
--                 if reversed then
--                     old[k] = v
--                 else
--                     old[k] = v
--                 end
--             end
--         end
--     end
-- end

local function deepClean(old)
    if type(old) == "table" or type(old) == "userdata" then
        for k,v in pairs(old) do
            if (type(v) == "table" or type(v) == "userdata") then
                deepClean(old[k])
            else
                if (type(v) == "string" and string.len(v) >= 36) then
                    old[k] =  "00000000-0000-0000-0000-000000000000"
                end
            end
        end
    end
end

local function deepWrite(old, new)
    if type(new) == "table" or type(new) == "userdata" then
        for k,v in pairs(new) do
            if (type(v) == "table" or type(v) == "userdata") then
                deepWrite(old[k], v)
            else
                old[k] = v
            end
        end
    end
end

local function cloneEntity(old, new)
    deepClean(old);
    deepWrite(old, new);
end


-- local function wait(milliseconds) 
--     local start = Ext.Utils.MonotonicTime() 
--     repeat until Ext.Utils.MonotonicTime() > start + milliseconds
-- end

----------------------
----------------------

-- DBs to ignore resetting when creating characters
local IgnoreDBs = utils_set({
    -- "DB_GlobalFlag",
    -- "DB_QRYRTN_CRIME_GetValidCrimeID",
    -- "DB_InternScene_CrimeActive",
    "DB_OnlyOnce",
    "DB_GLO_PartyMembers_Kicked",
    "DB_GLO_Tutorials_EndTheDay_DepletedShortRestResourceOrSpell",
    "DB_MOO_KitchenFight_QtrMasterDisrupter",
    "DB_Tadpole_CanUseDaisyPersuasion_Cached",
    "DB_CustomUseItemResponse",
    "DB_SCL_Drider_EscortedPlayer",
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

-- Make sure we only run CC functions in active games rather than new games
local SaveLoaded = false

local CharacterCreated = false

local SpellCaster

local SavedDBs = {}

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

        local success, _ = pcall(try_get_db, QueryShort, ParamCount)

        if success then
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
        end

        -- Cleans SavedDB
        SavedDBs[query] = nil
    end
end

Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", function ()
    SaveLoaded = true
end)

-- Give players Resculpt spell on sneak
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (guid, name, _, _)
    if name == "SNEAKING" and string.find(guid, GetHostCharacter(), 1, true) then
        Osi.AddSpell(guid, "Shout_Open_Creation", 1, 1)
        Osi.AddSpell(guid, "Shout_Open_Respec", 1, 1)
     end
end)

-- Remove Resculpt on sneak end
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function (guid, name, _, _)
    if name == "SNEAKING" and string.find(guid, GetHostCharacter(), 1, true) then
        Osi.RemoveSpell(guid, "Shout_Open_Creation", 0)
        Osi.RemoveSpell(guid, "Shout_Open_Respec", 0)
    end
end)

-- Do Creation Operations
Ext.Osiris.RegisterListener("CharacterCreationFinished", 0, "before", function ()
    if SaveLoaded then
        NewTav = nil
        CharacterCreated = true

        Osi.TimerLaunch("APPEARANCE_EDIT_ORIGIN_EDIT_FINISHED", 1500)

        -- Remove Daisies
        for _, entry in pairs(Osi["DB_GLO_DaisyAwaitsAvatar"]:Get(nil, nil)) do
            if (entry) then
                Osi.SetOnStage(entry[1], 0)
                Osi["DB_GLO_DaisyAwaitsAvatar"]:Delete(table.unpack(entry))
                Ext.Utils.Print("Daisy Cleaned Up")
            end
        end
    end
end)

-- Open character creation or respec on spell use
Ext.Osiris.RegisterListener("UsingSpell", 5, "after", function (uuid, name, _, _, _, _)
    if name == "Shout_Open_Creation" then
        SpellCaster = uuid
        Ext.Utils.Print(SpellCaster .. " casting spell")

        if ((string.find(uuid, "S_", 1, true) == 1)) then                
            for _, query in pairs(DBQueries) do
                -- Reset the SavedDB query before adding
                SavedDBs[query] = nil

                local t = {}
                for v in query:gmatch("[^(]+") do
                    table.insert(t, v)
                end

                local QueryShort = t[1]
                local ParamCount = select(2, string.gsub(t[2], ",", "")) + 1

                local success, _ = pcall(try_get_db, QueryShort, ParamCount)

                if not IgnoreDBs[QueryShort] and success then
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

            Osi.StartCharacterCreation()
        else
            Osi.StartChangeAppearance(uuid)
        end
        Ext.Utils.Print("Character Creator Shown")
    elseif name == "Shout_Open_Respec" then
        Osi.StartRespec(uuid)
        Ext.Utils.Print("Respec Screen Shown")
    end
end)

Ext.Osiris.RegisterListener("TimerFinished", 1, "after", function (event)
    if event == "APPEARANCE_EDIT_ORIGIN_EDIT_FINISHED" then
        if SaveLoaded and CharacterCreated then
            CharacterCreated = false
            Ext.Utils.Print("Origin or Hireling Edited")
            RepairChangedDbs()
        end
    end
end)