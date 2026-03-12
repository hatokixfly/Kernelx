--// KERNEL GUI V2
--// By Kernelx

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")

-- NOTIFICATION
pcall(function()
StarterGui:SetCore("SendNotification",{
Title = "Kernel",
Text = "By: Kernelx",
Duration = 5
})
end)

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KernelGUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- MAIN
local Main = Instance.new("Frame",ScreenGui)
Main.Size = UDim2.new(0,520,0,320)
Main.Position = UDim2.new(0.5,-260,0.5,-160)
Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

Instance.new("UICorner",Main).CornerRadius = UDim.new(0,10)

-- LEFT MENU
local Left = Instance.new("Frame",Main)
Left.Size = UDim2.new(0,150,1,0)
Left.BackgroundColor3 = Color3.fromRGB(15,15,15)
Left.BorderSizePixel = 0
Instance.new("UICorner",Left)

-- TITLE
local Title = Instance.new("TextLabel",Left)
Title.Size = UDim2.new(1,0,0,50)
Title.Text = "KERNEL"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(255,60,60)
Title.BackgroundTransparency = 1

-- TAB BUTTONS
local MainTabBtn = Instance.new("TextButton",Left)
MainTabBtn.Position = UDim2.new(0,10,0,70)
MainTabBtn.Size = UDim2.new(1,-20,0,40)
MainTabBtn.Text = "MAIN"
MainTabBtn.BackgroundColor3 = Color3.fromRGB(200,40,40)
MainTabBtn.TextColor3 = Color3.new(1,1,1)
MainTabBtn.BorderSizePixel = 0
Instance.new("UICorner",MainTabBtn)

local InfoTabBtn = Instance.new("TextButton",Left)
InfoTabBtn.Position = UDim2.new(0,10,0,120)
InfoTabBtn.Size = UDim2.new(1,-20,0,40)
InfoTabBtn.Text = "INFO"
InfoTabBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
InfoTabBtn.TextColor3 = Color3.new(1,1,1)
InfoTabBtn.BorderSizePixel = 0
Instance.new("UICorner",InfoTabBtn)

-- CONTENT
local Content = Instance.new("Frame",Main)
Content.Position = UDim2.new(0,150,0,0)
Content.Size = UDim2.new(1,-150,1,0)
Content.BackgroundTransparency = 1

local MainTab = Instance.new("Frame",Content)
MainTab.Size = UDim2.new(1,0,1,0)
MainTab.BackgroundTransparency = 1

local InfoTab = Instance.new("Frame",Content)
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
local function Toggle(name,y,callback)

local Frame = Instance.new("Frame",MainTab)
Frame.Size = UDim2.new(1,-40,0,40)
Frame.Position = UDim2.new(0,20,0,y)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Frame.BorderSizePixel = 0
Instance.new("UICorner",Frame)

local Label = Instance.new("TextLabel",Frame)
Label.Text = name
Label.Size = UDim2.new(0.7,0,1,0)
Label.BackgroundTransparency = 1
Label.TextColor3 = Color3.new(1,1,1)
Label.Font = Enum.Font.Gotham
Label.TextSize = 14

local Button = Instance.new("TextButton",Frame)
Button.Size = UDim2.new(0,40,0,20)
Button.Position = UDim2.new(1,-50,0.5,-10)
Button.Text = ""
Button.BackgroundColor3 = Color3.fromRGB(60,60,60)
Button.BorderSizePixel = 0
Instance.new("UICorner",Button)

local state=false

Button.MouseButton1Click:Connect(function()

state = not state

if state then
Button.BackgroundColor3 = Color3.fromRGB(255,40,40)
StarterGui:SetCore("SendNotification",{Title="Kernel",Text=name.." ON",Duration=2})
else
Button.BackgroundColor3 = Color3.fromRGB(60,60,60)
StarterGui:SetCore("SendNotification",{Title="Kernel",Text=name.." OFF",Duration=2})
end

callback(state)

end)

end

-- ESP
Toggle("ESP PLAYER",30,function(state)

for _,v in pairs(Players:GetPlayers()) do
if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then

if state then
local box = Instance.new("BoxHandleAdornment")
box.Name="ESP"
box.Adornee=v.Character.HumanoidRootPart
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
Toggle("TÀN HÌNH",80,function(state)

if LocalPlayer.Character then
for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
if v:IsA("BasePart") then
v.Transparency = state and 1 or 0
end
end
end

end)

-- HITBOX
Toggle("HITBOX RỘNG",130,function(state)

for _,v in pairs(Players:GetPlayers()) do
if v~=LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then

if state then
v.Character.HumanoidRootPart.Size=Vector3.new(10,10,10)
v.Character.HumanoidRootPart.Transparency=0.5
else
v.Character.HumanoidRootPart.Size=Vector3.new(2,2,1)
v.Character.HumanoidRootPart.Transparency=1
end

end
end

end)

-- INFO BUTTON
local function Button(text,y,link)

local Btn = Instance.new("TextButton",InfoTab)
Btn.Size = UDim2.new(0,260,0,50)
Btn.Position = UDim2.new(0.5,-130,0,y)
Btn.Text = text
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

Button("IG: fu._xinmo",80,"https://instagram.com/fu._xinmo")
Button("TikTok: hatokireal",150,"https://tiktok.com/@hatokireal")
