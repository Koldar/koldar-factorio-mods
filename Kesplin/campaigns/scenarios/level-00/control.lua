require "util"
require "story"
require "../../../directories.lua";
require fetch_commons("ui");
require fetch_commons("difficulty");
require fetch_commons("technologies");


local level00 = ScenarioLevel(
  0,
  "The Crash",
  DifficultyEnum.EASY,
  "level00.jpeg",
  1,
  5,
  "mission00",
  "level00.dat",
  true,
  {TechnologyEnum.AUTOMATION},
  {},
  function ()
  end,
  function ()
  end,
  function ()
  end
);

level00.applyScript(script)