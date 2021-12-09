# Settings Phase

The very first mod stage that is loaded when Factorio initializes is the settings stage. This stage is used to define all mod settings that are later shown in the in-game mod settings GUI, and has no other functions or possibilities

- executing `settings.lua` of all mods;
- executing `settings-updates-lua` is executed;
- invoked `settings-final-fixes.lua`;

# Data Phase

This is the most restricted part of the Factorio init, there's not much you can do here other than declare prototypes for technologies, entities, items and more. Things like manipulating files, affecting the world, etc, are blocked/unavailable. In fact, any functions or changes made will be discarded, as the lua session is terminated. You also cannot mess with the data table.

- executing `settings.lua` of all mods;
- executing `settings-updates-lua` is executed;
- invoked `settings-final-fixes.lua`;

# Migrations stage

To avoid having to write migrations, avoid changing prototype names and technology unlocks

# Runtime stage

This file contains scripting that makes the mod do things during the game, rather than just adding entities to the game. During this stage, each mod's control.lua is run, in it's own lua instance (this means no inter-communication without special setup) which it will own for the rest of the play session. During the play session, access to all tables provided by the game can be done inside of event handlers. (More on those below.) Because the control.lua is run every time a save file is created or loaded you don't need to restart the game to see changes made to the control.lua file. Simply restarting or reloading a save will re-run this stage.

