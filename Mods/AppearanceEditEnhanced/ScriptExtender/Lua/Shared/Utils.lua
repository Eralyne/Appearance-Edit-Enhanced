---@diagnostic disable: undefined-global

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                        Table Helpers                                        --
--                                                                                             --
-------------------------------------------------------------------------------------------------

function Utils.Set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

function Utils.Size(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function Utils.Equals(o1, o2, ignore_mt)
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
        if value2 == nil or Utils.Equals(value1, value2, ignore_mt) == false then
            return false
        end
        keySet[key1] = true
    end

    for key2, _ in pairs(o2) do
        if not keySet[key2] then return false end
    end
    return true
end

--- @param t table
--- @param toRemove table
function Utils.Remove(t, toRemove)
    local i, j, n = 1, 1, #t
    while i <= n do
        if (Utils.Equals(t[i], toRemove)) then
            local k = i
            repeat
                i = i + 1
            until i > n or not fnKeep(t, i, j + i - k)
            table.move(t, k, i - 1, j)
            j = j + i - k
        end
        i = i + 1
    end
    table.move(t, n + 1, n + n - j + 1, j)
    return t
end

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                         SE Helpers                                          --
--                                                                                             --
-------------------------------------------------------------------------------------------------

-- Credit: LazyIcarus for the implementation idea
function DelayedCall(ms, func)
    local Time = 0
    local handler
    handler = Ext.Events.Tick:Subscribe(function(e)
        Time = Time + e.Time.DeltaTime

        if (Time >= ms) then
            Ext.Events.Tick:Unsubscribe(handler)
            func()
        end
    end)
end

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                       String Helpers                                        --
--                                                                                             --
-------------------------------------------------------------------------------------------------

function Utils.StartsWith(string, prefix)
    return string:find(prefix, 1, true) == 1
end

function Utils.MatchAfter(string, prefix)
    return string:match(prefix .. "(.*)")
end

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                      Protected Helpers                                      --
--                                                                                             --
-------------------------------------------------------------------------------------------------

function Utils.TryGetProxy(entity, proxy)
    return entity[proxy]
end

function Utils.TryGetDB(query, arity)
    local db = Osi[query]
    if db and db.Get then
        return db:Get(table.unpack({}, 1, arity))
    end
end

local function protectedSet(old, key, value)
    old[key] = value
end

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                           Sets                                              --
--                                                                                             --
-------------------------------------------------------------------------------------------------

local CharacterOriginsUUIDs = Utils.Set(Constants.CharacterOriginsUUIDs)
local PermittedCopyObjects = Utils.Set(Constants.PermittedCopyObjects)
local MaleSecretOrigins = Utils.Set(Constants.MaleSecretOrigins)
local FemaleSecretOrigins = Utils.Set(Constants.FemaleSecretOrigins)
local ReallyTags = Utils.Set(Constants.ReallyTags)
local GenitalTags = Utils.Set(Constants.GenitalTags)


-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                         UUID Helpers                                        --
--                                                                                             --
-------------------------------------------------------------------------------------------------

function Utils.IsGUID(string)
    local x = "%x"
    local t = { x:rep(8), x:rep(4), x:rep(4), x:rep(4), x:rep(12) }
    local pattern = table.concat(t, '%-')

    return string:match(pattern)
end

function Utils.GetGUID(str)
    if str ~= nil and type(str) == 'string' then
        return string.sub(str, (string.find(str, "_[^_]*$") ~= nil and (string.find(str, "_[^_]*$") + 1) or 0), nil)
    end
    return ""
end

function Utils.UUIDEquals(item1, item2)
    if type(item1) == 'string' and type(item2) == 'string' then
        return (Utils.GetGUID(item1) == Utils.GetGUID(item2))
    end

    return false
end

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                     Entity Replication                                      --
--                                                                                             --
-------------------------------------------------------------------------------------------------

function Utils.DeepClean(old)
    if PermittedCopyObjects[getmetatable(old)] then
        for k, v in pairs(old) do
            if (k ~= "Template" and k ~= "OriginalTemplate") then
                if PermittedCopyObjects[getmetatable(v)] then
                    Utils.DeepClean(old[k])
                elseif getmetatable(v) ~= "EntityProxy" then
                    pcall(protectedSet, old, k, nil)
                end
            end
        end
    end
end

function Utils.DeepWrite(old, new)
    if PermittedCopyObjects[getmetatable(new)] then
        for k, v in pairs(new) do
            if (k ~= "Template" and k ~= "OriginalTemplate") then
                if PermittedCopyObjects[getmetatable(v)] then
                    if (old == nil) then
                        old = {}
                    end

                    Utils.DeepWrite(old[k], v)
                elseif getmetatable(v) ~= "EntityProxy" then
                    pcall(protectedSet, old, k, v)
                end
            end
        end
    end
end

function Utils.TempClean(old)
    if type(old) == "table" or type(old) == "userdata" then
        for k, v in pairs(old) do
            if (type(v) == "table" or type(v) == "userdata") then
                Utils.TempClean(old[k])
            else
                if (type(v) == "string" and string.len(v) >= 36) then
                    old[k] = "00000000-0000-0000-0000-000000000000"
                end
            end
        end
    end
end

function Utils.TempWrite(old, new)
    if type(new) == "table" or type(new) == "userdata" then
        for k, v in pairs(new) do
            if (type(v) == "table" or type(v) == "userdata") then
                Utils.TempWrite(old[k], v)
            else
                old[k] = v
            end
        end
    end
end

function Utils.TempClone(old, new)
    Utils.TempClean(old);
    Utils.TempWrite(old, new);
end

function Utils.CloneProxy(old, new)
    Utils.DeepClean(old)
    Utils.DeepWrite(old, new)
end

function Utils.CloneEntityEntry(old, new, entry)
    Utils.CloneProxy(old[entry], new[entry])

    local ExcludedReps = Utils.Set(Constants.ExcludedReplications)

    if (not ExcludedReps[entry]) then
        old:Replicate(entry)
    end
end

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                          Spells                                             --
--                                                                                             --
-------------------------------------------------------------------------------------------------

-- Probably only works on Container Spells
-- TODO: Add to AddedSpells when replication gets added
function Utils.AddSpellToSpellbook(char, spell)
    local CharEntity = Ext.Entity.Get(char)
    local SpellBook = CharEntity["SpellBook"]
    -- local AddedSpells = CharEntity["AddedSpells"]

    -- local TemplateAddedSpells = {
    --     ContainerSpell = "",
    --     CooldownType = "Default",
    --     ItemHandle = nil,
    --     SelectionType = "Singular",
    --     SpellCastingAbility = "None",
    --     SpellId = {
    --         OriginatorPrototype = spell,
    --         ProgressionSource = "00000000-0000-0000-0000-000000000000",
    --         SourceType = "Osiris"
    --     },
    --     SpellUUID = "00000000-0000-0000-0000-000000000000",
    --     field_29 = 0,
    --     field_48 = 0
    -- }

    local TemplateSpellBook = {
        CooldownType = "Default", -- Modify this to the properly CooldownType
        Id = {
            OriginatorPrototype = spell,
            ProgressionSource = "00000000-0000-0000-0000-000000000000",
            Prototype = spell,
            SourceType = "Osiris"
        },
        SpellCastingAbility = "None",
        SpellUUID = "00000000-0000-0000-0000-000000000000",
        field_38 = -1,
        field_3C = -1,
        field_41 = 1,
        field_42 = 0
    }

    SpellBook.Spells[#SpellBook.Spells + 1] = TemplateSpellBook

    CharEntity:Replicate("SpellBook")
    -- CharEntity:Replicate("AddedSpells")
end

function Utils.SpellExistsInAddedSpells(char, spell, remove)
    local CharEntity = Ext.Entity.Get(char)
    local AddedSpells = CharEntity["AddedSpells"]

    for addedSpellKey, addedSpell in pairs(AddedSpells["Spells"]) do
        if (addedSpell["SpellId"]["OriginatorPrototype"] == spell) then
            if (remove) then
                AddedSpells["Spells"][addedSpellKey] = nil
                -- TODO: Replicate here
            end

            return true
        end
    end
end

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                          Hotbar                                             --
--                                                                                             --
-------------------------------------------------------------------------------------------------

-- Just in-case
local function checkHotBarExists(character)
    local CharEntity = Ext.Entity.Get(character)

    local success, result = pcall(Utils.TryGetProxy, CharEntity, "HotbarContainer")

    if (success) then
        if (result and result["ActiveContainer"] == "DefaultBarContainer"
                and result["Containers"]
                and result["Containers"]["DefaultBarContainer"]
                and PermittedCopyObjects[getmetatable(result["Containers"]["DefaultBarContainer"])]) then
            return result["Containers"]["DefaultBarContainer"]
        end
    end
end

--- Only finds items on the "DefaultBarContainer"
function Utils.FindSpellIndexOnHotbar(character, spell)
    local CharacterHotbar = checkHotBarExists(character)

    if (CharacterHotbar) then
        local HotBar = Ext.Entity.Get(character).HotbarContainer.Containers.DefaultBarContainer

        for _, bar in pairs(HotBar) do
            if (bar) then
                for _, slot in pairs(bar.Elements) do
                    if (slot and slot["SpellId"] and slot["SpellId"]["Prototype"] == spell) then
                        return bar["Index"], bar["field_1"], slot["Slot"]
                    end
                end
            end
        end
    end
end

--- Returns table for slot at provided indexes in "DefaultBarContainer"
--- @return string|nil slotKey, table|nil slot
function Utils.GetHotbarSlotFromIndex(character, barIndex, slotIndex)
    local CharacterHotbar = checkHotBarExists(character)
    if (CharacterHotbar) then
        local HotBar = Ext.Entity.Get(character).HotbarContainer.Containers.DefaultBarContainer

        for _, bar in pairs(HotBar) do
            if (bar and bar["Index"] == barIndex) then
                for _, slot in pairs(bar.Elements) do
                    if (slot and slot["Slot"] == slotIndex) then
                        return slot["Slot"], slot
                    end
                end
            end
        end
    end
end

-- Look everywhere and remove all instances of spell from the hotbar
-- If persistantChar is provided, we don't remove
-- TODO: Unused
function Utils.RemoveSpellFromHotbar(character, spell, persistantChar)
    local BarIndex
    local SlotIndex

    if (persistantChar) then
        BarIndex = persistantChar["BarIndex"]
        SlotIndex = persistantChar["SlotIndex"]
    end

    local CharacterHotbar = checkHotBarExists(character)

    local SpellsFound = {}

    if (CharacterHotbar) then
        local HotBar = Ext.Entity.Get(character).HotbarContainer.Containers.DefaultBarContainer

        for barKey, bar in pairs(HotBar) do
            if (bar) then
                for slotKey, slot in pairs(bar.Elements) do
                    if (slot and slot["SpellId"] and slot["SpellId"]["Prototype"] == spell) then
                        SpellsFound[slotKey] = {
                            barKey = barKey,
                            barIndex = bar["Index"],
                            slotIndex = slot["Slot"]
                        }
                        -- if ((not BarIndex and not SlotIndex) or (BarIndex ~= bar["Index"] and SlotIndex ~= slot["Slot"])) then
                        --     Utils.Debug("Spell removed")
                        --     bar.Elements[slotKey] = nil
                        -- end
                    end
                end
            end
        end

        local SpellsRemaining = Utils.Size(SpellsFound)

        -- Utils.Debug("Removal:")
        -- _D(SpellsFound)
        -- _P(BarIndex)
        -- _P(SlotIndex)

        if (SpellsRemaining > 1) then
            -- Clear non-stored spells
            for slotKey, foundSpell in pairs(SpellsFound) do
                if ((not BarIndex and not SlotIndex) or (BarIndex ~= foundSpell["barIndex"] and SlotIndex ~= foundSpell["slotIndex"])) then
                    _D(foundSpell)
                    CharacterHotbar[foundSpell["barKey"]]["Elements"][slotKey] = nil
                    SpellsFound[slotKey] = nil
                end
            end

            -- Clear duplicate spells in the same slot

            if (Utils.Size(SpellsFound) > 1) then
                for slotKey, foundSpell in pairs(SpellsFound) do
                    if (Utils.Size(SpellsFound) < 2) then
                        break
                    end

                    if (CharacterHotbar[foundSpell["barKey"]]["Elements"][slotKey]) then
                        CharacterHotbar[foundSpell["barKey"]]["Elements"][slotKey] = nil
                    end
                    SpellsFound[slotKey] = nil

                    SpellsRemaining = Utils.Size(SpellsFound)
                end
            end

            Ext.Entity.Get(character):Replicate("HotbarContainer")
        end
    end
end

-- Insert persisted slot into Hotbar
-- TODO: Unused
function Utils.InsertIntoHotbarSlot(character, persistantChar)
    local CharacterHotbar = checkHotBarExists(character)
    local BarIndex = persistantChar["BarIndex"]
    local NewSlot = persistantChar["Slot"]


    if (CharacterHotbar) then
        local HotBar = Ext.Entity.Get(character).HotbarContainer.Containers.DefaultBarContainer


        for _, bar in pairs(HotBar) do
            if (bar and bar["Index"] == BarIndex and PermittedCopyObjects[getmetatable(bar.Elements)]) then
                -- for slotKey, slot in pairs(bar.Elements) do
                --     if (slot and slot["SpellId"] and slot["SpellId"]["Prototype"] == spell) then
                --         bar.Elements[slotKey] = nil
                --     end
                -- end

                -- Utils.Debug("Slot")
                -- _D(BarIndex)
                -- _D(NewSlot)

                bar.Elements[#bar.Elements + 1] = NewSlot
                Ext.Entity.Get(character):Replicate("HotbarContainer")
            end
        end
    end
end

-- Move spell to a new persisted slot, clear persistantChar after
function Utils.MoveSpellToSlot(character)
    local UUIDChar = Utils.GetGUID(character)
    local persistantChar = PersistentVars["SpellOwners"][UUIDChar]

    if (persistantChar) then
        local BarIndex = persistantChar["BarIndex"]
        local BarRemoved = persistantChar["BarRemoved"]
        local NewSlot = persistantChar["Slot"]

        local CharacterHotbar = checkHotBarExists(character)

        if (CharacterHotbar) then
            local HotBar = Ext.Entity.Get(character).HotbarContainer.Containers.DefaultBarContainer

            local Removed = false

            for _, bar in pairs(HotBar) do
                if (bar) then
                    for slotKey, slot in pairs(bar.Elements) do
                        if (slot and slot["SpellId"] and slot["SpellId"]["Prototype"] == NewSlot["SpellId"]["Prototype"]) then
                            -- Utils.Debug("Spell removed")
                            Removed = true
                            bar.Elements[slotKey] = nil
                        end
                    end
                end
            end

            -- local Moved = false

            if (Removed and BarIndex and NewSlot) then
                for _, bar in pairs(HotBar) do
                    if (bar) then
                        if (BarIndex == bar["Index"] and (BarRemoved ~= 1)) then
                            -- Utils.Debug("Spell moved")
                            -- Moved = true
                            bar.Elements[#bar.Elements + 1] = NewSlot
                        end
                    end
                end
            end

            if (Removed) then
                PersistentVars["SpellOwners"][UUIDChar] = {}
                Ext.Entity.Get(character):Replicate("HotbarContainer")
            end
        end
    end
end

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                       Character Work                                        --
--                                                                                             --
-------------------------------------------------------------------------------------------------

function Utils.IsHireling(character)
    local faction = Osi.GetFaction(character)

    return Utils.StartsWith(faction, "Hireling")
end

function Utils.IsOrigin(character)
    local faction = Osi.GetFaction(character)

    local UUIDChar = Utils.GetGUID(character)

    return Utils.StartsWith(faction, "Origin") or Utils.StartsWith(faction, "Companion") or CharacterOriginsUUIDs[UUIDChar]
end

function Utils.RemoveCharacter(character)
    local UUIDChar = Utils.GetGUID(character)

    -- Remove our custom spells
    if (PersistentVars["SpellOwners"][UUIDChar]) then
        PersistentVars["SpellOwners"][UUIDChar] = nil
    end

    Osi.RemoveSpell(UUIDChar, Constants.CustomSpells["SpellsContainer"], 1)

    -- Murder
    Osi.MakeNPC(UUIDChar)
    Osi.SetHasDialog(UUIDChar, 0)
    Osi.SetOnStage(UUIDChar, 0)
    Osi.PROC_RemoveAllPolymorphs(UUIDChar)
    Osi.PROC_RemoveAllDialogEntriesForSpeaker(UUIDChar)
    Osi.SetImmortal(UUIDChar, 0)
    Osi.Die(UUIDChar, 0, "NULL_00000000-0000-0000-0000-000000000000", 0, 0)

    -- Make sure our party isn't full anymore
    Osi.PROC_CheckPartyFull()
end

--
-- function Utils.HideCharacter(character)
-- Osi.TeleportTo()
-- SYS_Hirelings
-- end

function Utils.ShiftEquipmentVisual(character, reverse)
    -- Utils.Debug((reverse and "Reversing" or "Shifting") .. " Appearance of " .. character)

    local UUIDChar = Utils.GetGUID(character)

    local Entity = Ext.Entity.Get(character)

    if (Entity and PersistentVars["OriginalTemplates"][UUIDChar]) then
        for key, val in pairs(PersistentVars["OriginalTemplates"][UUIDChar]) do
            local copiedKey = Utils.MatchAfter(key, "Copied")

            if (copiedKey) then
                if (not reverse) then
                    -- Utils.Debug("Copying " .. copiedKey)
                    pcall(protectedSet, Ext.Entity.Get(character).ServerCharacter.Character.Template, copiedKey, val)
                end
            else
                if (reverse) then
                    -- Utils.Debug("Reversing " .. key)
                    pcall(protectedSet, Ext.Entity.Get(character).ServerCharacter.Character.Template, key, val)
                end
            end
        end
    elseif (PersistentVars["OriginalTemplates"] and not PersistentVars["OriginalTemplates"][UUIDChar]) then
        -- Utils.Warn("Your persistant vars are GONE. If you have a resculpted character, resculpt again or else you will have ISSUES.")
    end
end

function Utils.TempFixSecretOriginVoice(uuid)
    if (MaleSecretOrigins[uuid]) then
        Ext.Entity.Get(uuid).Voice.Voice = Constants.DefaultUUIDs["TempMaleVoice"]
    elseif (FemaleSecretOrigins[uuid]) then
        Ext.Entity.Get(uuid).Voice.Voice = Constants.DefaultUUIDs["TempFemaleVoice"]
    end
end

function Utils.ResetSecretOriginVoice(uuid)
    if (MaleSecretOrigins[uuid] or FemaleSecretOrigins[uuid]) then
        Ext.Entity.Get(uuid).Voice.Voice = Constants.DefaultUUIDs["NullTemplate"]
    end
end

function Utils.CopyAppearanceVisuals(uuid)
    local Entity = Ext.Entity.Get(uuid)

    if (not Entity.AppearanceOverride) then
        Entity:CreateComponent("AppearanceOverride")

        pcall(Osi.ObjectTimerLaunch, uuid, "AEE_Override_Replication", 500)
    else
        if (Utils.Size(Entity.AppearanceOverride.Visual.Elements) == 0) then
            Entity.AppearanceOverride.Visual.Elements = Constants.DefaultElements
        end

        if (Utils.Size(Entity.AppearanceOverride.Visual.Elements) == 0) then
            Entity.AppearanceOverride.Visual.AdditionalChoices = Constants.DefaultAdditionalChoices
        end

        Utils.CloneProxy(Entity.AppearanceOverride.Visual, Entity.CharacterCreationAppearance);

        Utils.CloneProxy(Entity.AppearanceOverride.Visual.Visuals, Entity.CharacterCreationAppearance.Visuals);
        Utils.CloneProxy(Entity.AppearanceOverride.Visual.Elements, Entity.CharacterCreationAppearance.Elements);

        if (Entity.GameObjectVisual.Type ~= 2) then
            Entity.GameObjectVisual.Type = 2
        end

        Entity:Replicate("GameObjectVisual")
        Entity:Replicate("AppearanceOverride")
    end
end

-- Delay replication because creating component takes a little bit
Ext.Osiris.RegisterListener("ObjectTimerFinished", 2, "after", function(uuid, event)
    if (event == "AEE_Override_Replication") then
        Utils.CopyAppearanceVisuals(uuid)
    end
end)

function Utils.FixREALLYTags(char, secondaryChar)
    local Entity = Ext.Entity.Get(char)
    local SecondaryEntity = Ext.Entity.Get(secondaryChar)
    local NewReallyTags = {}

    for _, val in pairs(SecondaryEntity.Tag.Tags) do
        if (Constants.ReallyTagsConvertion[val]) then
            table.insert(NewReallyTags, Constants.ReallyTagsConvertion[val])
        end
    end

    if (Utils.Size(NewReallyTags) > 0) then
        -- Tag
        for _, val in pairs(Entity.Tag.Tags) do
            if (ReallyTags[val]) then
                Osi.ClearTag(char, val)
            end
        end

        for _, val in pairs(NewReallyTags) do
            Osi.SetTag(char, val)
        end
    end
end

function Utils.FixGenitalTags(char, secondaryChar)
    local Entity = Ext.Entity.Get(char)
    local SecondaryEntity = Ext.Entity.Get(secondaryChar)
    local GenitalTag

    for _, val in pairs(SecondaryEntity.Tag.Tags) do
        if (GenitalTags[val]) then
            GenitalTag = val
        end
    end

    if (GenitalTag) then
        for _, val in pairs(Entity.Tag.Tags) do
            if (GenitalTags[val]) then
                Osi.ClearTag(char, val)
                Osi.SetTag(char, GenitalTag)
                break
            end
        end
    end
end

-- TODO: Figure out how to do this........
function Utils.ClearAppearanceChanges(character)

end

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                    Persistant Vars                                          --
--                                                                                             --
-------------------------------------------------------------------------------------------------

function Utils.PersistTemplateValues(character, copiedCharacter)
    local UUIDChar = Utils.GetGUID(character)

    local entity = Ext.Entity.Get(UUIDChar)
    local copiedEntity = Ext.Entity.Get(copiedCharacter)

    if (entity and copiedEntity) then
        local Template = entity.ServerCharacter.Character.Template
        local CopiedTemplate = copiedEntity.ServerCharacter.Character.Template

        if not PersistentVars["OriginalTemplates"][UUIDChar] then
            PersistentVars["OriginalTemplates"][UUIDChar] = {}
        end

        if (Utils.IsOrigin(UUIDChar) or Utils.IsHireling(UUIDChar)) then
            for _, k in pairs(Constants.PersistedOriginTemplateKeys) do
                PersistentVars["OriginalTemplates"][UUIDChar][k] = Template[k]
                PersistentVars["OriginalTemplates"][UUIDChar]["Copied" .. k] = CopiedTemplate[k]

                -- Make sure we keep the important pieces
                PersistentVars["OriginalTemplates"][UUIDChar]["CopiedStats"] = Template.Stats
                PersistentVars["OriginalTemplates"][UUIDChar]["CopiedGeneratePortrait"] = Template.GeneratePortrait
                PersistentVars["OriginalTemplates"][UUIDChar]["CopiedIcon"] = Template.Icon
            end
        else
            for _, k in pairs(Constants.PersistedTemplateKeys) do
                PersistentVars["OriginalTemplates"][UUIDChar][k] = Template[k]
                PersistentVars["OriginalTemplates"][UUIDChar]["Copied" .. k] = CopiedTemplate[k]
            end
        end
    end
end

function Utils.PersistHotBarSlot(character)
    local UUIDChar = Utils.GetGUID(character)

    local barIndex, barRemoved, slotIndex = Utils.FindSpellIndexOnHotbar(UUIDChar, Constants.CustomSpells["SpellsContainer"])

    if (barIndex and slotIndex) then
        local _, slot = Utils.GetHotbarSlotFromIndex(UUIDChar, barIndex, slotIndex)

        if (slot and PermittedCopyObjects[getmetatable(slot)]) then
            local convertedSlot = {}

            for key, val in pairs(slot) do
                if (PermittedCopyObjects[getmetatable(val)]) then
                    convertedSlot[key] = {}
                    for innerKey, innerVal in pairs(val) do
                        -- We only do one inner copy and pray we don't miss anything important
                        if (type(innerVal) ~= "userdata") then
                            convertedSlot[key][innerKey] = innerVal
                        end
                    end
                else
                    convertedSlot[key] = val
                end
            end

            PersistentVars["SpellOwners"][UUIDChar] = {
                ["BarIndex"] = barIndex,
                ["BarRemoved"] = barRemoved,
                ["SlotIndex"] = slotIndex,
                ["Slot"] = convertedSlot,
            }
        end
    else
        PersistentVars["SpellOwners"][UUIDChar] = {
            ["Slot"] = {
                ["SpellId"] = {
                    ["Prototype"] = Constants.CustomSpells["SpellsContainer"]
                }
            }
        }
    end
end

-------------------------------------------------------------------------------------------------
--                                                                                             --
--                                        Logging                                              --
--                                                                                             --
-------------------------------------------------------------------------------------------------

function Utils.Info(message)
    Ext.Utils.Print(AEE.modPrefix .. ' [Info] ' .. message)
end

function Utils.Warn(message)
    Ext.Utils.Print(AEE.modPrefix .. ' [Warning] ' .. message)
end

function Utils.Debug(message)
    Ext.Utils.Print(AEE.modPrefix .. ' [Debug] ' .. message)
end

function Utils.Error(message)
    Ext.Utils.Print(AEE.modPrefix .. ' [Error] ' .. message)
end
