local class = require 'middleclass'

local HashSet = class("HashSet");

function HashSet:initialize()
    self.next_n = 0
    self.set = {}
    self.set_len = 0
end

function HashSet:size()
    return self.set_len;
end

function HashSet:is_empty()
    return self:size() == 0
end

function HashSet:add(x)
    self.set[self.next_n] = x
    self.next_n = self.next_n + 1
    self.set_len = self.set_len + 1
    return self.next_n - 1
end

function HashSet:add_all(x) 
    for y in x do
        self:add(y)
    end
end

function HashSet:remove_object(x)
    for k, v in pairs(self.set) do
        if v == x then
            self.set[k] = nil
            self.set_len = self.set_len - 1
            return true
        end
    end
    return false
end

function HashSet:contains_value(x)
    for k, v in pairs(self.set) do
        if v == x then
            return true;
        end
    end
    return false;
end

function HashSet:stream()
    return stream(self:iter())
end

function HashSet:iter()
    co = coroutine.create(function()
        for k, v in pairs(self.set) do
            coroutine.yield(v)
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

return HashSet;