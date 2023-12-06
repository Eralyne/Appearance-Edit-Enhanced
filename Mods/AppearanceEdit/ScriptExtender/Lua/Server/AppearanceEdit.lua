---@diagnostic disable: undefined-global

local DBQueries = Ext.Require("Server/DBQueries.lua")
local Tags = Ext.Require("Server/Tags.lua")
local Flags = Ext.Require("Server/Flags.lua")

-- DB_GLO_Backgrounds_Players -- DOUBLE PORTRAITS ISSUE IS HERE

-- There's got to be a better way to do this....
-- In future update, check for one param Integer DBs and String DBs
local DBsToPreserve = {
"DB_WYR_Journal_FlorrickExecuted(INTEGER)",
"DB_SHA_RelicJournal(STRING)",
"DB_SCL_Drider_Journal_ReadOrders(INTEGER)",
"DB_SCL_Drider_LeadingEscort(INTEGER)",
"DB_PLA_ZhentShipmnt_Journal_ChestOpenSteps(STRING)",
"DB_PLA_ZhentShipmnt_Journal_PickUpChestFollowUps(STRING, STRING)",
"DB_PLA_ZhentShipmnt_Journal_PickUpChestUpdateReceived(INTEGER)",
"DB_PLA_ZhentShipmnt_Journal_WithChestSteps(STRING)",
"DB_ORI_Laezel_PreventDeadGithADDuringDriderEscord(INTEGER)",
"DB_ORI_Laezel_Journal_InquisitorConflictDone(INTEGER)",
"DB_ORI_Laezel_LeftCageBox(INTEGER)",
"DB_ORI_Laezel_MoonriseLeaveTriggers(TRIGGER)",
"DB_ORI_Gale_NeedMagicItemJournalUpdates(FLAG, STRING)",
"DB_LOW_CazadorsPalace_AddedJournalEntries(STRING)",
"DB_LOW_CazadorsPalace_Ballroom_DoorUnlocked(INTEGER)",
"DB_LOW_CazadorsPalace_CazadorsJournalEntries(FLAG, STRING)",
"DB_HAV_SavingPrisoners_JournalEpilogueReturn(INTEGER)",
"DB_DEN_SnakeCourt_AutoResolve_JournalUpdate(INTEGER, STRING)",
"DB_DEN_SnakeCourt_GroveProgressed(INTEGER)",
"DB_DEN_SnakeCourt_KidFate_JournalUpdate(STRING, STRING, INTEGER)",
"DB_WYR_Flohhouse_RedDwarfMother_HoldQuestUpdates(STRING)",
"DB_UND_InjuredGnome_Journal_HasCureQuestUpdate(INTEGER)",
"DB_TUT_Start_JournalUpdate(CHARACTER, STRING, STRING)",
"DB_TUT_OriginQuestStarts(CHARACTER, STRING, STRING)",
"DB_SCL_Journal_HavenQuestUpdates(STRING)",
"DB_ORI_Laezel_QuestCurrentPriority(STRING, INTEGER)",
"DB_ORI_Laezel_QuestPriorityStepList(INTEGER, STRING, STRING)",
"DB_ORI_COM_Laezel_DealWithOrpheusQuestSteps(STRING)",
"DB_ORI_COM_Laezel_GetOrphicHammerQuestSteps(STRING)",
"DB_LOW_ZhentLeaderEscapedGoldHandover_QuestStep(GUIDSTRING, STRING)",
"DB_LOW_ZhentLeaderPermaDefeatedWithGold_QuestStep(GUIDSTRING, STRING, FLAG)",
"DB_LOW_ZhentLeaderReceivedStolenGold_QuestStep(GUIDSTRING, STRING)",
"DB_LOW_SorcerousSundries_GaleQuestUpdates(STRING)",
"DB_LOW_SerialKiller_Victim_QuestState(CHARACTER, STRING)",
"DB_LOW_SaveValeriaQuestSteps(STRING)",
"DB_LOW_KnowsStolenGoldInSewers_QuestUpdates(STRING)",
"DB_GatherYourAllies_QuestStarted(INTEGER)",
"DB_GOB_DrowCommander_Event_DrowHostileAfterDialog(CHARACTER, INTEGER)",
"DB_GOB_DrowCommander_ForceLeaveTriggered(INTEGER)",
"DB_GOB_DrowCommander_GoToEntrance(CHARACTER, STRING)",
"DB_GOB_DrowCommander_InLeaveMove(CHARACTER, STRING)",
"DB_GOB_DrowCommander_LeaveADs(DIALOGRESOURCE, CHARACTER, INTEGER, STRING)",
"DB_GOB_DrowCommander_LeaveForRaid(INTEGER)",
"DB_GOB_DrowCommander_LeaveMoves(STRING, CHARACTER, TRIGGER, STRING)",
"DB_GOB_DrowCommander_MoveInterruptExclusion(STRING)",
"DB_GOB_DrowCommander_NextMoveTalk(STRING, STRING)",
"DB_GOB_DrowCommander_PurgedQueueRaider(CHARACTER)",
"DB_GOB_DrowCommander_RaiderInMovement(CHARACTER)",
"DB_GOB_DrowCommander_RaiderLeaveTimers(CHARACTER, INTEGER)",
"DB_GOB_DrowCommander_Raiders(CHARACTER, TRIGGER, STRING, INTEGER)",
"DB_GOB_DrowCommander_RaidersInGoblinCamp(CHARACTER)",
"DB_GOB_DrowCommander_RaidersOnStandby(CHARACTER)",
"DB_GOB_DrowCommander_WarchiefBravePurged(INTEGER)",
"DB_GOB_AdventurerFreedFlags(FLAG)",
"DB_GLO_VossContactLetter(ITEM)",
"DB_GLO_Voss_Act3Levels(STRING)",
"DB_GLO_Voss_PermanentHostilityIfAttackedInState(STRING, STRING)",
"DB_GLO_Voss_SilverSwordReward(ITEM)",
"DB_GLO_Voss_VossChangedSwords(INTEGER)",
"DB_GLO_Voss_VossLeftSCWithoutMeetingPlayer(INTEGER)",
"DB_GLO_Tadpole_SUB_Apprentice_Died(INTEGER, STRING)",
"DB_GLO_Tadpole_SUB_Creche_KnowsAboutCrecheDevice(STRING)",
"DB_GLO_Tadpole_SUB_Moonrise_CheckEnteredUnderdark(INTEGER)",
"DB_GLO_Tadpole_HadConsumeDialog(INTEGER)",
"DB_GLO_TadpoleTreeEnabled(INTEGER)",
"DB_GLO_TadpoleQuest_Druid_FoundHalsinKillLeaders(INTEGER)",
"DB_GLO_TadpoleQuest_Druid_HalsinLeaderEntries(CHARACTER, STRING, INTEGER, STRING)",
"DB_GLO_TadpoleQuest_Druid_HalsinLeftNoHelp(INTEGER, STRING)",
"DB_GLO_TadpoleQuest_Druid_HalsinReturnEntries(INTEGER, STRING)",
"DB_GLO_TadpoleQuest_Druid_KillLeaders(STRING, GUIDSTRING)",
"DB_GLO_TadpoleQuest_Druid_LeaderDiedEntries(INTEGER, STRING)",
"DB_GLO_TadpoleQuest_LearnedApprenticeConditions(STRING)",
"DB_GLO_Moonrise_Journal_ChainedStateIfOpen(STRING, STRING, STRING)",
"DB_GLO_Moonrise_Journal_KnowsAboutNereLanternFlags(FLAG)",
"DB_GLO_Moonrise_Journal_LearnedSourceFlags(FLAG)",
"DB_GLO_Moonrise_Journal_OnMoonriseMission(STRING)",
"DB_GLO_Moonrise_Journal_ZrellMarkerShown(CHARACTER)",
"DB_GLO_Halsin_AtDruidLeaderMeeting(CHARACTER)",
"DB_GLO_Halsin_ClosingEntries(INTEGER, STRING)",
"DB_GLO_Halsin_DebugAttackOnDenMeet(INTEGER)",
"DB_GLO_Halsin_DebugVictoryMeet(INTEGER)",
"DB_GLO_Halsin_DruidLeaderMeetingNPCs(CHARACTER)",
"DB_GLO_Halsin_DruidLeaderMeetingReady(INTEGER)",
"DB_GLO_Halsin_FirstHalsinInteraction(FLAG, INTEGER, STRING)",
"DB_GLO_Halsin_GotToKnowFlags(FLAG)",
"DB_GLO_Halsin_HearingAboutHalsinForFirstTime(DIALOGRESOURCE)",
"DB_GLO_Halsin_LimitedTimeToTalkToPartner(INTEGER, GUIDSTRING)",
"DB_GLO_Halsin_MetAtCelebration(INTEGER)",
"DB_GLO_Halsin_MetAtDen(INTEGER)",
"DB_GLO_Halsin_MoveToPlayerAtDen(INTEGER)",
"DB_GLO_Halsin_ReadyForDen(INTEGER)",
"DB_GLO_Halsin_RomanceFlags(GUIDSTRING)",
"DB_GLO_Halsin_StartingEntries(STRING)",
"DB_GLO_Halsin_SubquestStarted(INTEGER)",
"DB_GLO_Halsin_WildShapeFallback(STRING)",
"DB_GLO_Halsin_WildshapeSpells(STRING, STRING)",
"DB_GLO_DaisyUnlocked(INTEGER)",
"DB_GLO_Daisy_TrackTags(TAG)",
"DB_GEN_SerialKiller_TableuxPADs(CHARACTER, FLAG, STRING, TRIGGER)",
"DB_GEN_SerialKiller_Tableux_DisableForCharacters(CHARACTER)",
"DB_GEN_SerialKiller_Tableux_Initialized(INTEGER)",
"DB_GEN_DealWithDevil_DidntListenRaphael(INTEGER)",
"DB_GEN_DealWithDevil_GortashNotes(ITEMROOT)",
"DB_GEN_DealWithDevil_HelsikNotes(ITEMROOT)",
"DB_GEN_DealWithDevil_LearnedAboutBoudoir(INTEGER)",
"DB_GEN_DealWithDevil_UpdatesBeforeHouse(STRING)",
"DB_GEN_FreeOrpheus_GrimoireUpdate(INTEGER)",
"DB_GEN_FreeOrpheus_LearnedAboutHelsik(INTEGER)",
"DB_GEN_FreeOrpheus_QuestStartedBeforeHouse(INTEGER)",
"DB_GEN_FreeOrpheus_SetConditionalUpdatesInHouse(FLAG, STRING, STRING, INTEGER, FLAG)",
"DB_GEN_FreeOrpheus_SetUpdatesInHouse(FLAG, STRING, STRING)",
"DB_GEN_FreeOrpheus_UpdatesBeforeHouse(STRING)",
"DB_GEN_OrinsAbduction_AbducteeFlagList(STRING, FLAG)",
"DB_GEN_OrinsAbduction_AbducteeGender(STRING, FLAG)",
"DB_GEN_OrinsAbduction_AbducteeList(STRING, CHARACTER, GUIDSTRING)",
"DB_GEN_OrinsAbduction_Abductee_ExamineAbducteeDialog(STRING)",
"DB_GEN_OrinsAbduction_AbductionCamp(STRING, FLAG)",
"DB_GEN_OrinsAbduction_AbductionPlace(STRING)",
"DB_GEN_OrinsAbduction_CFM_Orin(DIALOGRESOURCE)",
"DB_GEN_OrinsAbduction_CheckingMintharaVictim(INTEGER)",
"DB_GEN_OrinsAbduction_ChosenChar(CHARACTER)",
"DB_GEN_OrinsAbduction_ChosenCharFlag(FLAG)",
"DB_GEN_OrinsAbduction_ChosenCharRelationship(FLAG)",
"DB_GEN_OrinsAbduction_ChosenHalsinVictim(STRING, CHARACTER)",
"DB_GEN_OrinsAbduction_ChosenName(STRING)",
"DB_GEN_OrinsAbduction_CurCampTrigPos(TRIGGER)",
"DB_GEN_OrinsAbduction_DummyAsylumPos(STRING, TRIGGER)",
"DB_GEN_OrinsAbduction_GaveDagger(INTEGER)",
"DB_GEN_OrinsAbduction_IsTransformed(INTEGER)",
"DB_GEN_OrinsAbduction_MintharaAbduction(STRING, CHARACTER, FLAG)",
"DB_GEN_OrinsAbduction_NestedParentListeners(GUIDSTRING)",
"DB_GEN_OrinsAbduction_OrinAbductionPosList(STRING, TRIGGER)",
"DB_GEN_OrinsAbduction_OrinAttacker(CHARACTER)",
"DB_GEN_OrinsAbduction_OrinInAttackedDialog(INTEGER)",
"DB_GEN_OrinsAbduction_OrinTransformRule_Common(SHAPESHIFTRULE)",
"DB_GEN_OrinsAbduction_OrinTransformRule_DarkUrge(SHAPESHIFTRULE)",
"DB_GEN_OrinsAbduction_OrinTransformRule_Gortash(SHAPESHIFTRULE)",
"DB_GEN_OrinsAbduction_Orin_SavedTitle(STRING, STRING)",
"DB_GEN_OrinsAbduction_PartneredList(STRING, FLAG)",
"DB_GEN_OrinsAbduction_PostCampHostage_TalkedToYenna(STRING)",
"DB_GEN_OrinsAbduction_WaitForOrinAttackedDialog(INTEGER)",
"DB_GEN_OrinsMessages_BloodSurfaceCreated(INTEGER)",
"DB_GEN_OrinsMessages_CurrentMessage(STRING)",
"DB_GEN_OrinsMessages_CurrentMessageInCamp(STRING)",
"DB_GEN_OrinsMessages_HandList(STRING, ITEM)",
"DB_GEN_OrinsMessages_List(STRING, FLAG, ITEM)",
"DB_GEN_OrinsMessages_MovedMessage(INTEGER)",
"DB_GEN_OrinsMessages_PlayersNotFoundMessage(INTEGER)",
"DB_GEN_OrinsMessages_PosList(STRING, TRIGGER)",
"DB_GEN_OrinsMessages_SteelWatchFought(GUIDSTRING)",
"DB_DEN_Adventurers(CHARACTER)",
"DB_DEN_AdventurersQuest_AdventurerOnRoad(CHARACTER, DIALOGRESOURCE, TRIGGER)",
"DB_DEN_AdventurersQuest_AdventurersOnRoad(INTEGER)",
"DB_DEN_AdventurersQuest_DenDialogs(CHARACTER, DIALOGRESOURCE)",
"DB_DEN_AdvenutrersQuest_CheckLeaveCorpseArea(INTEGER)",
"DB_QuestIsAccepted(STRING)",
"DB_QuestIsClosed(STRING)",
"DB_QuestIsOpened(STRING)",
"DB_QuestDef_BookReadState(STRING, STRING, ITEM)",
"DB_QuestDef_ChainedState(STRING, STRING, STRING)",
"DB_QuestDef_ChainedState(STRING, STRING, STRING, STRING)",
"DB_QuestDef_ConditionalState(STRING, STRING, STRING, STRING, INTEGER)",
"DB_QuestDef_ConditionalState(STRING, STRING, STRING, STRING, STRING, INTEGER)",
"DB_QuestDef_ConditionalState(STRING, STRING, STRING, STRING, STRING, STRING, INTEGER)",
"DB_QuestDef_DefeatedState(STRING, STRING, CHARACTER)",
"DB_QuestDef_LevelLoaded(STRING, STRING, STRING)",
"DB_QuestDef_LevelUnloading(STRING, STRING, STRING)",
"DB_QuestDef_PermaDefeatedState(STRING, STRING, CHARACTER)",
"DB_QuestDef_SawDeadState(STRING, STRING, CHARACTER)",
"DB_QuestDef_SawDefeatedState(STRING, STRING, CHARACTER)",
"DB_QuestDef_SawPermaDefeatedState(STRING, STRING, CHARACTER)",
"DB_QuestDef_State(FLAG, STRING, STRING)",
"DB_QuestDef_State_CompanionLeft(TAG, STRING, STRING)",
"DB_QuestDef_State_ConditionalFlag(FLAG, STRING, STRING, INTEGER, FLAG)",
"DB_GLO_LevelSwap_Location(STRING, TRIGGER, STRING, STRING, INTEGER, STRING, STRING)",
"DB_ORI_Astarion_ScheduleDarkUrgeFirstDiscussion(INTEGER)",
"DB_ORI_Astarion_IPRDWorthyDarkUrgeMoment(FLAG)",
"DB_MOO_Assault_DarkUrgeButlerTriggers(TRIGGER, TRIGGER, TRIGGER)",
"DB_LOW_BhaalTemple_PostBattleDarkUrge_WaitForDialog(INTEGER)",
"DB_LOW_BhaalTemple_DarkUrgeAcceptance_PreConfrontation(INTEGER)",
"DB_GLO_ORI_DarkUrge_ButlerConfigs(STRING, STRING)",
"DB_GLO_ORI_DarkUrge_ButlerHats(GUIDSTRING)",
"DB_GEN_OrinsAbduction_OrinTransformRule_DarkUrge(SHAPESHIFTRULE)",
"DB_FallbackCamp_ResurrectDarkUrge(FLAG)",
"DB_Camp_DarkUrge_ButlerDream(DIALOGRESOURCE)",
"DB_COL_Barracks_OnlySpotDarkUrge(INTEGER)",
"DB_COL_Barracks_DarkUrgeSpotMistressCorpse(INTEGER)",
"DB_QRYRTN_DarkUrgeButler_Config(STRING)",
"DB_ORI_DarkUrge_AlfiraIVBs(VOICEBARKRESOURCE, CHARACTER)",
"DB_ORI_DarkUrge_AlfiraMurderVictim(CHARACTER)",
"DB_ORI_DarkUrge_AlfiraMurderVictimWaitingFor(CHARACTER)",
"DB_ORI_DarkUrge_AlfiraPos(STRING, TRIGGER)",
"DB_ORI_DarkUrge_BecameHostileAfterMurder(CHARACTER)",
"DB_ORI_DarkUrge_BloodWeddingLevels(STRING)",
"DB_ORI_DarkUrge_BloodweddingFallback(INTEGER)",
"DB_ORI_DarkUrge_ButlerExpectedAtMoonrise(TRIGGER)",
"DB_ORI_DarkUrge_ButlerHolder(GUIDSTRING, STRING, INTEGER)",
"DB_ORI_DarkUrge_ButlerKiller(CHARACTER)",
"DB_ORI_DarkUrge_CorpseLooting(INTEGER)",
"DB_ORI_DarkUrge_Debug_ButlerToCamp(INTEGER)",
"DB_ORI_DarkUrge_Debug_QueueingSparedISobelNight(INTEGER)",
"DB_ORI_DarkUrge_ExperiencedUrges(DIALOGRESOURCE)",
"DB_ORI_DarkUrge_FavouriteCharacter(CHARACTER)",
"DB_ORI_DarkUrge_FavouriteExcluded(CHARACTER)",
"DB_ORI_DarkUrge_FavouriteKillCandidateFlag(CHARACTER, FLAG)",
"DB_ORI_DarkUrge_GaleHand(ITEM)",
"DB_ORI_DarkUrge_LeastFavouriteCharacter(CHARACTER)",
"DB_ORI_DarkUrge_LeastFavouriteFlags(CHARACTER, FLAG)",
"DB_ORI_DarkUrge_MurderOfAlfiraRandom(CHARACTER)",
"DB_ORI_DarkUrge_MurderOfAlfiraRandom_Chosen(GUIDSTRING)",
"DB_ORI_DarkUrge_OldLoc(STRING, REAL, REAL, REAL)",
"DB_ORI_DarkUrge_PotentialMurderJudger(CHARACTER, INTEGER)",
"DB_ORI_DarkUrge_ReactedUrges(DIALOGRESOURCE)",
"DB_ORI_DarkUrge_ResumeSlayerForm(INTEGER)",
"DB_ORI_DarkUrge_SetupMooCatKilling(INTEGER)",
"DB_ORI_DarkUrge_SetupNights(STRING)"
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

local GlobalFlags = {}

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

local SavedDBs = {}

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

local function RepairChangedDbs()
    for query, item in pairs(SavedDBs) do
        -- Ext.Utils.Print("Repairing DB: ", query)
        local t = {}
        for v in query:gmatch("[^(]+") do
            table.insert(t, v)
        end

        local QueryShort = t[1]
        local ParamCount = select(2, string.gsub(t[2], ",", "")) + 1

        for _, entry in ipairs(Osi[QueryShort]:Get(table.unpack({}, 1, ParamCount))) do
            -- Ext.Utils.Print("Deleting: ", dump(entry))
            Osi[QueryShort]:Delete(table.unpack(entry))
        end

        for _, entry in ipairs(item) do
            -- Ext.Utils.Print("Reinserting: ", dump(entry))
            Osi[QueryShort](table.unpack(entry))
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

        for _, entry in pairs(Flags) do
            local FlagValue = GetFlag(entry, "NULL_00000000-0000-0000-0000-000000000000")
            GlobalFlags[entry] = FlagValue
        end

        for _, query in pairs(DBsToPreserve) do
            local t = {}
            for v in query:gmatch("[^(]+") do
                table.insert(t, v)
            end

            local QueryShort = t[1]
            local ParamCount = select(2, string.gsub(t[2], ",", "")) + 1

            for _, entry in ipairs(Osi[QueryShort]:Get(table.unpack({}, 1, ParamCount))) do
                if not SavedDBs[query] then
                    SavedDBs[query] = {}
                end

                table.insert(SavedDBs[query], entry)
                -- Ext.Utils.Print("Inserted into SavedDB: ", dump(SavedDBs[query]))
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
        Osi.PROC_RemoveAllDialogEntriesForSpeaker(SpellCaster)
    end
end)

Ext.Osiris.RegisterListener("ObjectTimerFinished", 2, "after", function (uuid, name)
    if name == "APPEARANCE_EDIT_CLEAR_FLAGGED_ITEMS" then
        -- TimerActive = false 
        CharacterMoveTo(uuid, SpellCaster, "", "", 1)
        
        IterateInventory(SpellCaster, "APPEARANCE_EDIT_IterateInventory", "APPEARANCE_EDIT_IterateInventory_Done")

        for _, entry in ipairs(Osi["DB_ApprovalRating"]:Get(nil, nil, nil)) do
            local InsertTable = {}
            local MarkedForDeletion = false
            local Modified = false

            InsertTable, MarkedForDeletion, Modified = DBOperations(uuid, entry)

            if MarkedForDeletion then
                Osi["DB_ApprovalRating"]:Delete(table.unpack(entry))
            elseif Modified then
                Osi["DB_ApprovalRating"](table.unpack(InsertTable))
                ChangeApprovalRating(InsertTable[1], uuid, 0, InsertTable[3])
                -- Ext.Utils.Print("Changing Approval Rating: ", InsertTable[1], uuid, InsertTable[3])
            end
        end

        RepairChangedDbs()

        SetFaction(uuid, Faction)

        local DarkUrgeTag = 'fe825e69-1569-471f-9b3f-28fd3b929683'

        -- Try to fix Dark Urge, again?
        if IsTagged(uuid, DarkUrgeTag) then
            for _, entry in ipairs(Osi["DB_ORI_DarkUrge"]:Get(nil)) do
                Osi["DB_ORI_DarkUrge"]:Delete(entry[1])
            end
            Osi["DB_ORI_DarkUrge"](uuid)
        end

        -- Remove Spellcaster from Inspiration Table
        for _, entry in ipairs(Osi["DB_GLO_Backgrounds_Players"]:Get(SpellCaster, nil)) do
            Osi["DB_GLO_Backgrounds_Players"]:Delete(table.unpack(entry))
        end

        OpenMessageBox(uuid, "Appearance editing complete, enjoy.")

        -- Cleanup
        -- NewTav = nil
        -- SpellCaster = nil
    end
end)

-- Run replacement commands only when custom character is created
Ext.Osiris.RegisterListener("Activated", 1, "after", function (uuid)
    if SaveLoaded and CharacterCreated and not (string.find(uuid, "S_", 1, true) == 1) then
        CharacterCreated = false
        Ext.Utils.Print(tostring(uuid))

        local DarkUrgeTag = 'fe825e69-1569-471f-9b3f-28fd3b929683'
        local GenericTag = '730e82f3-c067-44a4-985b-0dfe079d4fea'
        local CleanUp = false

        if ((string.find(SpellCaster, "S_", 1, true) == 1) or not (IsTagged(SpellCaster, DarkUrgeTag) == IsTagged(uuid, DarkUrgeTag) and IsTagged(SpellCaster, GenericTag) == IsTagged(uuid, GenericTag))) then
            -- Spellcaster is an origin character or Player created a dark urge character when they weren't or a generic character when they were
            -- Ext.Utils.Print("Spellcaster origin is not the same as new character origin, cleaning up new character")
            OpenMessageBox(SpellCaster, "Spellcaster origin is not the same as new character origin, cleaning up new character")
            -- Mark for Cleanup
            CleanUp = true
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
                ["d1de279e-be63-9787-474a-c001fc38dc24"] = function ()
                    if HasActiveStatus(SpellCaster, "GLO_PIXIESHIELD") == 1 and HasActiveStatus(SpellCaster, "GLO_PIXIESHIELD") == 0 then
                        ApplyStatus(uuid, "GLO_PIXIESHIELD", -1, 0, uuid)
                    end
                end,
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

                    if not (GlobalFlags[entry] == GlobalFlag) then
                        -- Ext.Utils.Print(GlobalFlags[entry], GlobalFlag)
                        SetFlag(entry, "NULL_00000000-0000-0000-0000-000000000000", 0, GlobalFlags[entry])
                    end
                end
            end

            for _, entry in pairs(Tags) do
                if IsTagged(SpellCaster, entry) == 1 and IsTagged(uuid, entry) == 0 then
                    -- Ext.Utils.Print(tostring(entry))
                    SetTag(uuid, entry)
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
                if not (QueryShort == "DB_ApprovalRating") and not (QueryShort == "DB_ClassDeityTags_For") and not (QueryShort == "DB_GLO_Backgrounds_Players") then
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
                        -- if not ActiveDB[QueryShort] then
                        --     ActiveDB[QueryShort] = true
                        -- end

                        -- Ext.Utils.Print("Deleting OG: ", dump(entry))
                        Osi[QueryShort]:Delete(table.unpack(entry))
                        -- Ext.Utils.Print("Inserting New: ", dump(InsertTable))
                        Osi[QueryShort](table.unpack(InsertTable))
                    end
                end
            end

            if key == DBQuerySize and not CleanUp then
                ObjectTimerLaunch(uuid, "APPEARANCE_EDIT_CLEAR_FLAGGED_ITEMS", 5000, 1)
                -- ActiveDB = utils_set({})
            end
        end

        -- Remove improper character
        if CleanUp then
            MakeNPC(uuid)
            SetOnStage(uuid, 0)
            RepairChangedDbs()
            MakePlayerActive(SpellCaster)
            return
        end
    elseif SaveLoaded and CharacterCreated and CharacterOrigins[uuid] then
        RepairChangedDbs()
        RequestRespec(uuid)
    end
end)

-- It's testing time as I test all over the code

-- Ext.Osiris.RegisterListener("AddedTo", 3, "after", function (entity, char, _)
--     if TimerActive and not (string.find(entity, "Underwear", 1, true)) and not (string.find(entity, "ARM", 1, true)) and not (string.find(entity, "WPN", 1, true)) then
--         RequestDelete(entity)
--     end
-- end)

-- DBs to ignore listening to when creating characters
-- local IgnoreDBs = utils_set({"DB_Origins_SelfHealing_Disabled", "DB_Tadpole_Activated", "DB_CharacterCrimeEnabled", "DB_CharacterCrimeDisabled", "DB_Sees", "DB_NOOP", "DB_WasInRegion", "DB_DialogEnding", "DB_InRegion", "DB_DialogNPCs", "DB_DialogNumPlayers", "DB_AutomatedDialog", "DB_DialogNumNPCs", "DB_DialogName", "DB_HiddenCharacters", "DB_GLO_Tutorials_TrackedTimers", "DB_CRIME_Casting", "DB_HiddenCharacters", "DB_GLO_Backgrounds_Soldier_BossOneShotSpell", "DB_PlayLoopEffectHandleResult", "DB_LoopEffect", "DB_ActiveLevel", "DB_WYR_Brainquakes_ChainedEvents", "DB_COL_Vault_ChangedNodes", "DB_Debug_ORI_CampNight", "DB_DialogSpeakers", "DB_ClassDeityTags_For", "DB_CantMove"})

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