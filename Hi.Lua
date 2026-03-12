--// KernelX HaToKi
--// Script By: KernelX

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

-- LOADING
game.StarterGui:SetCore("SendNotification",{
Title = "KernelX HaToKi",
Text = "Script By: KernelX",
Duration = 5
})

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,520,0,350)
Main.Position = UDim2.new(0.5,-260,0.5,-175)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Main.Visible = true

Instance.new("UICorner",Main).CornerRadius = UDim.new(0,12)

local Top = Instance.new("TextLabel")
Top.Parent = Main
Top.Size = UDim2.new(1,0,0,40)
Top.BackgroundColor3 = Color3.fromRGB(30,30,30)
Top.Text = "KernelX HaToKi"
Top.TextColor3 = Color3.fromRGB(255,120,0)
Top.Font = Enum.Font.GothamBold
Top.TextSize = 20

Instance.new("UICorner",Top)

-- FLOAT BUTTON
local Open = Instance.new("TextButton")
Open.Parent = ScreenGui
Open.Size = UDim2.new(0,40,0,40)
Open.Position = UDim2.new(0,10,0.5,0)
Open.Text = "≡"
Open.TextSize = 20
Open.BackgroundColor3 = Color3.fromRGB(0,0,0)
Open.TextColor3 = Color3.fromRGB(255,120,0)

Instance.new("UICorner",Open)

Open.MouseButton1Click:Connect(function()
Main.Visible = not Main.Visible
end)

-- TAB SYSTEM
local Tabs = Instance.new("Frame",Main)
Tabs.Size = UDim2.new(1,0,0,35)
Tabs.Position = UDim2.new(0,0,0,40)
Tabs.BackgroundTransparency = 1

local Pages = Instance.new("Frame",Main)
Pages.Size = UDim2.new(1,0,1,-75)
Pages.Position = UDim2.new(0,0,0,75)
Pages.BackgroundTransparency = 1

local function CreatePage(name)
local b = Instance.new("TextButton",Tabs)
b.Size = UDim2.new(0,80,1,0)
b.Text = name
b.BackgroundColor3 = Color3.fromRGB(35,35,35)
b.TextColor3 = Color3.fromRGB(255,255,255)
b.Font = Enum.Font.Gotham
b.TextSize = 14

Instance.new("UICorner",b)

local p = Instance.new("Frame",Pages)
p.Size = UDim2.new(1,0,1,0)
p.BackgroundTransparency = 1
p.Visible = false

b.MouseButton1Click:Connect(function()
for _,v in pairs(Pages:GetChildren()) do
v.Visible=false
end
p.Visible=true
end)

return p
end

local Home = CreatePage("HOME")
local Esp = CreatePage("ESP")
local PlayerTab = CreatePage("PLAYER")
local Spin = CreatePage("SPIN")
local Tele = CreatePage("TELEPORT")
local Info = CreatePage("INFO")

Home.Visible = true

-- ESP SYSTEM
local espEnabled=false
local lineEnabled=false
local boxes={}
local lines={}

local function createESP(plr)
if plr==Player then return end

local box = Drawing.new("Square")
box.Color = Color3.fromRGB(255,0,0)
box.Thickness = 2
box.Filled=false
box.Visible=false
boxes[plr]=box

local line = Drawing.new("Line")
line.Color = Color3.fromRGB(255,0,0)
line.Thickness=1
line.Visible=false
lines[plr]=line
end

for _,p in pairs(Players:GetPlayers()) do
createESP(p)
end

Players.PlayerAdded:Connect(createESP)

RunService.RenderStepped:Connect(function()

for plr,box in pairs(boxes) do

if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then

local pos,onscreen = workspace.CurrentCamera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)

if onscreen and espEnabled then

box.Size=Vector2.new(60,80)
box.Position=Vector2.new(pos.X-30,pos.Y-40)
box.Visible=true

else
box.Visible=false
end

if lineEnabled then
local line=lines[plr]
line.From=Vector2.new(workspace.CurrentCamera.ViewportSize.X/2,workspace.CurrentCamera.ViewportSize.Y)
line.To=Vector2.new(pos.X,pos.Y)
line.Visible=true
else
lines[plr].Visible=false
end

end

end

end)

-- BUTTON FUNCTION
local function MakeButton(parent,text,callback)

local b=Instance.new("TextButton",parent)
b.Size=UDim2.new(0,150,0,30)
b.BackgroundColor3=Color3.fromRGB(255,120,0)
b.Text=text
b.Font=Enum.Font.GothamBold
b.TextSize=14
b.TextColor3=Color3.new(1,1,1)

Instance.new("UICorner",b)

b.MouseButton1Click:Connect(callback)

return b
end

local function Notify(t)
game.StarterGui:SetCore("SendNotification",{
Title="KernelX",
Text=t,
Duration=3
})
end

-- ESP TAB
MakeButton(Esp,"ESP BOX",function()

espEnabled=not espEnabled
Notify("ESP "..tostring(espEnabled))

end)

MakeButton(Esp,"ESP LINE",function()

lineEnabled=not lineEnabled
Notify("ESP LINE "..tostring(lineEnabled))

end)

-- PLAYER TAB
local savedPos=nil

MakeButton(PlayerTab,"SAVE POSITION",function()

savedPos=Character.HumanoidRootPart.Position
Notify("Position Saved")

end)

MakeButton(PlayerTab,"TELEPORT SAVED",function()

if savedPos then
Character.HumanoidRootPart.CFrame=CFrame.new(savedPos)
Notify("Teleporting")
end

end)

-- ANTI AFK
MakeButton(PlayerTab,"ANTI AFK",function()

Player.Idled:Connect(function()

VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())

end)

Notify("Anti AFK Enabled")

end)

-- AUTO JUMP
local autoJump=false

MakeButton(PlayerTab,"AUTO SPACE",function()

autoJump=not autoJump

while autoJump do
task.wait(1)
Character.Humanoid:ChangeState("Jumping")
end

end)

-- SPIN CAMERA
local spinCam=false

MakeButton(PlayerTab,"AUTO SPIN CAMERA",function()

spinCam=not spinCam

while spinCam do
task.wait()
workspace.CurrentCamera.CFrame*=CFrame.Angles(0,0.05,0)
end

end)

-- TELEPORT BASE
MakeButton(Tele,"TELEPORT BASE",function()

Character.HumanoidRootPart.CFrame =
Character.HumanoidRootPart.CFrame - Vector3.new(0,1000,0)

Notify("Teleporting to Base")

end)

-- INFO TAB
local function Link(text,url)

MakeButton(Info,text,function()

setclipboard(url)
Notify("Link Copied")

end)

end

Link("FACEBOOK","fb.com/htknew.cityy")
Link("DISCORD","https://discord.gg/tV5RhPgsz")
Link("TIKTOK","https://tiktok.com/@hatokireal")
Link("INSTAGRAM","https://instagram.com/@fu._xinmo")

print("KernelX HaToKi Loaded")
