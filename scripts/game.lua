local inspect = require("lib.inspect")
local Timer = require("lib.timer")

local player

local breathe_timer
local breathe_text

local hunger_timer
local hunger_text
local text
local vignette
local camera

local game_width
local game_height

function init(self)
    print("timer table", Timer)
    game_width = get_game_width()
    game_height = get_game_height()

    text = self:get_child("Text")
    player = self:get_child("Player")
    vignette = self:get_child("Vignette")
    camera = self:get_child("Camera")

    breathe_timer = player:get_child("Breathe Timer")
    breathe_text = self:get_child("Breathe Text")

    hunger_timer = player:get_child("Hunger Timer")
    hunger_text = self:get_child("Hunger Text")

    show_text("PRESS_SPACE")

    breathe_timer:connect("finish", function()
        Signal.emit("player_died")
    end)

    hunger_timer:connect("finish", function()
        Signal.emit("player_died")
    end)

    Signal.connect("show_text", function(text_key)
        show_text(text_key)
    end)

    Signal.connect("hide_text", function()
        hide_text()
    end)
end

function update(self, dt)
    Timer.update(dt)
    local camera_position = camera:get_transform().position
    local vignette_transform = vignette:get_transform()

    local breathe_percentage = breathe_timer:get_percentage_completed()
    local hunger_percentage = hunger_timer:get_percentage_completed()

    -- TODO: lerp between value 0 and 100
    breathe_text:set_text(string.format("%.0f", (1 - breathe_percentage) * 100) .. "%")
    hunger_text:set_text(string.format("%.0f", (1 - hunger_percentage) * 100) .. "%")

    vignette_transform.position.x = camera_position.x - get_game_width() / 2 - 200
    vignette_transform.position.y = camera_position.y - get_game_height() / 2 + 100
    vignette:set_transform(vignette_transform)
end


function show_text(text_key)
    fade_text(0.5, 0, 255)
    local translated_text = GET_TEXT(text_key)
    local size = text:measure_text_size(translated_text)
    local text_transform = text:get_local_transform()

    text_transform.position.x = game_width / 2 - size.x / 2
    text_transform.position.y = game_height / 2 - size.y / 2

    text:set_transform(text_transform)

    text:set_text(translated_text)
end

function hide_text()
    fade_text(0.5, 255, 0)
end

function fade_text(duration, start, _end)
    local color = text:get_color();
    Timer.tween(duration, { a = start }, { a = _end }, "linear", function(value)
        color.a = value.a
        text:set_color(color)
    end)
end