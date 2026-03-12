--// KernelX HaToKi HUB
--// Script By KernelX

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")

-- INTRO
game.StarterGui:SetCore("SendNotification",{
Title="KernelX HaToKi",
Text="Script By KernelX",
Duration=5
})

-- GUI
local gui = Instance.new("ScreenGui",game.CoreGui)
gui.Name="KernelX"

-- LOGO BUTTON
local logo = Instance.new("TextButton",gui)
logo.Size = UDim2.new(0,60,0,60)
logo.Position = UDim2.new(0,15,0.5,-30)
logo.Text = "K"
logo.BackgroundColor3 = Color3.fromRGB(255,150,0)
logo.TextColor3 = Color3.new(1,1,1)
logo.Font = Enum.Font.GothamBold
logo.TextSize = 26

-- MAIN WINDOW
local main = Instance.new("Frame",gui)
main.Size = UDim2.new(0,520,0,360)
main.Position = UDim2.new(0.3,0,0.2,0)
main.BackgroundColor3 = Color3.fromRGB(22,22,22)
main.Visible=false
main.Active=true
main.Draggable=true

-- ANIMATION
local function openMenu()
main.Visible=true
main.Size=UDim2.new(0,0,0,0)
TweenService:Create(main,TweenInfo.new(0.3),{
Size=UDim2.new(0,520,0,360)
}):Play()
end

logo.MouseButton1Click:Connect(openMenu)

-- TITLE
local title = Instance.new("TextLabel",main)
title.Size = UDim2.new(1,0,0,40)
title.Text="KernelX HaToKi"
title.BackgroundTransparency=1
title.TextColor3=Color3.fromRGB(255,170,0)
title.Font=Enum.Font.GothamBold
title.TextSize=22

-- CLOSE
local close = Instance.new("TextButton",main)
close.Size=UDim2.new(0,40,0,40)
close.Position=UDim2.new(1,-40,0,0)
close.Text="X"
close.BackgroundColor3=Color3.fromRGB(40,40,40)

close.MouseButton1Click:Connect(function()
main.Visible=false
end)

-- TOGGLE FUNCTION
local function createToggle(text,posY,callback)

local state=false

local btn = Instance.new("TextButton",main)
btn.Size=UDim2.new(0,200,0,35)
btn.Position=UDim2.new(0,20,0,posY)
btn.Text=text.." ❌"
btn.BackgroundColor3=Color3.fromRGB(35,35,35)

btn.MouseButton1Click:Connect(function()
state=not state
btn.Text=text..(state and " ✅" or " ❌")
callback(state)
end)

end

-- SAVE POSITION
local savedPos=nil

createToggle("SAVE POSITION",60,function(v)
if v then
savedPos=LocalPlayer.Character.HumanoidRootPart.Position
end
end)

-- TELEPORT SAVED
createToggle("TELEPORT SAVED",100,function(v)
if v and savedPos then
LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(savedPos)
end
end)

-- TELE BASE
createToggle("TELE BASE",140,function(v)
if v then
LocalPlayer.Character.HumanoidRootPart.CFrame=
LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,-1000,0)
end
end)

-- SPIN SCREEN
local spin=false

createToggle("SPIN SCREEN",180,function(v)
spin=v
while spin do
RunService.RenderStepped:Wait()
LocalPlayer.Character.HumanoidRootPart.CFrame=
LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.Angles(0,math.rad(5),0)
end
end)

-- AUTO JUMP
local jump=false

createToggle("AUTO JUMP",220,function(v)
jump=v
while jump do
task.wait(0.2)
LocalPlayer.Character.Humanoid.Jump=true
end
end)

-- ESP BOX
createToggle("ESP BOX",60,function(v)

if v then
for _,p in pairs(Players:GetPlayers()) do
if p~=LocalPlayer and p.Character then
local h=Instance.new("Highlight")
h.FillTransparency=1
h.OutlineColor=Color3.fromRGB(255,0,0)
h.Parent=p.Character
end
end
end

end)

-- ESP LINE
createToggle("ESP LINE",100,function(v)

if v then
for _,p in pairs(Players:GetPlayers()) do
if p~=LocalPlayer then
local beam=Instance.new("Beam")
beam.Parent=LocalPlayer.Character.Head
end
end
end

end)

-- ANTI AFK
LocalPlayer.Idled:Connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)

-- SPIN OPTIONS
local selectedSpin="Gold"

local spinLabel = Instance.new("TextLabel",main)
spinLabel.Text="Spin Type:"
spinLabel.Position=UDim2.new(0,260,0,60)
spinLabel.Size=UDim2.new(0,200,0,30)
spinLabel.BackgroundTransparency=1
spinLabel.TextColor3=Color3.new(1,1,1)

local function spinOption(name,y)

local b=Instance.new("TextButton",main)
b.Size=UDim2.new(0,200,0,30)
b.Position=UDim2.new(0,260,0,y)
b.Text=name
b.BackgroundColor3=Color3.fromRGB(35,35,35)

b.MouseButton1Click:Connect(function()
selectedSpin=name
spinLabel.Text="Spin Type: "..name
end)

end

spinOption("Lava",90)
spinOption("Gold",130)
spinOption("Diamond",170)
spinOption("Mythic",210)

-- AUTO SPIN
local autoSpin=false

createToggle("AUTO SPIN PET",260,function(v)
autoSpin=v

while autoSpin do
task.wait(1)
game:GetService("VirtualInputManager"):SendKeyEvent(true,"E",false,game)
end

end)

-- INFO
local info = Instance.new("TextLabel",main)
info.Size=UDim2.new(0,450,0,80)
info.Position=UDim2.new(0,20,0,300)
info.BackgroundTransparency=1
info.TextColor3=Color3.fromRGB(200,200,200)
info.Text="Facebook: fb.com/htknew.cityy\nDiscord: discord.gg/tV5RhPgsz\nTikTok: tiktok.com/@hatokireal\nIG: instagram.com/@fu._xinmo"
info.TextXAlignment=Enum.TextXAlignment.Left
