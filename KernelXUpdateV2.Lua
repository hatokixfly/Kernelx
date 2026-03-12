--// KernelX HaToKi
--// Script By KernelX

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

-- INTRO
game.StarterGui:SetCore("SendNotification",{
Title = "KernelX HaToKi",
Text = "Script By KernelX",
Duration = 5
})

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "KernelX"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,520,0,360)
main.Position = UDim2.new(0.3,0,0.2,0)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.Text = "KernelX HaToKi"
title.TextColor3 = Color3.fromRGB(255,170,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 22

-- CLOSE BUTTON
local close = Instance.new("TextButton", main)
close.Text = "X"
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-40,0,0)
close.BackgroundColor3 = Color3.fromRGB(40,40,40)

close.MouseButton1Click:Connect(function()
main.Visible=false
end)

-- OPEN BUTTON
local open = Instance.new("TextButton", gui)
open.Size = UDim2.new(0,50,0,50)
open.Position = UDim2.new(0,10,0.5,0)
open.Text="☰"
open.BackgroundColor3 = Color3.fromRGB(20,20,20)

open.MouseButton1Click:Connect(function()
main.Visible=true
end)

-- SAVE POSITION
local savedPos=nil

local save = Instance.new("TextButton",main)
save.Size=UDim2.new(0,200,0,35)
save.Position=UDim2.new(0,20,0,60)
save.Text="SAVE POSITION"

save.MouseButton1Click:Connect(function()
savedPos=LocalPlayer.Character.HumanoidRootPart.Position
end)

-- TELEPORT POSITION
local tele = Instance.new("TextButton",main)
tele.Size=UDim2.new(0,200,0,35)
tele.Position=UDim2.new(0,20,0,100)
tele.Text="TELEPORT SAVED"

tele.MouseButton1Click:Connect(function()
if savedPos then
LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(savedPos)
end
end)

-- TELE BASE (-1000m)
local base = Instance.new("TextButton",main)
base.Size=UDim2.new(0,200,0,35)
base.Position=UDim2.new(0,20,0,140)
base.Text="TELE BASE"

base.MouseButton1Click:Connect(function()
local hrp=LocalPlayer.Character.HumanoidRootPart
hrp.CFrame=hrp.CFrame * CFrame.new(0,-1000,0)
end)

-- ESP
local espEnabled=false

local espBtn=Instance.new("TextButton",main)
espBtn.Size=UDim2.new(0,200,0,35)
espBtn.Position=UDim2.new(0,20,0,180)
espBtn.Text="ESP BOX"

espBtn.MouseButton1Click:Connect(function()
espEnabled=not espEnabled

for i,v in pairs(Players:GetPlayers()) do
if v~=LocalPlayer and v.Character then

local highlight=Instance.new("Highlight")
highlight.FillTransparency=1
highlight.OutlineColor=Color3.fromRGB(255,0,0)
highlight.Parent=v.Character

end
end
end)

-- ESP LINE
local lineBtn=Instance.new("TextButton",main)
lineBtn.Size=UDim2.new(0,200,0,35)
lineBtn.Position=UDim2.new(0,20,0,220)
lineBtn.Text="ESP LINE"

lineBtn.MouseButton1Click:Connect(function()

for i,v in pairs(Players:GetPlayers()) do
if v~=LocalPlayer then

local beam=Instance.new("Beam")
beam.Parent=LocalPlayer.Character.Head

end
end

end)

-- AUTO SPIN SCREEN
local spin=false

local spinBtn=Instance.new("TextButton",main)
spinBtn.Size=UDim2.new(0,200,0,35)
spinBtn.Position=UDim2.new(0,260,0,60)
spinBtn.Text="SPIN SCREEN"

spinBtn.MouseButton1Click:Connect(function()
spin=not spin
while spin do
RunService.RenderStepped:Wait()
LocalPlayer.Character.HumanoidRootPart.CFrame=
LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0,math.rad(5),0)
end
end)

-- AUTO JUMP
local jump=false

local jumpBtn=Instance.new("TextButton",main)
jumpBtn.Size=UDim2.new(0,200,0,35)
jumpBtn.Position=UDim2.new(0,260,0,100)
jumpBtn.Text="AUTO SPACE"

jumpBtn.MouseButton1Click:Connect(function()
jump=not jump

while jump do
wait(0.2)
LocalPlayer.Character.Humanoid.Jump=true
end

end)

-- ANTI AFK
LocalPlayer.Idled:Connect(function()
VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
wait(1)
VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- AUTO SPIN PET (simple loop)
local autoSpin=false

local spinPet=Instance.new("TextButton",main)
spinPet.Size=UDim2.new(0,200,0,35)
spinPet.Position=UDim2.new(0,260,0,140)
spinPet.Text="AUTO SPIN PET"

spinPet.MouseButton1Click:Connect(function()
autoSpin=not autoSpin

while autoSpin do
wait(1)
game:GetService("VirtualInputManager"):SendKeyEvent(true,"E",false,game)
end

end)

-- INFO BOX
local info = Instance.new("TextLabel",main)
info.Size=UDim2.new(0,450,0,100)
info.Position=UDim2.new(0,20,0,260)
info.BackgroundTransparency=1
info.TextColor3=Color3.fromRGB(200,200,200)
info.Text=
"Facebook: fb.com/htknew.cityy\nDiscord: discord.gg/tV5RhPgsz\nTikTok: tiktok.com/@hatokireal\nIG: instagram.com/@fu._xinmo"

info.TextXAlignment=Enum.TextXAlignment.Left
