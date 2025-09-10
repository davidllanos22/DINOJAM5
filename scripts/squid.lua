local Timer = require("lib.timer")

local shape

function start_down_movement(self)
    local transform = self:get_local_transform()
    Timer.tween(2, transform.position, {x = transform.position.x, y = transform.position.y + 20 }, "linear", function(value)
        transform.position = { x = value.x, y = value.y }
        self:set_transform(transform)
    end, function()
        start_up_movement(self)
    end)
end

function start_up_movement(self)
    local transform = self:get_local_transform()
    local target_position = {
        x = transform.position.x + math.random(-100, 100),
        y = transform.position.y - math.random(50, 100)
    }
    Timer.tween(2, transform.position, target_position, "out-back", function(value)
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