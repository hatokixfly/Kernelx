--// Kernelx Premium UI
--// Script By: Nguyen Thanh Phu

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "KernelxPremium"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

--------------------------------------------------
-- COLOR SYSTEM
--------------------------------------------------

local Accent = Color3.fromRGB(255, 0, 0)

local function tween(obj, props, t)
	TweenService:Create(obj, TweenInfo.new(t, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props):Play()
end

--------------------------------------------------
-- LOGO BUTTON
--------------------------------------------------

local logo = Instance.new("TextButton")
logo.Parent = gui
logo.Size = UDim2.new(0, 62, 0, 62)
logo.Position = UDim2.new(0, 35, 0.5, -31)
logo.BackgroundColor3 = Color3.fromRGB(8,8,8)
logo.Text = "K"
logo.TextColor3 = Accent
logo.Font = Enum.Font.GothamBold
logo.TextScaled = true
logo.Active = true
logo.Draggable = true
Instance.new("UICorner", logo).CornerRadius = UDim.new(1,0)

local logoStroke = Instance.new("UIStroke", logo)
logoStroke.Color = Accent
logoStroke.Thickness = 1.5

--------------------------------------------------
-- MAIN MENU
--------------------------------------------------

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0, 720, 0, 460)
main.Position = UDim2.new(0.5, -360, 0.5, -230)
main.BackgroundColor3 = Color3.fromRGB(10,10,10)
main.Visible = false
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Accent
stroke.Thickness = 1.2

--------------------------------------------------
-- HEADER
--------------------------------------------------

local header = Instance.new("Frame")
header.Parent = main
header.Size = UDim2.new(1,0,0,55)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel")
title.Parent = header
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Text = "Kernelx"
title.TextColor3 = Accent
title.Font = Enum.Font.GothamBold
title.TextScaled = true

--------------------------------------------------
-- CREDIT RAINBOW
--------------------------------------------------

local credit = Instance.new("TextLabel")
credit.Parent = main
credit.Size = UDim2.new(1,0,0,25)
credit.Position = UDim2.new(0,0,1,-25)
credit.BackgroundTransparency = 1
credit.Text = "Script By: Nguyen Thanh Phu"
credit.Font = Enum.Font.GothamBold
credit.TextScaled = true

task.spawn(function()
	while true do
		for h = 0,1,0.01 do
			credit.TextColor3 = Color3.fromHSV(h,1,1)
			task.wait()
		end
	end
end)

--------------------------------------------------
-- TAB LEFT
--------------------------------------------------

local sidebar = Instance.new("Frame")
sidebar.Parent = main
sidebar.Size = UDim2.new(0,180,1,-80)
sidebar.Position = UDim2.new(0,15,0,65)
sidebar.BackgroundColor3 = Color3.fromRGB(15,15,15)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,10)

local function makeTab(text, y)
	local b = Instance.new("TextButton")
	b.Parent = sidebar
	b.Size = UDim2.new(1,-20,0,45)
	b.Position = UDim2.new(0,10,0,y)
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.Text = text
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextScaled = true
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

local mainTab = makeTab("MAIN",20)
local settingsTab = makeTab("SETTINGS",75)

--------------------------------------------------
-- CONTENT FRAME
--------------------------------------------------

local content = Instance.new("Frame")
content.Parent = main
content.Size = UDim2.new(0,500,0,340)
content.Position = UDim2.new(0,205,0,75)
content.BackgroundTransparency = 1

--------------------------------------------------
-- PREMIUM NOTIFICATION
--------------------------------------------------

local function notify(txt)
	local n = Instance.new("Frame")
	n.Parent = gui
	n.Size = UDim2.new(0,250,0,50)
	n.Position = UDim2.new(1,-270,0,50)
	n.BackgroundColor3 = Color3.fromRGB(10,10,10)
	Instance.new("UICorner", n).CornerRadius = UDim.new(0,10)

	local st = Instance.new("UIStroke", n)
	st.Color = Accent

	local t = Instance.new("TextLabel")
	t.Parent = n
	t.Size = UDim2.new(1,0,1,0)
	t.BackgroundTransparency = 1
	t.Text = txt
	t.TextColor3 = Color3.new(1,1,1)
	t.Font = Enum.Font.GothamBold
	t.TextScaled = true

	tween(n,{Position = UDim2.new(1,-270,0,80)},0.25)
	task.wait(2)
	tween(n,{Position = UDim2.new(1,50,0,80)},0.25)
	task.wait(0.3)
	n:Destroy()
end

--------------------------------------------------
-- TOGGLE CREATOR
--------------------------------------------------

local function createToggle(name,y,callback)
	local holder = Instance.new("Frame")
	holder.Parent = content
	holder.Size = UDim2.new(1,0,0,50)
	holder.Position = UDim2.new(0,0,0,y)
	holder.BackgroundColor3 = Color3.fromRGB(15,15,15)
	Instance.new("UICorner", holder).CornerRadius = UDim.new(0,10)

	local txt = Instance.new("TextLabel")
	txt.Parent = holder
	txt.Size = UDim2.new(0.7,0,1,0)
	txt.BackgroundTransparency = 1
	txt.Text = name
	txt.TextColor3 = Color3.new(1,1,1)
	txt.Font = Enum.Font.GothamBold
	txt.TextScaled = true

	local toggle = Instance.new("TextButton")
	toggle.Parent = holder
	toggle.Size = UDim2.new(0,55,0,28)
	toggle.Position = UDim2.new(1,-70,0.5,-14)
	toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
	toggle.Text = ""
	Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)

	local knob = Instance.new("Frame")
	knob.Parent = toggle
	knob.Size = UDim2.new(0,24,0,24)
	knob.Position = UDim2.new(0,2,0,2)
	knob.BackgroundColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

	local state = false

	toggle.MouseButton1Click:Connect(function()
		state = not state

		if state then
			tween(toggle,{BackgroundColor3 = Accent},0.2)
			tween(knob,{Position = UDim2.new(1,-26,0,2)},0.2)
			notify(name.." ENABLED")
		else
			tween(toggle,{BackgroundColor3 = Color3.fromRGB(40,40,40)},0.2)
			tween(knob,{Position = UDim2.new(0,2,0,2)},0.2)
			notify(name.." DISABLED")
		end

		callback(state)
	end)
end

--------------------------------------------------
-- MAIN FEATURES
--------------------------------------------------

createToggle("ANTI AFK",20,function(v)
	if v then
		player.Idled:Connect(function()
			VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			task.wait(1)
			VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
	end
end)

--------------------------------------------------
-- SETTINGS
--------------------------------------------------

createToggle("BOOST FPS",90,function(v)
	if v then
		for _,obj in pairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") then
				obj.Material = Enum.Material.SmoothPlastic
			end
		end
	end
end)

--------------------------------------------------
-- LOGO OPEN/CLOSE
--------------------------------------------------

logo.MouseButton1Click:Connect(function()
	if main.Visible == false then
		main.Visible = true
		main.Size = UDim2.new(0,0,0,0)
		tween(main,{Size = UDim2.new(0,720,0,460)},0.25)
	else
		tween(main,{Size = UDim2.new(0,0,0,0)},0.25)
		task.wait(0.25)
		main.Visible = false
	end
end)
