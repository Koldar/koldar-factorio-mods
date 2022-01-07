rockspec_format = "3.0"
package = "yadatastructure"
version = "1.0-0"
source = {
   url = "..."
}
description = {
   summary = "Specifies some data structures which can be used whenever you want",
   detailed = [[
      Data structures
   ]],
   homepage = "http://...", -- We don't have one yet
   maintainer = "Massimo Bono",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1",
   "middleclass",
   "typecheck",
   "lua-stream-api"
}
build = {
    type = "builtin",
    modules= {
        ArrayList = "src/ArrayList.lua",
        HashSet = "src/HashSet.lua",
        HashMap = "src/HashMap.lua",
        MixedGraph = "src/MixedGraph.lua",
    },
    copy_directories = {
      "src",
      "tests"
    }
}
test_dependencies = {
    "busted",
}
test = {
    type = "command"
}