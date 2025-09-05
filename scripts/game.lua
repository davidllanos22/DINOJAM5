local player
local breathe_timer
local breathe_text

function init(self)
    player = self:get_child("Player")
    breathe_text = self:get_child("Breathe Text")

    breathe_timer = player:get_child("Breathe Timer")

    breathe_timer:connect("finish", function()
        Signal.emit("player_suffocated")
    end)
end

function update(self, dt)
    local breathe_percentage = breathe_timer:get_percentage_completed()

    -- TODO: lerp between value 0 and 100
    breathe_text:set_text(string.format("%.0f", (1 - breathe_percentage) * 100) .. "%")
end