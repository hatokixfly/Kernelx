--// Kernel GUI
--// By: Kernelx

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

-- Notification
local function notify(txt)
pcall(function()
StarterGui:SetCore("SendNotification",{
Title = "Kernel",
Text = txt,
Duration = 5
})
end)
end

notify("By: Kernelx")

-- GUI
local gui = Instance.new("ScreenGui",game.CoreGui)
gui.Name = "KernelUI"
gui.ResetOnSpawn = false

-- Logo
local logo = Instance.new("TextButton",gui)
logo.Size = UDim2.new(0,60,0,60)
logo.Position = UDim2.new(0.05,0,0.3,0)
logo.BackgroundColor3 = Color3.fromRGB(0,0,0)
logo.Text = "K"
logo.TextColor3 = Color3.fromRGB(255,0,0)
logo.Font = Enum.Font.GothamBold
logo.TextSize = 28
logo.AutoButtonColor = false

Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)

local stroke = Instance.new("UIStroke",logo)
stroke.Color = Color3.fromRGB(255,0,0)
stroke.Thickness = 2

-- Menu
local menu = Instance.new("Frame",gui)
menu.Size = UDim2.new(0,420,0,260)
menu.Position = UDim2.new(0.35,0,0.3,0)
menu.BackgroundColor3 = Color3.fromRGB(10,10,10)
menu.Visible = false

Instance.new("UICorner",menu).CornerRadius = UDim.new(0,8)

local stroke2 = Instance.new("UIStroke",menu)
stroke2.Color = Color3.fromRGB(255,0,0)

-- Drag
local function dragify(Frame)

local dragToggle=nil
local dragInput=nil
local dragStart
local startPos

local function update(input)

local delta=input.Position-dragStart

Frame.Position=UDim2.new(
startPos.X.Scale,
startPos.X.Offset+delta.X,
startPos.Y.Scale,
startPos.Y.Offset+delta.Y)

end

Frame.InputBegan:Connect(function(input)

if input.UserInputType==Enum.UserInputType.MouseButton1 then

dragToggle=true
dragStart=input.Position
startPos=Frame.Position

input.Changed:Connect(function()

if input.UserInputState==Enum.UserInputState.End then
dragToggle=false
end

end)

end

end)

Frame.InputChanged:Connect(function(input)

if input.UserInputType==Enum.UserInputType.MouseMovement then
dragInput=input
end

end)

UIS.InputChanged:Connect(function(input)

if input==dragInput and dragToggle then
update(input)
end

end)

end

dragify(menu)
dragify(logo)

logo.MouseButton1Click:Connect(function()
menu.Visible = not menu.Visible
end)

-- Tabs
local tabFrame = Instance.new("Frame",menu)
tabFrame.Size = UDim2.new(0,110,1,0)
tabFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)

local mainTab = Instance.new("TextButton",tabFrame)
mainTab.Size = UDim2.new(1,0,0,50)
mainTab.Text = "MAIN"
mainTab.BackgroundColor3 = Color3.fromRGB(255,0,0)
mainTab.TextColor3 = Color3.new(1,1,1)

local infoTab = Instance.new("TextButton",tabFrame)
infoTab.Position = UDim2.new(0,0,0,50)
infoTab.Size = UDim2.new(1,0,0,50)
infoTab.Text = "INFO"
infoTab.BackgroundColor3 = Color3.fromRGB(20,20,20)
infoTab.TextColor3 = Color3.new(1,1,1)

-- Pages
local mainPage = Instance.new("Frame",menu)
mainPage.Position = UDim2.new(0,120,0,0)
mainPage.Size = UDim2.new(1,-120,1,0)
mainPage.BackgroundTransparency = 1

local infoPage = mainPage:Clone()
infoPage.Parent = menu
infoPage.Visible = false

-- Tab switch
mainTab.MouseButton1Click:Connect(function()

mainPage.Visible=true
infoPage.Visible=false

mainTab.BackgroundColor3=Color3.fromRGB(255,0,0)
infoTab.BackgroundColor3=Color3.fromRGB(20,20,20)

end)

infoTab.MouseButton1Click:Connect(function()

mainPage.Visible=false
infoPage.Visible=true

infoTab.BackgroundColor3=Color3.fromRGB(255,0,0)
mainTab.BackgroundColor3=Color3.fromRGB(20,20,20)

end)

-- INVISIBLE
local invisible=false

local invBtn = Instance.new("TextButton",mainPage)
invBtn.Size = UDim2.new(0,200,0,40)
invBtn.Position = UDim2.new(0,10,0,20)
invBtn.Text = "INVISIBLE"

invBtn.MouseButton1Click:Connect(function()

invisible=not invisible

local char=player.Character

if char then

for i,v in pairs(char:GetDescendants()) do

if v:IsA("BasePart") then
v.Transparency = invisible and 1 or 0
end

end

end

notify(invisible and "INVISIBLE ON" or "INVISIBLE OFF")

end)

-- GODMODE
local god=false

local godBtn = Instance.new("TextButton",mainPage)
godBtn.Size = UDim2.new(0,200,0,40)
godBtn.Position = UDim2.new(0,10,0,70)
godBtn.Text = "GODMODE"

godBtn.MouseButton1Click:Connect(function()

god = not god

local hum = player.Character:FindFirstChildOfClass("Humanoid")

if god then

hum:GetPropertyChangedSignal("Health"):Connect(function()
hum.Health = hum.MaxHealth
end)

notify("GODMODE ON")

else

notify("GODMODE OFF")

end

end)

-- SPEED INPUT
local speedBox = Instance.new("TextBox",mainPage)
speedBox.Position = UDim2.new(0,10,0,120)
speedBox.Size = UDim2.new(0,200,0,40)
speedBox.PlaceholderText = "Enter Speed (1 - 9999)"
speedBox.Text = ""
speedBox.TextColor3 = Color3.new(1,1,1)
speedBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
speedBox.ClearTextOnFocus = false

Instance.new("UICorner",speedBox)

speedBox.FocusLost:Connect(function()

local speed = tonumber(speedBox.Text)

if speed then

speed = math.clamp(speed,1,9999)

player.Character.Humanoid.WalkSpeed = speed

notify("SPEED: "..speed)

end

end)

-- INFO BUTTONS
local ig = Instance.new("TextButton",infoPage)
ig.Size = UDim2.new(0,240,0,60)
ig.Position = UDim2.new(0.5,-120,0,40)
ig.Text = "IG: fu._xinmo"

ig.MouseButton1Click:Connect(function()

setclipboard("https://instagram.com/fu._xinmo")

notify("Copied Instagram")

end)

local tk = ig:Clone()
tk.Parent = infoPage
tk.Position = UDim2.new(0.5,-120,0,120)
tk.Text = "TikTok: hatokireal"

tk.MouseButton1Click:Connect(function()

setclipboard("https://tiktok.com/@hatokireal")

notify("Copied TikTok")

end)
