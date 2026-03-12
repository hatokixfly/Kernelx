--// Kernel GUI
--// By: Kernelx

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer

-- notification
local function notify(t)
pcall(function()
StarterGui:SetCore("SendNotification",{
Title="Kernel",
Text=t,
Duration=3
})
end)
end

notify("Kernel Loaded")

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

--================================================
-- MENU
--================================================

local Menu = Instance.new("Frame")
Menu.Parent = ScreenGui
Menu.Size = UDim2.new(0,520,0,300)
Menu.Position = UDim2.new(0.5,-260,0.5,-150)
Menu.BackgroundColor3 = Color3.fromRGB(10,10,10)

Instance.new("UICorner",Menu)

local Stroke = Instance.new("UIStroke")
Stroke.Parent = Menu
Stroke.Color = Color3.fromRGB(255,0,0)

--================================================
-- DRAG
--================================================

local dragging=false
local dragStart
local startPos

Menu.InputBegan:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = Menu.Position
end

end)

Menu.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging=false
end
end)

UIS.InputChanged:Connect(function(input)

if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then

local delta=input.Position-dragStart

Menu.Position=UDim2.new(
startPos.X.Scale,
startPos.X.Offset+delta.X,
startPos.Y.Scale,
startPos.Y.Offset+delta.Y
)

end

end)

--================================================
-- TAB PANEL
--================================================

local TabPanel = Instance.new("Frame")
TabPanel.Parent = Menu
TabPanel.Size = UDim2.new(0,120,1,0)
TabPanel.BackgroundColor3 = Color3.fromRGB(15,15,15)

local MainTab = Instance.new("TextButton")
MainTab.Parent = TabPanel
MainTab.Size = UDim2.new(1,0,0,50)
MainTab.Text="MAIN"
MainTab.BackgroundColor3 = Color3.fromRGB(255,0,0)
MainTab.TextColor3 = Color3.new(1,1,1)

local InfoTab = Instance.new("TextButton")
InfoTab.Parent = TabPanel
InfoTab.Position = UDim2.new(0,0,0,50)
InfoTab.Size = UDim2.new(1,0,0,50)
InfoTab.Text="INFO"
InfoTab.BackgroundColor3 = Color3.fromRGB(20,20,20)
InfoTab.TextColor3 = Color3.new(1,1,1)

--================================================
-- PAGES
--================================================

local MainPage = Instance.new("Frame")
MainPage.Parent = Menu
MainPage.Position = UDim2.new(0,130,0,10)
MainPage.Size = UDim2.new(1,-140,1,-20)
MainPage.BackgroundTransparency = 1

local InfoPage = Instance.new("Frame")
InfoPage.Parent = Menu
InfoPage.Position = MainPage.Position
InfoPage.Size = MainPage.Size
InfoPage.Visible = false
InfoPage.BackgroundTransparency = 1

-- tab switch
MainTab.MouseButton1Click:Connect(function()

MainPage.Visible=true
InfoPage.Visible=false

MainTab.BackgroundColor3=Color3.fromRGB(255,0,0)
InfoTab.BackgroundColor3=Color3.fromRGB(20,20,20)

end)

InfoTab.MouseButton1Click:Connect(function()

MainPage.Visible=false
InfoPage.Visible=true

InfoTab.BackgroundColor3=Color3.fromRGB(255,0,0)
MainTab.BackgroundColor3=Color3.fromRGB(20,20,20)

end)

--================================================
-- VARIABLES
--================================================

local Invisible=false
local GodMode=false
local Speed=16

--================================================
-- CHARACTER LOOP
--================================================

RunService.RenderStepped:Connect(function()

local char=Player.Character
if not char then return end

local hum=char:FindFirstChildOfClass("Humanoid")
if not hum then return end

-- godmode
if GodMode then
hum.Health = hum.MaxHealth
end

-- speed
hum.WalkSpeed = Speed

-- invisible
if Invisible then
for _,v in pairs(char:GetDescendants()) do
if v:IsA("BasePart") then
v.Transparency = 1
end
end
end

end)

--================================================
-- INVISIBLE
--================================================

local InvBtn = Instance.new("TextButton")
InvBtn.Parent = MainPage
InvBtn.Size = UDim2.new(0,220,0,40)
InvBtn.Text="INVISIBLE"
InvBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
InvBtn.TextColor3 = Color3.new(1,1,1)

InvBtn.MouseButton1Click:Connect(function()

Invisible = not Invisible

if not Invisible then
local char=Player.Character
if char then
for _,v in pairs(char:GetDescendants()) do
if v:IsA("BasePart") then
v.Transparency = 0
end
end
end
end

notify(Invisible and "INVISIBLE ON" or "INVISIBLE OFF")

end)

--================================================
-- GOD MODE
--================================================

local GodBtn = Instance.new("TextButton")
GodBtn.Parent = MainPage
GodBtn.Position = UDim2.new(0,0,0,50)
GodBtn.Size = UDim2.new(0,220,0,40)
GodBtn.Text="GOD MODE"
GodBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
GodBtn.TextColor3 = Color3.new(1,1,1)

GodBtn.MouseButton1Click:Connect(function()

GodMode = not GodMode

notify(GodMode and "GODMODE ON" or "GODMODE OFF")

end)

--================================================
-- SPEED SLIDER
--================================================

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = MainPage
SpeedLabel.Position = UDim2.new(0,0,0,110)
SpeedLabel.Size = UDim2.new(0,220,0,30)
SpeedLabel.Text="SPEED: 16"
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = Color3.new(1,1,1)

local Slider = Instance.new("Frame")
Slider.Parent = MainPage
Slider.Position = UDim2.new(0,0,0,140)
Slider.Size = UDim2.new(0,220,0,8)
Slider.BackgroundColor3 = Color3.fromRGB(30,30,30)

local Bar = Instance.new("Frame")
Bar.Parent = Slider
Bar.Size = UDim2.new(0,0,1,0)
Bar.BackgroundColor3 = Color3.fromRGB(255,0,0)

local dragging=false

Slider.InputBegan:Connect(function(input)

if input.UserInputType==Enum.UserInputType.MouseButton1 then
dragging=true
end

end)

UIS.InputEnded:Connect(function(input)

if input.UserInputType==Enum.UserInputType.MouseButton1 then
dragging=false
end

end)

UIS.InputChanged:Connect(function(input)

if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then

local pos = math.clamp(
(input.Position.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X,
0,1
)

Bar.Size = UDim2.new(pos,0,1,0)

Speed = math.floor(1 + (199*pos))

SpeedLabel.Text="SPEED: "..Speed

end

end)

--================================================
-- INFO PAGE
--================================================

local IG = Instance.new("TextButton")
IG.Parent = InfoPage
IG.Size = UDim2.new(0,260,0,50)
IG.Text="IG: fu._xinmo"
IG.BackgroundColor3 = Color3.fromRGB(20,20,20)
IG.TextColor3 = Color3.new(1,1,1)

IG.MouseButton1Click:Connect(function()

setclipboard("https://instagram.com/fu._xinmo")
notify("Copied Instagram")

end)

local TT = Instance.new("TextButton")
TT.Parent = InfoPage
TT.Position = UDim2.new(0,0,0,60)
TT.Size = UDim2.new(0,260,0,50)
TT.Text="TikTok: hatokireal"
TT.BackgroundColor3 = Color3.fromRGB(20,20,20)
TT.TextColor3 = Color3.new(1,1,1)

TT.MouseButton1Click:Connect(function()

setclipboard
