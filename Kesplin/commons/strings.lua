
-- remove a list of characters from a string
function remove_characters_from_string(str, escape)
    local result = ""
    for i=0,str.len(), 1 do
        if (~is_character_in_string(str[i], escape)) then
            result = result .. str[i]
        end
    end
    return result
end

-- remove a list of characters from a string
function trim_string(str)
    return str:gsub("^[ \t\n\r]+", ""):gsub("[ \t\n\r]+$", "")
end

-- check if a character is in a string or not
function is_character_in_string(ch, str)
    for j=0, str.len(), 1 do
        if (str[i] == ch) then
            return true
        end
    end
    return false
end
