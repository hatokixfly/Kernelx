--// KERNEL GUI
--// By Kernelx

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

-- NOTIFICATION
StarterGui:SetCore("SendNotification",{
Title = "Kernel",
Text = "By: Kernelx",
Duration = 5
})

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- MAIN FRAME
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,520,0,320)
Main.Position = UDim2.new(0.5,-260,0.5,-160)
Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

local UICorner = Instance.new("UICorner",Main)
UICorner.CornerRadius = UDim.new(0,10)

-- SHADOW
local Shadow = Instance.new("ImageLabel")
Shadow.Parent = Main
Shadow.AnchorPoint = Vector2.new(0.5,0.5)
Shadow.Position = UDim2.new(0.5,0,0.5,0)
Shadow.Size = UDim2.new(1,30,1,30)
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageTransparency = 0.7
Shadow.ScaleType = "Slice"
Shadow.SliceCenter = Rect.new(10,10,118,118)
Shadow.BackgroundTransparency = 1
Shadow.ZIndex = 0

-- LEFT MENU
local Left = Instance.new("Frame")
Left.Parent = Main
Left.Size = UDim2.new(0,150,1,0)
Left.BackgroundColor3 = Color3.fromRGB(15,15,15)
Left.BorderSizePixel = 0

Instance.new("UICorner",Left).CornerRadius = UDim.new(0,10)

-- TITLE
local Title = Instance.new("TextLabel")
Title.Parent = Left
Title.Text = "KERNEL"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(255,50,50)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,0,0,50)

-- TAB BUTTONS
local MainTabBtn = Instance.new("TextButton")
MainTabBtn.Parent = Left
MainTabBtn.Size = UDim2.new(1,-20,0,40)
MainTabBtn.Position = UDim2.new(0,10,0,80)
MainTabBtn.Text = "MAIN"
MainTabBtn.Font = Enum.Font.GothamBold
MainTabBtn.TextSize = 14
MainTabBtn.BackgroundColor3 = Color3.fromRGB(200,40,40)
MainTabBtn.TextColor3 = Color3.new(1,1,1)
MainTabBtn.BorderSizePixel = 0
Instance.new("UICorner",MainTabBtn)

local InfoTabBtn = Instance.new("TextButton")
InfoTabBtn.Parent = Left
InfoTabBtn.Size = UDim2.new(1,-20,0,40)
InfoTabBtn.Position = UDim2.new(0,10,0,130)
InfoTabBtn.Text = "INFO"
InfoTabBtn.Font = Enum.Font.GothamBold
InfoTabBtn.TextSize = 14
InfoTabBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
InfoTabBtn.TextColor3 = Color3.new(1,1,1)
InfoTabBtn.BorderSizePixel = 0
Instance.new("UICorner",InfoTabBtn)

-- CONTENT
local Content = Instance.new("Frame")
Content.Parent = Main
Content.Position = UDim2.new(0,150,0,0)
Content.Size = UDim2.new(1,-150,1,0)
Content.BackgroundTransparency = 1

-- MAIN TAB
local MainTab = Instance.new("Frame")
MainTab.Parent = Content
MainTab.Size = UDim2.new(1,0,1,0)
MainTab.BackgroundTransparency = 1

-- INFO TAB
local InfoTab = Instance.new("Frame")
InfoTab.Parent = Content
InfoTab.Size = UDim2.new(1,0,1,0)
InfoTab.Visible = false
InfoTab.BackgroundTransparency = 1

-- TAB SWITCH
MainTabBtn.MouseButton1Click:Connect(function()
MainTab.Visible = true
InfoTab.Visible = false
MainTabBtn.BackgroundColor3 = Color3.fromRGB(200,40,40)
InfoTabBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
end)

InfoTabBtn.MouseButton1Click:Connect(function()
MainTab.Visible = false
InfoTab.Visible = true
InfoTabBtn.BackgroundColor3 = Color3.fromRGB(200,40,40)
MainTabBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
end)

-- TOGGLE FUNCTION
function createToggle(name,pos,callback)

local Frame = Instance.new("Frame",MainTab)
Frame.Size = UDim2.new(1,-40,0,40)
Frame.Position = pos
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Frame.BorderSizePixel = 0
Instance.new("UICorner",Frame)

local Label = Instance.new("TextLabel",Frame)
Label.Text = name
Label.Font = Enum.Font.Gotham
Label.TextSize = 14
Label.TextColor3 = Color3.new(1,1,1)
Label.BackgroundTransparency = 1
Label.Position = UDim2.new(0,10,0,0)
Label.Size = UDim2.new(0.7,0,1,0)

local Toggle = Instance.new("TextButton",Frame)
Toggle.Size = UDim2.new(0,40,0,20)
Toggle.Position = UDim2.new(1,-50,0.5,-10)
Toggle.Text = ""
Toggle.BackgroundColor3 = Color3.fromRGB(60,60,60)
Toggle.BorderSizePixel = 0
Instance.new("UICorner",Toggle)

local state=false

Toggle.MouseButton1Click:Connect(function()

state=not state

if state then
Toggle.BackgroundColor3 = Color3.fromRGB(255,40,40)
StarterGui:SetCore("SendNotification",{Title="Kernel",Text=name.." ON",Duration=2})
else
Toggle.BackgroundColor3 = Color3.fromRGB(60,60,60)
StarterGui:SetCore("SendNotification",{Title="Kernel",Text=name.." OFF",Duration=2})
end

callback(state)

end)

end

-- ESP
createToggle("ESP PLAYER",UDim2.new(0,20,0,30),function(state)

for _,v in pairs(Players:GetPlayers()) do
if v~=LocalPlayer and v.Character then

if state then

local box = Instance.new("BoxHandleAdornment")
box.Name="ESP"
box.Adornee=v.Character:FindFirstChild("HumanoidRootPart")
box.Size=Vector3.new(4,6,2)
box.Color3=Color3.fromRGB(255,0,0)
box.AlwaysOnTop=true
box.Parent=v.Character

else

if v.Character:FindFirstChild("ESP") then
v.Character.ESP:Destroy()
end

end

end
end

end)

-- INVISIBLE
createToggle("TÀN HÌNH",UDim2.new(0,20,0,80),function(state)

for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
if v:IsA("BasePart") then
v.Transparency = state and 1 or 0
end
end

end)

-- HITBOX
createToggle("HITBOX RỘNG",UDim2.new(0,20,0,130),function(state)

for _,v in pairs(Players:GetPlayers()) do
if v~=LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then

if state then
v.Character.HumanoidRootPart.Size=Vector3.new(10,10,10)
v.Character.HumanoidRootPart.Transparency=0.5
v.Character.HumanoidRootPart.BrickColor=BrickColor.new("Really red")
v.Character.HumanoidRootPart.Material="Neon"
v.Character.HumanoidRootPart.CanCollide=false
else
v.Character.HumanoidRootPart.Size=Vector3.new(2,2,1)
v.Character.HumanoidRootPart.Transparency=1
end

end
end

end)

-- INFO BUTTONS
function createButton(text,pos,link)

local Btn = Instance.new("TextButton",InfoTab)
Btn.Size = UDim2.new(0,260,0,50)
Btn.Position = pos
Btn.Text = text
Btn.Font = Enum.Font.GothamBold
Btn.TextSize = 16
Btn.BackgroundColor3 = Color3.fromRGB(200,40,40)
Btn.TextColor3 = Color3.new(1,1,1)
Btn.BorderSizePixel = 0
Instance.new("UICorner",Btn)

Btn.MouseButton1Click:Connect(function()

setclipboard(link)

StarterGui:SetCore("SendNotification",{
Title="Kernel",
Text="Copied to clipboard",
Duration=2
})

end)

end

createButton("IG: fu._xinmo",UDim2.new(0.5,-130,0.3,0),"https://instagram.com/fu._xinmo")
createButton("TikTok: hatokireal",UDim2.new(0.5,-130,0.5,0),"https://
