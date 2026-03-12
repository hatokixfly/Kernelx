-- KernelX HaToKi UI
-- Script By: KernelX

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Notification
game.StarterGui:SetCore("SendNotification",{
Title = "KernelX HaToKi",
Text = "Script By: KernelX",
Duration = 5
})

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "KernelXUI"

-- MAIN FRAME
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,600,0,360)
Main.Position = UDim2.new(0.5,-300,0.5,-180)
Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Main.BorderSizePixel = 0

local Corner = Instance.new("UICorner",Main)
Corner.CornerRadius = UDim.new(0,10)

-- LEFT MENU
local Left = Instance.new("Frame")
Left.Parent = Main
Left.Size = UDim2.new(0,150,1,0)
Left.BackgroundColor3 = Color3.fromRGB(15,15,15)
Left.BorderSizePixel = 0

Instance.new("UICorner",Left)

-- TITLE
local Title = Instance.new("TextLabel")
Title.Parent = Left
Title.Text = "KernelX HaToKi"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextColor3 = Color3.fromRGB(255,50,50)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,0,0,40)

-- TAB CONTAINER
local TabContainer = Instance.new("Frame")
TabContainer.Parent = Main
TabContainer.Position = UDim2.new(0,150,0,0)
TabContainer.Size = UDim2.new(1,-150,1,0)
TabContainer.BackgroundTransparency = 1

-- TAB FUNCTION
local function CreateTab(name,pos)

local Button = Instance.new("TextButton")
Button.Parent = Left
Button.Text = name
Button.Font = Enum.Font.Gotham
Button.TextSize = 14
Button.Size = UDim2.new(1,0,0,35)
Button.Position = UDim2.new(0,0,0,pos)
Button.BackgroundColor3 = Color3.fromRGB(20,20,20)
Button.TextColor3 = Color3.new(1,1,1)

local Corner = Instance.new("UICorner",Button)

local Page = Instance.new("Frame")
Page.Parent = TabContainer
Page.Size = UDim2.new(1,0,1,0)
Page.BackgroundTransparency = 1
Page.Visible = false

Button.MouseButton1Click:Connect(function()

for _,v in pairs(TabContainer:GetChildren()) do
if v:IsA("Frame") then
v.Visible=false
end
end

Page.Visible=true

end)

return Page

end

-- TABS
local MainTab = CreateTab("MAIN",50)
local EspTab = CreateTab("ESP",90)
local SpinTab = CreateTab("SPIN",130)
local TeleTab = CreateTab("TELEPORT",170)
local AfkTab = CreateTab("AFK",210)
local InfoTab = CreateTab("INFO",250)

MainTab.Visible=true

-- TOGGLE CREATOR
local function CreateToggle(parent,text,pos)

local Frame = Instance.new("Frame",parent)
Frame.Size = UDim2.new(0,250,0,40)
Frame.Position = UDim2.new(0,20,0,pos)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)

Instance.new("UICorner",Frame)

local Label = Instance.new("TextLabel",Frame)
Label.Text = text
Label.Font = Enum.Font.Gotham
Label.TextSize = 14
Label.TextColor3 = Color3.new(1,1,1)
Label.BackgroundTransparency = 1
Label.Position = UDim2.new(0,10,0,0)
Label.Size = UDim2.new(0.7,0,1,0)

local Toggle = Instance.new("TextButton",Frame)
Toggle.Size = UDim2.new(0,40,0,20)
Toggle.Position = UDim2.new(1,-50,0.5,-10)
Toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
Toggle.Text=""

Instance.new("UICorner",Toggle)

local enabled=false

Toggle.MouseButton1Click:Connect(function()

enabled = not enabled

if enabled then
TweenService:Create(Toggle,TweenInfo.new(0.2),
{BackgroundColor3 = Color3.fromRGB(255,50,50)}):Play()
else
TweenService:Create(Toggle,TweenInfo.new(0.2),
{BackgroundColor3 = Color3.fromRGB(40,40,40)}):Play()
end

end)

end

-- ESP TAB
CreateToggle(EspTab,"ESP BOX",20)
CreateToggle(EspTab,"ESP LINE",70)

-- AFK TAB
CreateToggle(AfkTab,"ANTI AFK",20)
CreateToggle(AfkTab,"AUTO SPIN CAMERA",70)
CreateToggle(AfkTab,"AUTO SPACE",120)

-- MAIN TAB BUTTONS

local SavePos

local Save = Instance.new("TextButton",MainTab)
Save.Size = UDim2.new(0,200,0,40)
Save.Position = UDim2.new(0,20,0,20)
Save.Text="SAVE POSITION"
Save.BackgroundColor3 = Color3.fromRGB(255,50,50)
Save.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",Save)

Save.MouseButton1Click:Connect(function()
SavePos = LocalPlayer.Character.HumanoidRootPart.CFrame
end)

local Tele = Save:Clone()
Tele.Parent = MainTab
Tele.Position = UDim2.new(0,20,0,70)
Tele.Text="TELEPORT TO SAVE"

Tele.MouseButton1Click:Connect(function()

if SavePos then
LocalPlayer.Character.HumanoidRootPart.CFrame = SavePos
end

end)

-- INFO BOX

local function CreateInfo(text,link,pos)

local Box = Instance.new("TextButton",InfoTab)
Box.Size = UDim2.new(0,300,0,40)
Box.Position = UDim2.new(0,20,0,pos)
Box.Text = text
Box.BackgroundColor3 = Color3.fromRGB(20,20,20)
Box.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",Box)

Box.MouseButton1Click:Connect(function()
setclipboard(link)
end)

end

CreateInfo("Facebook","fb.com/htknew.cityy",20)
CreateInfo("Discord","https://discord.gg/tV5RhPgsz",70)
CreateInfo("TikTok","tiktok.com/@hatokireal",120)
CreateInfo("Instagram","instagram.com/@fu._xinmo",170)

-- DRAG GUI

local UIS = game:GetService("UserInputService")

local dragging
local dragInput
local dragStart
local startPos

Main.InputBegan:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = Main.Position

input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)

end

end)

Main.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement then
dragInput = input
end
end)

UIS.InputChanged:Connect(function(input)

if input == dragInput and dragging then

local delta = input.Position - dragStart

Main.Position = UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)

end

end)
