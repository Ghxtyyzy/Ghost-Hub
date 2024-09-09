--// hwid system
local hwidT = loadstring(game:HttpGet("holdonnnn"))
local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
local plr = game:GetService("Players").LocalPlayer

for i, rawr in pairs(hwid) do
    if rawr == hwidT then
        print("Welcome")
    else
        plr:Kick("Not Whitelisted lmfao")
    end
end


local marketplaceService = game:GetService("MarketplaceService")
local GameName = "None"
local isSuccessful, info = pcall(marketplaceService.GetProductInfo, marketplaceService, game.PlaceId)
if isSuccessful then
    GameName = info.Name
end

local VirtualUser = game:GetService('VirtualUser')
game:GetService('Players').LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local NormalColor = BrickColor.new("Black")
local ModColor = BrickColor.new("Hot pink")
local AdminColor = BrickColor.new("Really blue")

local properties = {
    Color = NormalColor.Color,
    Font = Enum.Font.FredokaOne,
    TextSize = 18,
}

-- Speed
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__index

mt.__index = function(o, k)
    if tostring(o) == "Humanoid" and (tostring(k) == "WalkSpeed" or tostring(k) == "JumpPower") then
        return 16
    end
    return old(o, k)
end
setreadonly(mt, true)  -- Restore readonly status

-- Count Weights
local abbreviations = {'', 'K', 'M', 'B', 'T', 'Qd', 'Qn', 'Sx', 'Sp', 'O', 'N', 'D', 'Und', 'DD', 'Td', 'Qtd', 'QnD', 'SxD', 'SpD', 'OcD', 'NoD', 'VgN', 'UvG', 'DvG', 'TvG', 'QtV'}

local function roundNumber(Amount)
    local Text = tostring(Amount)
    local chosenAbbreviation
    for i = 1, #abbreviations do
        if tonumber(Amount) < 10^(i*3) then
            Text = math.floor(Amount / ((10^((i-1)*3)) / 100)) / 100 .. abbreviations[i]
            break
        end
    end
    return Text
end

-- Lower Ping
local function ping()
    local decalsyeeted = true
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = false
    l.FogEnd = 9e9
    l.Brightness = 0
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    for _, v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
        elseif v:IsA("Decal") and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        end
    end
    for _, e in pairs(l:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end
end

RainbowGloves = false
AutoLifting = false

local function Switching(value)
    if value then
        RainbowGloves = true
        repeat
            for _, weapon in ipairs({
                "Wamen", "Waffle", "Donut", "Pizza", "Snow Camo", "Dirt", "Red", "Green", "Desert Camo", "Bape",
                "Bape Blue", "Blue", "Spongebob", "Wanwood", "Adurite", "Rainbow", "Cartoon", "Grass", "Black Iron",
                "Pink", "Bape Pink", "Doge", "Trump", "White", "Gold", "Bluesteel"
            }) do
                game.ReplicatedStorage.Remotes.SellWep:FireServer(weapon)
                wait(0.1)
            end
        until not RainbowGloves
    else
        RainbowGloves = false
    end
end

properties.Text = "[Ghost]: Welcome To Ghost Hub | " .. plr.Name .. "!"
properties.Color = AdminColor.Color
StarterGui:SetCore("ChatMakeSystemMessage", properties)

properties.Text = "[Ghost]: Anti Afk Has Been Enabled"
properties.Color = AdminColor.Color
StarterGui:SetCore("ChatMakeSystemMessage", properties)

local ArrayField = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/ArrayField/main/Source.lua'))()

local Window = ArrayField:CreateWindow({
    Name = "Ghost Hub",
    LoadingTitle = "Welcome to Ghost Hub",
    LoadingSubtitle = "by Ghost",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "ArrayField"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "Untitled",
        Subtitle = "Key System",
        Note = "No method of obtaining the key is provided",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Actions = {
            [1] = {
                Text = 'Click here to copy the key link <--',
                OnPress = function()
                    print('Pressed')
                end,
            }
        },
        Key = {"Ghost"}
    }
})

local Farm = Window:CreateTab("Farming", 4483362458)
local Dupe = Window:CreateTab("Duping", 4483362458)
local Data = Window:CreateTab("Data", 4483362458)


-- Farming Section
local FarmSection = Farm:CreateSection("Farming", false)

Farm:CreateToggle({
    Name = "Farm",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(f)
        if f then
            local Debounce = 0.7
            AutoLifting = true
            repeat
                for _, v in pairs(plr.Character:GetChildren()) do
                    if v.Name == "Double Weight" then
                        v:Activate()
                    else
                        for _, v in pairs(plr.Character:GetChildren()) do
                            if v.Name == "Double Weight" then
                                v:Activate()
                                v.Parent = plr.Character
                            end
                        end
                    end
                end
                wait(Debounce)
            until not AutoLifting
        else
            AutoLifting = false
        end
    end,
})

local ExtraSection = Farm:CreateSection("Extra", false)

Farm:CreateButton({
    Name = "Less Ping",
    Interact = 'Click',
    Callback = function()
        ping()
    end,
})

Farm:CreateButton({
    Name = "Remove Ui",
    Interact = 'Click',
    Callback = function()
        local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
        if playerGui:FindFirstChild("HUD") then
            playerGui.HUD:Destroy()
        end
        local replicatedFirst = game:GetService("ReplicatedFirst")
        if replicatedFirst:FindFirstChild("TourneyQ") then
            replicatedFirst.TourneyQ:Destroy()
        end
    end,
})

Farm:CreateButton({
    Name = "Remove Camera",
    Interact = 'Click',
    Callback = function()
        local coreGui = game:GetService("CoreGui")
        if coreGui:FindFirstChild("RobloxGui") then
            local backpack = coreGui.RobloxGui:FindFirstChild("Backpack")
            if backpack then
                backpack:Destroy()
            end
        end
        local camera = game:GetService("Workspace"):FindFirstChild("Camera")
        if camera then
            camera:Destroy()
        end
    end,
})

Farm:CreateButton({
    Name = "Safe Zone",
    Interact = 'Click',
    Callback = function()
        local char = plr.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(-1977.9436, 510, -5295.2124,

 1, 0, 0, 0, 1, 0, 0, 0, 1)
        end
    end,
})






-- Data Section
local StrengthEarned = Data:CreateLabel("Strength Earned: 0")

spawn(function()
    task.wait(0.1)
    local str = plr.leaderstats:FindFirstChild("Strength")
    if str then
        local curvalue = str.Value
        local earned = 0
        local SuffixList = {"", "K", "M", "B", "T"}
        local function Format(value, idp)
            local exp = math.floor(math.log(math.max(1, math.abs(value)), 1000))
            local suffix = SuffixList[1 + exp] or ("e+"   .. exp)
            local norm = math.floor(value * ((10 ^ idp) / (1000 ^ exp))) / (10 ^ idp)
            return ("%." .. idp .. "f%s"):format(norm, suffix)
        end
        str:GetPropertyChangedSignal("Value"):Connect(function()
            local delta = (str.Value - curvalue)
            earned = earned + delta
            StrengthEarned:Set("Strength Earned: " .. Format(earned, 1))
            curvalue = str.Value
        end)
    end
end)





-- Duping Section
Dupe:CreateToggle({
    Name = "Dupe",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(state)
        if state then
            properties.Text = "[Ghost]: Duping Has Started!"
            properties.Color = AdminColor.Color
            StarterGui:SetCore("ChatMakeSystemMessage", properties)

            _G.AfkDuper1 = true
            local MarketplaceService = game:GetService("MarketplaceService")

            local function simulatePurchase(gamePassId)
                MarketplaceService:SignalPromptGamePassPurchaseFinished(plr, gamePassId, true)
            end
            while _G.AfkDuper1 do
                wait(1)
                simulatePurchase(5949054)
            end
        else
            _G.AfkDuper1 = false
        end
    end,
})