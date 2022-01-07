
-- perform a BFS algorithm.
-- @param graph the graph to iterate over
-- @param mapper a function that accept 2 input: id which is the id of the vertex; vertex is the paylaod of the vertex
function perform_bfs(args)
    local graph = args.graph
    local start = args.start
    local mapper = args.mapper

    -- 0: unvisited
    -- 1: visited
    local COLOR_TABLE = {}
    for (local id in graph:vertices_id_stream()) do
        COLOR_TABLE[id] = 0
    end

    function bfs_recursive(id, mapper)
        COLOR_TABLE[id] = 1
        mapper(id, g:get_vertex(id))
        for (local next_id in graph:stream_sinks_id_of(id)) do
            if (COLOR_TABLE[id] ~= 1) then
                COLOR_TABLE[id] = 1
                mapper(next_id, g:get_vertex(next_id))
            end
        end
    end

    for (local id in graph:vertices_id_stream()) do
        if (COLOR_TABLE[id] == 0) then
            bfs_recursive(id, mapper)
        end
    end
end


-- perform a DFS algorithm.
-- @param graph the graph to iterate over
-- @param mapper a function that accept 2 input: id which is the id of the vertex; vertex is the paylaod of the vertex
function perform_dfs(args)
    local graph = args.graph
    local mapper = args.mapper

    -- 0: unvisited
    -- 1: visited
    local COLOR_TABLE = {}
    for (local id in graph:vertices_id_stream()) do
        COLOR_TABLE[id] = 0
    end

    function dfs_recursive(id, mapper)
        COLOR_TABLE[id] = 1
        mapper(id, g:get_vertex(id))
        for (local next_id in graph:stream_sinks_id_of(id)) do
            if (COLOR_TABLE[id] ~= 1) then
                dfs_recursive(next_id, mapper)
            end
        end
    end

    for (local id in graph:vertices_id_stream()) do
        if (COLOR_TABLE[id] == 0) then
            dsf_recursive(id, mapper)
        end
    end
end


-- find all the vertices in the graph which can be identified as sources (they are successors of no vertex)
-- @return set of node id that have no sources
function get_sources(args)
    local graph = args.graph
    return HashSet(graph:vertices_id_stream():filter(function (id) ~graph:has_sources(id)).toarray())
end

-- find all the vertices in the graph which can be identified as sources (they are successors of no vertex)
-- @return set of node id that have no sinks
function get_sinks(args)
    local graph = args.graph
    return HashSet(graph:vertices_id_stream():filter(function (id) ~graph:has_sinks(id)).toarray())
end