SHOW_SHAPES = false

COLORS = {
    -- BG_CLEAR = { 48, 147, 198, 255 },
    -- BG_MEDIUM = { 28, 91, 152, 255 },
    -- BG_DARK = { 25, 66, 107, 255 },
    -- BG_FLOOR = { 131, 99, 50, 255 },
    BG_5 = { 190, 233, 250, 255 },
    BG_4 = { 102, 204, 244, 255 },
    BG_3 = { 0, 128, 177, 255 },
    BG_2 = { 0, 75, 112, 255 },
    BG_1 = { 0, 0, 0, 255 },
    BG_FLOOR = { 131, 99, 50, 255 },
    BG_PINK = { 255, 147, 198, 255 },
}

CURRENT_LANGUAGE = "ES"

TEXTS = {
    EN = {
        PRESS_SPACE = "Press space to start",
        TEXT_01 = "TEXT_01",
        TEXT_02 = "TEXT_02",
        TEXT_03 = "TEXT_03",
        TEXT_04 = "TEXT_04",
        TEXT_05 = "TEXT_05",
    },
    ES = {
        PRESS_SPACE = "Pulsa espacio para empezar",
        TEXT_01 = "El pequeño plesiosaurio despertó entre las olas suaves.\nBuscó con la mirada a su madre... pero no estaba.\nSolo el silencio del mar lo rodeaba.",
        TEXT_02 = "A medida que nadaba, el mar se volvía más profundo.\nSombras enormes se movían en la distancia.\nEl pequeño plesiosaurio debía tener cuidado... no estaba solo.",
        TEXT_03 = "Tras un largo viaje, llegó a una orilla tranquila.\nAl otro lado, quizás encontraría a su madre.\nPero el camino parecía imposible...",
        TEXT_03_2 = "No todos los gigantes eran peligrosos.\nAlgunos podían ser amigos.",
        TEXT_04 = "Finalmente, el mar volvió a ser cálido y seguro.\nEntre las olas, una silueta familiar apareció.\nSu madre lo había encontrado.",
        TEXT_05 = "El pequeño plesiosaurio había aprendido a respirar, a comer y a escapar de los peligros del mar.\nYa no era tan indefenso como antes...\ny, junto a su madre, seguiría explorando un océano lleno de misterios.",
    }
}

function GET_TEXT(id)
    return TEXTS[CURRENT_LANGUAGE][id]
end