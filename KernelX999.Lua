--// =========================================================
--// NGUYEN THANH PHU PREMIUM GUI
--// Style: Lee Hub / Kernel Premium Framework
--// By KernelX Style
--// =========================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

--=========================================================
-- Notification
--=========================================================
local function notify(txt)
    pcall(function()
        StarterGui:SetCore("SendNotification",{
            Title="KernelX",
            Text=txt,
            Duration=3
        })
    end)
end

notify("Script By KernelX")

--=========================================================
-- Remove old GUI
--=========================================================
pcall(function()
    game.CoreGui:FindFirstChild("KernelPremiumGUI"):Destroy()
end)

--=========================================================
-- ScreenGui
--=========================================================
local gui = Instance.new("ScreenGui")
gui.Name = "KernelPremiumGUI"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

--=========================================================
-- Logo Button
--=========================================================
local logo = Instance.new("TextButton")
logo.Parent = gui
logo.Size = UDim2.new(0,60,0,60)
logo.Position = UDim2.new(0,20,0.5,-30)
logo.Text = "K"
logo.TextColor3 = Color3.fromRGB(255,255,255)
logo.TextScaled = true
logo.Font = Enum.Font.GothamBold
logo.BackgroundColor3 = Color3.fromRGB(20,20,20)
logo.AutoButtonColor = false

local logoCorner = Instance.new("UICorner",logo)
logoCorner.CornerRadius = UDim.new(1,0)

--=========================================================
-- Main Frame
--=========================================================
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,650,0,420)
main.Position = UDim2.new(0.5,-325,0.5,-210)
main.BackgroundColor3 = Color3.fromRGB(10,10,10)

local mainCorner = Instance.new("UICorner",main)
mainCorner.CornerRadius = UDim.new(0,14)

-- Glow
local stroke = Instance.new("UIStroke",main)
stroke.Color = Color3.fromRGB(255,0,0)
stroke.Thickness = 1.5

--=========================================================
-- Shadow
--=========================================================
local shadow = Instance.new("ImageLabel")
shadow.Parent = main
shadow.BackgroundTransparency = 1
shadow.Size = UDim2.new(1,30,1,30)
shadow.Position = UDim2.new(0,-15,0,-15)
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10,10,118,118)
shadow.ZIndex = 0

main.ZIndex = 2

--=========================================================
-- Title Rainbow
--=========================================================
local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,50)
title.BackgroundTransparency = 1
title.Text = "Nguyen Thanh Phu"
title.Font = Enum.Font.GothamBold
title.TextScaled = true

spawn(function()
    while true do
        for i=0,1,0.01 do
            title.TextColor3 = Color3.fromHSV(i,1,1)
            wait()
        end
    end
end)

--=========================================================
-- Draggable
--=========================================================
local dragging = false
local dragInput, dragStart, startPos

main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

main.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

--=========================================================
-- Loading Frame
--=========================================================
local loading = Instance.new("Frame")
loading.Parent = gui
loading.Size = UDim2.new(0,400,0,120)
loading.Position = UDim2.new(0.5,-200,0.5,-60)
loading.BackgroundColor3 = Color3.fromRGB(15,15,15)

local lc = Instance.new("UICorner",loading)

local bar = Instance.new("Frame")
bar.Parent = loading
bar.Size = UDim2.new(0,0,0,15)
bar.Position = UDim2.new(0,20,0,70)
bar.BackgroundColor3 = Color3.fromRGB(255,0,0)

local percent = Instance.new("TextLabel")
percent.Parent = loading
percent.Size = UDim2.new(1,0,0,40)
percent.Text = "0%"
percent.BackgroundTransparency = 1
percent.TextColor3 = Color3.new(1,1,1)
percent.Font = Enum.Font.GothamBold
percent.TextScaled = true

for i=1,100 do
    percent.Text = i.."%"
    bar.Size = UDim2.new(i/100, -40,0,15)
    wait(0.02)
end

loading:Destroy()

--=========================================================
-- Toggle Menu
--=========================================================
logo.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

--=========================================================
-- Saved Position
--=========================================================
local savedPos = nil

local function savePos()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        savedPos = char.HumanoidRootPart.CFrame
        notify("Saved Position")
    end
end

local function telePos()
    local char = LocalPlayer.Character
    if char and savedPos then
        char.HumanoidRootPart.CFrame = savedPos
        notify("Teleported")
    end
end

--=========================================================
-- Auto Jump
--=========================================================
local autoJump = false
spawn(function()
    while true do
        if autoJump then
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Jump = true
            end
        end
        wait(0.2)
    end
end)

--=========================================================
-- Anti AFK
--=========================================================
LocalPlayer.Idled:Connect(function()
    local vu = game:GetService("VirtualUser")
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

--=========================================================
-- ESP BOX DEMO
--=========================================================
local espEnabled = false
local espObjects = {}

local function createESP(player)
    if player ~= LocalPlayer then
        local box = Instance.new("Highlight")
        box.FillTransparency = 1
        box.OutlineColor = Color3.fromRGB(255,0,0)
        box.Parent = player.Character
        espObjects[player] = box
    end
end

--=========================================================
-- FOV Circle Demo
--=========================================================
local fov = Drawing.new("Circle")
fov.Visible = false
fov.Radius = 120
fov.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2,workspace.CurrentCamera.ViewportSize.Y/2)
fov.Color = Color3.fromRGB(255,0,0)
fov.Thickness = 1

RunService.RenderStepped:Connect(function()
    fov.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2,workspace.CurrentCamera.ViewportSize.Y/2)
end)

--=========================================================
-- Sample Buttons
--=========================================================
local function createButton(text,pos,callback)
    local btn = Instance.new("TextButton")
    btn.Parent = main
    btn.Size = UDim2.new(0,180,0,40)
    btn.Position = pos
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Instance.new("UICorner",btn)

    btn.MouseButton1Click:Connect(callback)
end

createButton("Save Position",UDim2.new(0,20,0,80),savePos)
createButton("Tele Saved Position",UDim2.new(0,20,0,130),telePos)

createButton("Rejoin Server",UDim2.new(0,20,0,180),function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

createButton("Close GUI",UDim2.new(0,20,0,230),function()
    main.Visible = false
end)

createButton("Destroy GUI",UDim2.new(0,20,0,280),function()
    gui:Destroy()
end)

print("Kernel Premium GUI Loaded")
