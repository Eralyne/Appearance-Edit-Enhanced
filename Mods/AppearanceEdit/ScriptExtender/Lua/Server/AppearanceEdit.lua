local SpellHolder

-- Give player Resculpt spell on load
Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", function ()
    SpellHolder = GetHostCharacter()
    AddSpell(SpellHolder, "Shout_Open_Creation", 0, 0)
    Ext.Utils.Print("Resculpt Spell Added")

    -- Open character creation on spell use
    Ext.Osiris.RegisterListener("UsingSpell", 5, "after", function (_, name, _, _, _, _)
        if name == 'Shout_Open_Creation' then
            StartCharacterCreation()
            Ext.Utils.Print("Character Creator Shown")
        end
    end)

    -- Clear Dream Visitor after creation
    Ext.Osiris.RegisterListener("CharacterCreationFinished", 0, "after", function ()
        for _,entry in pairs(Osi.DB_GLO_DaisyAwaitsAvatar:Get(nil,nil)) do 
            SetOnStage(entry[1], 0)
            Osi.DB_GLO_DaisyAwaitsAvatar:Delete(entry[1], nil)
        end
        Ext.Utils.Print("Character Creation Finished, Daisies Cleaned Up")
    end)

    -- It's testing time as I test all over the code
    -- local entity = Ext.Osiris.GetCharacter(GetHostCharacter())
end)

-- Remove Resculpt spell on saving game (to allow clean uninstalls)
-- Ext.Osiris.RegisterListener("OnShutdown", 1, "before", function (int)
--     SpellHolder = GetHostCharacter()
--     RemoveSpell(SpellHolder, "Shout_Open_Creation", 0)
-- end)

