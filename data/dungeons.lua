local BASE_CHANCE = {
    nauvis = 0.2,
    vulcanus = 0.3,
    fulgora = 0.4,
    gleba = 0.5,
    aquilo = 0.75,
}

local PLANET_TILES = {
    nauvis = "brown-refined-concrete",
    vulcanus = "black-refined-concrete",
    fulgora = "red-refined-concrete",
    gleba = "green-refined-concrete",
    aquilo = "refined-hazard-concrete-left",
}

local function make_resonators(base_chance, start_tier, mults)
    local rolls = {}
    for i, mult in ipairs(mults) do
        rolls["hexadic-resonator-tier-" .. (start_tier + i - 1)] = base_chance * mult
    end
    return rolls
end

local function build_dungeon(surface_name, spec)
    spec.surface_name = surface_name
    spec.amount_scaling = spec.amount_scaling or 1
    spec.tile_type = spec.tile_type or PLANET_TILES[surface_name]
    spec.ammo = spec.ammo or {}
    return spec
end

return {
    queued_reloads = {},
    queued_reload_dungeon_indices = {},

    defs = {
        -- Nauvis
        build_dungeon("nauvis", { -- Hard
            loot_value = 30000,
            rolls = 6,
            chests = 2,
            qualities = { "normal", "uncommon" },
            wall_entities = {
                ["dungeon-wall"] = { 1 },
                ["dungeon-flamethrower-turret"] = { 2 },
                ["dungeon-laser-turret"] = { 5 },
                ["dungeon-gun-turret"] = { 7 },
            },
            ammo = { bullet_type = "uranium-rounds-magazine", flamethrower_type = "light-oil" },
            item_rolls = make_resonators(BASE_CHANCE.nauvis, 1, { 1, 0.5, 0.25, 0.125 }),
        }),
        build_dungeon("nauvis", { -- Medium
            loot_value = 10000,
            rolls = 5,
            chests = 2,
            qualities = { "normal", "uncommon" },
            wall_entities = {
                ["dungeon-wall"] = { 1 },
                ["dungeon-laser-turret"] = { 2 },
                ["dungeon-gun-turret"] = { 4 },
            },
            ammo = { bullet_type = "piercing-rounds-magazine" },
            item_rolls = make_resonators(BASE_CHANCE.nauvis, 1, { 0.5, 0.25, 0.125, 0.0625 }),
        }),
        build_dungeon("nauvis", { -- Easy
            loot_value = 4000,
            rolls = 4,
            chests = 1,
            qualities = { "normal" },
            wall_entities = {
                ["dungeon-wall"] = { 1 },
                ["dungeon-laser-turret"] = { 2 },
            },
            item_rolls = make_resonators(BASE_CHANCE.nauvis, 1, { 0.25, 0.125, 0.0625, 0.03625 }),
        }),

        -- Vulcanus
        build_dungeon("vulcanus", { -- Hard
            loot_value = 30000000,
            rolls = 8,
            chests = 3,
            qualities = { "rare" },
            wall_entities = {
                ["dungeon-wall"] = { 1, 8 },
                ["dungeon-flamethrower-turret"] = { 2, 8 },
                ["dungeon-laser-turret"] = { 10 },
                ["dungeon-gun-turret"] = { 12 },
            },
            ammo = { bullet_type = "magmatic-rounds-magazine", flamethrower_type = "light-oil" },
            item_rolls = make_resonators(BASE_CHANCE.vulcanus, 2, { 1, 0.5, 0.25, 0.125 }),
        }),
        build_dungeon("vulcanus", { -- Medium
            loot_value = 10000000,
            rolls = 6,
            chests = 3,
            qualities = { "uncommon", "rare" },
            wall_entities = {
                ["dungeon-wall"] = { 1 },
                ["dungeon-flamethrower-turret"] = { 2 },
                ["dungeon-gun-turret"] = { 6 },
            },
            ammo = { bullet_type = "magmatic-rounds-magazine", flamethrower_type = "light-oil" },
            item_rolls = make_resonators(BASE_CHANCE.vulcanus, 2, { 0.5, 0.25, 0.125, 0.0625 }),
        }),
        build_dungeon("vulcanus", { -- Easy
            loot_value = 4000000,
            rolls = 6,
            chests = 2,
            qualities = { "uncommon" },
            wall_entities = {
                ["dungeon-wall"] = { 1, 2, 3 },
                ["dungeon-laser-turret"] = { 4, 6 },
            },
            ammo = { bullet_type = "uranium-rounds-magazine" },
            item_rolls = make_resonators(BASE_CHANCE.vulcanus, 2, { 0.25, 0.125, 0.0625, 0.03625 }),
        }),

        -- Fulgora
        build_dungeon("fulgora", { -- Hard
            loot_value = 60000000,
            rolls = 10,
            chests = 3,
            qualities = { "rare", "epic" },
            wall_entities = {
                ["dungeon-wall"] = { 1 },
                ["dungeon-tesla-turret"] = { 3 },
                ["dungeon-laser-turret"] = { 7 },
                ["dungeon-gun-turret"] = { 9 },
            },
            ammo = { bullet_type = "uranium-rounds-magazine" },
            item_rolls = make_resonators(BASE_CHANCE.fulgora, 2, { 1, 0.5, 0.25, 0.125, 0.0625 }),
        }),
        build_dungeon("fulgora", { -- Medium
            loot_value = 20000000,
            rolls = 10,
            chests = 2,
            qualities = { "rare", "epic" },
            wall_entities = {
                ["dungeon-wall"] = { 1 },
                ["dungeon-laser-turret"] = { 2, 6 },
                ["dungeon-gun-turret"] = { 4, 8 },
            },
            ammo = { bullet_type = "piercing-rounds-magazine" },
            item_rolls = make_resonators(BASE_CHANCE.fulgora, 2, { 0.5, 0.25, 0.125, 0.0625, 0.03625 }),
        }),
        build_dungeon("fulgora", { -- Easy
            loot_value = 8000000,
            rolls = 6,
            chests = 2,
            qualities = { "rare" },
            wall_entities = {
                ["dungeon-wall"] = { 1 },
                ["dungeon-laser-turret"] = { 2 },
                ["dungeon-gun-turret"] = { 4 },
            },
            ammo = { bullet_type = "piercing-rounds-magazine" },
            item_rolls = make_resonators(BASE_CHANCE.fulgora, 2, { 0.5, 0.25, 0.125, 0.0625, 0.03625 }),
        }),

        -- Gleba
        build_dungeon("gleba", { -- Hard
            loot_value = 120000000,
            rolls = 12,
            chests = 4,
            qualities = { "epic", "legendary" },
            wall_entities = {
                ["dungeon-wall"] = { 1 },
                ["dungeon-laser-turret"] = { 2 },
                ["dungeon-rocket-turret"] = { 5 },
                ["dungeon-gun-turret"] = { 7 },
            },
            ammo = { rocket_type = "plague-rocket", bullet_type = "uranium-rounds-magazine" },
            item_rolls = make_resonators(BASE_CHANCE.gleba, 3, { 1, 0.5, 0.25, 0.125 }),
        }),
        build_dungeon("gleba", { -- Medium
            loot_value = 40000000,
            rolls = 11,
            chests = 3,
            qualities = { "epic" },
            wall_entities = {
                ["dungeon-wall"] = { 1 },
                ["dungeon-rocket-turret"] = { 5 },
                ["dungeon-gun-turret"] = { 7, 9 },
            },
            ammo = { rocket_type = "rocket", bullet_type = "uranium-rounds-magazine" },
            item_rolls = make_resonators(BASE_CHANCE.gleba, 3, { 0.5, 0.25, 0.125, 0.0625 }),
        }),
        build_dungeon("gleba", { -- Easy
            loot_value = 16000000,
            rolls = 10,
            chests = 3,
            qualities = { "rare", "epic" },
            wall_entities = {
                ["dungeon-wall"] = { 1 },
                ["dungeon-rocket-turret"] = { 5 },
                ["dungeon-gun-turret"] = { 7 },
            },
            ammo = { rocket_type = "explosive-rocket", bullet_type = "piercing-rounds-magazine" },
            item_rolls = make_resonators(BASE_CHANCE.gleba, 3, { 0.25, 0.125, 0.0625, 0.03625 }),
        }),

        -- Aquilo
        build_dungeon("aquilo", { -- Hard
            loot_value = 2000000000000,
            rolls = 15,
            chests = 3,
            qualities = { "legendary", "hextreme" },
            wall_entities = {
                ["dungeon-railgun-turret"] = { 3 },
                ["dungeon-tesla-turret"] = { 11 },
                ["dungeon-rocket-turret"] = { 15, 19 },
                ["dungeon-gun-turret"] = { 22, 24 },
            },
            ammo = { bullet_type = "magmatic-rounds-magazine", rocket_type = "plague-rocket", railgun_type = "railgun-ammo" },
            item_rolls = make_resonators(BASE_CHANCE.aquilo, 4, { 1, 0.5, 0.25 }),
        }),
        build_dungeon("aquilo", { -- Medium
            loot_value = 600000000000,
            rolls = 12,
            chests = 2,
            qualities = { "legendary" },
            wall_entities = {
                ["dungeon-tesla-turret"] = { 4 },
                ["dungeon-rocket-turret"] = { 8, 12 },
                ["dungeon-gun-turret"] = { 15, 17 },
            },
            ammo = { bullet_type = "magmatic-rounds-magazine", rocket_type = "plague-rocket" },
            item_rolls = make_resonators(BASE_CHANCE.aquilo, 4, { 0.5, 0.25, 0.125 }),
        }),
        build_dungeon("aquilo", { -- Easy
            loot_value = 240000000000,
            rolls = 10,
            chests = 2,
            qualities = { "epic", "legendary" },
            wall_entities = {
                ["dungeon-rocket-turret"] = { 3, 7 },
                ["dungeon-laser-turret"] = { 10 },
                ["dungeon-gun-turret"] = { 12 },
            },
            ammo = { bullet_type = "uranium-rounds-magazine", rocket_type = "rocket" },
            item_rolls = make_resonators(BASE_CHANCE.aquilo, 4, { 0.25, 0.125, 0.0625 }),
        }),
    },
}
