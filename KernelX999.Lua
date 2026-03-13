local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "KernelxPremium"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local Accent = Color3.fromRGB(255,40,40)

--------------------------------------------------
-- LOGO BUTTON
--------------------------------------------------

local Logo = Instance.new("TextButton")
Logo.Parent = gui
Logo.Size = UDim2.new(0,60,0,60)
Logo.Position = UDim2.new(0,50,0.5,-30)
Logo.BackgroundColor3 = Color3.fromRGB(10,10,10)
Logo.Text = "K"
Logo.TextColor3 = Accent
Logo.TextScaled = true
Logo.Font = Enum.Font.GothamBold
Logo.AutoButtonColor = false

local LogoCorner = Instance.new("UICorner",Logo)
LogoCorner.CornerRadius = UDim.new(1,0)

local LogoStroke = Instance.new("UIStroke",Logo)
LogoStroke.Color = Accent
LogoStroke.Thickness = 2

--------------------------------------------------
-- MAIN MENU
--------------------------------------------------

local Main = Instance.new("Frame")
Main.Parent = gui
Main.Size = UDim2.new(0,650,0,420)
Main.Position = UDim2.new(0.5,-325,0.5,-210)
Main.BackgroundColor3 = Color3.fromRGB(8,8,8)
Main.Visible = false

local MainCorner = Instance.new("UICorner",Main)
MainCorner.CornerRadius = UDim.new(0,14)

local MainStroke = Instance.new("UIStroke",Main)
MainStroke.Color = Accent
MainStroke.Thickness = 1.5

--------------------------------------------------
-- HEADER
--------------------------------------------------

local Header = Instance.new("TextLabel")
Header.Parent = Main
Header.Size = UDim2.new(1,0,0,55)
Header.BackgroundTransparency = 1
Header.Text = "Kernelx"
Header.TextColor3 = Accent
Header.Font = Enum.Font.GothamBold
Header.TextScaled = true

--------------------------------------------------
-- LEFT TAB PANEL
--------------------------------------------------

local LeftPanel = Instance.new("Frame")
LeftPanel.Parent = Main
LeftPanel.Size = UDim2.new(0,170,1,-55)
LeftPanel.Position = UDim2.new(0,0,0,55)
LeftPanel.BackgroundColor3 = Color3.fromRGB(12,12,12)

local LeftCorner = Instance.new("UICorner",LeftPanel)
LeftCorner.CornerRadius = UDim.new(0,12)

--------------------------------------------------
-- TAB BUTTONS
--------------------------------------------------

local function CreateTab(name,y)
	local b = Instance.new("TextButton")
	b.Parent = LeftPanel
	b.Size = UDim2.new(1,-20,0,45)
	b.Position = UDim2.new(0,10,0,y)
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.Text = name
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextScaled = true
	
	local c = Instance.new("UICorner",b)
	c.CornerRadius = UDim.new(0,10)
	
	return b
end

local MainTab = CreateTab("MAIN",20)
local SettingsTab = CreateTab("SETTINGS",80)

--------------------------------------------------
-- CONTENT
--------------------------------------------------

local Content = Instance.new("Frame")
Content.Parent = Main
Content.Size = UDim2.new(1,-190,1,-75)
Content.Position = UDim2.new(0,180,0,65)
Content.BackgroundTransparency = 1

--------------------------------------------------
-- TOGGLE CREATOR
--------------------------------------------------

local function CreateToggle(text,y)
	local holder = Instance.new("Frame")
	holder.Parent = Content
	holder.Size = UDim2.new(1,-20,0,50)
	holder.Position = UDim2.new(0,10,0,y)
	holder.BackgroundColor3 = Color3.fromRGB(15,15,15)

	local corner = Instance.new("UICorner",holder)
	corner.CornerRadius = UDim.new(0,10)

	local label = Instance.new("TextLabel")
	label.Parent = holder
	label.Size = UDim2.new(0.7,0,1,0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.new(1,1,1)
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true

	local toggle = Instance.new("TextButton")
	toggle.Parent = holder
	toggle.Size = UDim2.new(0,55,0,28)
	toggle.Position = UDim2.new(1,-70,0.5,-14)
	toggle.BackgroundColor3 = Color3.fromRGB(30,30,30)
	toggle.Text = ""

	local tc = Instance.new("UICorner",toggle)
	tc.CornerRadius = UDim.new(1,0)

	local knob = Instance.new("Frame")
	knob.Parent = toggle
	knob.Size = UDim2.new(0,24,0,24)
	knob.Position = UDim2.new(0,2,0.5,-12)
	knob.BackgroundColor3 = Color3.new(1,1,1)

	local kc = Instance.new("UICorner",knob)
	kc.CornerRadius = UDim.new(1,0)

	return toggle, knob
end

local AutoSlotToggle, AutoSlotKnob = CreateToggle("AUTO ITEM",20)
local AntiAfkToggle, AntiAfkKnob = CreateToggle("ANTI AFK",90)

--------------------------------------------------
-- NOTIFICATION
--------------------------------------------------

local function Notify(txt)
	local n = Instance.new("TextLabel")
	n.Parent = gui
	n.Size = UDim2.new(0,240,0,50)
	n.Position = UDim2.new(1,-260,0,50)
	n.BackgroundColor3 = Color3.fromRGB(10,10,10)
	n.Text = txt
	n.TextColor3 = Accent
	n.Font = Enum.Font.GothamBold
	n.TextScaled = true

	local nc = Instance.new("UICorner",n)
	nc.CornerRadius = UDim.new(0,10)

	local tween = TweenService:Create(n,TweenInfo.new(0.3),{
		Position = UDim2.new(1,-260,0,80)
	})
	tween:Play()

	task.wait(2)

	local tween2 = TweenService:Create(n,TweenInfo.new(0.3),{
		TextTransparency = 1
	})
	tween2:Play()

	task.wait(0.3)
	n:Destroy()
end

--------------------------------------------------
-- TOGGLE LOGIC
--------------------------------------------------

local autoSlot = false
AutoSlotToggle.MouseButton1Click:Connect(function()
	autoSlot = not autoSlot
	
	TweenService:Create(AutoSlotKnob,TweenInfo.new(0.25),{
		Position = autoSlot and UDim2.new(0,29,0.5,-12) or UDim2.new(0,2,0.5,-12)
	}):Play()

	AutoSlotToggle.BackgroundColor3 = autoSlot and Accent or Color3.fromRGB(30,30,30)
	Notify("AUTO SLOT 1 "..(autoSlot and "ENABLED" or "DISABLED"))
end)

task.spawn(function()
	while task.wait(1) do
		if autoSlot then
			local char = player.Character
			if char and not char:FindFirstChildOfClass("Tool") then
				local tool = player.Backpack:FindFirstChildOfClass("Tool")
				if tool then
					tool.Parent = char
				end
			end
		end
	end
end)

--------------------------------------------------
-- ANTI AFK
--------------------------------------------------

local antiAfk = false
AntiAfkToggle.MouseButton1Click:Connect(function()
	antiAfk = not antiAfk
	
	TweenService:Create(AntiAfkKnob,TweenInfo.new(0.25),{
		Position = antiAfk and UDim2.new(0,29,0.5,-12) or UDim2.new(0,2,0.5,-12)
	}):Play()

	AntiAfkToggle.BackgroundColor3 = antiAfk and Accent or Color3.fromRGB(30,30,30)
	Notify("ANTI AFK "..(antiAfk and "ENABLED" or "DISABLED"))
end)

player.Idled:Connect(function()
	if antiAfk then
		VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		task.wait(1)
		VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end
end)

--------------------------------------------------
-- MENU OPEN CLOSE
--------------------------------------------------

Logo.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
	if Main.Visible then
		Main.Size = UDim2.new(0,0,0,0)
		TweenService:Create(Main,TweenInfo.new(0.35),{
			Size = UDim2.new(0,650,0,420)
		}):Play()
	end
end)

--------------------------------------------------
-- DRAG SYSTEM
--------------------------------------------------

local function Dragify(frame)
	local dragging = false
	local dragInput, dragStart, startPos

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
end

Dragify(Main)
Dragify(Logo)

--------------------------------------------------
-- RAINBOW CREDIT
--------------------------------------------------

local Credit = Instance.new("TextLabel")
Credit.Parent = Main
Credit.Size = UDim2.new(1,0,0,25)
Credit.Position = UDim2.new(0,0,1,-30)
Credit.BackgroundTransparency = 1
Credit.Text = "Script By: Nguyen Thanh Phu"
Credit.Font = Enum.Font.GothamBold
Credit.TextScaled = true

task.spawn(function()
	while task.wait() do
		Credit.TextColor3 = Color3.fromHSV(tick()%5/5,1,1)
	end
end)
