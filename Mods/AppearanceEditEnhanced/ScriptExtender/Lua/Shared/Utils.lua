---@diagnostic disable: undefined-global

-- Local Functions --

local function protectedSet(old, key, value)
    old[key] = value
end

-- Global Functions --

function Utils.Size(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function Utils.Set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

function Utils.TryGetProxy(entity, proxy)
    return entity[proxy]
end

function Utils.TryGetDB(query, arity)
    local db = Osi[query]
    if db and db.Get then
        return db:Get(table.unpack({}, 1, arity))
    end
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

function Utils.DeepClean(old)
    local permittedCopyObjects = Utils.Set(Constants.PermittedCopyObjects)
    if permittedCopyObjects[getmetatable(old)] then
        for k, v in pairs(old) do
            if (k ~= "Template" and k ~= "OriginalTemplate") then
                if permittedCopyObjects[getmetatable(v)] then
                    Utils.DeepClean(old[k])
                elseif getmetatable(v) ~= "EntityProxy" then
                    pcall(protectedSet, old, k, nil)
                end
            end
        end
    end
end

function Utils.DeepWrite(old, new)
    local permittedCopyObjects = Utils.Set(Constants.PermittedCopyObjects)
    if permittedCopyObjects[getmetatable(new)] then
        for k, v in pairs(new) do
            if (k ~= "Template" and k ~= "OriginalTemplate") then
                if permittedCopyObjects[getmetatable(v)] then
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

function Utils.CloneEntity(old, new)
    Utils.DeepClean(old[entry])
    Utils.DeepWrite(old[entry], new[entry])

    local ExcludedReps = Utils.Set(Constants.ExcludedReplications)

    if (not ExcludedReps[entry]) then
        old:Replicate(entry)
    end
end

function Utils.CloneEntityEntry(old, new, entry)
    Utils.CloneEntity(old[entry], new[entry])
end

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
