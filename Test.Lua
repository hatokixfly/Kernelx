-- KernelX HaToKi
-- Script By: KernelX

if game.CoreGui:FindFirstChild("KernelX_HaToKi") then
game.CoreGui.KernelX_HaToKi:Destroy()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local VIM = game:GetService("VirtualInputManager")

local savedPosition = nil
local ESPBoxEnabled = false
local ESPLineEnabled = false
local AutoJump = false
local SpinCam = false
local AntiAFK = false

-------------------------------------------------
-- GUI
-------------------------------------------------

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KernelX_HaToKi"
ScreenGui.Parent = game.CoreGui

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,600,0,380)
Main.Position = UDim2.new(0.5,-300,0.5,-190)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.BorderSizePixel = 0

local Corner = Instance.new("UICorner",Main)
Corner.CornerRadius = UDim.new(0,10)

-------------------------------------------------
-- TITLE
-------------------------------------------------

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "KernelX HaToKi"
Title.TextColor3 = Color3.fromRGB(255,80,0)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold

-------------------------------------------------
-- TABS
-------------------------------------------------

local Tabs = {"HOME","ESP","PLAYER","SPIN","TELEPORT","INFO"}

local TabButtons = Instance.new("Frame")
TabButtons.Parent = Main
TabButtons.Position = UDim2.new(0,0,0,40)
TabButtons.Size = UDim2.new(1,0,0,35)
TabButtons.BackgroundTransparency = 1

local Pages = Instance.new("Frame")
Pages.Parent = Main
Pages.Position = UDim2.new(0,0,0,75)
Pages.Size = UDim2.new(1,0,1,-75)
Pages.BackgroundTransparency = 1

local PageList = {}

local function createPage(name)
local Page = Instance.new("Frame")
Page.Parent = Pages
Page.Size = UDim2.new(1,0,1,0)
Page.BackgroundTransparency = 1
Page.Visible = false
PageList[name] = Page
return Page
end

for i,v in pairs(Tabs) do

local Btn = Instance.new("TextButton")
Btn.Parent = TabButtons
Btn.Size = UDim2.new(0,100,1,0)
Btn.Position = UDim2.new(0,(i-1)*100,0,0)
Btn.Text = v
Btn.Font = Enum.Font.Gotham
Btn.TextSize = 14
Btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
Btn.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",Btn)

local Page = createPage(v)

Btn.MouseButton1Click:Connect(function()

for _,p in pairs(PageList) do
p.Visible = false
end

Page.Visible = true

end)

end

PageList["HOME"].Visible = true

-------------------------------------------------
-- NOTIFICATION
-------------------------------------------------

local function notify(txt)

game.StarterGui:SetCore("SendNotification",{
Title="KernelX",
Text=txt,
Duration=3
})

end

-------------------------------------------------
-- BUTTON / TOGGLE
-------------------------------------------------

local function createButton(parent,text,callback)

local B = Instance.new("TextButton")
B.Parent = parent
B.Size = UDim2.new(0,200,0,35)
B.BackgroundColor3 = Color3.fromRGB(45,45,45)
B.Text = text
B.TextColor3 = Color3.new(1,1,1)
B.Font = Enum.Font.Gotham

Instance.new("UICorner",B)

B.MouseButton1Click:Connect(callback)

return B
end

local function createToggle(parent,text,callback)

local Toggle = false

local B = createButton(parent,text.." : OFF",function()

Toggle = not Toggle

if Toggle then
B.Text = text.." : ON"
else
B.Text = text.." : OFF
end

callback(Toggle)

end)

return B

end

-------------------------------------------------
-- HOME TAB
-------------------------------------------------

local Home = PageList["HOME"]

local Info = Instance.new("TextLabel")
Info.Parent = Home
Info.Size = UDim2.new(1,0,0,60)
Info.Text = "KernelX HaToKi\nExploit GUI System"
Info.BackgroundTransparency = 1
Info.TextColor3 = Color3.new(1,1,1)
Info.Font = Enum.Font.GothamBold
Info.TextSize = 18

-------------------------------------------------
-- ESP TAB
-------------------------------------------------

local ESP = PageList["ESP"]

createToggle(ESP,"ESP BOX",function(v)

ESPBoxEnabled = v
notify("ESP Box "..(v and "Enabled" or "Disabled"))

end).Position = UDim2.new(0,20,0,20)

createToggle(ESP,"ESP LINE",function(v)

ESPLineEnabled = v
notify("ESP Line "..(v and "Enabled" or "Disabled"))

end).Position = UDim2.new(0,20,0,70)

-------------------------------------------------
-- PLAYER TAB
-------------------------------------------------

local PlayerTab = PageList["PLAYER"]

createButton(PlayerTab,"SAVE POSITION",function()

savedPosition = LocalPlayer.Character.HumanoidRootPart.CFrame
notify("Position Saved")

end).Position = UDim2.new(0,20,0,20)

createButton(PlayerTab,"TELEPORT SAVED",function()

if savedPosition then
LocalPlayer.Character.HumanoidRootPart.CFrame = savedPosition
notify("Teleported")
end

end).Position = UDim2.new(0,20,0,70)

createToggle(PlayerTab,"ANTI AFK",function(v)

AntiAFK = v

if v then

LocalPlayer.Idled:Connect(function()
VIM:SendKeyEvent(true,"W",false,game)
end)

end

end).Position = UDim2.new(0,20,0,120)

createToggle(PlayerTab,"AUTO SPACE",function(v)

AutoJump = v

end).Position = UDim2.new(0,20,0,170)

createToggle(PlayerTab,"AUTO SPIN CAMERA",function(v)

SpinCam = v

end).Position = UDim2.new(0,20,0,220)

-------------------------------------------------
-- TELEPORT TAB
-------------------------------------------------

local Teleport = PageList["TELEPORT"]

createButton(Teleport,"TELEPORT BASE",function()

local hrp = LocalPlayer.Character.HumanoidRootPart
hrp.CFrame = hrp.CFrame - Vector3.new(0,1000,0)

notify("Teleporting...")

end).Position = UDim2.new(0,20,0,20)

-------------------------------------------------
-- INFO TAB
-------------------------------------------------

local InfoTab = PageList["INFO"]

local function copyButton(name,link,pos)

createButton(InfoTab,name,function()

setclipboard(link)
notify("Link Copied")

end).Position = pos

end

copyButton("FACEBOOK","fb.com/htknew.cityy",UDim2.new(0,20,0,20))
copyButton("DISCORD","https://discord.gg/tV5RhPgsz",UDim2.new(0,20,0,70))
copyButton("TIKTOK","tiktok.com/@hatokireal",UDim2.new(0,20,0,120))
copyButton("INSTAGRAM","instagram.com/@fu._xinmo",UDim2.new(0,20,0,170))

-------------------------------------------------
-- RUNTIME
-------------------------------------------------

RS.RenderStepped:Connect(function()

if AutoJump then
local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
if hum then
hum:ChangeState(Enum.HumanoidStateType.Jumping)
end
end

if SpinCam then
Camera.CFrame = Camera.CFrame * CFrame.Angles(0,math.rad(1),0)
end

end)

-------------------------------------------------
-- BASIC ESP
-------------------------------------------------

RS.RenderStepped:Connect(function()

for i,v in pairs(Players:GetPlayers()) do

if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then

local hrp = v.Character.HumanoidRootPart

if ESPBoxEnabled then

if not hrp:FindFirstChild("ESPBox") then

local box = Instance.new("BoxHandleAdornment")
box.Name="ESPBox"
box.Adornee = hrp
box.Size = Vector3.new(4,6,1)
box.Color3 = Color3.fromRGB(255,0,0)
box.AlwaysOnTop = true
box.Parent = hrp

end

end

end

end

end)
