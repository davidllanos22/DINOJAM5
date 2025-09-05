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

    -- TODO: lerp between value 0 and 100
    breathe_text:set_text("Air: " .. string.format("%.0f", (1 - breathe_percentage) * 100) .. "%")
    hunger_text:set_text("Hunger: " .. string.format("%.0f", (1 - hunger_percentage) * 100) .. "%")
end