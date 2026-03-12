--// Kernel GUI
--// By: Kernelx

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer

-- notification
local function notify(text)
pcall(function()
StarterGui:SetCore("SendNotification",{
Title = "Kernel",
Text = text,
Duration = 3
})
end)
end

notify("By: Kernelx")

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

Instance.new("UICorner",Menu).CornerRadius = UDim.new(0,8)

local stroke = Instance.new("UIStroke",Menu)
stroke.Color = Color3.fromRGB(255,0,0)

--================================================
-- DRAG SYSTEM
--================================================

local dragToggle=nil
local dragInput=nil
local dragStart=nil
local startPos=nil

Menu.InputBegan:Connect(function(input)

if input.UserInputType==Enum.UserInputType.MouseButton1 then

dragToggle=true
dragStart=input.Position
startPos=Menu.Position

input.Changed:Connect(function()
if input.UserInputState==Enum.UserInputState.End then
dragToggle=false
end
end)

end

end)

Menu.InputChanged:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseMovement then
dragInput=input
end
end)

UIS.InputChanged:Connect(function(input)

if input==dragInput and dragToggle then

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
MainTab.Text = "MAIN"
MainTab.BackgroundColor3 = Color3.fromRGB(255,0,0)
MainTab.TextColor3 = Color3.new(1,1,1)
MainTab.Font = Enum.Font.GothamBold

local InfoTab = Instance.new("TextButton")
InfoTab.Parent = TabPanel
InfoTab.Position = UDim2.new(0,0,0,50)
InfoTab.Size = UDim2.new(1,0,0,50)
InfoTab.Text = "INFO"
InfoTab.BackgroundColor3 = Color3.fromRGB(20,20,20)
InfoTab.TextColor3 = Color3.new(1,1,1)
InfoTab.Font = Enum.Font.GothamBold

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

--================================================
-- TAB SWITCH
--================================================

MainTab.MouseButton1Click:Connect(function()

MainPage.Visible=true
InfoPage.Visible=false

MainTab.BackgroundColor3 = Color3.fromRGB(255,0,0)
InfoTab.BackgroundColor3 = Color3.fromRGB(20,20,20)

end)

InfoTab.MouseButton1Click:Connect(function()

MainPage.Visible=false
InfoPage.Visible=true

InfoTab.BackgroundColor3 = Color3.fromRGB(255,0,0)
MainTab.BackgroundColor3 = Color3.fromRGB(20,20,20)

end)

--================================================
-- INVISIBLE
--================================================

local inv=false

local InvBtn = Instance.new("TextButton")
InvBtn.Parent = MainPage
InvBtn.Size = UDim2.new(0,220,0,40)
InvBtn.Text="TÀN HÌNH"
InvBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
InvBtn.TextColor3 = Color3.new(1,1,1)

InvBtn.MouseButton1Click:Connect(function()

local char = Player.Character
if not char then return end

inv = not inv

for _,v in pairs(char:GetDescendants()) do
if v:IsA("BasePart") then
v.Transparency = inv and 1 or 0
end
end

notify(inv and "INVISIBLE ON" or "INVISIBLE OFF")

end)

--================================================
-- GOD MODE
--================================================

local god=false

local GodBtn = Instance.new("TextButton")
GodBtn.Parent = MainPage
GodBtn.Position = UDim2.new(0,0,0,50)
GodBtn.Size = UDim2.new(0,220,0,40)
GodBtn.Text="BẤT TỬ"
GodBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
GodBtn.TextColor3 = Color3.new(1,1,1)

GodBtn.MouseButton1Click:Connect(function()

local char = Player.Character
if not char then return end

god = not god

if god then
char:FindFirstChildOfClass("Humanoid").Health = math.huge
end

notify(god and "GODMODE ON" or "GODMODE OFF")

end)

--================================================
-- SPEED RANDOM
--================================================

local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Parent = MainPage
SpeedBtn.Position = UDim2.new(0,0,0,110)
SpeedBtn.Size = UDim2.new(0,220,0,40)
SpeedBtn.Text="SPEED RANDOM"
SpeedBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
SpeedBtn.TextColor3 = Color3.new(1,1,1)

SpeedBtn.MouseButton1Click:Connect(function()

local char = Player.Character
if not char then return end

local speed = math.random(1,999999)

char:FindFirstChildOfClass("Humanoid").WalkSpeed = speed

notify("SPEED: "..speed)

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

setclipboard("https://tiktok.com/@hatokireal")

notify("Copied TikTok")

end)
