---@diagnostic disable: undefined-global

-- -- We don't want to do work *too* much
local Time = 0

Ext.Events.Tick:Subscribe(function(e)
    Time = Time + e.Time.DeltaTime

    if (Time >= Constants.TickDelay) then
        Time = 0

        for char, _ in pairs(PersistentVars["OriginalTemplates"]) do
            local Entity = Ext.Entity.Get(char)

            -- Fix GameObjectVisual
            local GOVType = Entity.GameObjectVisual.Type

            if (GOVType ~= 2) then
                Ext.Entity.Get(char).GameObjectVisual.Type = 2
                Entity:Replicate("GameObjectVisual")
            end
        end
    end
end)
