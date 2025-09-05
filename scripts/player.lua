local root
local gravity = 98
local speed = 500

function init(self)
end

function update(self, dt)
    local transform = self:get_local_transform()



    if c_is_key_down("up") then
        transform.position.y = transform.position.y - speed * dt
    elseif c_is_key_down("down") then
        transform.position.y = transform.position.y + speed * dt
    end

    if c_is_key_down("left") then
        transform.position.x = transform.position.x - speed * dt
    elseif c_is_key_down("right") then
        transform.position.x = transform.position.x + speed * dt
    end

    transform.position.y = transform.position.y + gravity * dt


    self:set_transform(transform)
end