require "class.class"

-- a branch of a story. Once we have reached to the end of a branch, the mission ends
StoryNode = class({
    -- id of the node. Uniquely identify the node in a graph
    id,
    -- name of the node
    name,
    -- function invoked at the beginning of this node
    init,
    -- Update function that will run on all event 
    update,
    -- Condition to move on. If the return value is 'true', the story will continue.
    condition,
    -- Action to perform after condition is met
    action
})

function StoryNode:init(event, story)
    self:init(event, story)
end

function StoryNode:update(event, story)
    abstract("update");
end

function StoryNode:condition(event, story)
    abstract("condition");
end

function StoryNode:action(event, story)
    abstract("action");
end



-- create a new story graph
function create_story_graph()
    local result = require('luagraphs.data.graph').create(nil, true)
    result.next_id = 0;
    result.add_story_node(StoryNode{
        name="start",
        init=function
    })
end

function add_story_node(graph, node)
    node.id = graph.next_id
    graph.next_id = graph.next_id + 1
    graph:addVertexIfNotExists(node)
    return node
end

function add_story_edge(graph, source, sink, label)
    graph:addEdge(source, sink, label)
end

function build_story(graph)
    local dfs = require('luagraphs.search.DepthFirstSearch').create()
    local start = graph:findVertex(function(n) n.name == "start")
    dfs:run(graph, start)

    local ts = require('luagraphs.sort.TopologicalSort').create()
    ts:run(graph)

    local path = ts:path()
    local vorder = {} -- map from vertex to order visited

    -- Show the order, and collect it to check
    for i=0, path:size()-1 do
        print('sort #' .. i .. ': ' .. path:get(i))
        vorder[path:get(i)] = i
    end

end

