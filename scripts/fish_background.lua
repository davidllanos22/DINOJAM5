
local Timer = require("lib.timer")
local lume  = require("lib.lume")
local inspect = require("lib.inspect")

local direction = 1
local speed = 50
local spawn_time = 0.1
local num_fish = 10

local function spawn(self)
    local fish_sprite = Sprite("Fish")
    local transform = fish_sprite:get_local_transform()
    local start_color = lume.clone(COLORS.BG_5)
    local end_color = lume.clone(COLORS.BG_3)

    transform.position.x = lume.random(-200, -100)
    transform.position.y = lume.random(-50, 50)
    transform.scale = lume.random(0.1, 0.5)

    fish_sprite:set_texture_path("assets/textures/fish_background.png")
    fish_sprite:set_transform(transform)

    self:add_child(fish_sprite)

    Timer.tween(2, start_color, end_color, "linear", function(value)
        fish_sprite:set_color(value)
    end)
end

function init(self)
    self:get_child("Sprite"):queue_destroy()

    Timer.every(spawn_time, function()
        spawn(self)
    end, num_fish)  
end

function update(self, dt)
    local transform = self:get_local_transform()
    local children = self:get_children()

    transform.position.x = transform.position.x + speed * direction * dt

    -- for i = 1, #children do
    --     local fish = children[i]
    --     local fish_transform = fish:get_local_transform()
    --     fish_transform.angle = math.random(-5, 5)
    --     fish:set_transform(fish_transform)
    -- end

    self:set_transform(transform)
end
    