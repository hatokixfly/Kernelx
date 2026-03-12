--// Kernel GUI
--// By: Kernelx

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

-- Notification
local function notify(text)
StarterGui:SetCore("SendNotification",{
Title="Kernel",
Text=text,
Duration=3
})
end

StarterGui:SetCore("SendNotification",{
Title="Kernel",
Text="By: Kernelx",
Duration=5
})

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

--================================================
-- LOGO
--================================================

local Logo = Instance.new("TextButton")
Logo.Size = UDim2.new(0,60,0,60)
Logo.Position = UDim2.new(0,40,0.5,-30)
Logo.BackgroundColor3 = Color3.fromRGB(10,10,10)
Logo.Text = ""
Logo.Parent = ScreenGui
Logo.Active = true
Logo.Draggable = true

local LogoCorner = Instance.new("UICorner",Logo)
LogoCorner.CornerRadius = UDim.new(1,0)

local LogoStroke = Instance.new("UIStroke",Logo)
LogoStroke.Color = Color3.fromRGB(255,0,0)
LogoStroke.Thickness = 2

local LogoText = Instance.new("TextLabel")
LogoText.Parent = Logo
LogoText.Size = UDim2.new(1,0,1,0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "K"
LogoText.Font = Enum.Font.GothamBold
LogoText.TextColor3 = Color3.fromRGB(255,0,0)
LogoText.TextScaled = true

--================================================
-- MENU
--================================================

local Menu = Instance.new("Frame")
Menu.Size = UDim2.new(0,520,0,300)
Menu.Position = UDim2.new(0.5,-260,0.5,-150)
Menu.BackgroundColor3 = Color3.fromRGB(10,10,10)
Menu.Visible = false
Menu.Parent = ScreenGui
Menu.Active = true
Menu.Draggable = true

local MenuCorner = Instance.new("UICorner",Menu)
MenuCorner.CornerRadius = UDim.new(0,8)

local Stroke = Instance.new("UIStroke",Menu)
Stroke.Color = Color3.fromRGB(255,0,0)

--================================================
-- TOGGLE MENU
--================================================

Logo.MouseButton1Click:Connect(function()
Menu.Visible = not Menu.Visible
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
MainTab.TextColor3 = Color3.new(1,1,1)
MainTab.BackgroundColor3 = Color3.fromRGB(255,0,0)
MainTab.Font = Enum.Font.GothamBold

local InfoTab = Instance.new("TextButton")
InfoTab.Parent = TabPanel
InfoTab.Position = UDim2.new(0,0,0,50)
InfoTab.Size = UDim2.new(1,0,0,50)
InfoTab.Text = "INFO"
InfoTab.TextColor3 = Color3.new(1,1,1)
InfoTab.BackgroundColor3 = Color3.fromRGB(20,20,20)
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

local Invisible=false

local InvBtn = Instance.new("TextButton")
InvBtn.Parent = MainPage
InvBtn.Size = UDim2.new(0,220,0,40)
InvBtn.Text="TÀN HÌNH"
InvBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
InvBtn.TextColor3 = Color3.new(1,1,1)

InvBtn.MouseButton1Click:Connect(function()

local char = LocalPlayer.Character
if not char then return end

Invisible=not Invisible

for _,v in pairs(char:GetDescendants()) do
if v:IsA("BasePart") then
v.Transparency = Invisible and 1 or 0
end
end

notify(Invisible and "INVISIBLE ON" or "INVISIBLE OFF")

end)

--================================================
-- GODMODE
--================================================

local God=false

local GodBtn = Instance.new("TextButton")
GodBtn.Parent = MainPage
GodBtn.Position = UDim2.new(0,0,0,50)
GodBtn.Size = UDim2.new(0,220,0,40)
GodBtn.Text="BẤT TỬ"
GodBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
GodBtn.TextColor3 = Color3.new(1,1,1)

GodBtn.MouseButton1Click:Connect(function()

local char = LocalPlayer.Character
if not char then return end

God=not God

if God then
char.Humanoid.Health = math.huge
end

notify(God and "GODMODE ON" or "GODMODE OFF")

end)

--================================================
-- SPEED
--================================================

local Slider = Instance.new("TextButton")
Slider.Parent = MainPage
Slider.Position = UDim2.new(0,0,0,110)
Slider.Size = UDim2.new(0,220,0,40)
Slider.Text="SPEED: 16"
Slider.BackgroundColor3 = Color3.fromRGB(20,20,20)
Slider.TextColor3 = Color3.new(1,1,1)

Slider.MouseButton1Click:Connect(function()

local char = LocalPlayer.Character
if not char then return end

local speed = math.random(1,200)

char.Humanoid.WalkSpeed = speed

Slider.Text = "SPEED: "..speed

notify("SPEED: "..speed)

end)

--================================================
-- INFO PAGE
--================================================

local IG = Instance.new("TextButton")
IG.Parent = InfoPage
IG.Size = UDim2.new(0,260,0,50)
IG.Text = "IG: fu._xinmo"
IG.BackgroundColor3 = Color3.fromRGB(20,20,20)
IG.TextColor3 = Color3.new(1,1,1)

IG.MouseButton1Click:Connect(function()

setclipboard("https://instagram.com/fu._xinmo")

notify("Copied Instagram")

end)

local TikTok = Instance.new("TextButton")
TikTok.Parent = InfoPage
TikTok.Position = UDim2.new(0,0,0,60)
TikTok.Size = UDim2.new(0,260,0,50)
TikTok.Text = "TikTok: hatokireal"
TikTok.BackgroundColor3 = Color3.fromRGB(20,20,20)
TikTok.TextColor3 = Color3.new(1,1,1)

TikTok.MouseButton1Click:Connect(function()

setclipboard("https://tiktok.com/@hatokireal")

notify("Copied TikTok")

end)
