local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

--------------------------------------------------
-- REMOTE
--------------------------------------------------
local remote = ReplicatedStorage:FindFirstChild("PhuBabyRemote")
if not remote then
	remote = Instance.new("RemoteEvent")
	remote.Name = "PhuBabyRemote"
	remote.Parent = ReplicatedStorage
end

--------------------------------------------------
-- STATE
--------------------------------------------------
local savedPosition = nil
local autoPet = false

--------------------------------------------------
-- GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

--------------------------------------------------
-- LOGO
--------------------------------------------------
local logo = Instance.new("ImageButton")
logo.Parent = gui
logo.Size = UDim2.new(0,50,0,50)
logo.Position = UDim2.new(0,50,0.4,0)
logo.BackgroundColor3 = Color3.fromRGB(10,10,10)
logo.Image = "rbxassetid://7733960981"

Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)

local logoStroke = Instance.new("UIStroke",logo)
logoStroke.Color = Color3.fromRGB(255,0,0)

--------------------------------------------------
-- MENU
--------------------------------------------------
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,290,0,180)
frame.Position = UDim2.new(0.38,0,0.35,0)
frame.BackgroundColor3 = Color3.fromRGB(8,8,8)
frame.Visible = false

Instance.new("UICorner",frame).CornerRadius = UDim.new(0,14)

local stroke = Instance.new("UIStroke",frame)
stroke.Color = Color3.fromRGB(255,0,0)

--------------------------------------------------
-- TITLE
--------------------------------------------------
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,35)
title.BackgroundTransparency = 1
title.Text = "PhuBaby"
title.Font = Enum.Font.GothamBold
title.TextSize = 22

task.spawn(function()
	local colors = {
		Color3.fromRGB(255,0,0),
		Color3.fromRGB(255,120,0),
		Color3.fromRGB(255,255,0),
		Color3.fromRGB(0,255,0),
		Color3.fromRGB(0,255,255),
		Color3.fromRGB(0,0,255),
		Color3.fromRGB(255,0,255)
	}
	local i = 1
	while true do
		title.TextColor3 = colors[i]
		i = i % #colors + 1
		task.wait(0.2)
	end
end)

--------------------------------------------------
-- CLOSE
--------------------------------------------------
local close = Instance.new("TextButton")
close.Parent = frame
close.Size = UDim2.new(0,26,0,26)
close.Position = UDim2.new(1,-32,0,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(120,0,0)
close.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner",close).CornerRadius = UDim.new(1,0)

--------------------------------------------------
-- SAVE BUTTON
--------------------------------------------------
local saveBtn = Instance.new("TextButton")
saveBtn.Parent = frame
saveBtn.Size = UDim2.new(0.9,0,0,45)
saveBtn.Position = UDim2.new(0.05,0,0,45)
saveBtn.Text = "SAVE VỊ TRÍ"
saveBtn.Font = Enum.Font.GothamBold
saveBtn.TextSize = 17
saveBtn.TextColor3 = Color3.new(1,1,1)
saveBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)

Instance.new("UICorner",saveBtn).CornerRadius = UDim.new(0,12)

--------------------------------------------------
-- AUTO PET BUTTON
--------------------------------------------------
local autoBtn = Instance.new("TextButton")
autoBtn.Parent = frame
autoBtn.Size = UDim2.new(0.9,0,0,45)
autoBtn.Position = UDim2.new(0.05,0,0,105)
autoBtn.Text = "AUTO GET PET : OFF"
autoBtn.Font = Enum.Font.GothamBold
autoBtn.TextSize = 17
autoBtn.TextColor3 = Color3.new(1,1,1)
autoBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)

Instance.new("UICorner",autoBtn).CornerRadius = UDim.new(0,12)

--------------------------------------------------
-- SAVE POSITION
--------------------------------------------------
saveBtn.MouseButton1Click:Connect(function()
	savedPosition = hrp.Position

	StarterGui:SetCore("SendNotification", {
		Title = "SAVE",
		Text = "Đã lưu vị trí base",
		Duration = 2
	})
end)

--------------------------------------------------
-- AUTO TOGGLE
--------------------------------------------------
autoBtn.MouseButton1Click:Connect(function()
	autoPet = not autoPet

	if autoPet then
		autoBtn.Text = "AUTO GET PET : ON"
		autoBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
	else
		autoBtn.Text = "AUTO GET PET : OFF"
		autoBtn.BackgroundColor3 = Color3.fromRGB(20,20,20)
	end

	StarterGui:SetCore("SendNotification", {
		Title = "AUTO GET PET",
		Text = autoPet and "Đã bật" or "Đã tắt",
		Duration = 2
	})
end)

--------------------------------------------------
-- CLICK PET TEST SIGNAL
--------------------------------------------------
UIS.InputBegan:Connect(function(input,gp)
	if gp then return end

	if input.UserInputType == Enum.UserInputType.MouseButton1 and autoPet and savedPosition then
		local mouse = player:GetMouse()
		local target = mouse.Target

		if target then
			remote:FireServer(target, savedPosition)
		end
	end
end)

--------------------------------------------------
-- OPEN CLOSE MENU
--------------------------------------------------
logo.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

close.MouseButton1Click:Connect(function()
	frame.Visible = false
end)

--------------------------------------------------
-- DRAG
--------------------------------------------------
function dragify(obj)
	local dragging = false
	local dragStart
	local startPos

	obj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = obj.Position
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			obj.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

dragify(frame)
dragify(logo)
