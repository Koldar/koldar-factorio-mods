local class = require 'middleclass'
local coroutine = require "coroutine"
local stream = require "lua-stream-api"
HashMap = require "HashMap"


-- *********************************************************************
-- ******************* MIXEDGRAPHEDGE **********************************
-- *********************************************************************

-- direction of an edge
EdgeDirectionEnum = {
    UNDIRECTED = 0,
    DIRECTED = 1,
}


local MixedGraphEdge = class("MixedGraphEdge")

function MixedGraphEdge:initialize(arg)
    self.source_id = arg.source_id
    self.sink_id = arg.sink_id
    self.direction = arg.direction
    self.label = arg.label
end

function MixedGraphEdge:get_source(g) {
    return g:get_vertex(self.source_id)
}

function MixedGraphEdge:get_sink(g) {
    return g:get_vertex(self.sink_id)
}

-- *********************************************************************
-- ******************* MIXEDGRAPH **************************************
-- *********************************************************************

local MixedGraph = class("MixedGraph");

function MixedGraph:initialize()
    -- vertex payload indexed by vertex id
    self.vertices = HashMap()
    -- key index: vertex id, value: list of edges whose source is the specified id
    -- HashMap<int, HashMap<int, List<MixedGraphEdge>>>
    self.edges = HashMap()
    self.next_vertex_id = 0
end

function MixedGraph:vertices_stream() {
    return self.vertices:stream_values()
}

function MixedGraph:vertices_id_stream() {
    return self.vertices:stream_keys()
}

function MixedGraph:stream_sources_id_of(vertex_id)
    result = HashSet()
    for source_id, edges_map in pairs(self.edges) do
        for sink_id, edges_list in pairs(edges_map) do
            if sink_id == vertex_id then
                result.add_all(edges_list:stream_values(function(e) e.source_id end))
            end
        end
    end
    
    return result:stream()
end

function MixedGraph:get_sources_number_of(vertex_id)
    return self:stream_sources_id_of(vertex_id):count();
end

function MixedGraph:has_sources(vertex_id)
    return self:stream_sources_id_of(vertex_id):count() > 0;
end

-- yields a stream of the nodes which are sources of the specified vertex
function MixedGraph:stream_sources_of(vertex_id)
    return self:stream_sources_id_of(vertex_id).map(function (id) self:get_vertex{vertex_id=id} end)
end

function MixedGraph:stream_sinks_id_of(vertex_id)
    result = HashSet()
    for source_id, edges_map in pairs(self.edges) do
        if (source_id == vertex_id) then
            for sink_id, edges_list in pairs(edges_map) do
                result:add_all(edges_list:stream_values(function(e) e.sink_id end))
            end
        end
    end
    return result:stream()
end

function MixedGraph:get_sinks_number_of(vertex_id)
    return self:stream_sinks_id_of(vertex_id):count();
end

function MixedGraph:has_sinks(vertex_id)
    return self:stream_sinks_id_of(vertex_id):count() > 0;
end

-- yields a stream of the nodes which are sources of the specified vertex
function MixedGraph:stream_sink_of(vertex_id)
    return self:stream_sinks_id_of(vertex_id).map(function (id) self:get_vertex{vertex_id=id} end)
end

function MixedGraph:edges_stream() {
    result = ArrayList()
    for source_id, edges in self.edges:entry_set() do
        local source = self.vertices.get(source_id)
        for sink_id, edges_ss in self.edges.get(source_id).get(sink_id) do
            local sink = self.vertices.get(sink_id)
            for edge in edge_ss do
                result.add(edge)
            end
        end
    end

    return result:stream()
}

function MixedGraph:vertices_number()
    return self.vertices.size();
end

function MixedGraph:edges_number()
    result = 0
    self:map_over_edges(function(source_id, sink_id, source, sink, edge) 
        result = result + 1
        return true
    end)
    return resul
end

-- fetch the associated vertex whose id is vertex_id
function MixedGraph:get_vertex(args)
    local vertex_id = args.vertex_id
    return self.vertices:get(vertex_id);
end

-- fetch the associated edges going from source to sink
function MixedGraph:get_edges_between_stream(args)
    local source_id = args.source_id
    local sink_id = args.sink_id
    local edges = self.edges:get(source_id)
    return edges:stream()
end

function MixedGraph:add_vertex(v)
    local result = self.next_vertex_id
    self.vertices.put(self.next_vertex_id, v)
    self.next_vertex_id = self.next_vertex_id + 1
    return result
end

function MixedGraph:remove_vertex(vertex_id)
    self.vertices.remove_by_key(vertex_id)
    self.edges:remove_by_key(vertex_id)
    for source_id, edges_map in pairs(self.edges) do
        edges_map:remove_by_key(vertex_id)
    end
end

function MixedGraph:is_empty()
    return self.vertices:is_empty();
end

return MixedGraph