
local ArrayList = require('src.ArrayList')

describe("tests", function()
    describe("array list", function()
        it("01", function ()
            l = ArrayList()
            local i0 = l:add(4)
            local i1 = l:add(2)
            local i2 = l:add(1)
        
            assert.are.same(i0, 0)
            assert.are.same(i1, 1)
            assert.are.same(i2, 2)
        
            assert.are.same(l:size(), 3)
            assert.are.same(l:is_empty(), false)
            assert.are.same(l:get(0), 4)
            assert.are.same(l:get(1), 2)
            assert.are.same(l:get(2), 1)
        
            assert.are.same(l:last_index(), 2)
        
            sum = 0
            for v in l:iter() do
                sum = sum + v
            end
            assert.are.same(sum, 7)
        end)
        
        it("remove head", function ()
            l = ArrayList()
            local i0 = l:add(4)
            local i1 = l:add(2)
            local i2 = l:add(1)
        
            l:remove_index(0)
            assert.are.same(l:size(), 2)
            assert.are.same(l:get(0), 2)
            assert.are.same(l:get(1), 1)
            assert.are.same(l:last_index(), 1)
            sum = 0
            for v in l:iter() do
                sum = sum + v
            end
            assert.are.same(sum, 3)
        end)
        
        it("remove middle", function ()
            l = ArrayList()
            local i0 = l:add(4)
            local i1 = l:add(2)
            local i2 = l:add(1)
        
            l:remove_index(1)
            assert.are.same(l:size(), 2)
            assert.are.same(l:get(0), 4)
            assert.are.same(l:get(1), 1)
            assert.are.same(l:last_index(), 1)
            sum = 0
            for v in l:iter() do
                sum = sum + v
            end
            assert.are.same(sum, 5)
        end)
        
        it("remove tail", function ()
            l = ArrayList()
            local i0 = l:add(4)
            local i1 = l:add(2)
            local i2 = l:add(1)
        
            l:remove_index(2)
            assert.are.same(l:size(), 2)
            assert.are.same(l:get(0), 4)
            assert.are.same(l:get(1), 2)
            assert.are.same(l:last_index(), 1)
            sum = 0
            for v in l:iter() do
                sum = sum + v
            end
            assert.are.same(sum, 6)
        end)
        
        it("remove head by object",  function ()
            l = ArrayList()
            local i0 = l:add(4)
            local i1 = l:add(2)
            local i2 = l:add(1)
        
            l:remove_object(4)
            assert.are.same(l:size(), 2)
            assert.are.same(l:get(0), 2)
            assert.are.same(l:get(1), 1)
            assert.are.same(l:last_index(), 1)
            sum = 0
            for v in l:iter() do
                sum = sum + v
            end
            assert.are.same(sum, 3)
        end)
        
        it("remove middle by object", function ()
            l = ArrayList()
            local i0 = l:add(4)
            local i1 = l:add(2)
            local i2 = l:add(1)
        
            l:remove_object(2)
            assert.are.same(l:size(), 2)
            assert.are.same(l:get(0), 4)
            assert.are.same(l:get(1), 1)
            assert.are.same(l:last_index(), 1)
            sum = 0
            for v in l:iter() do
                sum = sum + v
            end
            assert.are.same(sum, 5)
        end)
        
        it("remove tail by object", function ()
            l = ArrayList()
            local i0 = l:add(4)
            local i1 = l:add(2)
            local i2 = l:add(1)
        
            l:remove_object(1)
            assert.are.same(l:size(), 2)
            assert.are.same(l:get(0), 4)
            assert.are.same(l:get(1), 2)
            assert.are.same(l:last_index(), 1)
            sum = 0
            for v in l:iter() do
                sum = sum + v
            end
            assert.are.same(sum, 6)
        end)
    end)
end)

