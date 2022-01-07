
local PriorityQueue = require('src.PriorityQueue')

describe("tests", function()
    describe("fifo queue", function()
        it("01", function ()
            l = PriorityQueue{}
            local i0 = l:add(4)
            local i1 = l:add(2)
            local i2 = l:add(1)
        
            assert.are.same(i0, 0)
            assert.are.same(i1, 1)
            assert.are.same(i2, 2)
        
            assert.are.same(l:size(), 3)
            assert.are.same(l:last_index(), 2)
            assert.are.same(l:is_empty(), false)
            assert.are.same(l:peek(), 4)
            assert.are.same(l:pop(), 4)
            assert.are.same(l:pop(), 2)
            assert.are.same(l:pop(), 1)
            assert.are.same(l:is_empty(), true)
        end)

        it("iterate over queue", function()
            l = PriorityQueue{}
            local i0 = l:add(4)
            local i1 = l:add(2)
            local i2 = l:add(1)

            sum = 0
            for v in l:iter() do
                sum = sum + v
            end
            assert.are.same(sum, 7)
        end)
        
        it("remove head", function ()
            l = PriorityQueue{}
            local i0 = l:add(4)
            local i1 = l:add(2)
            local i2 = l:add(1)
        
            assert.are.same(l:size(), 3)
            assert.are.same(l:peek(), 4)
            l:pop()
            assert.are.same(l:size(), 2)
            assert.are.same(l:peek(), 2)
            assert.are.same(l:last_index(), 1)
            sum = 0
            for v in l:iter() do
                sum = sum + v
            end
            assert.are.same(sum, 3)
        end)
    end)
end)

