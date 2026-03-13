--// Kernelx Premium Small UI
--// Script By: Nguyen Thanh Phu

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

--------------------------------------------------
-- COLOR SYSTEM
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

local function tween(obj,props,t)
	TweenService:Create(obj,TweenInfo.new(t,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),props):Play()
end

--------------------------------------------------
-- LOGO
--------------------------------------------------

local logo = Instance.new("TextButton")
logo.Parent = gui
logo.Size = UDim2.new(0,55,0,55)
logo.Position = UDim2.new(0,25,0.5,-27)
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

--------------------------------------------------
-- MAIN MENU
--------------------------------------------------

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,520,0,330)
main.Position = UDim2.new(0.5,-260,0.5,-165)
main.BackgroundColor3 = Color3.fromRGB(10,10,10)
main.Visible = false
main.Active = true
main.Draggable = true
Instance.new("UICorner",main).CornerRadius = UDim.new(0,12)

local stroke = Instance.new("UIStroke",main)
stroke.Color = Accent

--------------------------------------------------
-- HEADER
--------------------------------------------------

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,45)
title.BackgroundTransparency = 1
title.Text = "Kernelx"
title.TextColor3 = Accent
title.Font = Enum.Font.GothamBold
title.TextScaled = true

--------------------------------------------------
-- TAB
--------------------------------------------------

local sidebar = Instance.new("Frame")
sidebar.Parent = main
sidebar.Size = UDim2.new(0,130,0,250)
sidebar.Position = UDim2.new(0,10,0,55)
sidebar.BackgroundColor3 = Color3.fromRGB(15,15,15)
Instance.new("UICorner",sidebar).CornerRadius = UDim.new(0,10)

local function makeTab(txt,y)
	local b = Instance.new("TextButton")
	b.Parent = sidebar
	b.Size = UDim2.new(1,-10,0,40)
	b.Position = UDim2.new(0,5,0,y)
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.Text = txt
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextScaled = true
	Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)
	return b
end

local mainTab = makeTab("MAIN",15)
local settingsTab = makeTab("SETTINGS",65)

--------------------------------------------------
-- CONTENTS
--------------------------------------------------

local mainContent = Instance.new("Frame")
mainContent.Parent = main
mainContent.Size = UDim2.new(0,360,0,230)
mainContent.Position = UDim2.new(0,150,0,65)
mainContent.BackgroundTransparency = 1

local settingsContent = mainContent:Clone()
settingsContent.Parent = main
settingsContent.Visible = false

--------------------------------------------------
-- NOTIFY
--------------------------------------------------

local function notify(text)
	local n = Instance.new("TextLabel")
	n.Parent = gui
	n.Size = UDim2.new(0,220,0,40)
	n.Position = UDim2.new(1,-240,0,40)
	n.BackgroundColor3 = Color3.fromRGB(10,10,10)
	n.Text = text
	n.TextColor3 = Color3.new(1,1,1)
	n.Font = Enum.Font.GothamBold
	n.TextScaled = true
	Instance.new("UICorner",n).CornerRadius = UDim.new(0,8)

	tween(n,{Position=UDim2.new(1,-240,0,70)},0.2)
	task.wait(2)
	tween(n,{Position=UDim2.new(1,50,0,70)},0.2)
	task.wait(0.3)
	n:Destroy()
end

--------------------------------------------------
-- TOGGLE
--------------------------------------------------

local function createToggle(parent,name,y,callback)
	local holder = Instance.new("Frame")
	holder.Parent = parent
	holder.Size = UDim2.new(1,0,0,45)
	holder.Position = UDim2.new(0,0,0,y)
	holder.BackgroundColor3 = Color3.fromRGB(15,15,15)
	Instance.new("UICorner",holder).CornerRadius = UDim.new(0,8)

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
	toggle.Size = UDim2.new(0,50,0,24)
	toggle.Position = UDim2.new(1,-60,0.5,-12)
	toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
	toggle.Text = ""
	Instance.new("UICorner",toggle).CornerRadius = UDim.new(1,0)

	local knob = Instance.new("Frame")
	knob.Parent = toggle
	knob.Size = UDim2.new(0,20,0,20)
	knob.Position = UDim2.new(0,2,0,2)
	knob.BackgroundColor3 = Color3.new(1,1,1)
	Instance.new("UICorner",knob).CornerRadius = UDim.new(1,0)

	local state = false

	toggle.MouseButton1Click:Connect(function()
		state = not state
		if state then
			tween(toggle,{BackgroundColor3=Accent},0.2)
			tween(knob,{Position=UDim2.new(1,-22,0,2)},0.2)
			notify(name.." ON")
		else
			tween(toggle,{BackgroundColor3=Color3.fromRGB(40,40,40)},0.2)
			tween(knob,{Position=UDim2.new(0,2,0,2)},0.2)
			notify(name.." OFF")
		end
		callback(state)
	end)
end

--------------------------------------------------
-- MAIN FUNCTIONS
--------------------------------------------------

local autoSlot = false

createToggle(mainContent,"AUTO SLOT 1",10,function(v)
	autoSlot = v
end)

task.spawn(function()
	while task.wait(1) do
		if autoSlot then
			if not player.Character:FindFirstChildOfClass("Tool") then
				local tool = backpack:FindFirstChildOfClass("Tool")
				if tool then
					player.Character.Humanoid:EquipTool(tool)
				end
			end
		end
	end
end)

createToggle(mainContent,"ANTI AFK",65,function(v)
	if v then
		player.Idled:Connect(function()
			VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			task.wait(1)
			VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
	end
end)

--------------------------------------------------
-- SETTINGS COLOR PICKER
--------------------------------------------------

local selected = Colors[1]

for i,color in pairs(Colors) do
	local c = Instance.new("TextButton")
	c.Parent = settingsContent
	c.Size = UDim2.new(0,35,0,35)
	c.Position = UDim2.new(0,(i-1)*45,0,10)
	c.BackgroundColor3 = color
	c.Text = ""
	Instance.new("UICorner",c).CornerRadius = UDim.new(1,0)

	c.MouseButton1Click:Connect(function()
		selected = color
	end)
end

local apply = Instance.new("TextButton")
apply.Parent = settingsContent
apply.Size = UDim2.new(0,120,0,35)
apply.Position = UDim2.new(0,0,0,60)
apply.BackgroundColor3 = Color3.fromRGB(20,20,20)
apply.Text = "APPLY"
apply.TextColor3 = Color3.new(1,1,1)
apply.Font = Enum.Font.GothamBold
apply.TextScaled = true
Instance.new("UICorner",apply).CornerRadius = UDim.new(0,8)

apply.MouseButton1Click:Connect(function()
	Accent = selected
	title.TextColor3 = Accent
	stroke.Color = Accent
	logo.TextColor3 = Accent
	logoStroke.Color = Accent
	notify("MENU COLOR CHANGED")
end)

--------------------------------------------------
-- SETTINGS CREDIT
--------------------------------------------------

local credit = Instance.new("TextLabel")
credit.Parent = settingsContent
credit.Size = UDim2.new(1,0,0,25)
credit.Position = UDim2.new(0,0,1,-25)
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
-- OPEN MENU
--------------------------------------------------

logo.MouseButton1Click:Connect(function()
	if not main.Visible then
		main.Visible = true
		main.Size = UDim2.new(0,0,0,0)
		tween(main,{Size=UDim2.new(0,520,0,330)},0.25)
	else
		tween(main,{Size=UDim2.new(0,0,0,0)},0.25)
		task.wait(0.25)
		main.Visible = false
	end
end)
