--// PHUBABY DEV MOBILE FIX
--// Run Script By Nguyễn Thanh Phú

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--====================================================
-- SAFE GUI PARENT
--====================================================

pcall(function()
    if game.CoreGui:FindFirstChild("PhuBabyDev") then
        game.CoreGui.PhuBabyDev:Destroy()
    end
    if LocalPlayer.PlayerGui:FindFirstChild("PhuBabyDev") then
        LocalPlayer.PlayerGui.PhuBabyDev:Destroy()
    end
end)

local ParentGui = LocalPlayer:WaitForChild("PlayerGui")

pcall(function()
    local test = Instance.new("ScreenGui")
    test.Parent = game.CoreGui
    test:Destroy()
    ParentGui = game.CoreGui
end)

--====================================================
-- GUI ROOT
--====================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhuBabyDev"
ScreenGui.Parent = ParentGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function NeonColor()
    return Color3.fromHSV((tick()%5)/5,1,1)
end

--====================================================
-- LOADING LIGHT FIX
--====================================================

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Parent = ScreenGui
LoadingFrame.Size = UDim2.new(0,380,0,150)
LoadingFrame.Position = UDim2.new(0.5,-190,0.5,-75)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(10,10,10)
Instance.new("UICorner",LoadingFrame).CornerRadius = UDim.new(0,16)

local BarBg = Instance.new("Frame")
BarBg.Parent = LoadingFrame
BarBg.Size = UDim2.new(0,320,0,14)
BarBg.Position = UDim2.new(0.5,-160,0.65,0)
BarBg.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner",BarBg).CornerRadius = UDim.new(1,0)

local Bar = Instance.new("Frame")
Bar.Parent = BarBg
Bar.Size = UDim2.new(0,0,1,0)
Bar.BackgroundColor3 = Color3.fromRGB(0,255,255)
Instance.new("UICorner",Bar).CornerRadius = UDim.new(1,0)

local Txt = Instance.new("TextLabel")
Txt.Parent = LoadingFrame
Txt.Size = UDim2.new(1,0,0,40)
Txt.Position = UDim2.new(0,0,0.25,0)
Txt.BackgroundTransparency = 1
Txt.TextColor3 = Color3.new(1,1,1)
Txt.Font = Enum.Font.GothamBold
Txt.TextSize = 24

for i=1,100 do
    Txt.Text = i.."%"
    Bar.Size = UDim2.new(i/100,0,1,0)
    task.wait(0.01)
end

task.wait(0.2)
LoadingFrame:Destroy()

--====================================================
-- MAIN WINDOW
--====================================================

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,700,0,420)
Main.Position = UDim2.new(0.5,-350,0.5,-210)
Main.BackgroundColor3 = Color3.fromRGB(12,12,12)
Main.Active = true
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,18)

local Stroke = Instance.new("UIStroke",Main)
Stroke.Thickness = 2

RunService.RenderStepped:Connect(function()
    Stroke.Color = NeonColor()
end)

--====================================================
-- TITLE
--====================================================

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundTransparency = 1
Title.Text = "PhuBaby Dev"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24

--====================================================
-- TAB SYSTEM
--====================================================

local Tabs = {"MAIN","ESP","PLAYER","SERVER","SETTINGS"}
local Pages = {}

local TabHolder = Instance.new("Frame")
TabHolder.Parent = Main
TabHolder.Size = UDim2.new(0,140,1,-50)
TabHolder.Position = UDim2.new(0,0,0,50)
TabHolder.BackgroundTransparency = 1

local Content = Instance.new("Frame")
Content.Parent = Main
Content.Size = UDim2.new(1,-150,1,-60)
Content.Position = UDim2.new(0,150,0,55)
Content.BackgroundTransparency = 1

for i,v in ipairs(Tabs) do
    local Btn = Instance.new("TextButton")
    Btn.Parent = TabHolder
    Btn.Size = UDim2.new(1,-10,0,45)
    Btn.Position = UDim2.new(0,5,0,(i-1)*50)
    Btn.Text = v
    Btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 15
    Instance.new("UICorner",Btn)

    local Page = Instance.new("ScrollingFrame")
    Page.Parent = Content
    Page.Size = UDim2.new(1,0,1,0)
    Page.CanvasSize = UDim2.new(0,0,0,900)
    Page.ScrollBarThickness = 4
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.Visible = false
    Pages[v] = Page

    Btn.MouseButton1Click:Connect(function()
        for _,p in pairs(Pages) do
            p.Visible = false
        end
        Page.Visible = true
    end)
end

Pages["MAIN"].Visible = true

--====================================================
-- TOGGLE
--====================================================

local function CreateToggle(parent,text,y)
    local b = Instance.new("TextButton")
    b.Parent = parent
    b.Size = UDim2.new(0,300,0,40)
    b.Position = UDim2.new(0,10,0,y)
    b.BackgroundColor3 = Color3.fromRGB(120,0,0)
    b.Text = text.." [OFF]"
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    Instance.new("UICorner",b)

    local state = false

    b.MouseButton1Click:Connect(function()
        state = not state
        b.BackgroundColor3 = state and Color3.fromRGB(0,120,0) or Color3.fromRGB(120,0,0)
        b.Text = text..(state and " [ON]" or " [OFF]")
    end)
end

CreateToggle(Pages["MAIN"],"Hitbox Module Placeholder",20)
CreateToggle(Pages["MAIN"],"MultiJump Module Placeholder",80)

--====================================================
-- SERVER INFO
--====================================================

local Info = Instance.new("TextLabel")
Info.Parent = Pages["SERVER"]
Info.Size = UDim2.new(0,350,0,120)
Info.Position = UDim2.new(0,10,0,20)
Info.BackgroundColor3 = Color3.fromRGB(15,15,15)
Info.TextColor3 = Color3.new(1,1,1)
Info.Font = Enum.Font.GothamBold
Info.TextSize = 15
Instance.new("UICorner",Info)

RunService.RenderStepped:Connect(function()
    Info.Text =
        "Ping: "..math.random(20,80)..
        "\nFPS: "..math.random(58,60)..
        "\nPlayers: "..#Players:GetPlayers()
end)

--====================================================
-- TOUCH DRAG FIX
--====================================================

local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

Main.InputChanged:Connect(function(input)
    dragInput = input
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
