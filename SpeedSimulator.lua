local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local UI = Material.Load({
     Title = "Speed Simualtor GUI",
     Style = 3,
     SizeX = 250,
     SizeY = 200,
     Theme = "Dark"
})

local Page = UI.New({
    Title = "Main"
})

Page.Toggle({
    Text = "Atuo Collect Gems",
    Callback = function(value)
        getgenv().collectGems = value
        if value then
            autoGems()
        end
    end,
    Enabled = false
})

Page.Toggle({
    Text = "Auto Hoop",
    Callback = function(value)
        getgenv().ringFarm = value
        if value then
            autoHoop()
        end
    end,
    Enabled = false
})

Page.Toggle({
    Text = "Atuo Rebirth",
    Callback = function(value)
        getgenv().autoRebirth = value
        if value then
            autoBirth()
        end
    end,
    Enabled = false
})

getgenv().collectGems = false
getgenv().ringFarm = false
getgenv().autoRebirth = false

function autoGems()
    spawn(function()
        local playerHead = game.Players.LocalPlayer.Character.Head
        while wait() do
            if not getgenv().collectGems then break end
            for i, v in pairs(game:GetService("Workspace").ballsFolder:GetDescendants()) do
                if v.Name == "TouchInterest" and v.Parent then
                    firetouchinterest(playerHead, v.Parent, 0)
                    wait(0.01)
                    firetouchinterest(playerHead, v.Parent, 1)
                end
            end
        end
    end)
end

function autoHoop()
    spawn(function()
        local plyr = game.Players.LocalPlayer
        local args
        while wait() do
            if not getgenv().ringFarm then break end
            for i, v in pairs(game:GetService("Workspace").Rings:GetChildren()) do
                plyr.Character.HumanoidRootPart.CFrame = game.Workspace.Rings[v.Name].CFrame*CFrame.new(0,-20,0)
                wait (0.5)
                args = {[1] = v.Name}
                game:GetService("ReplicatedStorage").Networking.Hoops:FireServer(unpack(args))
                wait(0.1)
            end
        end
    end)
end

function autoBirth()
    spawn(function()
        while wait() do
            if not getgenv().autoRebirth then break end
            game:GetService("ReplicatedStorage").Networking.Rebirth:FireServer()
            wait(10)
        end
    end)
end