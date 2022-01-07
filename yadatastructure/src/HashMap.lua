local class = require 'middleclass'
local coroutine = require "coroutine"

local HashMap = class("HashMap");

function HashMap:initialize()
    self.table = {}
    self.len = 0
end

function HashMap:put(k, v)
    self.table[k] = v
    self.len = self.len + 1
end

function HashMap:remove_by_key(k)
    self.table[k] = nil
    self.len = self.len - 1
end

function HashMap:remove_by_value(x)
    for k,v in pairs(self.table) do
        if v == x then
            self.table[k] = nil
            self.len = self.len - 1
            return true
        end
    end
    return false;
end

function HashMap:is_empty()
    return self.len == 0
end

function HashMap:get(k)
    return self.table[k]
end


function HashMap:contains_key(x)
    if self.table[k] == nil then
        return false
    end
    return true
end

function HashMap:contains_value(x)
    for k, v in pairs(self.table) do
        if v == x then
            return true;
        end
    end
    return false;
end

-- fetch a stream of keys
function HashMap:stream_keys()
    return stream(self:iter())
end

-- fetch a stream of values
function HashMap:stream_values()
    return stream(self:iter()).map(function(k) 
        return self.table[k]
    end)
end

-- fetch a srteam of pairs
function HashMap:stream_entries()
    return stream(self:iter()).map(function(k) 
        return k, self.table[k]
    end)
end

function HashMap:iter()
    co = coroutine.create(function()
        for k,v in pairs(self.table) do
            coroutine.yield(k)
        end
    end)
    iterator =  function ()
        local status, k = coroutine.resume(co)
        if status then
            return k
        end
    end
    return iterator
end

function HashMap:entry_set()
    co = coroutine.create(function()
        for k,v in pairs(self.table) do
            coroutine.yield(k, v)
        end
    end)
    iterator =  function ()
        local status, k, v = coroutine.resume(co)
        if status then
            return k, v
        end
    end
    return iterator
end

return HashMap