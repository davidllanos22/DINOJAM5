local inspect = require("lib.inspect")
local lume = require("lib.lume")

local player

function init(self)
    player = self:get_root():get_child("Player")

    local player_transform = player:get_transform()
    local transform = self:get_local_transform()

    transform.position.x = player_transform.position.x
    transform.position.y = player_transform.position.y

    self:set_transform(transform)
    self:set_offset({ x = get_game_width() / 2 - 25, y = get_game_height() / 2 - 150})
end

function update(self, dt)
    local player_transform = player:get_transform()
    local transform = self:get_local_transform()
    
    transform.position.x = lume.lerp(transform.position.x, player_transform.position.x, 0.1)
    transform.position.y = lume.lerp(transform.position.y, player_transform.position.y, 0.1)

    local limit = 450 / self:get_zoom()
    if transform.position.x <= limit then
        transform.position.x = limit
    end
    
    self:set_transform(transform)
end
