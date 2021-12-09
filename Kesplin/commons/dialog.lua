-- a package containing some useful functions for printing elements to the player

-- print a message to a single player
-- @param player the player where we need to print a message. Can either be LuaPlayer or a number representing the player
-- @param source a string that is used to identify who is saying the message. 
-- @param message the message to print
-- @param color color used to print the message
-- @param icon icon used to prefix the message to print
function printToPlayer(player, source, message, color=nil, icon=nil)
    if (is_number(player))
        p = game.players[player]
    else
        p = player
    end
    if (color == nil)
        color = {r=1, g=1, b=1 a=0}
    end
    if (icon == nil)
        icon = ""
    else
        icon = "[img=entity/" + icon + "]"
    end

    p.print({
        message: {"", "[img=entity]", source, ": ", message},
        color: color
    })
end

-- print a message to all players belonging to a force (i.e., team)
-- @param force team where we need to print the message
-- @param source a string that is used to identify who is saying the message. 
-- @param message the message to print
-- @param color color used to print the message
-- @param icon icon used to prefix the message to print
function printToForce(force, source, message, color=nil, icon=nil)
    for (p in force.players)
        printToPlayer(p, source, message, color, icon)
    end
end

-- print a message to all players
-- @param source a string that is used to identify who is saying the message. 
-- @param message the message to print
-- @param color color used to print the message
-- @param icon icon used to prefix the message to print
function printToAllPlayers(source, message, color=nil, icon=nil)
    for (p in game.players)
        printToPlayer(p, source, message, color, icon)
    end
end