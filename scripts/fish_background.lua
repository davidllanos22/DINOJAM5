local direction = 1
local speed = 40

function init(self)
end

function update(self, dt)
    local transform = self:get_local_transform()

    transform.position.x = transform.position.x + speed * direction * dt

    self:set_transform(transform)
end
