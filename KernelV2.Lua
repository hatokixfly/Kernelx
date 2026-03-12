-- KernelX HaToKi UI
-- Script By: KernelX

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Notification Function
local function Notify(msg)
game.StarterGui:SetCore("SendNotification",{
Title = "KernelX HaToKi",
Text = msg,
Duration = 3
})
end

Notify("Script By: KernelX")

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "KernelXUI"

-------------------------------------------------
-- LOGO BUTTON (OPEN MENU)
-------------------------------------------------

local OpenBtn = Instance.new("TextButton")
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0,50,0,50)
OpenBtn.Position = UDim2.new(0,20,0.5,0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
OpenBtn.Text = "K"
OpenBtn.TextColor3 = Color3.fromRGB(255,50,50)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 18

Instance.new("UICorner",OpenBtn).CornerRadius = UDim.new(1,0)

-------------------------------------------------
-- MAIN FRAME
-------------------------------------------------

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,600,0,360)
Main.Position = UDim2.new(0.5,-300,0.5,-180)
Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Main.BorderSizePixel = 0

Instance.new("UICorner",Main).CornerRadius = UDim.new(0,10)

OpenBtn.MouseButton1Click:Connect(function()
Main.Visible = not Main.Visible
end)

-------------------------------------------------
-- LEFT MENU
-------------------------------------------------

local Left = Instance.new("Frame")
Left.Parent = Main
Left.Size = UDim2.new(0,150,1,0)
Left.BackgroundColor3 = Color3.fromRGB(15,15,15)

Instance.new("UICorner",Left)

local Title = Instance.new("TextLabel")
Title.Parent = Left
Title.Text = "KernelX HaToKi"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextColor3 = Color3.fromRGB(255,50,50)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,0,0,40)

-------------------------------------------------
-- TAB CONTAINER
-------------------------------------------------

local TabContainer = Instance.new("Frame")
TabContainer.Parent = Main
TabContainer.Position = UDim2.new(0,150,0,0)
TabContainer.Size = UDim2.new(1,-150,1,0)
TabContainer.BackgroundTransparency = 1

local function CreateTab(name,pos)

local Button = Instance.new("TextButton")
Button.Parent = Left
Button.Text = name
Button.Size = UDim2.new(1,0,0,35)
Button.Position = UDim2.new(0,0,0,pos)
Button.BackgroundColor3 = Color3.fromRGB(20,20,20)
Button.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",Button)

local Page = Instance.new("Frame")
Page.Parent = TabContainer
Page.Size = UDim2.new(1,0,1,0)
Page.BackgroundTransparency = 1
Page.Visible = false

Button.MouseButton1Click:Connect(function()

for _,v in pairs(TabContainer:GetChildren()) do
if v:IsA("Frame") then
v.Visible = false
end
end

Page.Visible = true

end)

return Page
end

-------------------------------------------------
-- TABS
-------------------------------------------------

local MainTab = CreateTab("MAIN",50)
local PlayerTab = CreateTab("PLAYERS",90)
local AfkTab = CreateTab("AFK",130)
local InfoTab = CreateTab("INFO",170)

MainTab.Visible = true

-------------------------------------------------
-- TOGGLE SYSTEM
-------------------------------------------------

local function CreateToggle(parent,text,pos,callback)

local Frame = Instance.new("Frame",parent)
Frame.Size = UDim2.new(0,250,0,40)
Frame.Position = UDim2.new(0,20,0,pos)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)

Instance.new("UICorner",Frame)

local Label = Instance.new("TextLabel",Frame)
Label.Text = text
Label.BackgroundTransparency = 1
Label.Size = UDim2.new(0.7,0,1,0)
Label.Position = UDim2.new(0,10,0,0)
Label.TextColor3 = Color3.new(1,1,1)

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

Notify(text.." ON")

else
TweenService:Create(Toggle,TweenInfo.new(0.2),
{BackgroundColor3 = Color3.fromRGB(40,40,40)}):Play()

Notify(text.." OFF")

end

if callback then
callback(enabled)
end

end)

end

-------------------------------------------------
-- AFK FEATURES
-------------------------------------------------

CreateToggle(AfkTab,"ANTI AFK",20,function(v)

if v then
LocalPlayer.Idled:Connect(function()
VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
wait(1)
VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
end

end)

CreateToggle(AfkTab,"AUTO SPACE",80,function(v)

spawn(function()

while v do
local hum = Character:FindFirstChildOfClass("Humanoid")
if hum then
hum.Jump = true
end
wait(1)
end

end)

end)

CreateToggle(AfkTab,"AUTO SPIN CAMERA",140,function(v)

spawn(function()

while v do
workspace.CurrentCamera.CFrame =
workspace.CurrentCamera.CFrame * CFrame.Angles(0,math.rad(5),0)
wait()
end

end)

end)

-------------------------------------------------
-- PLAYER SELECT SYSTEM
-------------------------------------------------

local SelectedPlayer = nil

local PlayerList = Instance.new("ScrollingFrame",PlayerTab)
PlayerList.Size = UDim2.new(0,200,0,200)
PlayerList.Position = UDim2.new(0,20,0,20)
PlayerList.CanvasSize = UDim2.new(0,0,5,0)

local function RefreshPlayers()

PlayerList:ClearAllChildren()

local y = 0

for _,plr in pairs(Players:GetPlayers()) do

local Btn = Instance.new("TextButton")
Btn.Parent = PlayerList
Btn.Size = UDim2.new(1,0,0,30)
Btn.Position = UDim2.new(0,0,0,y)
Btn.Text = plr.Name
Btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
Btn.TextColor3 = Color3.new(1,1,1)

y = y + 35

Btn.MouseButton1Click:Connect(function()

SelectedPlayer = plr
Notify("Selected "..plr.Name)

end)

end

end

RefreshPlayers()

Players.PlayerAdded:Connect(RefreshPlayers)
Players.PlayerRemoving:Connect(RefreshPlayers)

-------------------------------------------------
-- TELEPORT TO PLAYER
-------------------------------------------------

local TeleBtn = Instance.new("TextButton",PlayerTab)
TeleBtn.Size = UDim2.new(0,200,0,40)
TeleBtn.Position = UDim2.new(0,250,0,20)
TeleBtn.Text = "TELEPORT PLAYER"
TeleBtn.BackgroundColor3 = Color3.fromRGB(255,50,50)
TeleBtn.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",TeleBtn)

TeleBtn.MouseButton1Click:Connect(function()

if SelectedPlayer and SelectedPlayer.Character then

LocalPlayer.Character.HumanoidRootPart.CFrame =
SelectedPlayer.Character.HumanoidRootPart.CFrame

Notify("Teleported to "..SelectedPlayer.Name)

end

end)

-------------------------------------------------
-- SAVE POSITION
-------------------------------------------------

local SavePos

local Save = Instance.new("TextButton",MainTab)
Save.Size = UDim2.new(0,200,0,40)
Save.Position = UDim2.new(0,20,0,20)
Save.Text="SAVE POSITION"
Save.BackgroundColor3 = Color3.fromRGB(255,50,50)

Instance.new("UICorner",Save)

Save.MouseButton1Click:Connect(function()

SavePos = LocalPlayer.Character.HumanoidRootPart.CFrame
Notify("Position Saved")

end)

local Tele = Save:Clone()
Tele.Parent = MainTab
Tele.Position = UDim2.new(0,20,0,70)
Tele.Text="TELEPORT SAVE"

Tele.MouseButton1Click:Connect(function()

if SavePos then
LocalPlayer.Character.HumanoidRootPart.CFrame = SavePos
Notify("Teleported")
end

end)

-------------------------------------------------
-- INFO TAB
-------------------------------------------------

local function CreateInfo(text,link,pos)

local Box = Instance.new("TextButton",InfoTab)
Box.Size = UDim2.new(0,300,0,40)
Box.Position = UDim2.new(0,20,0,pos)
Box.Text = text
Box.BackgroundColor3 = Color3.fromRGB(20,20,20)

Instance.new("UICorner",Box)

Box.MouseButton1Click:Connect(function()
setclipboard(link)
Notify("Copied "..text)
end)

end

CreateInfo("Facebook","fb.com/htknew.cityy",20)
CreateInfo("Discord","https://discord.gg/tV5RhPgsz",70)
CreateInfo("TikTok","tiktok.com/@hatokireal",120)
CreateInfo("Instagram","instagram.com/@fu._xinmo",170)

-------------------------------------------------
-- DRAG GUI
-------------------------------------------------

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
