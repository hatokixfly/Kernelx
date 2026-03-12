--// Notification
game.StarterGui:SetCore("SendNotification",{
Title = "KernelX",
Text = "Script By KernelX",
Duration = 5
})

--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--// FOV
getgenv().FOV = 120

local circle = Drawing.new("Circle")
circle.Visible = true
circle.Radius = getgenv().FOV
circle.Color = Color3.fromRGB(255,0,0)
circle.Thickness = 2
circle.Filled = false

RunService.RenderStepped:Connect(function()
circle.Position = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
circle.Radius = getgenv().FOV
end)

--// GUI
local gui = Instance.new("ScreenGui",game.CoreGui)
gui.ResetOnSpawn = false

local frame = Instance.new("Frame",gui)
frame.Size = UDim2.new(0,260,0,180)
frame.Position = UDim2.new(0,20,0.5,-90)
frame.BackgroundColor3 = Color3.fromRGB(0,0,0)

local title = Instance.new("TextLabel",frame)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "KernelX"
title.TextColor3 = Color3.fromRGB(255,0,0)
title.TextScaled = true

--// Drag
frame.Active = true
frame.Draggable = true

--// ESP BUTTON
local esp = Instance.new("TextButton",frame)
esp.Size = UDim2.new(0,200,0,35)
esp.Position = UDim2.new(0,30,0,50)
esp.Text = "ESP OUTLINE"
esp.BackgroundColor3 = Color3.fromRGB(20,20,20)
esp.TextColor3 = Color3.fromRGB(255,0,0)

--// FOV SLIDER
local slider = Instance.new("TextButton",frame)
slider.Size = UDim2.new(0,200,0,35)
slider.Position = UDim2.new(0,30,0,95)
slider.Text = "FOV +"
slider.BackgroundColor3 = Color3.fromRGB(20,20,20)
slider.TextColor3 = Color3.fromRGB(255,0,0)

--// AIM LOCK
local aim = Instance.new("TextButton",frame)
aim.Size = UDim2.new(0,200,0,35)
aim.Position = UDim2.new(0,30,0,140)
aim.Text = "AIM LOCK"
aim.BackgroundColor3 = Color3.fromRGB(20,20,20)
aim.TextColor3 = Color3.fromRGB(255,0,0)

--// ESP SYSTEM
local espEnabled = false
local highlights = {}

local function addESP(player)

if player == LP then return end

local function char(c)

if highlights[player] then
highlights[player]:Destroy()
end

local h = Instance.new("Highlight")
h.FillTransparency = 1
h.OutlineColor = Color3.fromRGB(255,0,0)
h.OutlineTransparency = 0
h.Parent = c

highlights[player] = h

end

if player.Character then
char(player.Character)
end

player.CharacterAdded:Connect(char)

end

for _,p in pairs(Players:GetPlayers()) do
addESP(p)
end

Players.PlayerAdded:Connect(addESP)

esp.MouseButton1Click:Connect(function()

espEnabled = not espEnabled

for _,v in pairs(highlights) do
v.Enabled = espEnabled
end

end)

--// FOV CHANGE
slider.MouseButton1Click:Connect(function()

getgenv().FOV = getgenv().FOV + 20

if getgenv().FOV > 300 then
getgenv().FOV = 80
end

slider.Text = "FOV "..getgenv().FOV

end)

--// AIM SYSTEM
local aimEnabled = false

local function getClosest()

local closest
local dist = getgenv().FOV

for _,v in pairs(Players:GetPlayers()) do

if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then

local pos,vis = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)

if vis then

local mag = (Vector2.new(pos.X,pos.Y) -
Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)).Magnitude

if mag < dist then
dist = mag
closest = v
end

end

end
end

return closest
end

RunService.RenderStepped:Connect(function()

if aimEnabled then

local target = getClosest()

if target and target.Character then

Camera.CFrame = CFrame.new(
Camera.CFrame.Position,
target.Character.HumanoidRootPart.Position
)

end

end

end)

aim.MouseButton1Click:Connect(function()
aimEnabled = not aimEnabled
end)
