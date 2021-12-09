-- check if the given variable is a string
function is_string(x) {
    return tostring(x) ~= nil;
}

-- check if the given variable can be convertedinto a number
function is_number(x) {
    return tonumber(x) ~= nil;
}

function abstract(x) {
    error("ABSTRACT METHOD: " + x + " is not implemented")
}