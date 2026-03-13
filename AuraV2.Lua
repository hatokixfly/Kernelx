--// Kernelx Paid Small UI Fixed
--// Script By: Nguyen Thanh Phu

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false
gui.Name = "KernelxUI"

--------------------------------------------------
-- CONFIG
--------------------------------------------------

local Accent = Color3.fromRGB(255,0,0)

local ColorNames = {
	{"RED", Color3.fromRGB(255,0,0)},
	{"BLUE", Color3.fromRGB(0,170,255)},
	{"YELLOW", Color3.fromRGB(255,255,0)},
	{"GREEN", Color3.fromRGB(0,255,120)},
	{"PINK", Color3.fromRGB(255,0,255)},
	{"ORANGE", Color3.fromRGB(255,120,0)},
	{"WHITE", Color3.fromRGB(255,255,255)}
}

local function tween(obj,props,t)
	TweenService:Create(obj,TweenInfo.new(t,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),props):Play()
end

--------------------------------------------------
-- LOGO
--------------------------------------------------

local logo = Instance.new("TextButton")
logo.Parent = gui
logo.Size = UDim2.new(0,46,0,46)
logo.Position = UDim2.new(0,20,0.5,-23)
logo.BackgroundColor3 = Color3.fromRGB(10,10,10)
logo.Text = "K"
logo.TextColor3 = Accent
logo.Font = Enum.Font.GothamBold
logo.TextScaled = true
logo.Active = true
logo.Draggable = true
Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)

local logoStroke = Instance.new("UIStroke",logo)
logoStroke.Color = Accent
logoStroke.Thickness = 1.4

--------------------------------------------------
-- MAIN FRAME
--------------------------------------------------

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,390,0,250)
main.Position = UDim2.new(0.5,-195,0.5,-125)
main.BackgroundColor3 = Color3.fromRGB(10,10,10)
main.Visible = false
main.Active = true
main.Draggable = true
main.ClipsDescendants = true
Instance.new("UICorner",main).CornerRadius = UDim.new(0,10)

local stroke = Instance.new("UIStroke",main)
stroke.Color = Accent
stroke.Thickness = 1.2

--------------------------------------------------
-- HEADER
--------------------------------------------------

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,36)
title.BackgroundTransparency = 1
title.Text = "Kernelx"
title.TextColor3 = Accent
title.Font = Enum.Font.GothamBold
title.TextScaled = true

--------------------------------------------------
-- SIDEBAR
--------------------------------------------------

local sidebar = Instance.new("Frame")
sidebar.Parent = main
sidebar.Size = UDim2.new(0,100,0,185)
sidebar.Position = UDim2.new(0,10,0,48)
sidebar.BackgroundColor3 = Color3.fromRGB(15,15,15)
Instance.new("UICorner",sidebar).CornerRadius = UDim.new(0,8)

local function makeTab(txt,y)
	local b = Instance.new("TextButton")
	b.Parent = sidebar
	b.Size = UDim2.new(1,-10,0,34)
	b.Position = UDim2.new(0,5,0,y)
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.Text = txt
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextScaled = true
	Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)
	return b
end

local mainTab = makeTab("MAIN",10)
local settingsTab = makeTab("SETTINGS",52)

--------------------------------------------------
-- CONTENT
--------------------------------------------------

local mainContent = Instance.new("Frame")
mainContent.Parent = main
mainContent.Size = UDim2.new(0,260,0,185)
mainContent.Position = UDim2.new(0,120,0,48)
mainContent.BackgroundTransparency = 1

local settingsContent = Instance.new("Frame")
settingsContent.Parent = main
settingsContent.Size = UDim2.new(0,260,0,185)
settingsContent.Position = UDim2.new(0,120,0,48)
settingsContent.BackgroundTransparency = 1
settingsContent.Visible = false

--------------------------------------------------
-- NOTIFY
--------------------------------------------------

local function notify(txt)
	local n = Instance.new("Frame")
	n.Parent = gui
	n.Size = UDim2.new(0,190,0,36)
	n.Position = UDim2.new(1,-210,0,30)
	n.BackgroundColor3 = Color3.fromRGB(10,10,10)
	Instance.new("UICorner",n).CornerRadius = UDim.new(0,8)

	local ns = Instance.new("UIStroke",n)
	ns.Color = Accent

	local t = Instance.new("TextLabel")
	t.Parent = n
	t.Size = UDim2.new(1,0,1,0)
	t.BackgroundTransparency = 1
	t.Text = txt
	t.TextColor3 = Color3.new(1,1,1)
	t.Font = Enum.Font.GothamBold
	t.TextScaled = true

	n.BackgroundTransparency = 1
	t.TextTransparency = 1

	tween(n,{BackgroundTransparency=0},0.2)
	tween(t,{TextTransparency=0},0.2)

	task.delay(2,function()
		tween(n,{BackgroundTransparency=1},0.2)
		tween(t,{TextTransparency=1},0.2)
		task.wait(0.2)
		n:Destroy()
	end)
end

--------------------------------------------------
-- TOGGLE
--------------------------------------------------

local function createToggle(parent,name,y,callback)
	local box = Instance.new("Frame")
	box.Parent = parent
	box.Size = UDim2.new(1,0,0,40)
	box.Position = UDim2.new(0,0,0,y)
	box.BackgroundColor3 = Color3.fromRGB(15,15,15)
	Instance.new("UICorner",box).CornerRadius = UDim.new(0,8)

	local txt = Instance.new("TextLabel")
	txt.Parent = box
	txt.Size = UDim2.new(0.7,0,1,0)
	txt.BackgroundTransparency = 1
	txt.Text = name
	txt.TextColor3 = Color3.new(1,1,1)
	txt.Font = Enum.Font.GothamBold
	txt.TextScaled = true

	local toggle = Instance.new("TextButton")
	toggle.Parent = box
	toggle.Size = UDim2.new(0,44,0,22)
	toggle.Position = UDim2.new(1,-52,0.5,-11)
	toggle.BackgroundColor3 = Color3.fromRGB(50,50,50)
	toggle.Text = ""
	Instance.new("UICorner",toggle).CornerRadius = UDim.new(1,0)

	local knob = Instance.new("Frame")
	knob.Parent = toggle
	knob.Size = UDim2.new(0,18,0,18)
	knob.Position = UDim2.new(0,2,0,2)
	knob.BackgroundColor3 = Color3.new(1,1,1)
	Instance.new("UICorner",knob).CornerRadius = UDim.new(1,0)

	local state = false

	toggle.MouseButton1Click:Connect(function()
		state = not state
		if state then
			tween(toggle,{BackgroundColor3=Accent},0.18)
			tween(knob,{Position=UDim2.new(1,-20,0,2)},0.18)
			notify(name.." ENABLED")
		else
			tween(toggle,{BackgroundColor3=Color3.fromRGB(50,50,50)},0.18)
			tween(knob,{Position=UDim2.new(0,2,0,2)},0.18)
			notify(name.." DISABLED")
		end
		callback(state)
	end)
end

--------------------------------------------------
-- MAIN FUNCTIONS
--------------------------------------------------

local autoSlot = false

createToggle(mainContent,"AURA KILL",10,function(v)
	autoSlot = v
end)

task.spawn(function()
	while task.wait(0.08) do
		if autoSlot then
			local char = player.Character
			if char and not char:FindFirstChildOfClass("Tool") then
				local tool = backpack:FindFirstChildOfClass("Tool")
				if tool then
					char.Humanoid:EquipTool(tool)
				end
			end
		end
	end
end)

createToggle(mainContent,"BẤT TỬ",58,function(v)
	if v then
		player.Idled:Connect(function()
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new())
		end)
	end
end)

--------------------------------------------------
-- SETTINGS COLOR SELECT TEXT
--------------------------------------------------

local selectedIndex = 1

local colorLabel = Instance.new("TextLabel")
colorLabel.Parent = settingsContent
colorLabel.Size = UDim2.new(0,150,0,30)
colorLabel.Position = UDim2.new(0,0,0,8)
colorLabel.BackgroundColor3 = Color3.fromRGB(15,15,15)
colorLabel.Text = ColorNames[selectedIndex][1]
colorLabel.TextColor3 = Color3.new(1,1,1)
colorLabel.Font = Enum.Font.GothamBold
colorLabel.TextScaled = true
Instance.new("UICorner",colorLabel).CornerRadius = UDim.new(0,8)

local left = Instance.new("TextButton")
left.Parent = settingsContent
left.Size = UDim2.new(0,30,0,30)
left.Position = UDim2.new(0,160,0,8)
left.Text = "<"
left.BackgroundColor3 = Color3.fromRGB(20,20,20)
left.TextColor3 = Color3.new(1,1,1)
left.Font = Enum.Font.GothamBold
left.TextScaled = true
Instance.new("UICorner",left).CornerRadius = UDim.new(0,8)

local right = Instance.new("TextButton")
right.Parent = settingsContent
right.Size = UDim2.new(0,30,0,30)
right.Position = UDim2.new(0,195,0,8)
right.Text = ">"
right.BackgroundColor3 = Color3.fromRGB(20,20,20)
right.TextColor3 = Color3.new(1,1,1)
right.Font = Enum.Font.GothamBold
right.TextScaled = true
Instance.new("UICorner",right).CornerRadius = UDim.new(0,8)

left.MouseButton1Click:Connect(function()
	selectedIndex -= 1
	if selectedIndex < 1 then selectedIndex = #ColorNames end
	colorLabel.Text = ColorNames[selectedIndex][1]
end)

right.MouseButton1Click:Connect(function()
	selectedIndex += 1
	if selectedIndex > #ColorNames then selectedIndex = 1 end
	colorLabel.Text = ColorNames[selectedIndex][1]
end)

local apply = Instance.new("TextButton")
apply.Parent = settingsContent
apply.Size = UDim2.new(0,100,0,30)
apply.Position = UDim2.new(0,0,0,50)
apply.BackgroundColor3 = Color3.fromRGB(20,20,20)
apply.Text = "APPLY"
apply.TextColor3 = Color3.new(1,1,1)
apply.Font = Enum.Font.GothamBold
apply.TextScaled = true
Instance.new("UICorner",apply).CornerRadius = UDim.new(0,8)

apply.MouseButton1Click:Connect(function()
	Accent = ColorNames[selectedIndex][2]
	title.TextColor3 = Accent
	stroke.Color = Accent
	logo.TextColor3 = Accent
	logoStroke.Color = Accent
	notify("MENU COLOR "..ColorNames[selectedIndex][1])
end)

--------------------------------------------------
-- CREDIT
--------------------------------------------------

local credit = Instance.new("TextLabel")
credit.Parent = settingsContent
credit.Size = UDim2.new(1,0,0,18)
credit.Position = UDim2.new(0,0,1,-20)
credit.BackgroundTransparency = 1
credit.Text = "Script By: Nguyen Thanh Phu"
credit.Font = Enum.Font.GothamBold
credit.TextScaled = true

task.spawn(function()
	while true do
		for h=0,1,0.01 do
			credit.TextColor3 = Color3.fromHSV(h,1,1)
			task.wait()
		end
	end
end)

--------------------------------------------------
-- TAB SWITCH
--------------------------------------------------

mainTab.MouseButton1Click:Connect(function()
	mainContent.Visible = true
	settingsContent.Visible = false
	mainTab.BackgroundColor3 = Accent
	settingsTab.BackgroundColor3 = Color3.fromRGB(20,20,20)
end)

settingsTab.MouseButton1Click:Connect(function()
	mainContent.Visible = false
	settingsContent.Visible = true
	settingsTab.BackgroundColor3 = Accent
	mainTab.BackgroundColor3 = Color3.fromRGB(20,20,20)
end)

mainTab.BackgroundColor3 = Accent

--------------------------------------------------
-- OPEN / CLOSE FIX
--------------------------------------------------

local opened = false

logo.MouseButton1Click:Connect(function()
	if not opened then
		opened = true
		main.Visible = true
		main.Size = UDim2.new(0,0,0,0)
		mainContent.Visible = true
		settingsContent.Visible = false
		tween(main,{Size=UDim2.new(0,390,0,250)},0.22)
	else
		opened = false
		tween(main,{Size=UDim2.new(0,0,0,0)},0.22)
		task.wait(0.22)
		main.Visible = false
	end
end)
