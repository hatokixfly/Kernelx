-- PHUBABY HUB
-- Developer: Nguyen Thanh Phu

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui
ScreenGui.Name = "PhuBabyHub"
ScreenGui.ResetOnSpawn = false

-- MAIN FRAME
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,520,0,320)
Main.Position = UDim2.new(0.3,0,0.25,0)
Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Main.BorderColor3 = Color3.fromRGB(255,0,0)
Main.Active = true
Main.Draggable = true

-- TITLE
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundColor3 = Color3.fromRGB(0,0,0)
Title.Text = "PhuBaby"
Title.TextColor3 = Color3.fromRGB(255,0,0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22

-- CLOSE BUTTON
local Close = Instance.new("TextButton")
Close.Parent = Title
Close.Size = UDim2.new(0,40,0,40)
Close.Position = UDim2.new(1,-40,0,0)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(20,20,20)
Close.TextColor3 = Color3.fromRGB(255,0,0)

-- OPEN BUTTON
local Open = Instance.new("TextButton")
Open.Parent = ScreenGui
Open.Size = UDim2.new(0,60,0,30)
Open.Position = UDim2.new(0,10,0.5,0)
Open.Text = "OPEN"
Open.BackgroundColor3 = Color3.fromRGB(0,0,0)
Open.TextColor3 = Color3.fromRGB(255,0,0)

Close.MouseButton1Click:Connect(function()
	Main.Visible = false
end)

Open.MouseButton1Click:Connect(function()
	Main.Visible = true
end)

-- SIDEBAR
local Sidebar = Instance.new("Frame")
Sidebar.Parent = Main
Sidebar.Size = UDim2.new(0,130,1,-40)
Sidebar.Position = UDim2.new(0,0,0,40)
Sidebar.BackgroundColor3 = Color3.fromRGB(15,15,15)

local function CreateTabButton(name,pos)
	local b = Instance.new("TextButton")
	b.Parent = Sidebar
	b.Size = UDim2.new(1,0,0,40)
	b.Position = UDim2.new(0,0,0,pos)
	b.Text = name
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.TextColor3 = Color3.fromRGB(255,0,0)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	return b
end

local MainTab = CreateTabButton("MAIN",0)
local VisualTab = CreateTabButton("VISUAL",40)
local PlayerTab = CreateTabButton("PLAYER",80)
local InfoTab = CreateTabButton("INFO",120)

-- CONTENT
local Content = Instance.new("Frame")
Content.Parent = Main
Content.Size = UDim2.new(1,-130,1,-40)
Content.Position = UDim2.new(0,130,0,40)
Content.BackgroundColor3 = Color3.fromRGB(10,10,10)

local Pages = {}

local function CreatePage(name)
	local p = Instance.new("Frame")
	p.Parent = Content
	p.Size = UDim2.new(1,0,1,0)
	p.Visible = false
	p.BackgroundTransparency = 1
	Pages[name] = p
	return p
end

local PageMain = CreatePage("MAIN")
local PageVisual = CreatePage("VISUAL")
local PagePlayer = CreatePage("PLAYER")
local PageInfo = CreatePage("INFO")

PageMain.Visible = true

local function Switch(page)
	for i,v in pairs(Pages) do
		v.Visible = false
	end
	page.Visible = true
end

MainTab.MouseButton1Click:Connect(function() Switch(PageMain) end)
VisualTab.MouseButton1Click:Connect(function() Switch(PageVisual) end)
PlayerTab.MouseButton1Click:Connect(function() Switch(PagePlayer) end)
InfoTab.MouseButton1Click:Connect(function() Switch(PageInfo) end)

-- NOTIFICATION
local function Notify(text)
	game.StarterGui:SetCore("SendNotification",{
		Title = "PhuBaby",
		Text = text,
		Duration = 3
	})
end

-- ANTI AFK
local AntiAFK = false

local AntiButton = Instance.new("TextButton")
AntiButton.Parent = PageMain
AntiButton.Size = UDim2.new(0,200,0,40)
AntiButton.Position = UDim2.new(0,20,0,20)
AntiButton.Text = "ANTI AFK : OFF"
AntiButton.BackgroundColor3 = Color3.fromRGB(20,20,20)
AntiButton.TextColor3 = Color3.fromRGB(255,0,0)

AntiButton.MouseButton1Click:Connect(function()

	AntiAFK = not AntiAFK

	if AntiAFK then
		AntiButton.Text = "ANTI AFK : ON"
		Notify("Enabled Anti AFK")

		LocalPlayer.Idled:Connect(function()
			game:GetService("VirtualUser"):CaptureController()
			game:GetService("VirtualUser"):ClickButton2(Vector2.new())
		end)

	else
		AntiButton.Text = "ANTI AFK : OFF"
		Notify("Disabled Anti AFK")
	end

end)

-- ESP
local ESPEnabled = false
local ESPs = {}

local function CreateESP(player)

	if player == LocalPlayer then return end

	local box = Drawing.new("Square")
	box.Thickness = 2
	box.Color = Color3.fromRGB(255,0,0)
	box.Filled = false

	ESPs[player] = box

end

for i,v in pairs(Players:GetPlayers()) do
	CreateESP(v)
end

Players.PlayerAdded:Connect(CreateESP)

game:GetService("RunService").RenderStepped:Connect(function()

	if not ESPEnabled then
		for i,v in pairs(ESPs) do
			v.Visible = false
		end
		return
	end

	for player,box in pairs(ESPs) do

		local char = player.Character
		if char and char:FindFirstChild("HumanoidRootPart") then

			local pos,vis = workspace.CurrentCamera:WorldToViewportPoint(char.HumanoidRootPart.Position)

			if vis then
				box.Size = Vector2.new(60,100)
				box.Position = Vector2.new(pos.X-30,pos.Y-50)
				box.Visible = true
			else
				box.Visible = false
			end

		end

	end

end)

local ESPButton = Instance.new("TextButton")
ESPButton.Parent = PageVisual
ESPButton.Size = UDim2.new(0,200,0,40)
ESPButton.Position = UDim2.new(0,20,0,20)
ESPButton.Text = "ESP BOX : OFF"
ESPButton.BackgroundColor3 = Color3.fromRGB(20,20,20)
ESPButton.TextColor3 = Color3.fromRGB(255,0,0)

ESPButton.MouseButton1Click:Connect(function()

	ESPEnabled = not ESPEnabled

	if ESPEnabled then
		ESPButton.Text = "ESP BOX : ON"
		Notify("ESP Enabled")
	else
		ESPButton.Text = "ESP BOX : OFF"
		Notify("ESP Disabled")
	end

end)

-- INFO BOX
local function InfoBox(text,y)

	local box = Instance.new("TextLabel")
	box.Parent = PageInfo
	box.Size = UDim2.new(0,260,0,40)
	box.Position = UDim2.new(0,20,0,y)
	box.BackgroundColor3 = Color3.fromRGB(15,15,15)
	box.BorderColor3 = Color3.fromRGB(255,0,0)
	box.TextColor3 = Color3.fromRGB(255,255,255)
	box.Text = text
	box.Font = Enum.Font.GothamBold
	box.TextSize = 14

end

InfoBox("Developer : Nguyen Thanh Phu",20)
InfoBox("TikTok : @HaToKiReal",70)
InfoBox("Instagram : fu._xinmo",120)
InfoBox("Menu : PhuBaby",170)
