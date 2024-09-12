local slave = game:GetService("Players").LocalPlayer
local slavesCharacter = plr.Character

local rawr = getmetatable(game)

setreadonly(rawr, false)

local dinasour = rawr.__index

rawr.__index = function(h, w)
    if tostring(h) == 'Humanoid' or tostring(w) == "WalkSpeed" then
        return 16
    end
    return rawr(h, w)
end

local SlavesFolder = Instance.new("Folder")
SlavesFolder.Parent = slave

local OwnersOfTheSlaves = {}
local SlaveMods = {}

local SlaveColor = BrickColor.new("Black")

local properties = {
    Color = SlaveColor.Color;
    TextFont = Enum.Font.FredokaOne;
    TextSize = 18
}




