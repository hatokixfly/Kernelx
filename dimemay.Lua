--// PhuBaBy Premium GUI Fixed Logic
--// Clean Version

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local gui = Instance.new("ScreenGui")
gui.Name = "PhuBaByGUI"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

--------------------------------------------------
-- STATE
--------------------------------------------------

local savedBase = nil
local autoJump = false
local spinCam = false
local antiAfk = false

--------------------------------------------------
-- COLORS
--------------------------------------------------

local dark = Color3.fromRGB(15,15,15)
local dark2 = Color3.fromRGB(22,22,22)
local red = Color3.fromRGB(255,40,40)

--------------------------------------------------
-- LOGO
--------------------------------------------------

local logo = Instance.new("TextButton")
logo.Parent = gui
logo.Size = UDim2.new(0,60,0,60)
logo.Position = UDim2.new(0,20,0.4,0)
logo.Text = "P"
logo.TextScaled = true
logo.Font = Enum.Font.GothamBold
logo.TextColor3 = Color3.new(1,1,1)
logo.BackgroundColor3 = dark2

Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)

local stroke = Instance.new("UIStroke",logo)
stroke.Color = red
stroke.Thickness = 2

--------------------------------------------------
-- FRAME
--------------------------------------------------

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,520,0,340)
frame.Position = UDim2.new(0.5,-260,0.5,-170)
frame.BackgroundColor3 = dark
frame.Visible = false

Instance.new("UICorner",frame).CornerRadius = UDim.new(0,16)

--------------------------------------------------
-- HEADER
--------------------------------------------------

local header = Instance.new("Frame")
header.Parent = frame
header.Size = UDim2.new(1,0,0,50)
header.BackgroundColor3 = dark2

local title = Instance.new("TextLabel")
title.Parent = header
title.Size = UDim2.new(0.6,0,1,0)
title.Position = UDim2.new(0.03,0,0,0)
title.BackgroundTransparency = 1
title.Text = "PhuBaBy"
title.Font = Enum.Font.GothamBold
title.TextScaled = true

task.spawn(function()
	while true do
		for i=0,1,0.01 do
			title.TextColor3 = Color3.fromHSV(i,1,1)
			task.wait(0.03)
		end
	end
end)

--------------------------------------------------
-- CLOSE
--------------------------------------------------

local close = Instance.new("TextButton")
close.Parent = header
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-45,0.1,0)
close.Text = "X"
close.BackgroundColor3 = red
close.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",close)

--------------------------------------------------
-- CONTENT
--------------------------------------------------

local content = Instance.new("Frame")
content.Parent = frame
content.Position = UDim2.new(0,20,0,70)
content.Size = UDim2.new(1,-40,1,-90)
content.BackgroundTransparency = 1

--------------------------------------------------
-- NOTIFY
--------------------------------------------------

local function notify(txt)
	local n = Instance.new("TextLabel")
	n.Parent = gui
	n.Size = UDim2.new(0,220,0,50)
	n.Position = UDim2.new(1,250,0.1,0)
	n.BackgroundColor3 = dark2
	n.Text = txt
	n.TextColor3 = Color3.new(1,1,1)
	n.Font = Enum.Font.GothamBold
	n.TextScaled = true

	Instance.new("UICorner",n)

	TweenService:Create(n,TweenInfo.new(0.4), {
		Position = UDim2.new(1,-240,0.1,0)
	}):Play()

	task.wait(2)

	TweenService:Create(n,TweenInfo.new(0.4), {
		TextTransparency = 1,
		BackgroundTransparency = 1
	}):Play()

	task.wait(0.4)
	n:Destroy()
end

--------------------------------------------------
-- BUTTON MAKER
--------------------------------------------------

local y = 0

local function createButton(name, callback)
	local btn = Instance.new("TextButton")
	btn.Parent = content
	btn.Size = UDim2.new(1,0,0,45)
	btn.Position = UDim2.new(0,0,0,y)
	btn.BackgroundColor3 = dark2
	btn.Text = name
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold

	Instance.new("UICorner",btn)

	btn.MouseButton1Click:Connect(callback)

	y += 55
end

--------------------------------------------------
-- SAVE BASE
--------------------------------------------------

createButton("Save Base Position", function()
	savedBase = hrp.CFrame
	notify("[✓] Base Saved")
end)

--------------------------------------------------
-- TELEPORT BASE
--------------------------------------------------

createButton("Teleport To Base", function()
	if savedBase then
		hrp.CFrame = savedBase
		notify("[✓] Teleported")
	end
end)

--------------------------------------------------
-- AUTO JUMP
--------------------------------------------------

createButton("Auto Jump", function()
	autoJump = not autoJump

	if autoJump then
		notify("[✓] Auto Jump ON")
	else
		notify("[✕] Auto Jump OFF")
	end
end)

task.spawn(function()
	while true do
		task.wait(1)
		if autoJump then
			humanoid.Jump = true
		end
	end
end)

--------------------------------------------------
-- SPIN CAMERA
--------------------------------------------------

createButton("Spin Camera", function()
	spinCam = not spinCam

	if spinCam then
		notify("[✓] Spin ON")
	else
		notify("[✕] Spin OFF")
	end
end)

RunService.RenderStepped:Connect(function()
	if spinCam then
		workspace.CurrentCamera.CFrame =
			workspace.CurrentCamera.CFrame * CFrame.Angles(0,math.rad(2),0)
	end
end)

--------------------------------------------------
-- ANTI AFK
--------------------------------------------------

createButton("Anti AFK", function()
	antiAfk = not antiAfk

	if antiAfk then
		notify("[✓] Anti AFK ON")
	else
		notify("[✕] Anti AFK OFF")
	end
end)

player.Idled:Connect(function()
	if antiAfk then
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
end)

--------------------------------------------------
-- OPEN CLOSE
--------------------------------------------------

local opened = false

logo.MouseButton1Click:Connect(function()
	opened = not opened

	if opened then
		frame.Visible = true
		frame.Size = UDim2.new(0,0,0,0)

		TweenService:Create(frame,TweenInfo.new(0.35), {
			Size = UDim2.new(0,520,0,340)
		}):Play()
	else
		frame.Visible = false
	end
end)

close.MouseButton1Click:Connect(function()
	frame.Visible = false
	opened = false
end)
