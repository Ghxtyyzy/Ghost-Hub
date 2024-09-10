local plr = game:GetService("Players").LocalPlayer
local pingLimit = 250 -- Ping limit in milliseconds
local stats = game:GetService("Stats") -- For getting player stats

local NColor = BrickColor.new("Black")
local Lift = false
local properties = {
    Color = NColor.Color,
    Font = Enum.Font.FredokaOne,
    TextSize = 18
}

local StarterGui = game:GetService("StarterGui") -- Use GetService for consistency

local function PingFarm()
    Lift = true
    properties.Text = "[Ghost]: Ping Farm Activated!"
    properties.Color = NColor.Color
    StarterGui:SetCore("ChatMakeSystemMessage", properties)

    while Lift do
        local currentPing = stats.Network.ServerStatsItem["Data Ping"]:GetValue() * 1000 -- Ping in milliseconds

        if currentPing <= pingLimit then
            for _, tool in pairs(plr.Backpack:GetChildren()) do
                if tool.Name == "Double Weight" then
                    tool.Parent = plr.Character -- Equip the tool
                    tool:Activate() -- Activate the tool (simulate using it)
                end
            end
        else
            print("Ping is too high, try again after ping lowers.")
        end
    end
end

-- You can add a function to stop the loop:
local function StopPingFarm()
    Lift = false
    properties.Text = "[Ghost]: Ping Farm Deactivated!"
    StarterGui:SetCore("ChatMakeSystemMessage", properties)
end

PingFarm()
