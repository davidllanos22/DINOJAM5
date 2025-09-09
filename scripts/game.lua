local inspect = require("lib.inspect")
local player

local breathe_timer
local breathe_text

local hunger_timer
local hunger_text
local text

local game_width
local game_height

function init(self)
    game_width = get_game_width()
    game_height = get_game_height()

    text = self:get_child("Text")
    player = self:get_child("Player")

    breathe_timer = player:get_child("Breathe Timer")
    breathe_text = self:get_child("Breathe Text")

    hunger_timer = player:get_child("Hunger Timer")
    hunger_text = self:get_child("Hunger Text")

    show_text(GET_TEXT("PRESS_SPACE"))

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
    breathe_text:set_text(string.format("%.0f", (1 - breathe_percentage) * 100) .. "%")
    hunger_text:set_text(string.format("%.0f", (1 - hunger_percentage) * 100) .. "%")
end


function show_text(text_string)
    local size = text:measure_text_size(text_string)
    local text_transform = text:get_local_transform()

    print(inspect(size))
    print(game_width, game_height)

    text_transform.position.x = game_width / 2 - size.x / 2
    text_transform.position.y = game_height / 2 - size.y / 2

    text:set_transform(text_transform)

    text:set_text(text_string)
end