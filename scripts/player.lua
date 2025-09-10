local Timer = require("lib.timer")
local inspect = require("lib.inspect")

local breathe_timer
local hunger_timer
local camera

local gravity = 1.5
local speed = 5
local damping = 0.9
local accel_x = 0
local accel_y = 0
local accel_max = 300

local eat_area

local last_position = { x = 0, y = 0}

local movement_locked = true;

function init(self)
    camera = self:get_root():get_child("Camera")
    eat_area = self:get_child("Eat Area")
    breathe_timer = self:get_child("Breathe Timer")
    hunger_timer = self:get_child("Hunger Timer")
    local shape = self:get_child("Shape")

    shape:set_size({x = 50, y = 50})

    eat_area:connect("collision", function(other)
        if c_is_key_pressed("space") then
            hunger_timer:start()
            other:queue_destroy()
        end
    end)

    -- breathe_timer:connect("finish", function()
    --     Signal.emit("player_suffocated")
    -- end)
end

function update(self, dt)
    local transform = self:get_local_transform()
    local breathe_percentage = breathe_timer:get_percentage_completed()

    if c_is_key_pressed("x") then
        Timer.script(function(wait)
            Signal.emit("hide_text")
            wait(0.2)
            Timer.tween(1, transform.position, {x = transform.position.x, y = transform.position.y - 100 }, "out-cubic", function(value)
                transform.position = { x = value.x, y = value.y }
                self:set_transform(transform)
            end)
            Timer.tween(0.8, {zoom = 3}, {zoom = 1}, "out-cubic", function(value)
                camera:set_zoom(value.zoom)
            end)
            wait(0.5)
            accel_y = -30
            movement_locked = false
            Signal.emit("show_text", "TEXT_01")
            wait(10)
            Signal.emit("hide_text")
        end)
    end

    if (movement_locked) then
        return
    end

    if is_key_down("up") then
        accel_y = accel_y - speed
    elseif is_key_down("down") then
        accel_y = accel_y + speed
    else
        accel_y = accel_y / (1 + damping * dt)
    end

    if is_key_down("left") then
        accel_x = accel_x - speed
    elseif is_key_down("right") then
        accel_x = accel_x + speed
    else
        accel_x = accel_x / (1 + damping * dt)
    end

    -- TODO: don't apply gravity if we are colliding
    -- local position_diff = (last_position.y - transform.position.y)
    -- if(math.abs(position_diff) > 5) then
    --     accel_y = accel_y + gravity
    -- end

    accel_y = accel_y + gravity

    if(accel_x > accel_max) then
        accel_x = accel_max
    elseif(accel_x < -accel_max) then
        accel_x = -accel_max
    end

    if(accel_y > accel_max) then
        accel_y = accel_max
    elseif(accel_y < -accel_max) then
        accel_y = -accel_max
    end


    transform.position.x = transform.position.x + accel_x * dt
    transform.position.y = transform.position.y + accel_y * dt

    last_position = transform.position

    local is_out_of_water = transform.position.y < 0

    if (is_out_of_water) then
        -- TODO: stop player from moving above water
        breathe_timer:start()
    end

    self:set_transform(transform)
end