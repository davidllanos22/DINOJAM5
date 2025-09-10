local Timer = require("lib.timer")
local lume  = require("lib.lume")

local speed = 50
local spawn_time = 0.5

local function spawn(self)
    local bubble_sprite = Sprite("Bubble")
    local transform = bubble_sprite:get_local_transform()
    local duration_time = 5

    transform.position.x = lume.random(-30, 30)
    transform.scale = lume.random(0.5, 1)

    bubble_sprite:set_texture_path("assets/textures/bubble.png")
    bubble_sprite:set_transform(transform)

    Timer.after(duration_time, function()
        Timer.script(function(wait)
            bubble_sprite:set_texture_path("assets/textures/bubble_exploded.png")
            wait(0.1)
            bubble_sprite:queue_destroy()
        end)
    end)

    self:add_child(bubble_sprite)
end

function init(self)
    self:get_child("Sprite"):queue_destroy()

    Timer.every(spawn_time, function()
        spawn(self)
    end)  
end

function update(self, dt)
    local children = self:get_children()
    for i = 1, #children do
        local transform = children[i]:get_local_transform()

        transform.position.y = transform.position.y - speed * dt

        children[i]:set_transform(transform)
    end
end

