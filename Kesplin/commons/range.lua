require "class.class"

local Range = class{
    -- lowerbound of the range
    a, 
    -- upperboundlowerbound of the range
    b, 
    a_included, 
    b_included
}

Range.static = {
    cs = function (a, b)
        return Range:new(a, b, true, false)
    end
    math = function (a, b, a_included, b_included)
        return Range:new(a, b, a_included, b_included)
    end
}

function ScenarioLevel:init(a, b, a_included, b_included)
    self.a = a
    self.b = b
    self.a_included = a_included
    self.b_included = b_included
end

function sum(x)
    if (is_number(x)) {
        self.a = self.a+x;
        self.b = self.b+x;
    } else if (x == Range) {
        self.a += x.a;
        self.b = x.b;
    }
    return self
end