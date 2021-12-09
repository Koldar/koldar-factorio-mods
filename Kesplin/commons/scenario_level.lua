
require "../../../../directories.lua"
require fetch_commons("class.class")
require fetch_commons("difficulty")
require fetch_commons("utils")
require fetch_commons("dialog")
require fetch_commons("ui")

-- a class representing a single level of a campaign.
-- This class represents a summary of the mission.
local ScenarioLevel = class{
    -- index uniquely identifying the scenario
    id,
    -- name of the scenario (e.g. "The Crash")
    name,
    --  difficulty of the scenario
    difficulty,
    -- path of the wall paper to be used at the beginning of the scenario
    wallpaper_path,
    -- minimum players allowed in the scenario. [1, +inf]
    minimum_players,
    -- maximum players allowed in the scenario. [1]
    maximum_players,
    -- name of the locale configuration containing i18n strings of this level
    i18n_section_name,
    -- name of the file containing represented the players can play
    map_name,
    -- if true players can research technologies. If false the player cannot research technologies
    enable_researches,
    -- the set of technologies the players can indeed reseacher. List of strings.
    researchable_technologies,
    -- set of technologies the players have already researched. List of strings.
    researched_technologies,
}

function ScenarioLevel:init(id, name, difficulty, wallpaper_path, min_players, max_players, i18n_section_name, map_name, enable_researches, researchable_technologies, researched_technologies, is_story)
    self.id = id
    self.name = name
    self.difficulty = difficulty
    self.wallpaper_path = wallpaper_path
    self.min_players = min_players
    self.max_players = max_players
    self.i18n_section_name = i18n_section_name
    self.map_name = map_name
    self.enable_researches = enable_researches
    self.researchable_technologies = researchable_technologies
    self.researched_technologies = researched_technologies
    self.is_story = is_story
end

-- on_init() will run when the game starts (or in mod cases, when you add it to an existing save). 
-- It is used to initialize global variables you will need
function ScenarioLevel:on_init_event()
    printToAllPlayers("narrator", "on_init_event")
    if self.is_story then
        global.story = story_init()
    end
    game.map_settings.enemy_expansion.enabled = false
    game.forces.enemy.evolution_factor = 0
    game.map_settings.enemy_evolution.enabled = false
end

-- on_configuration_changed(data) will run when some configuration about this save game changes, such as a mod being added, changed or removed. This function is used to account for changes to game or prototype changes. data will contain information on what has changed. 
function ScenarioLevel:on_configuration_changed()
    printToAllPlayers("narrator", "on_configuration_changed")
end

-- on_load() will run every time the script loads
function ScenarioLevel::on_load()
    printToAllPlayers("narrator", "on_load")
end

function ScenarioLevel:toString()
    return tostring(self.id);
end

function ScenarioLevel:configure_story()
end

-- apply events in order for this scenario to be playable
function ScenarioLevel:applyScript(script)
    script.on_event(defines.events.on_player_created, function(event)
        self._setup()
    end)
    script.on_event(defines.events, function(event)
        story_update(global.story, event)
    end)
    -- register script off-event functions
    script.on_init(self:on_init_event)
    script.on_configuration_changed(self:on_configuration_changed)
    script.on_load(self:on_load)

    local story_table = self:configure_story()
    story_init_helpers(story_table)
end

-- setup the scenario
function ScenarioLevel:_setup() {
    printToAllPlayers("narrator", "setup_scenario_begin")
    self:setup_scenario_begin()
    for (i, p in ipairs(game.players))
    printToAllPlayers("narrator", "setup_scenario_begin player" .. i)
        self.setup_scenario_player(i, p)
    end
    printToAllPlayers("narrator", "setup_scenario_end")
    self.setup_scenario_end()
}

function ScenarioLevel:setup_scenario_begin()
    frame = create_wallpaper_frame_all_players{
        frame_title="Mission "..self.id, 
        wallpaper_file_path=fetch_resource(self.wallpaper_path), 
        frame_text=self.i18n_section_name .. ".frame_text", 
        button_text=self.i18n_section_name .. ".button_text", 
        button_name="confirm_name", 
        script
    }
end

function ScenarioLevel:setup_scenario_end()
    --abstract("setup_scenario_end")
end

function ScenarioLevel:setup_scenario_player(player_index, player)
    --abstract("setup_scenario_player")
end
