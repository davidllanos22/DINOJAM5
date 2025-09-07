local player

local breathe_timer
local breathe_text

local hunger_timer
local hunger_text

function init(self)
    player = self:get_child("Player")

    breathe_timer = player:get_child("Breathe Timer")
    breathe_text = self:get_child("Breathe Text")

    hunger_timer = player:get_child("Hunger Timer")
    hunger_text = self:get_child("Hunger Text")

    breathe_timer:connect("finish", function()
        Signal.emit("player_died")
    end)

    hunger_timer:connect("finish", function()
        Signal.emit("player_died")
    end)
end

function update(self, dt)
    local breathe_percentage = breathe_timer:get_percentage_completed()
    local hunger_percentage = hunger_timer:get_percentage_completed()

    if c_is_key_pressed("space") then
        -- local game_object = GameObject2D("test")
        -- local transform = game_object:get_local_transform()
        -- transform.position.x = 50
        -- game_object:set_transform(transform)
        -- local clone = game_object:clone()
        -- self:add_child_at(clone, 12)

        -- self:queue_destroy_all_children()
    end

    -- TODO: lerp between value 0 and 100
    breathe_text:set_text(string.format("%.0f", (1 - breathe_percentage) * 100) .. "%")
    hunger_text:set_text(string.format("%.0f", (1 - hunger_percentage) * 100) .. "%")
end