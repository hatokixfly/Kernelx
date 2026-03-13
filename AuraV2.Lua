--// Kernelx Paid Style Small UI
--// Script By: Nguyen Thanh Phu

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

--------------------------------------------------
-- COLORS
--------------------------------------------------

local Accent = Color3.fromRGB(255,0,0)

local Colors = {
	Color3.fromRGB(255,0,0),
	Color3.fromRGB(0,170,255),
	Color3.fromRGB(255,255,0),
	Color3.fromRGB(0,255,120),
	Color3.fromRGB(255,0,255),
	Color3.fromRGB(255,120,0),
	Color3.fromRGB(255,255,255)
}

local rainbowMode = false

local function tween(obj,props,t)
	TweenService:Create(obj,TweenInfo.new(t,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),props):Play()
end

--------------------------------------------------
-- LOGO
--------------------------------------------------

local logo = Instance.new("TextButton")
logo.Parent = gui
logo.Size = UDim2.new(0,48,0,48)
logo.Position = UDim2.new(0,20,0.5,-24)
logo.BackgroundColor3 = Color3.fromRGB(8,8,8)
logo.Text = "K"
logo.TextColor3 = Accent
logo.Font = Enum.Font.GothamBold
logo.TextScaled = true
logo.Active = true
logo.Draggable = true
Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)

local logoStroke = Instance.new("UIStroke",logo)
logoStroke.Color = Accent

--------------------------------------------------
-- MAIN MENU
--------------------------------------------------

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,450,0,290)
main.Position = UDim2.new(0.5,-225,0.5,-145)
main.BackgroundColor3 = Color3.fromRGB(10,10,10)
main.Visible = false
main.Active = true
main.Draggable = true
Instance.new("UICorner",main).CornerRadius = UDim.new(0,10)

local stroke = Instance.new("UIStroke",main)
stroke.Color = Accent

--------------------------------------------------
-- HEADER
--------------------------------------------------

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,-50,0,38)
title.BackgroundTransparency = 1
title.Text = "Kernelx"
title.TextColor3 = Accent
title.Font = Enum.Font.GothamBold
title.TextScaled = true

--------------------------------------------------
-- MINIMIZE BUTTON
--------------------------------------------------

local mini = Instance.new("TextButton")
mini.Parent = main
mini.Size = UDim2.new(0,30,0,30)
mini.Position = UDim2.new(1,-35,0,4)
mini.BackgroundColor3 = Color3.fromRGB(20,20,20)
mini.Text = "-"
mini.TextColor3 = Color3.new(1,1,1)
mini.Font = Enum.Font.GothamBold
mini.TextScaled = true
Instance.new("UICorner",mini).CornerRadius = UDim.new(1,0)

local minimized = false

mini.MouseButton1Click:Connect(function()
	if not minimized then
		tween(main,{Size=UDim2.new(0,450,0,45)},0.25)
		minimized = true
	else
		tween(main,{Size=UDim2.new(0,450,0,290)},0.25)
		minimized = false
	end
end)

--------------------------------------------------
-- TAB
--------------------------------------------------

local sidebar = Instance.new("Frame")
sidebar.Parent = main
sidebar.Size = UDim2.new(0,115,0,220)
sidebar.Position = UDim2.new(0,10,0,50)
sidebar.BackgroundColor3 = Color3.fromRGB(15,15,15)
Instance.new("UICorner",sidebar).CornerRadius = UDim.new(0,8)

local function makeTab(txt,y)
	local b = Instance.new("TextButton")
	b.Parent = sidebar
	b.Size = UDim2.new(1,-10,0,36)
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
local settingsTab = makeTab("SETTINGS",55)

--------------------------------------------------
-- CONTENT
--------------------------------------------------

local mainContent = Instance.new("Frame")
mainContent.Parent = main
mainContent.Size = UDim2.new(0,300,0,210)
mainContent.Position = UDim2.new(0,135,0,55)
mainContent.BackgroundTransparency = 1

local settingsContent = mainContent:Clone()
settingsContent.Parent = main
settingsContent.Visible = false

--------------------------------------------------
-- NOTIFY
--------------------------------------------------

local function notify(txt)
	local n = Instance.new("TextLabel")
	n.Parent = gui
	n.Size = UDim2.new(0,180,0,35)
	n.Position = UDim2.new(1,-200,0,35)
	n.BackgroundColor3 = Color3.fromRGB(10,10,10)
	n.Text = txt
	n.TextColor3 = Color3.new(1,1,1)
	n.Font = Enum.Font.GothamBold
	n.TextScaled = true
	Instance.new("UICorner",n).CornerRadius = UDim.new(0,8)
	task.delay(2,function() n:Destroy() end)
end

--------------------------------------------------
-- TOGGLE STYLE LEE HUB
--------------------------------------------------

local function createToggle(parent,name,y,callback)
	local box = Instance.new("Frame")
	box.Parent = parent
	box.Size = UDim2.new(1,0,0,42)
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
	toggle.Size = UDim2.new(0,46,0,22)
	toggle.Position = UDim2.new(1,-55,0.5,-11)
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
			tween(toggle,{BackgroundColor3=Accent},0.2)
			tween(knob,{Position=UDim2.new(1,-20,0,2)},0.2)
		else
			tween(toggle,{BackgroundColor3=Color3.fromRGB(50,50,50)},0.2)
			tween(knob,{Position=UDim2.new(0,2,0,2)},0.2)
		end
		callback(state)
	end)
end

--------------------------------------------------
-- MAIN
--------------------------------------------------

local autoSlot = false

createToggle(mainContent,"AUTO SLOT 1",10,function(v)
	autoSlot = v
end)

task.spawn(function()
	while task.wait(0.2) do
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

createToggle(mainContent,"ANTI AFK",60,function(v)
	if v then
		player.Idled:Connect(function()
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new())
		end)
	end
end)

--------------------------------------------------
-- SETTINGS COLORS
--------------------------------------------------

local selected = Colors[1]

for i,c in pairs(Colors) do
	local b = Instance.new("TextButton")
	b.Parent = settingsContent
	b.Size = UDim2.new(0,28,0,28)
	b.Position = UDim2.new(0,(i-1)*35,0,5)
	b.BackgroundColor3 = c
	b.Text = ""
	Instance.new("UICorner",b).CornerRadius = UDim.new(1,0)

	b.MouseButton1Click:Connect(function()
		selected = c
		rainbowMode = false
	end)
end

local rainbow = Instance.new("TextButton")
rainbow.Parent = settingsContent
rainbow.Size = UDim2.new(0,80,0,28)
rainbow.Position = UDim2.new(0,0,0,45)
rainbow.Text = "RAINBOW"
rainbow.Font = Enum.Font.GothamBold
rainbow.TextScaled = true
rainbow.BackgroundColor3 = Color3.fromRGB(20,20,20)
rainbow.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",rainbow).CornerRadius = UDim.new(0,8)

rainbow.MouseButton1Click:Connect(function()
	rainbowMode = true
end)

local apply = Instance.new("TextButton")
apply.Parent = settingsContent
apply.Size = UDim2.new(0,100,0,30)
apply.Position = UDim2.new(0,90,0,45)
apply.Text = "APPLY"
apply.Font = Enum.Font.GothamBold
apply.TextScaled = true
apply.BackgroundColor3 = Color3.fromRGB(20,20,20)
apply.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",apply).CornerRadius = UDim.new(0,8)

apply.MouseButton1Click:Connect(function()
	if not rainbowMode then
		Accent = selected
		title.TextColor3 = Accent
		stroke.Color = Accent
		logo.TextColor3 = Accent
		logoStroke.Color = Accent
	end
end)

task.spawn(function()
	while true do
		if rainbowMode then
			for h=0,1,0.01 do
				Accent = Color3.fromHSV(h,1,1)
				title.TextColor3 = Accent
				stroke.Color = Accent
				logo.TextColor3 = Accent
				logoStroke.Color = Accent
				task.wait()
			end
		end
		task.wait()
	end
end)

--------------------------------------------------
-- BOOST FPS
--------------------------------------------------

createToggle(settingsContent,"BOOST FPS",90,function(v)
	if v then
		Lighting.GlobalShadows = false
		for _,obj in pairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") then
				obj.Material = Enum.Material.SmoothPlastic
			end
		end
	end
end)

--------------------------------------------------
-- CREDIT
--------------------------------------------------

local credit = Instance.new("TextLabel")
credit.Parent = settingsContent
credit.Size = UDim2.new(1,0,0,20)
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
end)

settingsTab.MouseButton1Click:Connect(function()
	mainContent.Visible = false
	settingsContent.Visible = true
end)

--------------------------------------------------
-- OPEN
--------------------------------------------------

logo.MouseButton1Click:Connect(function()
	if not main.Visible then
		main.Visible = true
		main.Size = UDim2.new(0,0,0,0)
		tween(main,{Size=UDim2.new(0,450,0,290)},0.25)
	else
		tween(main,{Size=UDim2.new(0,0,0,0)},0.25)
		task.wait(0.25)
		main.Visible = false
	end
end)
