local direction = 1
local speed = 40

function init(self)
end

function update(self, dt)
    local transform = self:get_local_transform()
    local children = self:get_children()

    transform.position.x = transform.position.x + speed * direction * dt

    for i = 1, #children do
        local fish = children[i]
        local fish_transform = fish:get_local_transform()
        fish_transform.angle = math.random(-5, 5)
        fish:set_transform(fish_transform)
    end

    self:set_transform(transform)
end
    