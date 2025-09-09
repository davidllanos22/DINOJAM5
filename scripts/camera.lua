local inspect = require("lib.inspect")
local lume = require("lib.lume")

local player

local offsetX = 60
local offsetY = 50

function init(self)
    player = self:get_root():get_child("Player")

    local player_transform = player:get_transform()
    local transform = self:get_local_transform()

    transform.position.x = player_transform.position.x + offsetX
    transform.position.y = player_transform.position.y + offsetY
    self:set_transform(transform)

end

function update(self, dt)
    local player_transform = player:get_transform()
    local transform = self:get_local_transform()
    local zoom = self:get_zoom()
    
    transform.position.x = lume.lerp(transform.position.x, player_transform.position.x, 0.1)
    transform.position.y = lume.lerp(transform.position.y, player_transform.position.y, 0.1)
    
    self:set_transform(transform)
end
