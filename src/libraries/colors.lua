local colors = {
    light_red       = {250, 50,   50,   255},
    red             = {250, 0,    0,    255},
    dark_red        = {150, 0,    0,    255},

    light_orange    = {250, 150,  50,   255},
    orange          = {250, 125,  0,    255},
    dark_orange     = {150, 75,   0,    255},

    light_yellow    = {250, 250,  50,   255},
    yellow          = {250, 250,  50,   255},
    dark_yellow     = {150, 150,  0,    255},

    light_green     = {50,  250,  50,   255},
    green           = {0,   250,  0,    255},
    dark_green      = {0,   150,  0,    255},

    light_blue      = {50,  250,  250,  255},
    blue            = {50,  150,  250,  255},
    dark_blue       = {50,  50,   250,  255},

    light_purple    = {150, 50,   250,  255},
    purple          = {150, 0,    250,  255},
    dark_purple     = {75,  0,    150,  255},

    light_pink      = {250, 50,   250,  255},
    pink            = {250, 0,    250,  255},
    dark_pink       = {150, 0,    150,  255},

    white           = {255, 255,  255,  255},
    grey_1          = {225, 225,  225,  255},
    grey_2          = {195, 195,  195,  255},
    grey_3          = {160, 160,  160,  255},
    grey_4          = {125, 125,  125,  255},
    grey_5          = {95,  95,   95,   255},
    grey_6          = {65,  65,   65,   255},
    grey_7          = {30,  30,   30,   255},
    black           = {0,   0,    0,    255},
}

function colors.translucent(color)
    return {color[1], color[2], color[3], 100}
end

function colors.intensify(color, rate)
    return {color[1] + rate, color[2] + rate, color[3] + rate, color[4]}
end

function colors.random()
    local c = nil
    while type(c) ~= "table" do
        c = table.random(colors)
    end
    return c
end

return colors