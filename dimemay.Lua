--// PhuBaBy Premium GUI
--// Premium Dark Red Style

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "PhuBaByGUI"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

--------------------------------------------------
-- MAIN COLORS
--------------------------------------------------

local dark = Color3.fromRGB(15,15,15)
local dark2 = Color3.fromRGB(22,22,22)
local red = Color3.fromRGB(255,40,40)

--------------------------------------------------
-- LOGO BUTTON
--------------------------------------------------

local logo = Instance.new("TextButton")
logo.Parent = gui
logo.Size = UDim2.new(0,60,0,60)
logo.Position = UDim2.new(0,20,0.4,0)
logo.Text = "P"
logo.TextColor3 = Color3.new(1,1,1)
logo.TextScaled = true
logo.Font = Enum.Font.GothamBold
logo.BackgroundColor3 = dark2
logo.AutoButtonColor = false

local logoCorner = Instance.new("UICorner",logo)
logoCorner.CornerRadius = UDim.new(1,0)

local logoStroke = Instance.new("UIStroke",logo)
logoStroke.Color = red
logoStroke.Thickness = 2

local logoGlow = Instance.new("UIStroke",logo)
logoGlow.Color = red
logoGlow.Transparency = 0.5
logoGlow.Thickness = 4

--------------------------------------------------
-- DRAG LOGO
--------------------------------------------------

local dragging = false
local dragStart
local startPos

logo.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = logo.Position
	end
end)

logo.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		logo.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

--------------------------------------------------
-- MAIN FRAME
--------------------------------------------------

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,520,0,340)
frame.Position = UDim2.new(0.5,-260,0.5,-170)
frame.BackgroundColor3 = dark
frame.Visible = false

local corner = Instance.new("UICorner",frame)
corner.CornerRadius = UDim.new(0,16)

local stroke = Instance.new("UIStroke",frame)
stroke.Color = red
stroke.Transparency = 0.3

--------------------------------------------------
-- SHADOW
--------------------------------------------------

local shadow = Instance.new("ImageLabel")
shadow.Parent = frame
shadow.Size = UDim2.new(1,30,1,30)
shadow.Position = UDim2.new(0,-15,0,-15)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10,10,118,118)
shadow.ZIndex = 0

--------------------------------------------------
-- HEADER
--------------------------------------------------

local header = Instance.new("Frame")
header.Parent = frame
header.Size = UDim2.new(1,0,0,50)
header.BackgroundColor3 = dark2

local headerCorner = Instance.new("UICorner",header)
headerCorner.CornerRadius = UDim.new(0,16)

local title = Instance.new("TextLabel")
title.Parent = header
title.Size = UDim2.new(0.6,0,1,0)
title.Position = UDim2.new(0.03,0,0,0)
title.BackgroundTransparency = 1
title.Text = "PhuBaBy"
title.Font = Enum.Font.GothamBold
title.TextScaled = true

--------------------------------------------------
-- RAINBOW TITLE
--------------------------------------------------

task.spawn(function()
	while true do
		for i=0,1,0.01 do
			title.TextColor3 = Color3.fromHSV(i,1,1)
			task.wait(0.03)
		end
	end
end)

--------------------------------------------------
-- CLOSE BUTTON
--------------------------------------------------

local close = Instance.new("TextButton")
close.Parent = header
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-45,0.1,0)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = red

local closeCorner = Instance.new("UICorner",close)

--------------------------------------------------
-- TAB PANEL
--------------------------------------------------

local tabPanel = Instance.new("Frame")
tabPanel.Parent = frame
tabPanel.Size = UDim2.new(0,120,1,-50)
tabPanel.Position = UDim2.new(0,0,0,50)
tabPanel.BackgroundColor3 = dark2

local mainTab = Instance.new("TextButton")
mainTab.Parent = tabPanel
mainTab.Size = UDim2.new(1,0,0,50)
mainTab.Text = "MAIN"
mainTab.BackgroundColor3 = red
mainTab.TextColor3 = Color3.new(1,1,1)
mainTab.Font = Enum.Font.GothamBold

local settingsTab = Instance.new("TextButton")
settingsTab.Parent = tabPanel
settingsTab.Position = UDim2.new(0,0,0,55)
settingsTab.Size = UDim2.new(1,0,0,50)
settingsTab.Text = "SETTINGS"
settingsTab.BackgroundColor3 = dark
settingsTab.TextColor3 = Color3.new(1,1,1)
settingsTab.Font = Enum.Font.GothamBold

--------------------------------------------------
-- CONTENT
--------------------------------------------------

local content = Instance.new("Frame")
content.Parent = frame
content.Position = UDim2.new(0,130,0,60)
content.Size = UDim2.new(1,-140,1,-70)
content.BackgroundTransparency = 1

--------------------------------------------------
-- NOTIFICATION
--------------------------------------------------

local function notify(text)
	local n = Instance.new("TextLabel")
	n.Parent = gui
	n.Size = UDim2.new(0,220,0,50)
	n.Position = UDim2.new(1,250,0.1,0)
	n.BackgroundColor3 = dark2
	n.Text = text
	n.TextColor3 = Color3.new(1,1,1)
	n.Font = Enum.Font.GothamBold
	n.TextScaled = true
	
	local c = Instance.new("UICorner",n)
	
	TweenService:Create(n,TweenInfo.new(0.4),{
		Position = UDim2.new(1,-240,0.1,0)
	}):Play()
	
	task.wait(2)
	
	TweenService:Create(n,TweenInfo.new(0.4),{
		TextTransparency = 1,
		BackgroundTransparency = 1
	}):Play()
	
	task.wait(0.4)
	n:Destroy()
end

--------------------------------------------------
-- TOGGLE CREATOR
--------------------------------------------------

local y = 0

local function createToggle(name)
	local btn = Instance.new("TextButton")
	btn.Parent = content
	btn.Size = UDim2.new(1,0,0,45)
	btn.Position = UDim2.new(0,0,0,y)
	btn.BackgroundColor3 = dark2
	btn.Text = name
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	
	local state = false
	
	btn.MouseButton1Click:Connect(function()
		state = not state
		
		if state then
			btn.BackgroundColor3 = red
			notify("[✓] Auto Enabled")
		else
			btn.BackgroundColor3 = dark2
			notify("[✕] Auto Disabled")
		end
	end)
	
	local c = Instance.new("UICorner",btn)
	
	y += 55
end

--------------------------------------------------
-- MAIN TOGGLES
--------------------------------------------------

createToggle("Auto Collect")
createToggle("Auto Bring Pet")
createToggle("Auto Farm")
createToggle("Auto Teleport Base")

--------------------------------------------------
-- OPEN CLOSE
--------------------------------------------------

local opened = false

logo.MouseButton1Click:Connect(function()
	opened = not opened
	
	if opened then
		frame.Visible = true
		frame.Size = UDim2.new(0,0,0,0)
		
		TweenService:Create(frame,TweenInfo.new(0.35),{
			Size = UDim2.new(0,520,0,340)
		}):Play()
	else
		local tw = TweenService:Create(frame,TweenInfo.new(0.3),{
			Size = UDim2.new(0,0,0,0)
		})
		
		tw:Play()
		tw.Completed:Wait()
		frame.Visible = false
	end
end)

close.MouseButton1Click:Connect(function()
	frame.Visible = false
	opened = false
end)
