local class = require 'middleclass'
local coroutine = require "coroutine"
local stream = require "stream"
local inspect = require "inspect"

-- We use a min heap to model the priority queue
-- If the priority is not defines, we will use "next_n" to estabilsh priority (thuis this will be a FIFO queue)
local PriorityQueueItem = class("PriorityQueueItem");

function PriorityQueueItem:initialize(args)
    self.priority = args.priority
    self.item = args.item
end

function PriorityQueueItem:get_item()
    return self.item;
end


local PriorityQueue = class("PriorityQueue");

function PriorityQueue:initialize(args)
    if args == nil then
        args = {}
    end
    if args.priority_function == nil then
        args.priority_function = function(x) return self.next_n; end;
    end
    self.priority_function = args.priority_function
    self.next_n = 0
    self.heap_len = 0
    -- heap of PriorityQueueItem
    self.heap = {}
end

function PriorityQueue:size()
    return self.heap_len;
end

function PriorityQueue:is_empty()
    return self:size() == 0
end

function PriorityQueue:last_index()
    if self:is_empty() then
        return 0
    else
        return self:size() - 1;
    end
end

function PriorityQueue:add_all(x) 
    for y in x do
        self:add(y)
    end
end

function PriorityQueue:add(x)
    local new_priority = self.priority_function(x)
    local new_item = PriorityQueueItem{priority=new_priority, item=x}

    -- add at the end of the heap
    self.heap[self.heap_len] = new_item
    self.next_n = self.next_n + 1
    self.heap_len = self.heap_len + 1

    self:_heapify_up(self.heap_len - 1)
    return self.next_n - 1
end

function PriorityQueue:to_string()
    local result = "(size=" .. self:size() .. "){ ";
    for k,v in pairs(self.heap) do
        result = result .. (k .. "[".. v.priority .."]".. "=" .. v.item) .. ", ";
    end
    result = result .. " }";
    return result;
end

function PriorityQueue:delete_min()
    if (self:is_empty()) then
        error("heap is empty")
    end
    local result = self.heap[0];
    local last_index = self:last_index();

    -- print("last index")
    -- print(inspect(last_index))
    -- print("heap before:")
    -- print(self:to_string())
    -- replace the mininum element wit hte maximum one, then percolate
    self:_swap(0, last_index)
    self.heap_len = self.heap_len - 1;
    self.heap[last_index] = nil;
    -- print("heap after:")
    -- print(self:to_string())
    
    self:_heapify_down(0)
    -- print("heap after heapify:")
    -- print(self:to_string())
    return result.item;
end

-- fetch the first value present in the priority queue
function PriorityQueue:peek()
    if (self:is_empty()) then
        error("heap is empty")
    end
    -- print("heap reprsentation")
    -- print(self:to_string())
    return self.heap[0].item;
end

function PriorityQueue:pop()
    if (self:is_empty()) then
        error("heap is empty")
    end
    local result = self:delete_min();
    return result;
end

function PriorityQueue:_get(index)
    local result = self.heap[index];
    -- print(index)
    -- print(self:size())
    return result;
end

function PriorityQueue:_is_root(index)
    return index == 0;
end

function PriorityQueue:_is_leaf(index)
    -- print("is leaf")
    -- print(index)
    return self:_left_child_index(index) > self.heap_len;
end

function PriorityQueue:_get_parent_index(index)
    return math.floor((index - 1) / 2);
end

function PriorityQueue:_get_parent(index)
    return self.heap[self:_get_parent_index(index)];
end

function PriorityQueue:_left_child_index(index)
    return 2 * index + 1;
end

function PriorityQueue:_right_child_index(index)
    return 2 * index + 2;
end

function PriorityQueue:_left_child(index)
    return self.heap[self:_left_child_index(index)];
end

function PriorityQueue:_right_child(index)
    return self.heap[self:_right_child_index(index)];
end

function PriorityQueue:_has_left_child(parent)
    return self:_left_child_index(parent) < self.heap_len
end

function PriorityQueue:_has_right_child(parent)
    return self:_right_child_index(parent) < self.heap_len
end

function PriorityQueue:_heapify_down(index)
    if self:_is_leaf(index) then
        return;
    end

    local left_child_index = self:_left_child_index(index);
    local right_child_index = self:_right_child_index(index);
    local largest_index = index;

    local index_priority = self:_get(index).priority;

    -- find the largest element between index, left and right
    -- this "<" is what makes the priority queue a min queue
    local has_left = self:_has_left_child(index)
    local has_right = self:_has_right_child(index)
    
    if has_left then
        local left_priority = self:_left_child(index).priority;
        if left_priority < index_priority then
            largest_index = left_priority
        end
    end
    if has_right then
        local right_priority = self:_right_child(index).priority;
        if right_priority < index_priority then
            largest_index = right_priority
        end
    end

    -- swap index with largest
    if largest_index ~= index then
        self:_swap(index, largest_index)
        -- print("swapping " .. index .. " with " .. largest_index .. " ...")
        self:_heapify_down(largest_index)
    end
end

function PriorityQueue:_heapify_up(index_of_new_item)
    if (self:_is_root(index_of_new_item)) then
        return;
    end

    local parent_index = self:_get_parent_index(index_of_new_item)

    -- this "<" is what makes the priority queu a min queue
    local parent_priority = self:_get(parent_index).priority;
    local index_priority = self:_get(index_of_new_item).priority;
    if parent_priority > index_priority then
        self:_swap(parent_index, index_of_new_item)
        self:_heapify_up(parent_index)
    end
end

function PriorityQueue:_swap(indexa, indexb)
    local valuea = self.heap[indexa];
    local valueb = self.heap[indexb];
    self.heap[indexa] = valueb;
    self.heap[indexb] = valuea;
end

function PriorityQueue:contains(x)
    for v in self:iter() do
        if v == x then
            return true;
        end
    end
    return false;
end

-- convert the list into a lua-stream-api
function PriorityQueue:stream()
    return stream(self:iter())
end

function PriorityQueue:iter()
    co = coroutine.create(function()
        for i=0,self:size(),1 do
            coroutine.yield(self:_get(i).item)
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

return PriorityQueue