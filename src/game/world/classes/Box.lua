BoxType = {
    Wall        = {blocked=true, block_sight=true, color=colors.dark_yellow},
    Grass       = {blocked=true, block_sight=true, color=colors.dark_green},
    Dirt        = {blocked=true, block_sight=true, color=colors.dark_orange},
    Floor       = {blocked=true, block_sight=true, color=colors.grey_3},
    Road        = {blocked=true, block_sight=true, color=colors.grey_6},
    Air         = {blocked=false, block_sight=false, color={0, 0, 0, 0}}
}

Box = class("Box")
function Box:initialize (type)
    self.blocked = type.blocked
    self.block_sight = type.block_sight or type.blocked
    self.color = type.color
end