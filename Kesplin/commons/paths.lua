require "libraries.class.class"
require "os"
require "strings"

IOSEnv = class()

function IOSEnv:load_resource(x)
    abstract("load_resource")
end
function IOSEnv:get_cwd()
    abstract("get_cwd")
end
function IOSEnv:part_path()
    abstract("part_path")
end
function IOSEnv:join_path(...)
    local result = "";
    local arg = {...}
    for i, v in pairs(arg) do
        if (i == 1) then
            result = v
        else
            result = result .. self:part_path() .. v
        end
    end
    return result
end
function IOSEnv:get_parent(p)
    abstract("get_parent")
end
function IOSEnv:execute(command)
    abstract("execute")
end
function IOSEnv:find_directory(start, target, max_top)
    if start == nil then
        start = self:get_cwd()
    end
    if max_top == nil then
        max_top = 5
    end
    local tmp = start
    local i = 0
    while true do
        for k, v in pairs(self:list_directories(tmp)) do
            if v == target then
                return self:join_path(tmp, target)
            end
        end
        tmp = self:get_parent(tmp)
        i = i + 1
        if i == max_top then
            error("Cannot find the target " .. target .. "!")
        end
    end
end
function IOSEnv:list_directories(x)
    abstract("list_directories")
end

-- *******************************************
-- WINDOWS ENV 
-- *******************************************

WindowEnv = IOSEnv:extend();

function WindowEnv:load_resource(x)
    abstract("load_resource")
end
function WindowEnv:get_cwd()
    local result = self:execute("cd");
    result = trim_string(result)
    return result
end
function WindowEnv:part_path()
    return "\\"
end
function WindowEnv:get_parent(p)
    return p .. self:part_path() .. "..";
end
function WindowEnv:execute(command)
    local handle = io.popen(command, "r")
    local result = handle:read("*a")
    handle:close()
    return result
end

function WindowEnv:list_directories(x)
    content = self:execute("dir /b /o:n /ad " .. x)
    result = {}
    for s in content:gmatch("[^\n\r\n]+") do
        table.insert(result, s)
    end
    return result
end

-- *******************************************
-- LINUX ENV 
-- *******************************************

LinuxEnv = IOSEnv:extend();


function LinuxEnv:load_resource(x)
    abstract("load_resource")
end
function LinuxEnv:get_cwd()
    local result = self:execute("pwd");
    result = trim_string(result)
    return result
end
function LinuxEnv:part_path()
    return "/"
end
function LinuxEnv:get_parent(p)
    return p .. self:part_path() .. "..";
end
function LinuxEnv:execute(command)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()
    return result
end

function LinuxEnv:list_directories(x)
    content = self:execute("ls -d " + x)
    result = {}
    for s in content:gmatch("[^\n\r\n]+") do
        table.insert(result, s)
    end
    return result
end

window_paths = WindowEnv()
linux_paths = LinuxEnv()