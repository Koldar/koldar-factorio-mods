require "commons.paths"

-- fetch the path from CWD to resources
function resource()
    return window_paths:find_directory(nil, "resources", nil)
end

-- load resource from the factorio side
-- @return file/resource/image.jpeg
function fetch_resource(resource)
    return "file/" .. resource() .. "/" .. resource
end

-- fetch the path from CWD to commons/
function commons()
    return window_paths:find_directory(nil, "commons", nil))
end

-- fetch the path from CWD to commons/file
function fetch_commons(file)
    return window_paths:join_path(window_paths:find_directory(nil, "commons", nil), file)
end