local class = require 'middleclass'
local coroutine = require "coroutine"
local stream = require "lua-stream-api"

local Stack = class("Stack");

function Stack:initialize()
    self.next_id = 0;
    self.stack = {};
end

function Stack:size()
    return self.next_id;
end

function Stack:is_empty()
    return self.next_id == 0;
end

function Stack:peek()
    return self.stack[self.next_id - 1]
end

function Stack:pop()
    local result = self.stack[self.next_id - 1]
    self.stack[self.next_id - 1] = nil
    self.next_id = self.next_id - 1
    return result
end

function Stack:push_all(x) 
    for (local y in x) do
        self:push(y)
    end
end

function Stack:push(x)
    self.stack[self.next_n] = x
    self.next_n = self.next_n + 1
end

return Stack