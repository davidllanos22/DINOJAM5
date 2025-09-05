local player

local offsetX = 20
local offsetY = 20

function init(self)
    player = self:get_root():get_child("Player")
end

function update(self, dt)
    local player_transform = player:get_transform()
    local transform = self:get_local_transform()
    

    transform.position.x = transform.position.x + (player_transform.position.x - transform.position.x) * 0.1 + offsetX
    transform.position.y = transform.position.y + (player_transform.position.y - transform.position.y) * 0.1 + offsetY

    self:set_transform(transform)
end
