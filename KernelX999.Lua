--// =========================================================
--// NGUYEN THANH PHU PREMIUM GUI V2
--// Full Premium Framework Style Lee Hub / Kernel
--// =========================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

pcall(function()
    game.CoreGui:FindFirstChild("KernelPremiumV2"):Destroy()
end)

--==================================================
-- Notification
--==================================================
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

--==================================================
-- GUI ROOT
--==================================================
local gui = Instance.new("ScreenGui")
gui.Name = "KernelPremiumV2"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

--==================================================
-- LOGO BUTTON
--==================================================
local logo = Instance.new("TextButton")
logo.Parent = gui
logo.Size = UDim2.new(0,58,0,58)
logo.Position = UDim2.new(0,20,0.5,-29)
logo.Text = "K"
logo.Font = Enum.Font.GothamBlack
logo.TextScaled = true
logo.TextColor3 = Color3.new(1,1,1)
logo.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)

local logoStroke = Instance.new("UIStroke",logo)
logoStroke.Color = Color3.fromRGB(255,0,0)

--==================================================
-- MAIN FRAME
--==================================================
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,720,0,460)
main.Position = UDim2.new(0.5,-360,0.5,-230)
main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Instance.new("UICorner",main).CornerRadius = UDim.new(0,14)

local stroke = Instance.new("UIStroke",main)
stroke.Color = Color3.fromRGB(255,0,0)
stroke.Thickness = 1.5

-- glow pulse
spawn(function()
    while true do
        TweenService:Create(stroke,TweenInfo.new(1),{Transparency=0.3}):Play()
        wait(1)
        TweenService:Create(stroke,TweenInfo.new(1),{Transparency=0}):Play()
        wait(1)
    end
end)

--==================================================
-- TITLE
--==================================================
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

--==================================================
-- LOADING
--==================================================
local load = Instance.new("Frame")
load.Parent = gui
load.Size = UDim2.new(0,420,0,130)
load.Position = UDim2.new(0.5,-210,0.5,-65)
load.BackgroundColor3 = Color3.fromRGB(15,15,15)
Instance.new("UICorner",load)

local bar = Instance.new("Frame")
bar.Parent = load
bar.Position = UDim2.new(0,20,0,80)
bar.Size = UDim2.new(0,0,0,16)
bar.BackgroundColor3 = Color3.fromRGB(255,0,0)
Instance.new("UICorner",bar)

local txt = Instance.new("TextLabel")
txt.Parent = load
txt.Size = UDim2.new(1,0,0,40)
txt.Text = "0%"
txt.BackgroundTransparency = 1
txt.TextColor3 = Color3.new(1,1,1)
txt.Font = Enum.Font.GothamBold
txt.TextScaled = true

for i=1,100 do
    txt.Text = i.."%"
    bar.Size = UDim2.new(i/100,-40,0,16)
    wait(0.015)
end
load:Destroy()

--==================================================
-- DRAGGABLE
--==================================================
local dragging=false
local dragStart,startPos

main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging=true
        dragStart=input.Position
        startPos=main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta=input.Position-dragStart
        main.Position=UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset+delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset+delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 then
        dragging=false
    end
end)

--==================================================
-- LOGO OPEN/CLOSE
--==================================================
logo.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

--==================================================
-- TAB SYSTEM
--==================================================
local tabs = {"Main","Movement","Visual","Settings"}
local pages = {}

for i,v in ipairs(tabs) do
    local tab = Instance.new("TextButton")
    tab.Parent = main
    tab.Size = UDim2.new(0,150,0,35)
    tab.Position = UDim2.new(0,(i-1)*160+20,0,60)
    tab.Text = v
    tab.BackgroundColor3 = Color3.fromRGB(20,20,20)
    tab.TextColor3 = Color3.new(1,1,1)
    tab.Font = Enum.Font.GothamBold
    Instance.new("UICorner",tab)

    local page = Instance.new("Frame")
    page.Parent = main
    page.Size = UDim2.new(1,-40,1,-120)
    page.Position = UDim2.new(0,20,0,110)
    page.BackgroundTransparency = 1
    page.Visible = i==1
    pages[v]=page

    tab.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do
            p.Visible=false
        end
        page.Visible=true
    end)
end

--==================================================
-- BUTTON MAKER
--==================================================
local function makeButton(parent,text,y,callback)
    local b=Instance.new("TextButton")
    b.Parent=parent
    b.Size=UDim2.new(0,220,0,42)
    b.Position=UDim2.new(0,10,0,y)
    b.Text=text
    b.BackgroundColor3=Color3.fromRGB(22,22,22)
    b.TextColor3=Color3.new(1,1,1)
    b.Font=Enum.Font.GothamBold
    Instance.new("UICorner",b)

    b.MouseButton1Click:Connect(function()
        notify(text)
        callback()
    end)
end

--==================================================
-- MAIN FUNCTIONS
--==================================================
local savedPos=nil

makeButton(pages.Main,"Save Position",10,function()
    local c=LocalPlayer.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        savedPos=c.HumanoidRootPart.CFrame
    end
end)

makeButton(pages.Main,"Tele Saved Position",60,function()
    local c=LocalPlayer.Character
    if c and savedPos then
        c.HumanoidRootPart.CFrame=savedPos
    end
end)

makeButton(pages.Main,"Rejoin Server",110,function()
    TeleportService:Teleport(game.PlaceId,LocalPlayer)
end)

--==================================================
-- PLAYER LIST
--==================================================
local list = Instance.new("ScrollingFrame")
list.Parent = pages.Main
list.Size = UDim2.new(0,250,0,220)
list.Position = UDim2.new(0,260,0,10)
list.CanvasSize = UDim2.new(0,0,0,600)
list.BackgroundColor3 = Color3.fromRGB(15,15,15)
Instance.new("UICorner",list)

for i,p in ipairs(Players:GetPlayers()) do
    local t = Instance.new("TextLabel")
    t.Parent = list
    t.Size = UDim2.new(1,-10,0,35)
    t.Position = UDim2.new(0,5,0,(i-1)*40)
    t.Text = p.Name
    t.TextColor3 = Color3.new(1,1,1)
    t.BackgroundTransparency = 1
end

--==================================================
-- MOVEMENT
--==================================================
local speed=16
local jump=50

makeButton(pages.Movement,"Speed +5",10,function()
    speed+=5
    local h=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed=speed end
end)

makeButton(pages.Movement,"JumpPower +10",60,function()
    jump+=10
    local h=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if h then h.JumpPower=jump end
end)

local autoJump=false
makeButton(pages.Movement,"Auto Jump ON/OFF",110,function()
    autoJump=not autoJump
end)

spawn(function()
    while true do
        if autoJump then
            local h=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if h then h.Jump=true end
        end
        wait(0.25)
    end
end)

--==================================================
-- VISUAL
--==================================================
local fov = Drawing.new("Circle")
fov.Visible=false
fov.Radius=120
fov.Thickness=1
fov.Color=Color3.fromRGB(255,0,0)

makeButton(pages.Visual,"FOV Circle",10,function()
    fov.Visible=not fov.Visible
end)

RunService.RenderStepped:Connect(function()
    fov.Position=Vector2.new(
        workspace.CurrentCamera.ViewportSize.X/2,
        workspace.CurrentCamera.ViewportSize.Y/2
    )
end)

makeButton(pages.Visual,"ESP Box Demo",60,function()
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LocalPlayer and p.Character and not p.Character:FindFirstChild("Highlight") then
            local h=Instance.new("Highlight")
            h.FillTransparency=1
            h.OutlineColor=Color3.fromRGB(255,0,0)
            h.Parent=p.Character
        end
    end
end)

--==================================================
-- SETTINGS
--==================================================
makeButton(pages.Settings,"Close GUI",10,function()
    main.Visible=false
end)

makeButton(pages.Settings,"Destroy GUI",60,function()
    gui:Destroy()
end)

makeButton(pages.Settings,"Reset Values",110,function()
    speed=16
    jump=50
end)

print("Premium V2 Loaded")
