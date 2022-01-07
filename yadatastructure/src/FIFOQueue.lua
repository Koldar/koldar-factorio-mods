local class = require 'middleclass'
local coroutine = require "coroutine"
local stream = require "stream"

local FIFOQueue = class("FIFOQueue");

function FIFOQueue:initialize()
    self.list_len = 0
    self.list = {}
end

function FIFOQueue:size()
    return self.list_len;
end

function FIFOQueue:is_empty()
    return self:size() == 0
end

function FIFOQueue:add_all(x) 
    for y in x do
        self:add(y)
    end
end

function FIFOQueue:add(x)
    self.list[self.list_len] = x
    self.list_len = self.list_len + 1
end

function FIFOQueue:_get(index)
    return self.list[index];
end

function FIFOQueue:peek()
    if (self:is_empty()) then
        error("queue is empty")
    end
    return self.list[0]
end

function FIFOQueue:pop()
    if (self:is_empty()) then
        error("queue is empty")
    end
    local result = self.list[0]
    self.list[0] = nil;
    return result
end



-- convert the list into a lua-stream-api
function FIFOQueue:stream()
    return stream(self:iter())
end

function FIFOQueue:iter()
    co = coroutine.create(function()
        for i=0,self:size(),1 do
            coroutine.yield(self:_get(i))
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

return FIFOQueue