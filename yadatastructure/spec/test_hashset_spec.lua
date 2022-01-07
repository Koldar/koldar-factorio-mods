
local HashSet = require('src.HashSet')

describe("tests", function()

    describe("test sets", function()
        it("01", function ()
            l = HashSet()
            local i0 = l:add(4)
            local i1 = l:add(2)
            local i2 = l:add(1)
        
            assert.are.same(i0, 0)
            assert.are.same(i1, 1)
            assert.are.same(i2, 2)
        
            assert.are.same(l:size(), 3)
            assert.are.same(l:is_empty(), false)
        
            sum = 0
            for v in l:iter() do
                sum = sum + v
            end
            assert.are.same(sum, 7)
        end)
        
        it("remove head", function ()
            l = HashSet()
            local i0 = l:add(4)
            local i1 = l:add(2)
            local i2 = l:add(1)
        
            l:remove_object(4)
            assert.are.same(l:size(), 2)
            sum = 0
            for v in l:iter() do
                sum = sum + v
            end
            assert.are.same(sum, 3)
        end)
        
        it("remove middle", function ()
            l = HashSet()
            local i0 = l:add(4)
            local i1 = l:add(2)
            local i2 = l:add(1)
        
            l:remove_object(2)
            assert.are.same(l:size(), 2)
            sum = 0
            for v in l:iter() do
                sum = sum + v
            end
            assert.are.same(sum, 5)
        end)
        
        it("remove tail", function ()
            l = HashSet()
            l:add(4)
            l:add(2)
            l:add(1)
        
            l:remove_object(1)
            assert.are.same(l:size(), 2)
            sum = 0
            for v in l:iter() do
                sum = sum + v
            end
            assert.are.same(sum, 6)
        end)
    end)
end)

