local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer

--------------------------------------------------
-- GUI
--------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "KernelxV2"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local Accent = Color3.fromRGB(255,40,40)

--------------------------------------------------
-- LOGO BUTTON
--------------------------------------------------

local Logo = Instance.new("TextButton")
Logo.Parent = gui
Logo.Size = UDim2.new(0,52,0,52)
Logo.Position = UDim2.new(0,40,0.5,-26)
Logo.BackgroundColor3 = Color3.fromRGB(10,10,10)
Logo.Text = "K"
Logo.TextColor3 = Accent
Logo.Font = Enum.Font.GothamBold
Logo.TextScaled = true
Logo.AutoButtonColor = false

Instance.new("UICorner",Logo).CornerRadius = UDim.new(1,0)

local LogoStroke = Instance.new("UIStroke",Logo)
LogoStroke.Color = Accent
LogoStroke.Thickness = 2

--------------------------------------------------
-- MAIN MENU SMALLER
--------------------------------------------------

local Main = Instance.new("Frame")
Main.Parent = gui
Main.Size = UDim2.new(0,540,0,320)
Main.Position = UDim2.new(0.5,-270,0.5,-160)
Main.BackgroundColor3 = Color3.fromRGB(8,8,8)
Main.Visible = false

Instance.new("UICorner",Main).CornerRadius = UDim.new(0,14)

local MainStroke = Instance.new("UIStroke",Main)
MainStroke.Color = Accent
MainStroke.Thickness = 1.4

--------------------------------------------------
-- HEADER
--------------------------------------------------

local Header = Instance.new("TextLabel")
Header.Parent = Main
Header.Size = UDim2.new(1,0,0,45)
Header.BackgroundTransparency = 1
Header.Text = "Kernelx"
Header.TextColor3 = Accent
Header.Font = Enum.Font.GothamBold
Header.TextScaled = true

--------------------------------------------------
-- LEFT PANEL
--------------------------------------------------

local Left = Instance.new("Frame")
Left.Parent = Main
Left.Size = UDim2.new(0,140,1,-45)
Left.Position = UDim2.new(0,0,0,45)
Left.BackgroundColor3 = Color3.fromRGB(12,12,12)

Instance.new("UICorner",Left).CornerRadius = UDim.new(0,12)

--------------------------------------------------
-- TAB CREATOR
--------------------------------------------------

local function Tab(name,y)
	local b = Instance.new("TextButton")
	b.Parent = Left
	b.Size = UDim2.new(1,-16,0,38)
	b.Position = UDim2.new(0,8,0,y)
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.Text = name
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextScaled = true
	Instance.new("UICorner",b).CornerRadius = UDim.new(0,9)
	return b
end

local MainTab = Tab("MAIN",15)
local SettingsTab = Tab("SETTINGS",60)

MainTab.BackgroundColor3 = Accent

--------------------------------------------------
-- CONTENT
--------------------------------------------------

local Content = Instance.new("Frame")
Content.Parent = Main
Content.Size = UDim2.new(1,-155,1,-60)
Content.Position = UDim2.new(0,150,0,50)
Content.BackgroundTransparency = 1

--------------------------------------------------
-- TOGGLE CREATOR
--------------------------------------------------

local function CreateToggle(text,y)
	local holder = Instance.new("Frame")
	holder.Parent = Content
	holder.Size = UDim2.new(1,-10,0,42)
	holder.Position = UDim2.new(0,5,0,y)
	holder.BackgroundColor3 = Color3.fromRGB(14,14,14)

	Instance.new("UICorner",holder).CornerRadius = UDim.new(0,10)

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
	toggle.Size = UDim2.new(0,48,0,24)
	toggle.Position = UDim2.new(1,-58,0.5,-12)
	toggle.BackgroundColor3 = Color3.fromRGB(28,28,28)
	toggle.Text = ""

	Instance.new("UICorner",toggle).CornerRadius = UDim.new(1,0)

	local knob = Instance.new("Frame")
	knob.Parent = toggle
	knob.Size = UDim2.new(0,20,0,20)
	knob.Position = UDim2.new(0,2,0.5,-10)
	knob.BackgroundColor3 = Color3.new(1,1,1)

	Instance.new("UICorner",knob).CornerRadius = UDim.new(1,0)

	return toggle, knob
end

local AutoToggle, AutoKnob = CreateToggle("AUTO SLOT 1",20)
local AfkToggle, AfkKnob = CreateToggle("ANTI AFK",75)

--------------------------------------------------
-- NOTIFICATION
--------------------------------------------------

local function Notify(msg)
	local n = Instance.new("TextLabel")
	n.Parent = gui
	n.Size = UDim2.new(0,220,0,42)
	n.Position = UDim2.new(1,-240,0,40)
	n.BackgroundColor3 = Color3.fromRGB(10,10,10)
	n.Text = msg
	n.TextColor3 = Accent
	n.Font = Enum.Font.GothamBold
	n.TextScaled = true

	Instance.new("UICorner",n).CornerRadius = UDim.new(0,10)

	TweenService:Create(n,TweenInfo.new(0.3),{
		Position = UDim2.new(1,-240,0,70)
	}):Play()

	task.wait(2)

	TweenService:Create(n,TweenInfo.new(0.3),{
		TextTransparency = 1,
		BackgroundTransparency = 1
	}):Play()

	task.wait(0.3)
	n:Destroy()
end

--------------------------------------------------
-- AUTO SLOT
--------------------------------------------------

local auto = false

AutoToggle.MouseButton1Click:Connect(function()
	auto = not auto

	TweenService:Create(AutoKnob,TweenInfo.new(0.25),{
		Position = auto and UDim2.new(0,26,0.5,-10) or UDim2.new(0,2,0.5,-10)
	}):Play()

	AutoToggle.BackgroundColor3 = auto and Accent or Color3.fromRGB(28,28,28)

	Notify("AUTO SLOT "..(auto and "ON" or "OFF"))
end)

task.spawn(function()
	while task.wait(1) do
		if auto then
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

local anti = false

AfkToggle.MouseButton1Click:Connect(function()
	anti = not anti

	TweenService:Create(AfkKnob,TweenInfo.new(0.25),{
		Position = anti and UDim2.new(0,26,0.5,-10) or UDim2.new(0,2,0.5,-10)
	}):Play()

	AfkToggle.BackgroundColor3 = anti and Accent or Color3.fromRGB(28,28,28)

	Notify("ANTI AFK "..(anti and "ON" or "OFF"))
end)

player.Idled:Connect(function()
	if anti then
		VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		task.wait(1)
		VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end
end)

--------------------------------------------------
-- DRAG SYSTEM
--------------------------------------------------

local function Dragify(obj)
	local drag = false
	local dragInput
	local start
	local startPos

	obj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			drag = true
			start = input.Position
			startPos = obj.Position
		end
	end)

	obj.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and drag then
			local delta = input.Position - start
			obj.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			drag = false
		end
	end)
end

Dragify(Main)
Dragify(Logo)

--------------------------------------------------
-- OPEN CLOSE
--------------------------------------------------

Logo.MouseButton1Click:Connect(function()
	if Main.Visible == false then
		Main.Visible = true
		Main.Size = UDim2.new(0,0,0,0)
		TweenService:Create(Main,TweenInfo.new(0.35),{
			Size = UDim2.new(0,540,0,320)
		}):Play()
	else
		TweenService:Create(Main,TweenInfo.new(0.25),{
			Size = UDim2.new(0,0,0,0)
		}):Play()

		task.wait(0.25)
		Main.Visible = false
	end
end)
