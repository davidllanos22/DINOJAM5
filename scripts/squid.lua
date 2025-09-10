local Timer = require("lib.timer")
local lume = require("lib.lume")

local shape

function start_down_movement(self)
    local transform = self:get_local_transform()
    local duration = lume.random(3.5, 4.5)

    Timer.tween(duration, transform.position, {x = transform.position.x, y = transform.position.y + 20 }, "linear", function(value)
        transform.position = { x = value.x, y = value.y }
        self:set_transform(transform)
    end, function()
        start_up_movement(self)
    end)
end

function start_up_movement(self)
    local transform = self:get_local_transform()
    local direction = lume.randomchoice({ 1, -1 })
    local target_position = {
        x = transform.position.x + math.random(60, 70) * direction,
        y = transform.position.y - math.random(50, 60)
    }
    local duration = lume.random(1.5, 2.5)
    Timer.tween(duration, transform.position, target_position, "out-back", function(value)
        transform.position = { x = value.x, y = value.y }
        self:set_transform(transform)
    end, function()
        start_down_movement(self)
    end)
end

function init(self)
    
    shape = self:get_child("Shape")

    shape:connect("collision", function(other)
    end)

    start_up_movement(self)
    
end

function update(self, dt)
    Timer.update(dt)

end