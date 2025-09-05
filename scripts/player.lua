local gravity = 1.5
local speed = 5
local damping = 0.9
local accel_x = 0
local accel_y = 0
local max_accel = 300
local last_position = { x = 0, y = 0}

function init(self)
end

function update(self, dt)
    local transform = self:get_local_transform()


    if c_is_key_down("up") then
        accel_y = accel_y - speed
    elseif c_is_key_down("down") then
        accel_y = accel_y + speed
    else
        accel_y = accel_y / (1 + damping * dt)
    end

    if c_is_key_down("left") then
        accel_x = accel_x - speed
    elseif c_is_key_down("right") then
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

    if(accel_x > max_accel) then
        accel_x = max_accel
    elseif(accel_x < -max_accel) then
        accel_x = -max_accel
    end

    if(accel_y > max_accel) then
        accel_y = max_accel
    elseif(accel_y < -max_accel) then
        accel_y = -max_accel
    end


    transform.position.x = transform.position.x + accel_x * dt
    transform.position.y = transform.position.y + accel_y * dt


    --transform.position.y = transform.position.y + gravity * dt
    last_position = transform.position

    self:set_transform(transform)
end