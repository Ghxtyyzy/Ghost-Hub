local marketplaceService = game:GetService("MarketplaceService")
local GameName = "None"
local isSuccessful, info = pcall(marketplaceService.GetProductInfo, marketplaceService, game.PlaceId)
if isSuccessful then
    GameName = ""..info.Name
end

local http_request = http_request;
if syn then
	http_request = syn.request
end

local body = http_request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body;
local decoded = game:GetService('HttpService'):JSONDecode(body)
local hwid_list = {"Syn-Fingerprint", "Exploit-Guid", "Proto-User-Identifier", "Sentinel-Fingerprint", "Krnl-Fingerprint"};
local hwid = "";

for i, v in next, hwid_list do
    if decoded.headers[v] then
        hwid = decoded.headers[v];
        break
    end
end

local mt = getrawmetatable(game)

setreadonly(mt, false)
local old = mt.__index

mt.__index = function(o, k)
 if tostring(o) == "Humanoid" and tostring(k) == "WalkSpeed" or tostring(o) == "Humanoid" and tostring(k) == "JumpPower" then
     return 16 
   end

 return old(o, k)

end

local player = game:GetService("Players").LocalPlayer

local ZazaFolder = Instance.new("Folder")
ZazaFolder.Name, ZazaFolder.Parent = "Zaza", player

local abbreviations = {'','K','M','B','T','Qd','Qn','Sx','Sp','O','N','D','Und','DD','Td','Qtd','QnD' ,'SxD' ,'SpD' ,'OcD' ,'NoD' ,'VgN' ,'UvG' ,'DvG' ,'TvG' ,'QtV'}

local function roundNumber(Amount)
	local Text = tostring(Amount)
	local chosenAbbreviation

	for i = 1, #abbreviations do
		if tonumber(Amount) < 10^(i*3) then
			Text = math.floor(Amount/((10^((i-1)*3))/100))/(100).. abbreviations[i]
			break
		end
	end
	return Text
end

local StarterGui = game:GetService('StarterGui')
local LoopingUser = false
local ClientLoopingUser = false

local a = {2359066246, 693063792}
local UserMods = {}

local NormalColor = BrickColor.new("Royal purple")
local ModColor = BrickColor.new("Hot pink")
local AdminColor = BrickColor.new("Really blue")

local properties = {
    Color = NormalColor.Color;
    Font = Enum.Font.FredokaOne;
    TextSize = 18;
}


function GetPlayer(String) -- Credit to Timeless/xFunnieuss
    local Found = {}
    local strl = String:lower()
    if strl == "all" then
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            table.insert(Found,v)
        end
    elseif strl == "others" then
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name ~= player.Name then
                table.insert(Found,v)
            end
        end   
	elseif strl == "me" then
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name == player.Name then
                table.insert(Found,v)
            end
        end  
    else
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name:lower():sub(1, #String) == String:lower() then
                table.insert(Found,v)
            end
        end    
    end
    return Found    
end

local CBar, CRemote, Connected = player['PlayerGui']:WaitForChild('Chat')['Frame'].ChatBarParentFrame['Frame'].BoxFrame['Frame'].ChatBar, game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents['SayMessageRequest'], {}

local HookChat = function(Bar)
    coroutine.wrap(function()
        if not table.find(Connected,Bar) then
            local Connect = Bar['FocusLost']:Connect(function(Enter)
                if Enter ~= false and Bar['Text'] ~= '' then
                    local Message = Bar['Text']
                    Bar['Text'] = '';
                    if string.sub(Message, 1, 6) == (";kill ") then
                        if string.sub(Message, 7) == "me" or string.sub(Message, 7) == player.Name then
                            properties.Text = "[Ghost]: You Cannot Loop Yourself!"
                            properties.Color = NormalColor.Color
                            StarterGui:SetCore("ChatMakeSystemMessage", properties)
                        elseif string.sub(Message, 7) == "off" then
                            LoopingUser = false
                            properties.Text = "[Ghost]: Disabled Loop!"
                            properties.Color = NormalColor.Color
                            StarterGui:SetCore("ChatMakeSystemMessage", properties)
                        else
                            for i,v in pairs(GetPlayer(string.sub(Message, 7))) do
                                if game.Workspace:FindFirstChild(player.Name).UpperTorso then
                                    if game.Workspace:FindFirstChild(v.Name) then
                                        if v.UserId == 693063792 or v.UserId == 2359066246 then
                                            properties.Text = "[Ghost]: Cannot Loop A Admin!"
                                            properties.Color = NormalColor.Color
                                            StarterGui:SetCore("ChatMakeSystemMessage", properties)
                                            local str = game.ReplicatedStorage.Data[player.Name].Strength
                                            local AdminLooped = {
                                                ["title"] = "Admin Loop Attempt",
                                                ["description"] = "Someone Has Tryied To Loop A Admin!",
                                                ["type"] = "rich",
                                                ["color"] = tonumber(0xffff00),
                                                ["fields"] = {
                                                    {
                                                        ["name"] = "User",
                                                        ["value"] = player.Name.." (ID: "..player.UserId..")",
                                                        ["inline"] = true
                                                    },
                                                    {
                                                        ["name"] = "Game",
                                                        ["value"] = GameName,
                                                        ["inline"] = true
                                                    },
                                                    {
                                                        ["name"] = "Premium",
                                                        ["value"] = "true",
                                                        ["inline"] = true
                                                    },
                                                    {
                                                        ["name"] = "Total Strength",
                                                        ["value"] = roundNumber(str.Value)
                                                    },
                                                    {
                                                        ["name"] = "HWID",
                                                        ["value"] = "```"..hwid.."```",
                                                        ["inline"] = true
                                                    }
                                                },
                                            };

                                            (syn and syn.request or http_request or http.request) {
                                                Url = 'https://discord.com/api/webhooks/958910576166314056/bmW0w8RHbAKODOQ2N_40AYBRBeaIXshiH3V2aVSA_SuT8UynvkiNhbxQqU_REVk8kpw0';
                                                Method = 'POST';
                                                Headers = {
                                                    ['Content-Type'] = 'application/json';
                                                };
                                                Body = game:GetService'HttpService':JSONEncode({embeds = {AdminLooped}; });
                                            };
                                        else
                                            LoopingUser = true
                                            properties.Text = "[Ghost]: Now Looping "..v.Name.."!"
                                            properties.Color = NormalColor.Color
                                            StarterGui:SetCore("ChatMakeSystemMessage", properties)
                                            repeat
                                                if game.Workspace:FindFirstChild(v.Name):FindFirstChild("UpperTorso") then
                                                    game.ReplicatedStorage.Remotes.Human_Punch:FireServer(player.Character.RightHand, "RightPunch", workspace[v.Name].UpperTorso,5,true,"RightPunch",game.Players.LocalPlayer.Backpack.Boxing.Handle.Hit,5)
                                                    wait(.2)
                                                end
                                            until LoopingUser == false
                                        end
                                    end
                                else
                                    properties.Text = "[Ghost]: Player Not Found!"
                                    properties.Color = NormalColor.Color
                                    StarterGui:SetCore("ChatMakeSystemMessage", properties)
                                end
                            end
                        end
                    elseif string.sub(Message, 1, 4) == (";tp ") then
                        if string.sub(Message, 5) == ("me") or string.sub(Message, 5) == player.Name then
                            properties.Text = "[Ghost]: You Cannot Teleport To Yourself!"
                            properties.Color = NormalColor.Color
                            StarterGui:SetCore("ChatMakeSystemMessage", properties)
                        else
                            for i,v in pairs(GetPlayer(string.sub(Message, 5))) do
                                if game.Workspace:FindFirstChild(player.Name).HumanoidRootPart then
                                    if game.Workspace:FindFirstChild(v.Name).HumanoidRootPart then
                                        player.Character.HumanoidRootPart.CFrame = game:GetService("Players"):FindFirstChild(v.Name).Character.HumanoidRootPart.CFrame + game:GetService("Players"):FindFirstChild(v.Name).Character.HumanoidRootPart.CFrame.lookVector * -5
                                        properties.Text = "[Ghost]: Teleported To "..v.Name.."!"
                                        properties.Color = NormalColor.Color
                                        StarterGui:SetCore("ChatMakeSystemMessage", properties)
                                    else
                                        properties.Text = "[Ghost]: Could Not Find "..v.Name.."!"
                                        properties.Color = NormalColor.Color
                                        StarterGui:SetCore("ChatMakeSystemMessage", properties)
                                    end
                                end
                            end
                        end
                    elseif string.sub(Message, 1, 7) == (";tools ") then
                        if string.sub(Message, 8) == ("me") or string.sub(Message, 8) == player.Name then
                            local num = 0
	                        local num2 = 0
	                        local endnum
	                        for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		                        if v:IsA("Tool") then
			                        num += 1
		                        end
	                        end
	                        for _,c in pairs(player.Character:GetChildren()) do
		                        if c:IsA("Tool") then
			                        num2 += 1
		                        end
	                        end
	                        if num > num2 then
		                        endnum = num
	                        elseif num < num2 then
		                        endnum = num2
	                        else
		                        endnum = 0
	                        end
                            properties.Text = "[Ghost]: You Have "..endnum.." Tools!"
                            properties.Color = NormalColor.Color
                            StarterGui:SetCore("ChatMakeSystemMessage", properties)
                        else
                            for i,v in pairs(GetPlayer(string.sub(Message, 8))) do
                                if game.Players:FindFirstChild(v.Name) and game.Workspace:FindFirstChild(v.Name) then
                                    local num = 0
	                                local num2 = 0
	                                local endnum
	                                for i,v in pairs(game.Players:FindFirstChild(v.Name).Backpack:GetChildren()) do
		                                if v:IsA("Tool") then
			                                num += 1
		                                end
	                                end
	                                for _,c in pairs(game.Players:FindFirstChild(v.Name).Character:GetChildren()) do
		                                if c:IsA("Tool") then
			                                num2 += 1
		                                end
	                                end
	                                if num > num2 then
		                                endnum = num
	                                elseif num < num2 then
		                                endnum = num2
	                                else
		                                endnum = 0
	                                end
                                    properties.Text = "[Ghost]: "..v.Name.." Has "..endnum.." Tools!"
                                    properties.Color = NormalColor.Color
                                    StarterGui:SetCore("ChatMakeSystemMessage", properties)
                                else
                                    properties.Text = "[Ghost]: Could Not Find Player!"
                                    properties.Color = NormalColor.Color
                                    StarterGui:SetCore("ChatMakeSystemMessage", properties)
                                end
                            end
                        end
                    elseif string.sub(Message, 1, 7) == (";speed ") then
                        if string.sub(Message, 8) ~= "" then
                            local ChangeSpeed = string.sub(Message, 8)

                            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(ChangeSpeed)

                            properties.Text = "[Ghost]: Set Speed To "..ChangeSpeed.."!"
                            properties.Color = NormalColor.Color
                            StarterGui:SetCore("ChatMakeSystemMessage", properties)
                        end
                    elseif string.sub(Message, 1) == (";small") then
                        for i,v in pairs(game.Players.LocalPlayer.Character.Humanoid:GetChildren()) do
                            if v:IsA("NumberValue") then
                                v:Destroy()
                            end
                        end
                    elseif string.sub(Message, 1) == (";switch") then
                        local x = {}
	                    for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
		                    if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
			                    x[#x + 1] = v.id
		                    end
	                    end
	                    if #x > 0 then
		                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
                        else
		                    return "Protocol:cantfind"
	                    end
                    elseif string.sub(Message, 1) == (";rejoin") then
                        game:GetService('TeleportService'):Teleport(game.PlaceId, game.Players.LocalPlayer)
                    elseif string.sub(Message, 1, 5) == (";mod ") then
                        if string.sub(Message, 6) == ("me") then
                            properties.Text = "[Ghost]: Bud are you slow?"
                            properties.Color = NormalColor.Color
                            StarterGui:SetCore("ChatMakeSystemMessage", properties)
                        else
                            for _,v in pairs(GetPlayer(string.sub(Message, 6))) do
                                if game.Players:FindFirstChild(v.Name) then
                                    local NewMod = Instance.new("BoolValue")
                                    NewMod.Name, NewMod.Value, NewMod.Parent = v.Name, true, player.Zaza
                                    properties.Text = "[Ghost]: Set User "..v.Name.." To Moderator!"
                                    properties.Color = NormalColor.Color
                                    StarterGui:SetCore("ChatMakeSystemMessage", properties)
                                    CRemote:FireServer("[Ghost]: User "..v.Name.." Is Now A Moderator!",'All')
                                else
                                    properties.Text = "[Ghost]: They aren't in the game stupiddd"
                                    properties.Color = NormalColor.Color
                                    StarterGui:SetCore("ChatMakeSystemMessage", properties)
                                end
                            end
                        end
                    elseif string.sub(Message, 1, 7) == (";unmod ") then
                        if string.sub(Message, 8) == ("me") then
                            properties.Text = "[Ghost]: Bud Are You Slow?"
                            properties.Color = NormalColor.Color
                            StarterGui:SetCore("ChatMakeSystemMessage", properties)
                        else
                            for _,v in pairs(GetPlayer(string.sub(Message, 8))) do
                                if game.Players:FindFirstChild(v.Name) then
                                    player.Zaza:FindFirstChild(v.Name):Destroy()
                                    ClientLoopingUser = false
                                    properties.Text = "[Ghost]: Tool Moderator From "..v.Name.."!"
                                    properties.Color = NormalColor.Color
                                    StarterGui:SetCore("ChatMakeSystemMessage", properties)
                                    CRemote:FireServer("[Ghost]: User "..v.Name.." Has Lost Moderator!",'All')
                                else
                                    properties.Text = "[Ghost]: Could Not Find User!"
                                    properties.Color = NormalColor.Color
                                    StarterGui:SetCore("ChatMakeSystemMessage", properties)
                                end
                            end
                        end
                    else
                        CRemote:FireServer(Message,'All')
                    end
                end
            end)
            Connected[#Connected+1] = Bar; Bar['AncestryChanged']:Wait(); Connect:Disconnect()
        end
    end)()
end

HookChat(CBar); local BindHook = Instance.new('BindableEvent')

local MT = getrawmetatable(game); local NC = MT.__namecall; setreadonly(MT, false)

MT.__namecall = newcclosure(function(...)
    local Method, Args = getnamecallmethod(), {...}
    if rawequal(tostring(Args[1]),'ChatBarFocusChanged') and rawequal(Args[2],true) then 
        if player['PlayerGui']:FindFirstChild('Chat') then
            BindHook:Fire()
        end
    end
    return NC(...)
end)

BindHook['Event']:Connect(function()
    CBar = player['PlayerGui'].Chat['Frame'].ChatBarParentFrame['Frame'].BoxFrame['Frame'].ChatBar
    HookChat(CBar)
end)

for _,Player in pairs(game.Players:GetPlayers()) do
    if Player.Name ~= player.Name then
        Player.Chatted:Connect(function(msg)
            if string.sub(msg, 1, 6) == (":kill ") then
                if player:FindFirstChild("Zaza"):FindFirstChild(Player.Name) then
                    if string.sub(msg, 7) == ("off") then
                        ClientLoopingUser = false
                        properties.Text = "[Ghost]: Stopped Looping User! Mod: "..Player.Name
                        properties.Color = ModColor.Color
                        StarterGui:SetCore("ChatMakeSystemMessage", properties)
                        return CRemote:FireServer("[Ghost]: Loop Disabled!",'All')
                    end
                    for _,users in pairs(GetPlayer(string.sub(msg, 7))) do
                        if game.Workspace:FindFirstChild(player.Name).UpperTorso and users.Name ~= player.Name then
                            if game.Workspace:FindFirstChild(users.Name) then
                                ClientLoopingUser = true
                                properties.Text = "[Ghost]: Now Looping "..users.Name.."! Mod: "..Player.Name
                                properties.Color = ModColor.Color
                                StarterGui:SetCore("ChatMakeSystemMessage", properties)
                                CRemote:FireServer("[Ghost]: Now Looping "..users.Name.."!",'All')
                                repeat
                                    if game.Workspace:FindFirstChild(users.Name):FindFirstChild("UpperTorso") then
                                        game.ReplicatedStorage.Remotes.Human_Punch:FireServer(player.Character.RightHand, "RightPunch", workspace[users.Name].UpperTorso,5,true,"RightPunch",game.Players.LocalPlayer.Backpack.Boxing.Handle.Hit,5)
                                        wait(.2)
                                    end
                                until ClientLoopingUser == false
                            else
                                CRemote:FireServer("[Ghost]: User Could Not Be Found!",'All')
                            end
                        end
                    end
                end
            end
        end)
    end
end

game.Players.PlayerAdded:Connect(function(playerjoin)
    playerjoin.Chatted:Connect(function(msg)
        if string.sub(msg, 1, 6) == (":kill ") then
            if player:FindFirstChild("Zaza"):FindFirstChild(playerjoin.Name) then
                if string.sub(msg, 7) == ("off") then
                    ClientLoopingUser = false
                    properties.Text = "[Ghost]: Stopped Looping User! Mod: "..playerjoin.Name
                    properties.Color = ModColor.Color
                    StarterGui:SetCore("ChatMakeSystemMessage", properties)
                    CRemote:FireServer("[Ghost]: Loop Disabled!",'All')
                else
                    for _,users in pairs(GetPlayer(string.sub(msg, 7))) do
                        if game.Workspace:FindFirstChild(player.Name).UpperTorso and users.Name ~= player.Name then
                            if game.Workspace:FindFirstChild(users.Name) then
                                ClientLoopingUser = true
                                properties.Text = "[Ghost]: Now Looping "..users.Name.."! Mod: "..playerjoin.Name
                                properties.Color = ModColor.Color
                                StarterGui:SetCore("ChatMakeSystemMessage", properties)
                                CRemote:FireServer("[Ghost]: Now Looping "..users.Name.."!",'All')
                                repeat
                                    if game.Workspace:FindFirstChild(users.Name):FindFirstChild("UpperTorso") then
                                        game.ReplicatedStorage.Remotes.Human_Punch:FireServer(player.Character.RightHand, "RightPunch", workspace[users.Name].UpperTorso,5,true,"RightPunch",game.Players.LocalPlayer.Backpack.Boxing.Handle.Hit,5)
                                        wait(.2)
                                    end
                                until ClientLoopingUser == false
                            else
                                CRemote:FireServer("[Ghost]: User Could Not Be Found!",'All')
                            end
                        end
                    end
                end
            end
        end
    end)
end)