---@diagnostic disable: undefined-global, undefined-field

-- Retrieve Mod Variables --
local function LoadModVars()
    ModVars = Ext.Vars.GetModVariables(Constants.ModUUID)

    for k, _ in pairs(PersistentVarsTemplate) do
        if (not ModVars[k]) then
            ModVars[k] = {}
        end
    end

    Ext.Vars.SyncModVariables(Constants.ModUUID)
end

local function RemoveSpellFromCharacter(character, clearPersistantVars)
    local UUIDChar = Utils.GetGUID(character)

    ModVars = Ext.Vars.GetModVariables(Constants.ModUUID)

    Osi.RemoveSpell(UUIDChar, Constants.CustomSpells["SpellsContainer"], 1)

    if (clearPersistantVars) then
        ModVars["SpellOwners"][UUIDChar] = nil
        ModVars["SpellOwners"] = ModVars["SpellOwners"]
    else
        Utils.PersistHotBarSlot(UUIDChar)
    end
end

local function FixAppearanceTemplates()
    -- Fix templates to prevent PROBLEMS
    -- This is a backup in-case they load/close game during mirror
    for char, _ in pairs(ModVars["OriginalTemplates"]) do
        Utils.ShiftEquipmentVisual(char, true)
    end
end

local function SaveCleanUp()
    LoadModVars()
    -- Fix spells
    -- for player, _ in pairs(ModVars["SpellOwners"]) do
    --     RemoveSpellFromCharacter(player, false)
    -- end

    FixAppearanceTemplates()
end

local function GiveSpellToCharacter(character)
    local UUIDChar = Utils.GetGUID(character)

    -- For Mod Authors: Replace this with your spell/container
    local Spell = Constants.CustomSpells["SpellsContainer"]

    if (Osi.HasSpell(UUIDChar, Spell) == 0) then
        local PersistantChar = ModVars["SpellOwners"][UUIDChar]

        if (PersistantChar and PersistantChar["Slot"]) then
            -- Utils.Debug("Adding spells to " .. UUIDChar)
            Osi.AddSpell(UUIDChar, Spell, 0, 1)
        else
            Osi.AddSpell(UUIDChar, Spell, 1, 1)

            -- Spell doesn't show up on Hotbar in-time to check entity
            -- We don't need slot yet, we just need a SpellOwner
            ModVars["SpellOwners"][UUIDChar] = {}
        end
    end
end

local function RestoreSpells()
    if (Utils.Size(ModVars["SpellOwners"]) > 0) then
        for player, _ in pairs(ModVars["SpellOwners"]) do
            GiveSpellToCharacter(player)
        end
    else
        local success, result = pcall(Utils.TryGetDB, "DB_Players", 1)

        if (success) then
            for _, player in pairs(result) do
                GiveSpellToCharacter(player[1])
            end
        end
    end
end

local function CloneTemplateEntities()
    -- TODO: Unironically, I don't think this even does anything
    for origin, copy in pairs(ModVars["OriginCopiedChars"]) do
        Utils.CloneProxy(Ext.Entity.Get(origin).ServerCharacter.Template, Ext.Entity.Get(copy).ServerCharacter.Template)
    end

    for char, _ in pairs(ModVars["OriginalTemplates"]) do
        Utils.ShiftEquipmentVisual(char, true)
        Utils.CopyAppearanceVisuals(char)
    end
end

local function LoadedActions()
    LoadModVars()
    RestoreSpells()
    CloneTemplateEntities()
end

Ext.Events.GameStateChanged:Subscribe(function(e)
    -- ----------------------------- Loaded ------------------------------ --
    if e.FromState == "Sync" and e.ToState == "Running" then
        Utils.Info("Game Loaded, restoring mod aspects.")
        LoadedActions()

        -- ----------------------------- Before Saving ------------------------------ --
    elseif e.FromState == "Running" and e.ToState == "Save" then
        Utils.Info("Saving started, cleaning up.")
        SaveCleanUp()

        -- -------------------------------- Post Save ------------------------------- --
    elseif e.FromState == "Save" and e.ToState == "Running" then
        Utils.Info("Saving finished, restoring mod aspects.")
        LoadedActions()

        -- ------------------ Go back to main ------------------ --
    elseif e.FromState == "Running" and e.ToState == "UnloadLevel" then
        Utils.Info("Leveling unloading, cleaning up.")
        SaveCleanUp()

        -- ------------------ Load save ------------------ --
    elseif e.FromState == "UnloadSession" and e.ToState == "LoadSession" then
        Utils.Info("Loading another save, cleaning up.")
        SaveCleanUp()
    end
end)

Ext.Osiris.RegisterListener("CharacterJoinedParty", 1, "after", function(character)
    Utils.Info(character .. " joined the party, providing spells")
    GiveSpellToCharacter(character)
end)

Ext.Osiris.RegisterListener("CharacterLeftParty", 1, "after", function(character)
    Utils.Info(character .. " left the party, removing spells")
    RemoveSpellFromCharacter(character, true)
end)
