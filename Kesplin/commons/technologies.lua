exports = {}

-- techbnology enum
TechnologyEnum = {
    CHEMICAL_PLANT = "chemical-plant",
    AUTOMATION = "automation",
    STONE_WALL = "stone-wall",
    OPTICS = "optics",
    GUN_TURRET = "gun-turret",
    LOGISTIC = "logistics",
    MILITARY = "military",
    LOGISTIC_SCIENCE_PACK = "logistic-science-pack",
    STEEL_PROCESSING = "steel-processing",
    ELECTRONICS = "electronics", 
    FAST_INSERTER = "fast-inserter", 
    AUTOMATION2 = "automation-2",
    ELECTRIC_ENERGY_DISTRIBUTION_1 = "electric-energy-distribution-1", 
    ENGINE = "engine", 
    FLUID_HANDLING = "fluid-handling", 
    OIL_PROCESSING = "oil-processing",
    LOGISTICS = "logistics",
    HEAVY_ARMOR = "heavy-armor",
    STEEL_AXE = "steel-axe", 
    MILITARY2 = "military-2",
    CHEMICAL_SCIENCE_PACK = "chemical-science-pack",
    MILITARY_SCIENCE_PACK = "military-science-pack", 
    LOGISTICS2 = "logistics-2",
    ADVANCE_MATERIAL_PROCESSING = "advanced-material-processing",
    SOLAR_ENERGY = "solar-energy",
    LASER = "laser",
    FLAMETHROWER = "flamethrower",
    FLAMMABLES = "flammables",
    MODULES = "modules",
    SPEED_MODULE = "speed-module",
    EFFECTIVITY_MODULE = "effectivity-module",
    PRODUCTIVITY_MODULE = "productivity-module",
    SULFUR_PROCESSING = "sulfur-processing",
    TOOLBELT = "toolbelt",
    ADVANCE_ELECTRONICS = "advanced-electronics",
    EXPLOSIVES = "explosives",
    LAND_MINE = "land-mine",
    ELECTRIC-ENERGY-ACCUMULATORS = "electric-energy-accumulators",
    LASER_TURRET = "laser-turret",
    TANK = "tank",
    CIRCUIT_NETWORK = "circuit-network",
    NIGHT_VISION_EQUIPMENT = "night-vision-equipment",
    SOLAR_PANEL_EQUIPMENT = "solar-panel-equipment",
    ENERGY_SHIELD_EQUIPMENT = "energy-shield-equipment",
    BATTERY_EQUIPMENT = "battery-equipment",
    MODULAR_ARMOR = "modular-armor",
    MILITARY3 = "military-3",
    RAILWAY = "railway",
    AUTOMATED_RAIL_TRANSPORTATION = "automated-rail-transportation",
    RAIL_SIGNALS = "rail-signals",
    AUTOMOBILISM = "automobilism",
    GATE = "gate",
    ROCKETRY = "rocketry",
    BATTERY = "battery",
    PLASTICS = "plastics",
    FLUID_WAGON = "fluid-wagon",
    STACK_INSERTER = "stack-inserter",
    AUTOMATION3 = "automation-3",
    EXPLOSIVE_ROCKETRY = "explosive-rocketry",
    BRAKING_FORCE2 = "braking-force-2",
    CLIFF_EXPLOSVES = "cliff-explosives",
    CONSTRUCTION_ROBOTICS = "construction-robotics",
    ENERGY_WEAPONS_DAMAGE3 = "energy-weapons-damage-3",
    EXOSKELETON_EQUIPMENT = "exoskeleton-equipment",
    LANDFILL = "landfill",
    UTILITY_SCIENCE_PACK = "utility-science-pack",
    PRODUCTION_SCIENCE_PACK = "production-science-pack",
    ADVANCED_MATERIAL_PROCESSING2  ="advanced-material-processing-2",
    PERSONAL-ROBOPORT_EQUIPMENT = "personal-roboport-equipment",
    PERSONAL_LASER_DEFENSE_EQUIPMENT = "personal-laser-defense-equipment",
    NUCLEAR_FUEL_REPROCESSING = "nuclear-fuel-reprocessing",
    NUCLEAR_POWER = "nuclear-power",
    MILITARY4 = "military-4",
    DESTROYER = "destroyer",
    DEFENDER = "defender",
    DISCHARGE_DEFENSE_EQUIPMENT = "discharge-defense-equipment",
    DISTRACTOR = "distractor",
    ARTILLERY = "artillery",
    ATOMIC_BOMB = "atomic-bomb",
    ROBOTICS = "robotics",
    AUTOMATION3 = "automation-3",
    ROCKET_CONTROL_UNIT = "rocket-control-unit",
    LOGISTIC_SYSTEM = "logistic-system",
    LOGISTIC_ROBOTICS = "logistic-robotics",
    ELECTRIC_ENGINE = "electric-engine",
    URANIUM_PROCESSING = "uranium-processing",
    SPIDERTRON = "spidertron",
    KOVAREX_ENRICHMENT_PROCESS = "kovarex-enrichment-process",
    LUBRIFICANT = "lubricant",
    LOW_DENSITY_STRUCTURE = "low-density-structure",
    ROCKET_FUEL = "rocket-fuel",
    BRAKING_FORCE1 = "braking-force-1",
    ENERGY_WEAPONS_DAMAGE1 = "energy-weapons-damage-1",
    ENERGY_WEAPONS_DAMAGE2 = "energy-weapons-damage-2",
    ENERGY_WEAPONS_DAMAGE3 = "energy-weapons-damage-3",
    INSERTER_CAPACITY_BONUS1 = "inserter-capacity-bonus-1",
    INSERTER_CAPACITY_BONUS2 = "inserter-capacity-bonus-2",
    INSERTER_CAPACITY_BONUS3 = "inserter-capacity-bonus-3",
    LASERT_SHOOTING_SPEED1 = "laser-shooting-speed-1",
    LASERT_SHOOTING_SPEED2 = "laser-shooting-speed-2",
    LASERT_SHOOTING_SPEED3 = "laser-shooting-speed-3",
    STRONGER_EXPLOSIVES1 = "stronger-explosives-1",
    STRONGER_EXPLOSIVES2 = "stronger-explosives-2",
    STRONGER_EXPLOSIVES3 = "stronger-explosives-3",
    PHYSICAL_PROJECTILE_DAMAGE1 = "physical-projectile-damage-1",
    PHYSICAL_PROJECTILE_DAMAGE2 = "physical-projectile-damage-2",
    PHYSICAL_PROJECTILE_DAMAGE3 = "physical-projectile-damage-3",
    PHYSICAL_PROJECTILE_DAMAGE4 = "physical-projectile-damage-4",
    PHYSICAL_PROJECTILE_DAMAGE5 = "physical-projectile-damage-5",
    REFINED_FLAMMABLES1 = "refined-flammables-1",
    REFINED_FLAMMABLES2 = "refined-flammables-2",
    REFINED_FLAMMABLES3 = "refined-flammables-3",
    RESEARCH_SPEED1 = "research-speed-1",
    RESEARCH_SPEED2 = "research-speed-2",
    RESEARCH_SPEED3 = "research-speed-3",
    RESEARCH_SPEED4 = "research-speed-4",
    MINING_PRODUCTIVITY1 = "mining-productivity-1",
    MINING_PRODUCTIVITY2 = "mining-productivity-2",
    WEAPON_SHOOTING_SPEED1 = "weapon-shooting-speed-1",
    WEAPON_SHOOTING_SPEED2 = "weapon-shooting-speed-2",
    WEAPON_SHOOTING_SPEED3 = "weapon-shooting-speed-3",
    WEAPON_SHOOTING_SPEED4 = "weapon-shooting-speed-4",
    WORKER_ROBOTS_SPEED1 ="worker-robots-speed-1",
    WORKER_ROBOTS_SPEED2 = "worker-robots-speed-2",
    WORKER_ROBOTS_STORAGE1 = "worker-robots-storage-1",
    WORKER_ROBOTS_STORAGE2 = "worker-robots-storage-2",
    ARTILLERY_SHEEL_RANGE1 = "artillery-shell-range-1",
    ARTILLERY_SHEEL_SPEED1 = "artillery-shell-speed-1",
    FOLLOWER_ROBOT_COUNT1 = "follower-robot-count-1",
    FOLLOWER_ROBOT_COUNT2 = "follower-robot-count-2",
}


-- Set the specified technologies as researhced
exports.set_technologies_as_researched = function set_technologies_as_researched(tech_list)
    local technology_list = game.forces.player.technologies;
    for t in tech_list do
        technology_list[t].researched = true;
    end
end

-- Set the specified technologies as researchables
exports.set_technologies_as_unresearched = function set_technologies_as_unresearched(tech_list)
    local technology_list = game.forces.player.technologies;
    for t in tech_list do
        technology_list[t].researched = false;
    end
end

-- Set the specified technologies as available for research
exports.set_technologies_as_enabled = function set_technologies_as_enabled(tech_list)
    local technology_list = game.forces.player.technologies;
    for t in tech_list do
        technology_list[t].enabled = true;
    end
end

exports.set_technologies_as_disabled = function set_technologies_as_disabled(tech_list)
    local technology_list = game.forces.player.technologies;
    for t in tech_list do
        technology_list[t].enabled = false;
    end
end