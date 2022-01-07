local class = require 'middleclass'
local coroutine = require "coroutine"
local stream = require "stream"

local ArrayList = class("ArrayList");

function ArrayList:initialize()
    self.next_n = 0
    self.list_len = 0
    self.list = {}
end

function ArrayList:size()
    return self.list_len;
end

function ArrayList:last_index()
    if self:is_empty() then
        return 0
    else
        return self:size() - 1;
    end
end

function ArrayList:is_empty()
    return self:size() == 0
end

function ArrayList:add_all(x) 
    for y in x do
        self:add(y)
    end
end

function ArrayList:add(x)
    self.list[self.next_n] = x
    self.next_n = self.next_n + 1
    self.list_len = self.list_len + 1
    return self.next_n - 1
end

function ArrayList:get(index)
    return self.list[index]
end

function ArrayList:remove_index(index)
    local old_size = self:size()
    for i=index, old_size, 1 do
        self.list[i] = self.list[i + 1]
    end
    self.list[old_size] = nil
    self.next_n = self.next_n - 1;
    self.list_len = self.list_len - 1
end

function ArrayList:remove_object(x)
    for i=0, self:size(), 1 do
        if self:get(i) == x then
            self:remove_index(i)
            return i
        end
    end
end

function ArrayList:contains_index(x)
    for k, v in pairs(self.list) do
        if k == x then
            return true;
        end
    end
    return false;
end

function ArrayList:contains_value(x)
    for v in self:iter() do
        if v == x then
            return true;
        end
    end
    return false;
end

-- convert the list into a lua-stream-api
function ArrayList:stream()
    return stream(self:iter())
end

function ArrayList:iter()
    co = coroutine.create(function()
        for i=0,self:size(),1 do
            coroutine.yield(self:get(i))
        end
    end)
    iterator =  function ()
        local status, v = coroutine.resume(co)
        if status then
            return v
        end
    end
    return iterator
end

return ArrayList