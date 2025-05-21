local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local NewEmail = ReplicatedStorage.Events.NewEmail
local StartVote = ReplicatedStorage.Events.StartVote
local TakenItems = game:GetService("Workspace").GameInfo.TakenItems
local ChangingPlayerHealth = ReplicatedStorage.Events.ChangingPlayerHealth 
local function a()local b=""for c=1,math.random(45,50)do b=b..string.char(math.random(48,122))end;return b end

local Window = Fluent:CreateWindow({
    Title = "Radiant Script",
    SubTitle = "by catlover326",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "house" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "shapes" }),
}

local Options = Fluent.Options

do -- start

    local iem = 0
    local eviliem = 1
    local Input = Tabs.Main:AddInput("Input", {
        Title = "Amount",
        Default = "1",
        Placeholder = "Amount items to add/remove",
        Numeric = true,
        Finished = false,
        Callback = function(item)
        iem = item
        eviliem = item
        print(item)
        end
    })

local itemNames = {}
local evilitemNames = {}
for _, item in ipairs(TakenItems:GetChildren()) do
table.insert(itemNames, item.Name)
table.insert(evilitemNames, item.Name)
end

local Dropdown = Tabs.Main:AddDropdown("Dropdown", { -- should autoupdate if new items are added
    Title = "Item Giver",
    Values = itemNames,
    Multi = false,
    Default = 1,
})

Dropdown:OnChanged(function(Value)
        print("item changed:", Value)
        StartVote:FireServer("Pay Virus Requested Amount", Value, -iem)
    end)


    Tabs.Main:AddButton({
        Title = "Give All Items",
        Description = "Adds every item with the amount from the input",
        Callback = function()
        for _, item in ipairs(TakenItems:GetChildren()) do
            StartVote:FireServer("Pay Virus Requested Amount", item.Name, -iem)
        end
        end
    })


-- misc section
local CleanedToilet = ReplicatedStorage.Events.CleanedToilet
local ChangingGeneratorHealth = ReplicatedStorage.Events.ChangingGeneratorHealth
local LoweringStats = Players.LocalPlayer.PlayerGui.BasementItemGUIs.Computer.Background.Market.ProductIDs.LoweringStats
local BoughtProductFromMarket = ReplicatedStorage.Events.BoughtProductFromMarket
local ChargeCam = ReplicatedStorage.Events.SecurityCamera.ChangingHealth
local ActiveVoteCounting = ReplicatedStorage.Events.ActiveVoteCounting
local Respawn = ReplicatedStorage.Events.Respawn

    Tabs.Misc:AddButton({
        Title = "Heal Self",
        Description = "Heals you",
        Callback = function()
            ChangingPlayerHealth:FireServer(
                -100,
                true
            )

        end
    })

        Tabs.Misc:AddButton({
        Title = "Respawn",
        Description = "Can also revive you",
        Callback = function()
            Respawn:FireServer()
        end
    })

    Tabs.Misc:AddButton({
        Title = "Buy Stats lowering boost",
        Description = "Buys the stat lowering boost from the market (For Free)",
        Callback = function()
            firesignal(BoughtProductFromMarket.OnClientEvent, 
                LoweringStats
            )

        end
    })

local Toggle3 = Tabs.Misc:AddToggle("heal2", {Title = "Auto Heal", Default = false })

    Toggle3:OnChanged(function()
        print("Toggle changed:", Options.heal2.Value)
        while Options.heal2.Value == true do
        task.wait(.1)
            ChangingPlayerHealth:FireServer(
                -100,
                true
            )
        end
    end)

local Toggle2 = Tabs.Misc:AddToggle("door", {Title = "Auto Charge VaultDoor", Default = false })

    Toggle2:OnChanged(function()
        print("Toggle changed:", Options.door.Value)
        while Options.door.Value == true do
        task.wait(.1)
        ChargeCam:FireServer()
        end
    end)


local Toggle1 = Tabs.Misc:AddToggle("generator", {Title = "Auto Charge Generator", Default = false })


    Toggle1:OnChanged(function()
        print("Toggle changed:", Options.generator.Value)
        while Options.generator.Value == true do
        task.wait(.1)
        ChangingGeneratorHealth:FireServer()
        end
    end)

end -- end
